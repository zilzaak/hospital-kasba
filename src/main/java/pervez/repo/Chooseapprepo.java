package pervez.repo;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.ChooseAppointment;

public interface Chooseapprepo extends JpaRepository<ChooseAppointment,Integer>{

List<ChooseAppointment> findByChdateAndChdid(Date chdate,Integer chdid);	
boolean existsByChdateAndChdidAndChsid(Date chdate,Integer chdid,Integer chsid);
List<ChooseAppointment> findByChsid(int sid);
List<ChooseAppointment> findByStringdateAndChdid(String stringdate,Integer chdid);
List<ChooseAppointment> findByChdateBetweenAndChdid(Date d1,Date d2,int did);
List<ChooseAppointment> findByChdateAfterAndChdid(Date d1,int did);
List<ChooseAppointment> findByChdateBeforeAndChdid(Date d1,int did);
List<ChooseAppointment> findByChdid(int did);

}
