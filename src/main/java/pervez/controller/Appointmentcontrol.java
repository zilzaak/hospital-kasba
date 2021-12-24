package pervez.controller;


import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import pervez.model.ChooseAppointment;
import pervez.model.Doctor;
import pervez.model.Patient;
import pervez.repo.Chooseapprepo;
import pervez.repo.Doctorrepo;
import pervez.repo.Studentreo;

@Controller
@RequestMapping(value="/appoint")
public class Appointmentcontrol {
	public final String from ="sijanhex@gmail.com";
	@Autowired
	private Studentreo sr;
	
	@Autowired
	private Doctorrepo drapp;
   
	@Autowired
	private Chooseapprepo crap;
	

	
	@PostMapping(value="/drbydis",
			consumes=MediaType.TEXT_PLAIN_VALUE,
			produces=MediaType.APPLICATION_JSON_VALUE)
			public ResponseEntity<List<Doctor>> getdoctorBy(@RequestBody String r){
List<Doctor> lst = drapp.findByExpertintContaining(r);
if(lst.isEmpty()) {
	 lst =  Arrays.asList(new Doctor(),new Doctor());
}
                return new ResponseEntity<List<Doctor>>(lst,HttpStatus.OK);

			}
	@RequestMapping(value="/myapp")
			public String myapp(){

           return "getapp";

			}
	
	public boolean serialordateoverflow( Date d, int did,int sid ) {
		boolean serialno=false; boolean noduplicate=false;  
			if(crap.findByChdateAndChdid(d, did).size()<4) {
				serialno=true;
						}
		 if(!crap.existsByChdateAndChdidAndChsid(d, did,sid)) {
			 noduplicate=true; 
		 }
		return ((serialno && noduplicate));
                 		}
	
	public int serialno( Date d, int did) {
		  
		return 	crap.findByChdateAndChdid(d, did).size(); 
					}
	
	
	
	
	
