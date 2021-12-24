package pervez.repo;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.Prescription;
public interface Prescriptionrepo extends JpaRepository<Prescription,Integer> {

public List<Prescription> findByName(String name);
	
	public List<Prescription> findByDridOrderByPresidDesc(int drid);
	public List<Prescription> findByDrid(int drid);
	
}
