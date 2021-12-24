package pervez.controller;

import java.text.SimpleDateFormat;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import pervez.model.Doctor;
import pervez.model.Level;
import pervez.model.OnlineActiveMode;
import pervez.model.StudPsSms;
import pervez.model.Patient;
import pervez.repo.Doctorrepo;
import pervez.repo.Levelrepo;
import pervez.repo.Onlineactiverepo;
import pervez.repo.Smsrepo;
import pervez.repo.Studentreo;


@Controller
@RequestMapping(value="/chat")
public class Pchat {
@Autowired
Studentreo sr;
@Autowired
Doctorrepo drr;
@Autowired
Onlineactiverepo orr;
@Autowired
Smsrepo smr;
@Autowired
Levelrepo lrr;
	
	
	@RequestMapping(value="/patientchat/{sid}")
	public ModelAndView tpatientchat(@PathVariable int sid) {
		ModelAndView mv = new ModelAndView("chatting");
		Patient st = sr.getOne(sid);
		mv.addObject("st",st);			
		return mv;
	}
	


	@GetMapping(value="/activedr")
	public ResponseEntity<List<OnlineActiveMode>> activedr(){
List<OnlineActiveMode> lst = orr.findByDesignation("doctor");
return new ResponseEntity<List<OnlineActiveMode>>(lst,HttpStatus.OK);	
	
	}
	
	
	
	@PostMapping(value="/chatwithdr")
public ResponseEntity<List<StudPsSms>> chatwithdr(@RequestBody StudPsSms r){
	List<StudPsSms> lst= smr.findByAidAndSid(r.getAid(),r.getSid());
       if(!lst.isEmpty()) {
    	   return new ResponseEntity<List<StudPsSms>>(lst,HttpStatus.OK); 
       }
       else {
    	   List<StudPsSms> lst2 = new ArrayList<StudPsSms>();
    	   lst2.add(new StudPsSms("n", "n","empty","empty",new Date(),""));
    	   return new ResponseEntity<List<StudPsSms>>(lst2,HttpStatus.OK); 
       }
	
	}	
	

	
  
	@SuppressWarnings({ "unused", "deprecation" })
	@PostMapping(value="/psend")
	public ResponseEntity<List<StudPsSms>> psend(@RequestBody StudPsSms r){

       SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm");
    	Patient st = sr.findById(Integer.valueOf(r.getSid())).get();
    	Doctor dr = drr.findById(Integer.valueOf(r.getAid())).get();
    	Date d = new Date();
    
             r.setStringdate(df.format(d));
            r.setDate(d);
             StudPsSms sm = new StudPsSms(r.getSid(),r.getAid(),r.getStudsms(),r.getPssms(),r.getDate(),r.getStringdate());
             System.out.println("/psend/from the chatting java using array data");
             smr.save(sm);
          List<StudPsSms> lst = smr.findByAidAndSid(r.getAid(), r.getSid());
	    List<Level> track=lrr.findByLsidAndLdid(r.getSid(), r.getAid());
	    
	    if(track.isEmpty()) {
	    Level l = new Level();
	    l.setLdid(r.getAid());l.setLsid(r.getSid());
	    l.setLsname(st.getName());l.setLdname(dr.getName());
	    l.setSlevel(lst.size());l.setDlevel(0);
	    if(l.getSlevel()-l.getDlevel()>0) {
	    	l.setDelta("slarger");
	    }
	    if(l.getSlevel()-l.getDlevel()<0) {
	    	l.setDelta("dlarger");
	    }
	    if((l.getSlevel()-l.getDlevel())==0) {
	    	l.setDelta("same");
	    }
	    
	    lrr.save(l);
	    }
	    else {
	    	 Level l =track.get(0);    	
	  l.setSlevel(lst.size());  
	  if(l.getSlevel()-l.getDlevel()>0) {
	    	l.setDelta("slarger");
	    }
	    if(l.getSlevel()-l.getDlevel()<0) {
	    	l.setDelta("dlarger");
	    }
	    if((l.getSlevel()-l.getDlevel())==0) {
	    	l.setDelta("same");
	    }
	    lrr.save(l);	
	    }
	    
	return new ResponseEntity<List<StudPsSms>>(lst,HttpStatus.OK);
	}	
    
    
	 @PostMapping(value="/refreshp")
		public ResponseEntity<List<StudPsSms>> refresh(@RequestBody StudPsSms r){
List<StudPsSms> lst = smr.findByAidAndSid(r.getAid(), r.getSid()) ;
if(!lst.isEmpty()) {
	List<Level> l = lrr.findByLsidAndLdid(r.getSid(), r.getAid());
	if(!l.isEmpty()) {
		Level lv = l.get(0);
		lv.setSlevel(lst.size());
		if(lv.getDlevel()>lv.getSlevel()) {
			lv.setDelta("dlarger");
		}
		if(lv.getDlevel()<lv.getSlevel()) {
			lv.setDelta("slarger");
		}
		if(lv.getDlevel()==lv.getSlevel()) {
			lv.setDelta("same");
		}
		lrr.save(lv);
	}
	
	return new ResponseEntity<List<StudPsSms>>(lst,HttpStatus.OK);
	
}
else {
   List<StudPsSms> list = new ArrayList<StudPsSms>();
	list.add(new StudPsSms(r.getSid(),r.getAid(),"empty","write",new Date(),""));
	return new ResponseEntity<List<StudPsSms>>(list,HttpStatus.OK);
}

	}
   
