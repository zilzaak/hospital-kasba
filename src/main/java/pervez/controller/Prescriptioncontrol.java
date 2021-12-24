package pervez.controller;

import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import pervez.model.Drugg;
import pervez.model.Medicine;
import pervez.model.Doctor;
import pervez.model.Prescription;
import pervez.model.Patient;
import pervez.repo.Doctorrepo;
import pervez.repo.Medicinerepo;
import pervez.repo.Prescriptionrepo;
import pervez.repo.Studentreo;

@Controller
@RequestMapping("/pres")
public class Prescriptioncontrol {
	@Autowired
	Studentreo sr;
	@Autowired
	Doctorrepo drp;
	@Autowired
	Medicinerepo mr;
	@Autowired
	Prescriptionrepo prr;
	
	@RequestMapping(value="/prescribe/{sid}/{did}")
public ModelAndView prescribe(@PathVariable Integer sid,
		@PathVariable Integer did
		) {
		Patient st = sr.findById(sid).get();
		Doctor dr = drp.findById(did).get();
	Prescription pr= new Prescription();
	pr.setAge(st.getAge());pr.setSex(st.getGender());pr.setName(st.getName());pr.setDrname(dr.getName());
	pr.setPtid(st.getSid());
	pr.setDrid(dr.getDid());
    List<Drugg> lst = new ArrayList<Drugg>();
	lst.add(new Drugg());lst.add(new Drugg());
	pr.setDruglist(lst);
	String prr = new Gson().toJson(pr);
	ModelAndView mv = new ModelAndView("prscribe");
	mv.addObject("pro",prr);
	//request.setAttribute("prs",prr);we can convert it in js in jsp page as var x = <%=request.getAttribute("prs")
	mv.addObject("dr", dr);
    return mv;	
}
	
	 
	

	@PostMapping(value="/medilike",
			consumes=MediaType.TEXT_PLAIN_VALUE,
			produces=MediaType.APPLICATION_JSON_VALUE)
public ResponseEntity<List<Medicine>> prescribe(@RequestBody String q) {
List<Medicine> lst = mr.findByNameContaining(q);
if(lst.isEmpty()) {
	lst.add(new Medicine("","","",0,"","",0,0));
	lst.add(new Medicine("","","",0,"","",0,0));
}
 return new ResponseEntity<List<Medicine>>(lst,HttpStatus.OK);	
}	
	
	@PostMapping(value="/postpress")
public ResponseEntity<Prescription> postpress(@RequestBody Prescription pr) {
		pr.setPresnam((pr.getDrname()+"_"+pr.getName()+"_"+pr.getDate()));
         prr.save(pr);
 return new ResponseEntity<Prescription>(pr,HttpStatus.OK);	
}	
	
	
	@PostMapping(value="/patientcopy",consumes=MediaType.TEXT_PLAIN_VALUE)
public   ResponseEntity<List<Prescription>>	patientcopy(@RequestBody String pn) {
     
		List<Prescription> lst = prr.findByName(pn);
		
 return new ResponseEntity<List<Prescription>>(lst,HttpStatus.OK);	
}		

	
	@PostMapping(value="/drcopy",consumes=MediaType.TEXT_PLAIN_VALUE)
public   ResponseEntity<List<Prescription>>	drcopy(@RequestBody String f) {
   List<Prescription> lst = prr.findByDridOrderByPresidDesc(Integer.parseInt(f));
		
 return new ResponseEntity<List<Prescription>>(lst,HttpStatus.OK);	
}		
	
	@RequestMapping(value="/downloadpres/{prid}")
public  ModelAndView patientcopy(@PathVariable Integer prid) {
     ModelAndView mv = new ModelAndView("prespage");
Prescription pr = prr.getOne(prid);

Doctor dr = drp.findById(pr.getDrid()).get();
	mv.addObject("pres",pr);
	mv.addObject("dr", dr);
 return mv;	
}		
	
	
	
	

}
