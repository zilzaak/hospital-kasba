package pervez.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.servlet.tags.form.PasswordInputTag;

import pervez.model.Admin;

public interface Adminrepo extends JpaRepository<Admin,Integer> {

	boolean existsByUsernameAndPassword(String user,PasswordInputTag p);
	
}
