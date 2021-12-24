package pervez.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class Remainstock {

	private int stockid;

	private String name;
	private String power;
	private String type;
	private String company;
	private int remainunit;
	private int unitprice;
	private int totalprice;
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	private String dimension;
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
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public int getStockid() {
		return stockid;
	}
	public void setStockid(int stockid) {
		this.stockid = stockid;
	}
	public String getName() {
		return name;
	}
	public void setName(String itemname) {
		this.name = itemname;
	}
	public String getPower() {
		return power;
	}
	public void setPower(String power) {
		this.power = power;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public int getRemainunit() {
		return remainunit;
	}
	public void setRemainunit(int remainunit) {
		this.remainunit = remainunit;
	}
	public Remainstock(String name, String power, String type, String company, int remainunit,int unitprice,int totalprice) {
		super();
		this.name = name;
		this.power = power;
		this.type = type;
		this.company = company;
		this.remainunit = remainunit;
		this.unitprice =unitprice;
		this.totalprice =totalprice;
	}
	public Remainstock() {
		super();
		
	          }
	
	
                     }
