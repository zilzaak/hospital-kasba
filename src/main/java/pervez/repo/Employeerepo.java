package pervez.repo;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.Employee;
public interface Employeerepo extends JpaRepository<Employee,Integer>{
public List<Employee> findByDesignation(String r);
}
