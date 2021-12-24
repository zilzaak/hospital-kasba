package pervez.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class Medicine {
private int medicine_id;
private String type;
private String name;
private String company;
private int totalunit;
private String power;
private String dimension;
private int unitprice;
private int totalprice;
private Date date;

public String getDimension() {
	return dimension;
}
public void setDimension(String dimension) {
	this.dimension = dimension;
}
public int getUnitprice() {
	return unitprice;
}
public void setUnitprice(int unitprice) {
	this.unitprice = unitprice;
}
public Date getDate() {
	return date;
}
public void setDate(Date date) {
	this.date = date;
}
@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
public int getMedicine_id() {
	return medicine_id;
}
public void setMedicine_id(int medicine_id) {
	this.medicine_id = medicine_id;
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


public String getCompany() {
	return company;
}
public void setCompany(String company) {
	this.company = company;
}




public Medicine() {
	super();
	
}

public int getTotalunit() {
	return totalunit;
}
public void setTotalunit(int totalunit) {
	this.totalunit = totalunit;
}
public String getPower() {
	return power;
}
public void setPower(String power) {
	this.power = power;
}
public int getPriceperunit() {
	return unitprice;
}
public void setPriceperunit(int priceperunit) {
	this.unitprice = priceperunit;
}
public int getTotalprice() {
	return totalprice;
}
public void setTotalprice(int totalprice) {
	this.totalprice = totalprice;
}
public Medicine(String type, String name, String company, int totalunit, String power,
		String dimension, int priceperunit, int totalprice) {
	super();
	this.type = type;
	this.name = name;
	this.company = company;
	this.totalunit = totalunit;
	this.power = power;
	this.dimension = dimension;
	this.unitprice = priceperunit;
	this.totalprice = totalprice;
}



}
