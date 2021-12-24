package pervez.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import pervez.model.Doctor;
import pervez.model.OnlineActiveMode;
import pervez.model.Patient;
import pervez.repo.Doctorrepo;
import pervez.repo.Onlineactiverepo;
import pervez.repo.Studentreo;



@Controller
public class Registration {

@Autowired
private Studentreo sr;
@Autowired
private Onlineactiverepo or;
@Autowired
private Doctorrepo drr;

		@RequestMapping(value="/")
		public String test() {
		
			return "test";
		}
		@RequestMapping(value="/pdf")
		public String pdftest() {
	
			return "test";
		}
		
		@GetMapping(value="/choice")
		public String choice(@RequestParam("operation") String operation) {
				
			return operation ;
		}
		
		
		@PostMapping(value="/regstudent")
		public ResponseEntity<Patient> regstu(@RequestBody Patient st) {
			
			if(sr.findByName(st.getName()).isEmpty()) {
				sr.save(st);
				st.setName("sucessfully completed Registration");
		return new ResponseEntity<Patient>(st,HttpStatus.OK);
			}
			st.setName("username you have entered is already exist");
			return new ResponseEntity<Patient>(st,HttpStatus.OK);
		
		}
		
		@RequestMapping(value="/loginstudent" , method=RequestMethod.POST)
		public  ModelAndView studentlogin(@RequestParam("name") String uname,
				@RequestParam("password") String password
				,HttpSession session) {
			
			 ModelAndView mv = new  ModelAndView();
			
			if(!sr.findByNameAndPassword(uname, password).isEmpty()) {
			      Patient st1 = sr.findByName(uname).get(0);
			      OnlineActiveMode st = new OnlineActiveMode(st1.getSid(),"patient","active",uname);
			if(or.findByDesignationAndName("patient",uname).isEmpty()) {
				or.save(st);
			}
			else {
		List<OnlineActiveMode> lst=or.findByDesignationAndName("patient",uname);
		OnlineActiveMode oam = lst.get(0);
		oam.setActive_status("active");
		or.save(oam);
			}
			
		
				mv.setViewName("stprofile");
				session.setAttribute("sid",st1.getSid());
				session.setAttribute("username",uname);
				session.setAttribute("password",password);
				session.setAttribute("pname",uname);
				Gson g = new Gson();
				String pat = g.toJson(st1);
				session.setAttribute("pt",pat);
			}
			else {
				mv.setViewName("studentlogin");
		        mv.addObject("loginsms","Username is not match please try again");		
			}
			return mv;	
		
		   }
		
		@RequestMapping(value="/logout")
		public String logout(@RequestParam("log") String log,@RequestParam("id") Integer id, HttpSession session) {
			
			if(log.equals("patient")) {
				String name = (String) session.getAttribute("username");
					List<OnlineActiveMode> lst=or.findByDesignationAndName("patient",name);
					OnlineActiveMode oam = lst.get(0);
					oam.setActive_status("inactive");
					or.save(oam);
				session.removeAttribute("username");session.removeAttribute("password");
				session.invalidate();
			}
			if(log.equals("doctor")) {
				String name = (String) session.getAttribute("Dusername");
				List<OnlineActiveMode> lst=or.findByDesignationAndName("doctor",name);
				OnlineActiveMode oam = lst.get(0);
				oam.setActive_status("inactive");
				or.save(oam);
				session.removeAttribute("Dusername");session.removeAttribute("Dpassword");
				session.invalidate();
				 
			}
			
			return "test";
	                                    	}
		
		@PostMapping(value="/newdocreg")
		public ResponseEntity<Doctor>  getgame(@RequestBody Doctor dr ){

		if(drr.findByName(dr.getName()).isEmpty()){
			drr.save(dr);
				dr.setDegree("successfully registered");
		   	}
		else {
			dr.setDegree("ohhh!!, username allready exist,try again");
		}
			
			return new ResponseEntity<Doctor>(dr,HttpStatus.OK);
		}
		
		@RequestMapping(value="/logindoctor" , method=RequestMethod.POST)
		public  ModelAndView  doctorlogin(@RequestParam("name") String uname,
				@RequestParam("password") String password
				,HttpSession session) {
			 ModelAndView mv = new  ModelAndView();
			if(!drr.findByNameAndPassword(uname,password).isEmpty()) {
				Doctor dr = drr.findByName(uname).get(0);
				  int did = dr.getDid();
 OnlineActiveMode st = new OnlineActiveMode(did,"doctor","active",uname);
					if(or.findByDesignationAndName("doctor",uname).isEmpty()) {
						or.save(st);
					}
					else {
				List<OnlineActiveMode> lst=or.findByDesignationAndName("doctor",uname);
				OnlineActiveMode oam = lst.get(0);
				oam.setActive_status("active");
				or.save(oam);
					}
				 
				session.setAttribute("aid",did);
				session.setAttribute("Dusername",uname);
				session.setAttribute("Dpassword",password);
				Gson g = new Gson();
				String jdr = g.toJson(dr);
		       // mv.addObject("drr", jdr);	
		        session.setAttribute("drr",jdr);
				mv.setViewName("doctorprofile");
				
			}else {
				mv.setViewName("doctorlogin");
				mv.addObject("sms","username or password is not match .Try again");
			
			}
			
			return mv;	
		
		   }
		
	

		@PostMapping(value="/updatedoc")
		public ResponseEntity<Doctor> updatedoc(@RequestBody Doctor dr,HttpSession session){
			Doctor d = drr.getOne(dr.getDid());
			List<OnlineActiveMode> lst=or.findByDesignationAndName("doctor",d.getName());
			OnlineActiveMode oam = lst.get(0);
			oam.setActive_status("active"); oam.setName(dr.getName());
			or.save(oam);
			
			dr.setPassword(d.getPassword());
			dr.setFilename(d.getFilename());
			dr.setDrphotopath(d.getDrphotopath());
			drr.save(dr);
			 session.setAttribute("Dusername",dr.getName());
	        return new ResponseEntity<Doctor>(dr,HttpStatus.OK);
				 
		                                                                                    }
		
		@PostMapping(value="/updatepatient")
		public ResponseEntity<Patient> updatpatient(@RequestBody Patient patient,HttpSession session){
			Patient d = sr.getOne(patient.getSid());
			List<OnlineActiveMode> lst=or.findByDesignationAndName("patient",d.getName());
			OnlineActiveMode oam = lst.get(0);
			oam.setActive_status("active"); oam.setName(patient.getName());
			or.save(oam);
	  sr.save(patient);
	  session.setAttribute("username",patient.getName());
          return new ResponseEntity<Patient>(patient,HttpStatus.OK);
				 
		}	

	




}
