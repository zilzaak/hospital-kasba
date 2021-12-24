package pervez.model;


import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class Cabin {
private int cid;
private String bedno;
private String name;
private String age;
private Date admit;
private  Date  enddate;
private String phone;
private String gender;
private String address;
private int duration;

public int getDuration() {
	return duration;
}
public void setDuration(int duration) {
	this.duration = duration;
}
public String getAddress() {
	return address;
}
public void setAddress(String address) {
	this.address = address;
}
public String getGender() {
	return gender;
}
public void setGender(String gender){
	this.gender = gender;
}


@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getCid() {
	return cid;
}
public void setCid(int cid) {
	this.cid = cid;
}

public String getBedno() {
	return bedno;
}
public void setBedno(String bedno) {
	this.bedno = bedno;
}

public String getAge() {
	return age;
}
public void setAge(String age) {
	this.age = age;
}
public Date getAdmit() {
	return admit;
}
public void setAdmit(Date admit) {
	this.admit = admit;
}

public Date getEnddate() {
	return enddate;
}

public void setEnddate(Date enddate) {
	this.enddate = enddate;
}

public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public Cabin(String bedno, String name, String age, Date admit, Date enddate, String phone,
		String gender, String address, int duration) {
	super();
	this.bedno = bedno;
	this.name = name;
	this.age = age;
	this.admit = admit;
	this.enddate = enddate;
	this.phone = phone;
	this.gender = gender;
	this.address = address;
	this.duration = duration;
}
public Cabin() {
	super();
	// TODO Auto-generated constructor stub
}


}
