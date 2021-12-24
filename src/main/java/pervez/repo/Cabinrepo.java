package pervez.repo;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.Cabin;

public interface Cabinrepo extends JpaRepository<Cabin,Integer>{

	List<Cabin> findByName(String name);
	
	List<Cabin> findByBednoAndEnddateAfter(String name, Date d);
	
	List<Cabin> findByBednoOrderByEnddateDesc(String bedno);
	
	List<Cabin> findByAdmitBetween(Date d1,Date d2);
	
}
