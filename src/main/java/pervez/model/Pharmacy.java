package pervez.model;


import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table
public class Pharmacy{

	private int pharmacy_id;
	private String pharmacyname;
	private String msg;
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getPharmacyname() {
		return pharmacyname;
	}

	public void setPharmacyname(String pharmacyname) {
		this.pharmacyname = pharmacyname;
	}
	private List<Medicine> medicines;
	
	public Pharmacy() {
		super();

	}
	
	
	public Pharmacy(String pharmacyname, List<Medicine> medicines,String msg) {
		super();
		this.pharmacyname = pharmacyname;
		this.medicines = medicines;
		this.msg = msg;
	}

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public int getPharmacy_id() {
		return pharmacy_id;
	}
	public void setPharmacy_id(int pharmacy_id) {
		this.pharmacy_id = pharmacy_id;
	}
	
	
	@OneToMany(targetEntity=Medicine.class,cascade=CascadeType.ALL,fetch=FetchType.EAGER,orphanRemoval=true)
   
	public List<Medicine> getMedicines() {
		return medicines;
	}
	public void setMedicines(List<Medicine> medicines) {
		this.medicines = medicines;
	}


	
}
