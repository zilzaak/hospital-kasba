package pervez.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.OnlineActiveMode;

public interface Onlineactiverepo extends JpaRepository<OnlineActiveMode,Integer>{
 List<OnlineActiveMode> findByDesignationAndName(String designation,String name);
 
 List<OnlineActiveMode> findByDesignation(String designation);
 
 List<OnlineActiveMode> findByPersonAndDesignation(Integer person,String designation);
	 
}
