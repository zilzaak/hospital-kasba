package pervez.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class OnlineActiveMode {

	private int oaid;
	private int person;
	private String designation;
	private String active_status;
	private String name;
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	
	public int getOaid() {
		return oaid;
	}


	public void setOaid(int oaid) {
		this.oaid = oaid;
	}


	public OnlineActiveMode() {
		super();
		
	}
	
	
	public int getPerson() {
		return person;
	}
	public OnlineActiveMode(int person, String designation, String active_status,String name) {
		this.person= person;
		this.designation = designation;
	this.active_status = active_status;
	    this.name =name;	
	}
	public void setPerson(int person) {
		this.person = person;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getActive_status() {
		return active_status;
	}
	public void setActive_status(String active_status) {
		this.active_status = active_status;
	}
	
	
}
