package pervez.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class Level {


private int lid;
private String lsid;
private String ldid;
private String lsname;
private String ldname;
private int slevel;
private int dlevel;
private String delta;

@Id
@GeneratedValue(strategy=GenerationType.AUTO)
public int getLid() {
	return lid;
}
public void setLid(int lid) {
	this.lid = lid;
}
public String getLsid() {
	return lsid;
}
public void setLsid(String lsid) {
	this.lsid = lsid;
}
public String getLdid() {
	return ldid;
}
public void setLdid(String ldid) {
	this.ldid = ldid;
}
public String getLsname() {
	return lsname;
}
public void setLsname(String lsname) {
	this.lsname = lsname;
}
public String getLdname() {
	return ldname;
}
public void setLdname(String ldname) {
	this.ldname = ldname;
}
public int getSlevel() {
	return slevel;
}
public void setSlevel(int slevel) {
	this.slevel = slevel;
}
public int getDlevel() {
	return dlevel;
}
public void setDlevel(int dlevel) {
	this.dlevel = dlevel;
}
public String getDelta() {
	return delta;
}
public void setDelta(String delta) {
	this.delta = delta;
}


}
