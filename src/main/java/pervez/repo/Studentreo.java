package pervez.repo;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.Patient;
public interface Studentreo extends JpaRepository<Patient,Integer>{

public List<Patient> findByName(String name);	
public List<Patient> findByNameAndPassword(String name,String password);	

}
