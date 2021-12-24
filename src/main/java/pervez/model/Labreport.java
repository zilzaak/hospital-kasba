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
public class Labreport {

private int labid;
private String labuser;
private String labpassword;
private List<Meditest> mt;


public Labreport(String labuser, String labpassword) {
	super();
	this.labuser = labuser;
	this.labpassword = labpassword;
}
@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getLabid() {
	return labid;
}
public void setLabid(int labid) {
	this.labid = labid;
}

public String getLabuser() {
	return labuser;
}
public void setLabuser(String labuser) {
	this.labuser = labuser;
}
public String getLabpassword() {
	return labpassword;
}
public Labreport() {
	super();
	// TODO Auto-generated constructor stub
}
public void setLabpassword(String labpassword) {
	this.labpassword = labpassword;
}

@OneToMany(cascade=CascadeType.ALL,orphanRemoval=true,fetch=FetchType.EAGER)
public List<Meditest> getMt() {
	return mt;
}
public void setMt(List<Meditest> mt) {
	this.mt = mt;
}
	
}
