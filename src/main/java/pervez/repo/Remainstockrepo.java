package pervez.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.Remainstock;

public interface Remainstockrepo extends JpaRepository<Remainstock,Integer>{

	public List<Remainstock> findByNameIgnoreCaseAndPowerAndType(String name,String power,String type);
	boolean existsByNameAndPower(String name,String power);
	                                 


}
