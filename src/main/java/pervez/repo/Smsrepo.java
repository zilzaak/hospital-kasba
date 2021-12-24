package pervez.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.StudPsSms;

public interface Smsrepo extends JpaRepository <StudPsSms,Integer>{

	List<StudPsSms> findByAidAndSid(String aid,String sid);
	
	
	
}
