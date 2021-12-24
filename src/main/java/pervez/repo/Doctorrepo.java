package pervez.repo;

import pervez.model.Doctor;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
public interface Doctorrepo  extends JpaRepository<Doctor,Integer>{
	public List<Doctor> findByName(String name);	
	public List<Doctor> findByNameAndPassword(String name,String password);
	
	public List<Doctor> findByExpertintContaining(String q);
   
}
