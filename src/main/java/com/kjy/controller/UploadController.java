package com.kjy.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	@GetMapping("/uploadForm")
	public void uploadFrom() {
		
		log.info("upload form");
	}

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model	) {
		
		String uploadFolder = "D:\\upload";  // 업로드할 폴더 경로
		
		for( MultipartFile multipartFile : uploadFile) {
			
			log.info("---------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename()); // 저장될파일 
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				log.error(e.getMessage());
			}//end catch
		
		} //end for
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() { //ajax를 이용하는 파일 업로드
		 
		log.info("upload ajax");
	}
	
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);  // separator 을 이용해 파일의 경로를 구분 해준다.
	}
	
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch(IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("update ajax post................");
		
		String uploadFolder = "D:\\upload"; // 업로드할 폴더 경로
		
		//폴더 생성
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path :"+uploadPath);
		
		if(uploadPath.exists() == false) {
			//업로드 파일의 경로가 존재하지 않을경우 
			uploadPath.mkdirs();
			//yyyy/MM/dd 폴더 생성
		}
		
		for(MultipartFile multipartFile: uploadFile) {
			log.info("------------------------");
			log.info("Upload File name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			// IE로 연결시 file path 
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			
			UUID uuid = UUID.randomUUID(); // 중복된 이름을 업로드시 덮어쓰기가 아닌 새로운 파일로 인식하기위한 랜덤 아이디값 uuid 생성 
			uploadFileName = uuid.toString() + "_" + uploadFileName;  //  랜덤값 + "_" + 파일 이름 형식으로 다시 작성 

			
			try {
				//File saveFile = new File(uploadFolder, uploadFileName);
				File saveFile = new File(uploadPath, uploadFileName); // 파일을 uploadPath를 통해 년/월/일 폴더를 생성해 파일 을 저장
			
				multipartFile.transferTo(saveFile);
				// check image type file
				if(checkImageType(saveFile)) {
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+ uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,100,100);
					
					thumbnail.close();
				}
			}catch(Exception e) {
				log.error(e.getMessage());
			}//end catch
			
		} // end for
		
	}
}
