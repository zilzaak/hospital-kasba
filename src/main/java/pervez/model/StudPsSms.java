package pervez.model;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class StudPsSms{
	
     public StudPsSms(String sid, String aid, String studsms, String pssms, Date date,String stringdate) {
		
		this.sid = sid;
		this.aid = aid;
		this.studsms = studsms;
		this.pssms = pssms;
		this.date = date;
		this.stringdate = stringdate;
	}
	private int id; 
 	 private String sid,aid;
 	 private String studsms,pssms,stringdate;
 	private  Date date;
     @Id
     @GeneratedValue(strategy=GenerationType.IDENTITY)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	
	public String getSid() {
		return sid;
	}
	public String getStringdate() {
		return stringdate;
	}
	public void setStringdate(String stringdate) {
		this.stringdate = stringdate;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getStudsms() {
		return studsms;
	}
	public void setStudsms(String studsms) {
		this.studsms = studsms;
	}
	public String getPssms() {
		return pssms;
	}
	public void setPssms(String pssms) {
		this.pssms = pssms;
	}
	public StudPsSms() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
