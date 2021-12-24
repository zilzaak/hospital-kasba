package pervez.repo;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.Meditest;

public interface Repotest extends JpaRepository<Meditest,Integer> {

	List<Meditest> findByTestmaker(String user);
	List<Meditest> findByDateBefore(Date d);
	List<Meditest> findByDateAfter(Date d);
	List<Meditest> findByDateBetween(Date d1,Date d2);
	List<Meditest> findByAgeLessThan(Integer age);
	List<Meditest> findByAgeGreaterThan(Integer age);
	List<Meditest> findByAgeBetween(Integer age1,Integer age2);
	List<Meditest> findByPatientnameContaining(String x);
	
}
