package pervez.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table
public class Drugg implements Serializable{
	private int drugid;
	private String drugtype;
	private String drugname;
	private String rules;
	private String days;
	private String consult;
	private String instruction;

	
	

@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getDrugid() {
	return drugid;
}
public void setDrugid(int drugid) {
	this.drugid = drugid;
}
public String getDrugtype() {
	return drugtype;
}
public void setDrugtype(String drugtype) {
	this.drugtype = drugtype;
}
public String getDrugname() {
	return drugname;
}
public void setDrugname(String drugname) {
	this.drugname = drugname;
}
public String getRules() {
	return rules;
}
public void setRules(String rules) {
	this.rules = rules;
}
public String getDays() {
	return days;
}
public void setDays(String days) {
	this.days = days;
}

public String getInstruction() {
	return instruction;
}
public void setInstruction(String instruction) {
	this.instruction = instruction;
}
public String getConsult() {
	return consult;
}
public void setConsult(String consult) {
	this.consult = consult;
}
public Drugg( String drugtype, String drugname, String rules, String days, String consult,
		String instruction) {
	super();
	
	this.drugtype = drugtype;
	this.drugname = drugname;
	this.rules = rules;
	this.days = days;
	this.consult = consult;
	this.instruction = instruction;
}

public Drugg() {
	super();
	
}


}
