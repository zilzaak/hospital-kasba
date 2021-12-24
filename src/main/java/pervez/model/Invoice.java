package pervez.model;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table
public class Invoice {
private int invid;
private String type;
private String name;
private String power;
private int totalunit;
private int unitprice;
private int totalprice;
private String dimension;
private String company;
public String getCompany() {
	return company;
}
public void setCompany(String company) {
	this.company = company;
}
private Selldrug selldrug;


@ManyToOne(fetch=FetchType.EAGER)
@JoinColumn
public Selldrug getSelldrug() {
	return selldrug;
}
public void setSelldrug(Selldrug selldrug) {
	this.selldrug = selldrug;
}

public String getDimension() {
	return dimension;
}
public void setDimension(String dimension) {
	this.dimension = dimension;
}
@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getInvid() {
	return invid;
}
public void setInvid(int invid) {
	this.invid = invid;
}
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getPower() {
	return power;
}
public void setPower(String power) {
	this.power = power;
}
public int getTotalunit() {
	return totalunit;
}
public void setTotalunit(int totalunit) {
	this.totalunit = totalunit;
}
public int getUnitprice() {
	return unitprice;
}
public void setUnitprice(int priceperunit) {
	this.unitprice = priceperunit;
}
public int getTotalprice() {
	return totalprice;
}
public void setTotalprice(int totalprice) {
	this.totalprice = totalprice;
}
public Invoice( String company ,String type, String name, String power, int totalunit, int unitprice, int totalprice) {
	super();
	this.company=company;
	this.type = type;
	this.name = name;
	this.power = power;
	this.totalunit = totalunit;
	this.unitprice = unitprice;
	this.totalprice = totalprice;
}
public Invoice() {
	super();
	
                 }


}
