package pervez.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.Medicine;

public interface Medicinerepo extends JpaRepository<Medicine,Integer>{
List<Medicine> findByNameContaining(String name);
	List<Medicine> findByTypeContaining(String type);
	List<Medicine> findByCompany(String company);
}