		@PostMapping(value="/unreadp")
		public ResponseEntity<List<Level>> unreadd(@RequestBody Integer sid){
		List<Level> lst = lrr.findByLsidAndDelta(String.valueOf(sid),"dlarger");
		
	 return new ResponseEntity<List<Level>>(lst,HttpStatus.OK);	
			
			}	  

 
    
   @PostMapping(value="/chatrecord")
 	public ResponseEntity<List<Level>> patientchtrecord(@RequestBody Integer sid) {
    List<Level> lst = lrr.findByLsid(String.valueOf(sid));
    
	 return new ResponseEntity<List<Level>>(lst,HttpStatus.OK);
   }
   

   

	 
	 
/*	 
@SuppressWarnings("unused")
@PostMapping(value="/unread")
		public ResponseEntity<List<Chatunread>> unread(@RequestBody Chatunread r){
		String sender="doctor";
		String reciever="patient";
List<Chatunread> unlst = new ArrayList<Chatunread>();
List<Chatunread> lst = srvc.senderlevellist(r.getFr(),reciever);
Chatunread p=lst.get(1);
//if(!lst.isEmpty()) {
//for(Chatunread p : lst) {
	//System.out.println(p.getFr()+"    "+p.getTr()+"   "+p.getSendertype());

//}
//}
	//System.out.println(p.getFr()+"    "+p.getTr()+"   "+p.getSendertype());
Chatunread g = srvc.recieverlevel(p.getTr(), p.getFr(),"doctor");

Chatunread cf = new Chatunread("5","1","dr",4,8);
Chatunread c2 = new Chatunread("5","1","dr",4,8);
unlst.add(cf);
unlst.add(c2);
  return new ResponseEntity<List<Chatunread>>(unlst,HttpStatus.OK);
		}
	 	
	
		
		@PostMapping(value="/drseen")
		public ResponseEntity<List<StudPsSms>> drseen(@RequestBody StudPsSms r){
			SimpleDateFormat df = new SimpleDateFormat("MM-dd-yyyy");
            Date d = new Date();
            String str = df.format(d);
           r.setDate(new Date());r.setStringdate(str);
       System.out.println("value is request body is did is"+r.getAid()+"and sid is "+r.getSid());
       System.out.println("value is request body is did is"+r.getAid()+"and sid is "+r.getSid());
       System.out.println("value is request body is did is"+r.getAid()+"and sid is "+r.getSid());
       System.out.println("value is request body is did is"+r.getAid()+"and sid is "+r.getSid());
       System.out.println("value is request body is did is"+r.getAid()+"and sid is "+r.getSid());
             List<StudPsSms> lst = srvc.drseen(r);
            
		    return new ResponseEntity<List<StudPsSms>>(lst,HttpStatus.OK);	
			
			}		
	*/	
		
		
	
}
