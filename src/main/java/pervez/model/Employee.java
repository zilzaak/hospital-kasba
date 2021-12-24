package pervez.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class Employee {
private int amid;
private String name;
private int age;
private String designation;
private String gender;
private String contact;
private String nid;
private String permanantaddress;

public String getGender() {
	return gender;
}
public void setGender(String gender) {
	this.gender = gender;
}


@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getAmid() {
	return amid;
}
public void setAmid(int amid) {
	this.amid = amid;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getAge() {
	return age;
}
public void setAge(int age) {
	this.age = age;
}
public String getDesignation() {
	return designation;
}
public void setDesignation(String designation) {
	this.designation = designation;
}
public String getContact() {
	return contact;
}
public void setContact(String contact) {
	this.contact = contact;
}
public String getPermanantaddress() {
	return permanantaddress;
}
public void setPermanantaddress(String permanantaddress) {
	this.permanantaddress = permanantaddress;
}
public String getNid() {
	return nid;
}
public void setNid(String nid) {
	this.nid = nid;
}

}