	@SuppressWarnings("deprecation")
	@PostMapping(value="/chooseapp")
	public ResponseEntity<ChooseAppointment>  selectappointmentdate(@RequestBody ChooseAppointment ca,
			HttpSession sn) throws ParseException, DocumentException, IOException, AddressException, MessagingException {
		
		 Doctor dr = drapp.getOne(ca.getChdid());	
		 Patient st = sr.getOne(ca.getChsid());
	     Date d = new Date();
		 SimpleDateFormat df =new SimpleDateFormat("dd/MM/yyyy");
		 Date d1 = df.parse(ca.getStringdate());
		 Date d3 = df.parse(df.format(d));
         ca.setChdate(d1);
        
		 if( d3.compareTo(ca.getChdate())>0) {	
			 System.out.println("present date"+d3+" is greater then choosed date"+d1);
	     ca.setChsmg("invalid date selection");
		 return new ResponseEntity<ChooseAppointment>(ca,HttpStatus.OK); 
		                    
		                         }
	
			 
		 if(!checkday(d1.getDay(),dr.getDay())) {	
		     ca.setChsmg("select any of these days "+dr.getDay());
			 return new ResponseEntity<ChooseAppointment>(ca,HttpStatus.OK); 
			                    
			                         }
		 	
 if(serialordateoverflow(ca.getChdate(),ca.getChdid(),ca.getChsid())) {
				SimpleDateFormat format2 = new SimpleDateFormat("dd-MM-yyyy");
				SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
			@SuppressWarnings("unused")
				Date dn = format1.parse(ca.getStringdate());
				String hifentypedate=format2.format(d);
				ca.setPdfname(hifentypedate+ca.getPrname()+ca.getDname());
				int s = 1+serialno(ca.getChdate(),ca.getChdid());
		ca.setSirialno(s);
		ca.setChsmg("successfull");
		crap.save(ca);
		appdfcreater(dr,ca,sn);
		sendmail(st,dr,ca);
		return new ResponseEntity<ChooseAppointment>(ca,HttpStatus.OK); 
		                                                                           }

	 ca.setChsmg("date overflowed,choose other date");
	 return new ResponseEntity<ChooseAppointment>(ca,HttpStatus.OK); 
	}

	
	
	
	
	
	
	
	
	
	boolean checkday(int i,String da) {
		String day="sun";
		if(i==1) {
			day="mon";
		}
		if(i==2) {
			day="tue";
		}
if(i==3) {
		day="wed";	
		}
if(i==4) {
	day="thu";
}

if(i==5) {
	day="fri";
}
if(i==6) {
	day="sat";
}

          if(da.contains(day)) {
	                         return true;
                                  }
          
                    		return false;
                    		
	}
	
	
	
	
	@PostMapping(value="/myapprecord")
	public ResponseEntity<List<ChooseAppointment>> apprecord(@RequestBody Integer sid){

	List<ChooseAppointment> lst = crap.findByChsid(sid);
	return new ResponseEntity<List<ChooseAppointment>>(lst,HttpStatus.OK) ;

	}
	
public void appdfcreater(Doctor dr,ChooseAppointment ap,HttpSession s) throws DocumentException, IOException, ParseException{
 Document document = new Document();
OutputStream out =new FileOutputStream(s.getServletContext().getRealPath("/")+"appoint/"+ap.getPdfname()+".pdf");
		PdfWriter.getInstance(document,out);
		document.open();
		if(dr.getDrphotopath()!=null) {
			Image img = Image.getInstance(dr.getDrphotopath());	
			document.add(img);
		}
		    document.add(new Paragraph("green hospital" +"     "  +"Date:"+ap.getStringdate()));
			document.add(new Paragraph("Doctor Name:-"+dr.getName())); document.add(new Paragraph("Expertin:-"+dr.getExpertint()+"(MBBS)"));
			document.add(new Paragraph("Time schedule:-"+dr.getSchedule()));
			document.add(new Paragraph("Days:-"+dr.getDay()));
			document.add(new Paragraph("Patient Name:-"+ap.getPrname()));
			document.add(new Paragraph("Patient Serial No:-"+ap.getSirialno()));
			document.addTitle("Appointment");
			document.close();
			out.flush();
			out.close();	
		           }	

	
	@RequestMapping(value="/downloadapp/{pdfname}")
	public  RedirectView dapp(@PathVariable String pdfname,HttpServletResponse rs,HttpSession session) throws IOException{

	File file = new File(session.getServletContext().getRealPath("/")+"appoint/"+pdfname+".pdf");
	FileInputStream k = new FileInputStream(file);
	InputStream im = new  BufferedInputStream(k );
	String mimetype = URLConnection.guessContentTypeFromStream(im);
	if(mimetype==null){
	mimetype="application/octet-stream";
	rs.setContentType(mimetype);
	rs.setContentLengthLong(file.length());
	rs.setHeader("Content-Disposition", String.format("attachment;filename=\"%s\"",file.getName()));
	FileCopyUtils.copy(im,rs.getOutputStream());	
	}
return new RedirectView("/myapp");
	}
	

	@PostMapping(value="/appinadate")
	public ResponseEntity<List<ChooseAppointment>>recordapp(@RequestBody ChooseAppointment r) {

	List<ChooseAppointment> lst= crap.findByStringdateAndChdid(r.getStringdate(),r.getChdid());

	return new ResponseEntity<List<ChooseAppointment>>(lst,HttpStatus.OK) ;
	}
	
	
	
