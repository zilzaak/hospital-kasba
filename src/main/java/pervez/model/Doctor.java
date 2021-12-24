package pervez.model;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table
public class Doctor{
private int did; 
private String drphone;
private String name,age,degree,
expertint,password,schedule,day,
drphotopath,filename;
 
  // private PersonalAssist ps;	
  
   public String getFilename() {
	return filename;
}
   public Doctor(int did ,String drphone, String name, String age, String degree, String expertint,String schedule,String day
			) {
		this.did=did;
		this.drphone = drphone;
		this.name = name;
		this.age = age;
		this.degree = degree;
		this.expertint = expertint;
		this.schedule = schedule;
		this.day = day;
	
	}
   
public Doctor(String drphone, String name, String age, String degree, String expertint, String password, String schedule,
		String day, String drphotopath, String filename) {

	this.drphone = drphone;
	this.name = name;
	this.age = age;
	this.degree = degree;
	this.expertint = expertint;
	this.password = password;
	this.schedule = schedule;
	this.day = day;
	this.drphotopath = drphotopath;
	this.filename = filename;

}
public Doctor() {

	// TODO Auto-generated constructor stub
}
public void setFilename(String filename) {
	this.filename = filename;
}

  public String getDay() {
	return day;
}
public void setDay(String day) {
	this.day = day;
}
public String getSchedule() {
	return schedule;
}
public void setSchedule(String schedule) {
	this.schedule = schedule;
}

public String getDrphone() {
	return drphone;
}
public void setDrphone(String drphone) {
	this.drphone = drphone;
}
public String getDrphotopath() {
	return drphotopath;
}
public void setDrphotopath(String drphotopath) {
	this.drphotopath = drphotopath;
}
public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}
@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
	public int getDid() {
		return did;
	}
	public void setDid(int did) {
		this.did = did;
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
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getExpertint() {
		return expertint;
	}
	public void setExpertint(String expertint) {
		this.expertint = expertint;
	}
	
		
	
}
