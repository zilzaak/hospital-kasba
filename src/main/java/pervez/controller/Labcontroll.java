package pervez.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import pervez.model.Labreport;
import pervez.model.Meditest;
import pervez.repo.Repolab;
import pervez.repo.Repotest;

@Controller
@RequestMapping("/lab")
public class Labcontroll {
@Autowired
Repolab rl;

@Autowired
Repotest rt;
	
	@PostMapping("/reglab")
	private String reglabuser(@RequestBody Labreport lr) {
		
		return "labprofile";
	}
	
	
	@PostMapping(value="/login")
	private ModelAndView userlogin(@RequestParam String user,@RequestParam String password,
			HttpSession session) {
              
		if(rl.existsByLabuserAndLabpassword(user,password)) {
			Date d = new Date();
			SimpleDateFormat format2 = new SimpleDateFormat("dd-MM-yyyy");
        	String hifentypedate=format2.format(d);
			Labreport lr = new Labreport();
			lr.setLabuser(user);lr.setLabpassword(password);
			Meditest m1 = new Meditest();
			m1.setTestmaker(user);m1.setStringdate(hifentypedate);
			Meditest m2 = new Meditest();
			m2.setTestmaker(user);m2.setStringdate(hifentypedate);
			List<Meditest> lst = new ArrayList<Meditest>();
			lst.add(m1);
			lst.add(m2);
			lr.setMt(lst);
			String lrr = new Gson().toJson(lr);
			session.setAttribute("lr",lrr);
			ModelAndView mv = new ModelAndView("lab");
			session.setAttribute("labuser",user);
			session.setAttribute("labpassword", password);
			
			return mv;
		}
		else {
		    return new ModelAndView("labsection","sms","invalid username or password");
		}
		                                
	     }
	
	@PostMapping(value="/register")
	private ResponseEntity<String[]> register(@RequestBody String[] x) {
              
		if(rl.existsByLabuser(x[0])) {
			x[0]="username already exist";
		    return new ResponseEntity<String[]>(x,HttpStatus.OK);
		                      }
		else {
			Labreport lr = new Labreport();
			lr.setLabuser(x[0]);lr.setLabpassword(x[1]);
			rl.save(lr);
			x[0]="successfully registered";
	        return new ResponseEntity<String[]>(x,HttpStatus.OK);
		        }
		
	}
	
	@PostMapping(value="/insert")
	private ResponseEntity<Labreport> insert(@RequestBody Labreport lr) throws ParseException {
		SimpleDateFormat format2 = new SimpleDateFormat("dd-MM-yyyy");
    	String hifentypedate=format2.format(new Date());
    	Date d = format2.parse(hifentypedate);
	for(Meditest m : lr.getMt()) {
		
		
		m.setDate(d);
	}
       rl.save(lr);   
	  return new   ResponseEntity<Labreport>(lr,HttpStatus.OK);   
	
	}
	
	
	@PostMapping(value="/allrecord",consumes=MediaType.TEXT_PLAIN_VALUE)
	private ResponseEntity<List<Meditest>> insert(@RequestBody String x) {
       List<Meditest> lst = rt.findByTestmaker(x);
	  return new   ResponseEntity<List<Meditest>>(lst,HttpStatus.OK);   
	
	                                                                    }
	@PostMapping(value="/sbydatebefore")
	private ResponseEntity<List<Meditest>> sbydatelower(@RequestBody Date d) {
       List<Meditest> lst = rt.findByDateBefore(d);

  return new   ResponseEntity<List<Meditest>>(lst,HttpStatus.OK);   
	
	                                                                    }
	@PostMapping(value="/sbydateafter")
	private ResponseEntity<List<Meditest>> sbydateupper(@RequestBody Date d) {
       List<Meditest> lst = rt.findByDateAfter(d);

	  return new   ResponseEntity<List<Meditest>>(lst,HttpStatus.OK);   
	
	                            }
	
	
	
	@PostMapping(value="/sbydatebetween")
	private ResponseEntity<List<Meditest>> sbydatebetween(@RequestBody Date[] d) {
      List<Meditest> lst = rt.findByDateBetween(d[0], d[1]);
		return new   ResponseEntity<List<Meditest>>(lst,HttpStatus.OK);   
	
	                                                                    }
	
	
	@PostMapping(value="/agebetween")
	private ResponseEntity<List<Meditest>> agebetween(@RequestBody Integer[] d) {
      List<Meditest> lst = rt.findByAgeBetween(d[0], d[1]);
		return new   ResponseEntity<List<Meditest>>(lst,HttpStatus.OK);   
	
	                                                                    }

	@PostMapping(value="/agelessthan")
	private ResponseEntity<List<Meditest>> agelessthan(@RequestBody Integer d) {
      List<Meditest> lst = rt.findByAgeLessThan(d);
		return new   ResponseEntity<List<Meditest>>(lst,HttpStatus.OK);   
	
	                                                                    }
	@PostMapping(value="/agelargerthan")
	private ResponseEntity<List<Meditest>> agelargerthan(@RequestBody Integer d) {
      List<Meditest> lst = rt.findByAgeGreaterThan(d);
		return new   ResponseEntity<List<Meditest>>(lst,HttpStatus.OK);   
	
	                                                                    }
	
	@PostMapping(value="/sbyname",consumes=MediaType.TEXT_PLAIN_VALUE)
	private ResponseEntity<List<Meditest>> sbyname(@RequestBody String name) {
       List<Meditest> lst = rt.findByPatientnameContaining(name);
	  return new   ResponseEntity<List<Meditest>>(lst,HttpStatus.OK);   
	
	                                                                    }
	
	
	
}
