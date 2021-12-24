package pervez.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table
public class Prescription implements Serializable{
	private int presid;
	private String name;
	private String drname;
	public String getDrname() {
		return drname;
	}
	public void setDrname(String drname) {
		this.drname = drname;
	}
	private int drid;
	private int ptid;
	public int getDrid() {
		return drid;
	}
	public void setDrid(int drid) {
		this.drid = drid;
	}
	public int getPtid() {
		return ptid;
	}
	public void setPtid(int ptid) {
		this.ptid = ptid;
	}
	private String age;
	private String test;
	private String sex;
	private String advice;
	private String presnam;
	private Date date;
	public String getPresnam() {
		return presnam;
	}
	public void setPresnam(String presnam) {
		this.presnam = presnam;
	}

	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	private List<Drugg> druglist;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getPresid() {
		return presid;
	}
	public void setPresid(int presid) {
		this.presid = presid;
	}

public String getTest() {
	return test;
}


public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getAge() {
	return age;
}
public void setAge(String age) {
	this.age = age;
}

@OneToMany(cascade=CascadeType.ALL,orphanRemoval=true,fetch=FetchType.EAGER)
public List<Drugg> getDruglist() {
	return druglist;
}
public void setDruglist(List<Drugg> druglist) {
	this.druglist = druglist;
}
public void setTest(String test) {
	this.test = test;
}



public Prescription(int presid, String name, int drid, int ptid, String age, String test, String sex,
		String advice, String presnam, Date date, List<Drugg> druglist,String drname) {
	super();
	this.presid = presid;
	this.name = name;
	this.drid = drid;
	this.ptid = ptid;
	this.age = age;
	this.test = test;
	this.sex = sex;
	this.advice = advice;
	this.presnam = presnam;
	this.date = date;
	this.druglist = druglist;
	this.drname = drname;
}
public Prescription() {
	super();
	
}
public String getSex() {
	return sex;
}
public void setSex(String sex) {
	this.sex = sex;
}
public String getAdvice() {
	return advice;
}
public void setAdvice(String advice) {
	this.advice = advice;
}



}

