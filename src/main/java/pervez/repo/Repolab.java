package pervez.repo;
import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.Labreport;

public interface Repolab extends JpaRepository<Labreport,Integer> {

	boolean existsByLabuser(String user);
	boolean existsByLabuserAndLabpassword(String user,String labpassword);
}