	@PostMapping(value="/appbytwodate")
	public ResponseEntity<List<ChooseAppointment>> recordapptwodate(@RequestBody Date[] sd,HttpSession session) throws ParseException{
 Date d1=sd[0];
Date d2 = sd[1];
int did =  (Integer) session.getAttribute("aid");
List<ChooseAppointment> d =crap.findByChdateBetweenAndChdid(d1, d2,did);
return new ResponseEntity<List<ChooseAppointment>>(d,HttpStatus.OK);
	}
	


	
	@PostMapping(value="/appbyafter")
	public ResponseEntity<List<ChooseAppointment>> appbyafter(@RequestBody Date d2,HttpSession session 
	) throws ParseException{
		int did =  (Integer) session.getAttribute("aid");
List<ChooseAppointment> d =crap.findByChdateAfterAndChdid( d2,did);
return new ResponseEntity<List<ChooseAppointment>>(d,HttpStatus.OK);
	}	
	
	
	
	
	@PostMapping(value="/appbybefore")
	public ResponseEntity<List<ChooseAppointment>> appbybefore(@RequestBody Date d1,HttpSession session) throws ParseException{
		int did = (Integer) session.getAttribute("aid");
List<ChooseAppointment> d =crap.findByChdateBeforeAndChdid(d1,did);
return new ResponseEntity<List<ChooseAppointment>>(d,HttpStatus.OK);

	                             }	
	
	
	@PostMapping(value="/allappfordr")
	public ResponseEntity<List<ChooseAppointment>> appbybefore(@RequestBody Integer did){
List<ChooseAppointment> d =crap.findByChdid(did);
return new ResponseEntity<List<ChooseAppointment>>(d,HttpStatus.OK);

	                             }		
	
	
@GetMapping(value="/doctorlist")
public ResponseEntity<List<Doctor>> doclist() {
List<Doctor> lst = drapp.findAll();
	return new ResponseEntity<List<Doctor>>(lst,HttpStatus.OK);
}
	

	
@SuppressWarnings("unused")
public void sendmail(Patient st , Doctor dr,ChooseAppointment ca) {
	String to=st.getEmail();
	Properties prop=new Properties();
	prop.put("mail.smtp.port",587);
	prop.put("mail.smtp.auth","true");
	prop.put("mail.smtp.host","smtp.gmail.com");
	prop.put("mail.smtp.starttls.enable","true");
	String ms="the email address is perfect";
	try {
		Session session = Session.getInstance(prop, 
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(from,"aslamhex666");
					                }
					});
		            
				    MimeMessage msg = new MimeMessage(session);
					msg.setSubject("appointment confirmation from Green hospital");
					msg.setFrom(new InternetAddress(from));
					String stn="appointment of"+" "+dr.getName()+" "+"appointment date::"+
							ca.getChdate()+"  "+"doctor contact::"+dr.getDrphone()+"  "+
							"Doctor Schedule::"+dr.getDay()+"Time::"+dr.getSchedule()+"patient Name::"+st.getName()+"  "+
							"patient email::"+st.getEmail();
				msg.setContent("<h1>"+stn+"</h1>","text/html");
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(st.getEmail()));
				Transport.send(msg);
	}catch( Exception e){
		ms="the email address is invalid";
		e.printStackTrace();
	}
System.out.println(ms+ms+ms);
System.out.println(ms+ms+ms);
System.out.println(ms+ms+ms);

}

/*	
	@RequestMapping(value="/provideddrug/{fpid}")
public ModelAndView provideddrug(@PathVariable("fpid") int fpid) {
	List<Drug> lst = srvc2.provideddrugs(fpid);
for(Drug d : lst) {
	
	System.out.println("drug name is "+d.getNdrug()+"    "+"schedule of drug"+"  "+d.getSdrug());
	System.out.println("patient name is"+d.getFpdoct().getXpname());
}
	return new ModelAndView("provideddrugs","druglist",lst);
	
}
	
//@RequestMapping(value="/presfordoc/{sid}/{aid}", method=RequestMethod.GET)
	//public ModelAndView presfordoc(@PathVariable("sid") int sid,@PathVariable("aid") int aid,
	//HttpServletResponse rs) throws IOException {
	//ModelAndView mv = new ModelAndView("successtodownload");
	//mv.addObject("sms", "downloaded prescription successfully");
	//String existprescription = srvc2.existPrescriptionOrNot(aid, sid);
	//if(existprescription.equals("not")) {
	//	mv.setViewName("meetonline");
	//mv.addObject("failmsg","your doctor have not prescribe any thing yet!! request him to provide a prescription");
	    // }else {
		////	File file = new File(existprescription);
			//FileInputStream k = new FileInputStream(file);
			//InputStream im = new  BufferedInputStream(k );
			//String mimetype = URLConnection.guessContentTypeFromStream(im);
			//if(mimetype==null) {
			//mimetype="application/octet-stream";
			//rs.setContentType(mimetype);
			//rs.setContentLengthLong(file.length());
			//rs.setHeader("Content-Disposition", String.format("attachment;filename=\"%s\"",file.getName()));
			//FileCopyUtils.copy(im,rs.getOutputStream());
	//}	
//}
		//return mv;
//}
	
*/
	
}
