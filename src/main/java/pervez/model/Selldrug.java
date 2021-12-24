package pervez.model;

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

@Entity
@Table
public class Selldrug {

	public int storid;
	public String phone;
	private String deliverto;
	private String address;
	private Date date;
	private String msg;
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	private List<Invoice> invoices;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public int getStorid() {
		return storid;
	}
	
	public void setStorid(int storid) {
		this.storid = storid;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getDeliverto() {
		return deliverto;
	}
	
	public void setDeliverto(String deliverto) {
		this.deliverto = deliverto;
	}
	
	@OneToMany(targetEntity=Invoice.class,cascade=CascadeType.ALL,fetch=FetchType.EAGER,orphanRemoval=true)
	public List<Invoice> getInvoices() {
		return invoices;
	}
	
	
	
	public void setInvoices(List<Invoice> invoices) {
		this.invoices = invoices;
	}
	public Selldrug( String phone, String deliverto, List<Invoice> invoices) {
		super();
		this.phone = phone;
		this.deliverto = deliverto;
		this.invoices = invoices;
	}
	public Selldrug() {
		super();
		
	}
	
	
}
