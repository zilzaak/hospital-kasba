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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import pervez.model.Admin;
import pervez.model.Cabin;
import pervez.model.Employee;
import pervez.repo.Adminrepo;
import pervez.repo.Cabinrepo;
import pervez.repo.Employeerepo;

@Controller
@RequestMapping("/admin")
public class Admincontrol {
	@Autowired
	Adminrepo ar;
	@Autowired
	Employeerepo er;
	
	@Autowired
	Cabinrepo cr;
	
	@PostMapping(value="/login")
	public String admin(@ModelAttribute Admin ad){
		
		if(ar.count()==0) {
			if(ad.getUsername().equalsIgnoreCase("admin") && ad.getPassword().equalsIgnoreCase("admin")) {
				 ar.save(ad);
			     return "admin";
			    
			}
		}
	 if(ar.count()==1){
	Admin am = ar.getOne(1);
		if(ad.getUsername().equalsIgnoreCase(am.getUsername()) && am.getPassword().equalsIgnoreCase(ad.getPassword())) {
		
			return "admin";	
					}
				        }
	      
	      
	 return "redirect:/"; 
	       
	}
	
	
	
	@GetMapping(value="/allcabin")
	public ResponseEntity<List<Cabin>> allcabin(){
         List<Cabin> lst = cr.findAll();
	   return new ResponseEntity<List<Cabin>>(lst,HttpStatus.OK) ;   
	}	
	
	
	
	

	
	@PostMapping("/addemployee")
public ResponseEntity<Employee> addemployee(@RequestBody Employee emp){
	er.save(emp);
	return new ResponseEntity<Employee>(emp,HttpStatus.OK);
	
}
	
	
	@PostMapping("/getbydesignation")
public ResponseEntity<List<Employee>> getbydesignation(@RequestBody String r){
  List<Employee> lst = er.findByDesignation(r);
	return new ResponseEntity<List<Employee>>(lst,HttpStatus.OK);
}	
	
	@PostMapping("/addadmit")
public ResponseEntity<Cabin> addadmit(@RequestBody Cabin r) throws ParseException{

Date admit = r.getAdmit();
Date enddate = r.getEnddate();
Date d = new Date();
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");

if(admit.getYear()!=d.getYear() || enddate.getYear()!=d.getYear()) {
	 r.setAddress("invalid  year, choose current year");
	 return new ResponseEntity<Cabin>(r,HttpStatus.OK); 
}


if(admit.before(d)){
	   r.setAddress("sorry!! 'admit' date is backdated, select next days");
	   return new ResponseEntity<Cabin>(r,HttpStatus.OK);  	
	    	
	              }
if(enddate.before(admit)){
	   r.setAddress("wrong leaving date , select again");
	   return new ResponseEntity<Cabin>(r,HttpStatus.OK);  	
	    	
	              }
int dt = enddate.getDate()-admit.getDate();
if((enddate.getMonth()-admit.getMonth())==0) {
	  if(3>dt || dt>10) {
	    r.setAddress("choose date between 3 to 10days");
  	 return new ResponseEntity<Cabin>(r,HttpStatus.OK); 	 
	    
	    	 }
	  else {
		  List<Cabin> lst = cr.findByBednoAndEnddateAfter(r.getBedno(),admit);  	 
	    	if(lst.isEmpty()) {
	    		r.setEnddate(enddate);
	    		r.setAdmit(admit);r.setDuration(dt);
	    		cr.save(r);
	    		r.setAddress("successfully cabin hired"); 
	    		return new ResponseEntity<Cabin>(r,HttpStatus.OK); 
	    	}
	    	else {
	    		 r.setAddress("Sorry!!,this date already booked select another 'admit' date"); 
	    		 return new ResponseEntity<Cabin>(r,HttpStatus.OK); 
	    	}
	  }
	  
	  
	  
}
	    

              

 if((enddate.getMonth()-admit.getMonth())==1)  {
	 
 int dt2 = enddate.getDate()+30-admit.getDate();
	    if(3>dt2 || dt2>10) {
	    	
	   	 r.setAddress("choose date between 3 to 10days");
    	 return new ResponseEntity<Cabin>(r,HttpStatus.OK); 	 
	    
	    	 }
	    else {
	    	List<Cabin> lst = cr.findByBednoAndEnddateAfter(r.getBedno(),admit);  	 
	    	if(lst.isEmpty()) {
	    		r.setEnddate(enddate);
	    		r.setAdmit(admit);r.setDuration(dt);
	    		cr.save(r);
	    		r.setAddress("successfully cabin hired"); 
	    		return new ResponseEntity<Cabin>(r,HttpStatus.OK); 
	    	}
	    	else {
	    		 r.setAddress("not empty,choose another date"); 
	    		 return new ResponseEntity<Cabin>(r,HttpStatus.OK); 
	    	}	
	    	
	    }
	    	   }



      
r.setAddress("book only one month before");

 return new ResponseEntity<Cabin>(r,HttpStatus.OK); 


                                      }
	
	
	@PostMapping("/emptycabin")
public ResponseEntity<List<Cabin>> emptycabin(@RequestBody String[] beds){
	List<Cabin> lst = new ArrayList<Cabin>();
	     
    for(int i=0; i<beds.length;i++) {
    if(!cr.findByBednoOrderByEnddateDesc(beds[i]).isEmpty()) {
        	Cabin c = cr.findByBednoOrderByEnddateDesc(beds[i]).get(0);
        	System.out.println("the data from query is"+c.getEnddate()+"the data from query is"+c.getEnddate());
        	lst.add(c);
    	
    		  	}
    else {
    	Cabin c=new Cabin();c.setBedno(beds[i]);
    	lst.add(c);
    }
    
                   }

return new ResponseEntity<List<Cabin>>(lst,HttpStatus.OK);
	
}	
	
	
@PostMapping("/cabinbytwodate")
public ResponseEntity<List<Cabin>> getbetweentwodate(@RequestBody Date[] dt){

	Date admit = dt[0];
	Date enddate = dt[1];
	
	List<Cabin> lst = cr.findByAdmitBetween(admit, enddate);
	return new ResponseEntity<List<Cabin>>(lst,HttpStatus.OK) ;
}
	
	

}




