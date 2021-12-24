package pervez.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import pervez.model.Invoice;

public interface Invoicerepo extends JpaRepository<Invoice,Integer> {

}
