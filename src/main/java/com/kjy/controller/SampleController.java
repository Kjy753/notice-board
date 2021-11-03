package com.kjy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/sample/*")
@Controller
public class SampleController {

	@GetMapping("/all")
	public void doAll() {
		// 로그인을 하지 않은 사용자도 접근 가능한 URI
		log.info("do all can access everybody");
		
	}
	
	@GetMapping("/member")
	public void doMember() {
		//로그인 한 사용자들만이 접근할 수 있는 URI
		log.info("logined member");
		
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		//로그인 한 사용자들 중에서 관리자 궈한을 가진 사용자만이 접근할 수 있는 URI
		log.info("admin only");
	}
	
	
	
	
	
	
}
