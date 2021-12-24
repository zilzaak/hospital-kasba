package pervez.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.*;
public interface Levelrepo extends JpaRepository<Level,Integer>{
List<Level> findByLsidAndLdid(String lsid,String ldid);
List<Level> findByLdid(String ldid);
List<Level> findByLsid(String lsid);
List<Level> findByLdidAndDelta(String ldid,String delta);
List<Level> findByLsidAndDelta(String lsid,String delta);

	
}
