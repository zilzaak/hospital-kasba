package pervez.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import pervez.model.Doctor;
import pervez.repo.Doctorrepo;

@Controller
public class Fileuploader {
	@Autowired
	private Doctorrepo drr;
	@GetMapping(value="/findex")
	public String fileindex() {
		
		return "findex";
	}
	
	@PostMapping("/drupload")
public String  uploadfile(@RequestParam("file") MultipartFile file,
		HttpSession session) throws IOException{
		byte[] data = file.getBytes();
		File f = new File(file.getOriginalFilename());
		String path = session.getServletContext().getRealPath("/")+"static"+File.separator+"images"+File.separator+f.getName();
		System.out.println("the context path is as"+path);
		FileOutputStream fo = new FileOutputStream(path);
		fo.write(data);
		fo.close();
	
int did = (Integer) session.getAttribute("aid");
	Doctor dr = drr.findById(did).get();
	dr.setDrphotopath(path);dr.setFilename(f.getName());
	drr.save(dr);
	Gson g = new Gson();
	String jdr = g.toJson(dr);
session.setAttribute("drr", jdr);
	/* no need these lines 
	 s.setAttribute("photo", dr.getDrphotopath());s.setAttribute("photoname",f.getName());
	 final long x  = 100*1024;
	final long y=50*1024;
	 if(file.getSize()<y || file.getSize()>x) {
			//System.out.println("the file size is not perfect"+file.getSize()); 
	 }
	 else {
			System.out.println("the file size is perfect"+file.getSize());
	 }
	
	 BufferedImage bi = ImageIO.read(f);
	 System.out.println("the width of the file is"+bi.getHeight());
	 System.out.println("the length of the file is"+bi.getWidth());
	 */ 
		return "doctorprofile";
			}
	
}
