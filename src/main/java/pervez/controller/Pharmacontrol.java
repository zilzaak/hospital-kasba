package pervez.controller;

import java.util.ArrayList;
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

import com.google.gson.Gson;

import pervez.model.Pharmacy;
import pervez.model.Remainstock;
import pervez.model.Selldrug;
import pervez.repo.Invoicerepo;
import pervez.repo.Medicinerepo;
import pervez.repo.Pharmarepo;
import pervez.repo.Remainstockrepo;
import pervez.repo.Selldrugrepo;
import pervez.model.Invoice;
import pervez.model.Medicine;

@Controller
@RequestMapping(value="/pharmacy")
public class Pharmacontrol {

@Autowired

Pharmarepo pr;
@Autowired

Medicinerepo mr;

@Autowired
Remainstockrepo rst;

@Autowired
Selldrugrepo sdr;

@Autowired
Invoicerepo ir;
	@RequestMapping(value="/pharma")
	public String pharma(HttpSession session) {
		
		Pharmacy pharma = new  Pharmacy();
		List<Medicine> medicines=new ArrayList<Medicine>();
		Medicine m1 = new Medicine("","","",0,"","",0,0);
		Medicine m2 = new Medicine("","","",0,"","",0,0);
		medicines.add(m1);medicines.add(m2);
		pharma.setMsg("succesfully item added");
		pharma.setPharmacyname("the green hospital");
		pharma.setMedicines(medicines);
		String p = new Gson().toJson(pharma);
		session.setAttribute("pharma", p);
		
	Selldrug selldrug = new Selldrug();	
	List<Invoice> invoices = new ArrayList<Invoice>();	
	Invoice i1 = new Invoice("","","","",0,0,0);
	Invoice i2 = new Invoice("","","","",0,0,0);
	invoices.add(i1);	 invoices.add(i2);
	selldrug.setInvoices(invoices);
	
	String selldru = new Gson().toJson(selldrug);
	session.setAttribute("selldrug", selldru);
	
	return "pharmacy";
	      
	}
	
	
	@PostMapping(value="/selldrug")
	public ResponseEntity<Selldrug> postpharma(@RequestBody Selldrug x) {
		Selldrug sd = new Selldrug();
		sd.setAddress(x.getAddress());sd.setDate(x.getDate());sd.setDeliverto(x.getDeliverto());
		sd.setPhone(x.getPhone());
	List<Invoice> lst = new ArrayList<Invoice>();
		for(Invoice i : x.getInvoices()) {
			Invoice i1 = new Invoice();
			
i1.setType(i.getType()); i1.setName(i.getName()); i1.setPower(i.getPower()); 
i1.setUnitprice(i.getUnitprice()); i1.setTotalunit(i.getTotalunit()); i1.setTotalprice(i.getTotalprice());
i1.setDimension(i.getDimension()); i1.setCompany(i.getCompany());
i1.setSelldrug(sd) ; 
lst.add(i1);
		            
		}
		
sd.setInvoices(lst);
	

String msg = "";   int err=0;    List<Remainstock> remlst = new ArrayList<Remainstock>();
    
    
  for(Invoice i : sd.getInvoices()) {
			
List<Remainstock> rlst = rst.findByNameIgnoreCaseAndPowerAndType(i.getName(),i.getPower(),i.getType());

if(!rlst.isEmpty()) {
	
	Remainstock rm =rlst.get(0); 
	
	if(i.getTotalunit()>rm.getRemainunit()) {
		msg=msg+"item"+i.getName()+i.getPower()+" is not enough("+rm.getRemainunit()+")in stock "+",  ";
		err++;
	}
	else {
		int remunit=rm.getRemainunit()-i.getTotalunit();
		int totalprice = remunit*i.getUnitprice();
		rm.setRemainunit(remunit);rm.setTotalprice(totalprice);
		remlst.add(rm);
	}
		
	}
else {
	msg=msg+"item"+i.getName()+i.getPower()+" is not found"+" , ";
	err++;
}
	
	
		            
	}   
			

	if(err<1) {
sdr.save(sd);
		 
for(Remainstock s : remlst){	

rst.save(s);
	
		}
msg="suucessfully created invoice";

	}
		
	 x.setMsg(msg);   
		
	
	
   
	return new ResponseEntity<Selldrug>(x,HttpStatus.OK);
      
	}		
	
	
	
	
	@PostMapping(value="/postpharma")
	public ResponseEntity<Pharmacy> postpharma(@RequestBody Pharmacy x) {
 String msg="";
 int err=0;
 
 List<Remainstock> rems=new ArrayList<Remainstock>();
	for(Medicine m : x.getMedicines()) {
	List<Remainstock> lst = rst.findByNameIgnoreCaseAndPowerAndType(m.getName(),m.getPower(),m.getType());
			if(lst.isEmpty()){
Remainstock rs = new Remainstock(m.getName(),m.getPower(),m.getType(),m.getCompany(),m.getTotalunit(),m.getUnitprice()
		,m.getTotalunit()*m.getUnitprice()); 
    if(m.getType().equalsIgnoreCase("tablet")){
	rs.setDimension(m.getDimension());
                                    }
       rems.add(rs);  
		
			}
      else {
	msg=msg+","+m.getName()+m.getPower();
	err++;
           }

			}
	if(err<1) {
		x.setMsg("success");
		pr.save(x);
	for(Remainstock r : rems) {
		rst.save(r);
	}
		
	}else{
		x.setMsg(msg+" "+"allready exist. want to add more???");
		
	}

return new ResponseEntity<Pharmacy>(x,HttpStatus.OK);
      

	}	
	
	
	
	
	
	@PostMapping(value="/postexistpharma")
	public ResponseEntity<Pharmacy> postexistpharma(@RequestBody Pharmacy x) {
		x.setMsg("successfully added");
		pr.save(x);	
			
for(Medicine m : x.getMedicines()) {
	List<Remainstock> lst = rst.findByNameIgnoreCaseAndPowerAndType(m.getName(),m.getPower(),m.getType());
			
if(lst.isEmpty()){
Remainstock rs = new Remainstock(m.getName(),m.getPower(),m.getType(),m.getCompany(),m.getTotalunit(),m.getUnitprice()
		,m.getTotalunit()*m.getUnitprice()); 
    if(m.getType().equalsIgnoreCase("tablet")) {
	rs.setDimension(m.getDimension());
                                    }
            rst.save(rs) ; 
		
			}
else {
	Remainstock rs = lst.get(0);
	rs.setRemainunit(m.getTotalunit()+rs.getRemainunit());
	rs.setUnitprice(m.getUnitprice());
	rs.setTotalprice(rs.getRemainunit()*rs.getUnitprice());
	rst.save(rs);
}

			}

return new ResponseEntity<Pharmacy>(x,HttpStatus.OK);
      
}
	
	
	
	

	
	
	@GetMapping(value="/storingrecord")
	public ResponseEntity<List<Medicine>> medirecord() {
List<Medicine> lst = mr.findAll();
return new ResponseEntity<List<Medicine>>(lst,HttpStatus.OK);
	}
	
	
	@PostMapping(value="/updat")
	public ResponseEntity<Medicine> updat(@RequestBody Medicine rec) {
       mr.save(rec);
return new ResponseEntity<Medicine>(rec,HttpStatus.OK);
	}
	

	@GetMapping(value="/allstock")
	public ResponseEntity<List<Remainstock>> allstock() {
       List<Remainstock> lst=rst.findAll();
return new ResponseEntity<List<Remainstock>>(lst,HttpStatus.OK);
	}	
	
	
	
	
}
