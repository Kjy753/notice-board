package com.kjy.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kjy.domain.AttachFileDTO;

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
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("update ajax post................");
		List<AttachFileDTO> list = new ArrayList<>(); // 업로드할 객체정보를 리스트로 만듬
		String uploadFolder = "D:\\upload"; // 업로드할 폴더 경로
		
		String uploadFolderPath = getFolder();
		//폴더 생성
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path :"+uploadPath);
		
		if(uploadPath.exists() == false) {
			//업로드 파일의 경로가 존재하지 않을경우 
			uploadPath.mkdirs();
			//yyyy/MM/dd 폴더 생성
		}
		
		for(MultipartFile multipartFile: uploadFile) {

			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			// IE로 연결시 file path 
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			
			attachDTO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID(); // 중복된 이름을 업로드시 덮어쓰기가 아닌 새로운 파일로 인식하기위한 랜덤 아이디값 uuid 생성 
			uploadFileName = uuid.toString() + "_" + uploadFileName;  //  랜덤값 + "_" + 파일 이름 형식으로 다시 작성 

			
			try {
				//File saveFile = new File(uploadFolder, uploadFileName);
				File saveFile = new File(uploadPath, uploadFileName); // 파일을 uploadPath를 통해 년/월/일 폴더를 생성해 파일 을 저장
			
				multipartFile.transferTo(saveFile);
			
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
				
				// check image type file
				if(checkImageType(saveFile)) {
					
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+ uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,100,100);
					
					thumbnail.close();
				}
				
				// 리스트에 전달할 객체 정보를  추가 
				list.add(attachDTO);
			}catch(Exception e) {
				log.error(e.getMessage());
			}//end catch
			
		} // end for
		return new ResponseEntity<>(list, HttpStatus.OK);
		
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){  // 특정한 파일 이름을 받아서 이미지 데이터를 전송하는 컨트롤러 
		log.info("fileName: " + fileName);
		
		File file = new File("D:\\upload\\" + fileName);

		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping(value= "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent,String fileName) {
		
		log.info("download file: "+ fileName);
		
		Resource resource = new FileSystemResource("d:\\upload\\" + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		log.info("resource: " + resource);
		
		String resourceName = resource.getFilename(); // 다운로드될 파일 이름
		
		// uuid 제거
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1); 
		
		HttpHeaders headers = new HttpHeaders(); //httpHeaders 객체를 생성 
		try {
			String downloadName = null;
			
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+"," ");
			}else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			}else {
				log.info("Chrome browser");
				downloadName =new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
				
			}
			log.info("downloadName: " + downloadName);
			headers.add("Content-Disposition", "attachment; filename=" +downloadName);
						// 다운로드시 저장되는 이름 지정, 다운로드되는 파일이름 아직 IE 에서는 에러가 발생 할 예정i
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource,headers, HttpStatus.OK);
		
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deletFile(String fileName, String type){
		
		log.info("deleteFile: "+ fileName);
		
		File file; 
		
		try {
			file = new File("d:\\upload\\"+ URLDecoder.decode(fileName,"UTF-8"));
			
			file.delete();
			
			if(type.equals("image")) {
				
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName: " + largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
}
