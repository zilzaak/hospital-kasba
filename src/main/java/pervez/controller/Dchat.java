package pervez.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import pervez.model.*;
import pervez.repo.Doctorrepo;
import pervez.repo.Levelrepo;
import pervez.repo.Onlineactiverepo;
import pervez.repo.Smsrepo;
import pervez.repo.Studentreo;

@Controller
@RequestMapping(value="/dchat")
public class Dchat {
	@Autowired
	Studentreo sr;
	@Autowired
	Doctorrepo drr;
	@Autowired
	Onlineactiverepo or;
	@Autowired
	Smsrepo smr;
	@Autowired
	Levelrepo lrr;
	
	@PostMapping(value="/activepatient")
	public ResponseEntity<List<OnlineActiveMode>> activepatient(@RequestBody Integer did){
	    List<OnlineActiveMode> lst = new ArrayList<OnlineActiveMode>();	
		List<Level> record = lrr.findByLdid(String.valueOf(did));
	if(!record.isEmpty()) {
		
	for(Level l : record) {
		OnlineActiveMode oa =or.findByPersonAndDesignation(Integer.valueOf(l.getLsid()),"patient").get(0);
		 lst.add(oa); 
      }
		}
	return new ResponseEntity<List<OnlineActiveMode>>(lst,HttpStatus.OK);	
	
	}
	
	

	@SuppressWarnings("unused")
	@PostMapping(value="/chatwithpr")
	public ResponseEntity<List<StudPsSms>> chatwithpr(@RequestBody StudPsSms r){
            Patient st = sr.findById(Integer.valueOf(r.getSid())).get();
	    	Doctor dr = drr.findById(Integer.valueOf(r.getAid())).get();
		List<StudPsSms> lst= smr.findByAidAndSid(r.getAid(),r.getSid());
	       if(!lst.isEmpty()) {
	    	   return new ResponseEntity<List<StudPsSms>>(lst,HttpStatus.OK); 
	       }
	       else {
	    	   List<StudPsSms> lst2 = new ArrayList<StudPsSms>();
	    	   lst2.add(new StudPsSms("n", "n","empty","empty",   new Date(),""));
	    	   return new ResponseEntity<List<StudPsSms>>(lst2,HttpStatus.OK); 
	       }
	       
  	       }
	
	
	@SuppressWarnings({ "unused", "deprecation" })
	@PostMapping(value="/dsend")
		public ResponseEntity<List<StudPsSms>> psend(@RequestBody StudPsSms r) throws ParseException{
		
		       SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm");
	 	      Date d = new Date();
           
           r.setStringdate(df.format(d));

	    	Patient st = sr.findById(Integer.valueOf(r.getSid())).get();
	    	Doctor dr = drr.findById(Integer.valueOf(r.getAid())).get();
            r.setDate(df.parse(df.format(d)));
	    	
	             StudPsSms sm = new StudPsSms(r.getSid(),r.getAid(),r.getStudsms(),r.getPssms(),r.getDate(),r.getStringdate());
	             System.out.println("/psend/from the chatting java using array data");
	             smr.save(sm);
	          List<StudPsSms> lst = smr.findByAidAndSid(r.getAid(), r.getSid());
		    List<Level> track=lrr.findByLsidAndLdid(r.getSid(), r.getAid());
		    
		    if(track.isEmpty()) {
		    Level l = new Level();
		    l.setLdid(r.getAid());l.setLsid(r.getSid());
		    l.setLsname(st.getName());l.setLdname(dr.getName());
		    l.setSlevel(0);l.setDlevel(lst.size());
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
		  l.setDlevel(lst.size());  
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
	    
	
	@PostMapping(value="/unreadd")
	public ResponseEntity<List<Level>> unreadd(@RequestBody Integer did){
	List<Level> lst = lrr.findByLdidAndDelta(String.valueOf(did),"slarger");
	
	  return new ResponseEntity<List<Level>>(lst,HttpStatus.OK);	
		
		}	
	
	
	
	
	
	@PostMapping(value="/seenit")
	public ResponseEntity<List<StudPsSms>> seenit(@RequestBody Level x){
	
List<StudPsSms> lst = smr.findByAidAndSid(x.getLdid(),x.getLsid());
  x.setDlevel(lst.size());x.setSlevel(lst.size());
  x.setDelta("same");
  lrr.save(x);
	  return new ResponseEntity<List<StudPsSms>>(lst,HttpStatus.OK);	
		
		}	
	
	 @PostMapping(value="/refreshd")
		public ResponseEntity<List<StudPsSms>> refresh(@RequestBody StudPsSms r){
List<StudPsSms> lst = smr.findByAidAndSid(r.getAid(), r.getSid()) ;
if(!lst.isEmpty()) {
	List<Level> l = lrr.findByLsidAndLdid(r.getSid(), r.getAid());
	if(!l.isEmpty()) {
		Level lv = l.get(0);
		lv.setDlevel(lst.size());
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
	list.add(new StudPsSms(r.getSid(),r.getAid(),"empty","write something",new Date(),""));
	return new ResponseEntity<List<StudPsSms>>(list,HttpStatus.OK);
}

	}

}
