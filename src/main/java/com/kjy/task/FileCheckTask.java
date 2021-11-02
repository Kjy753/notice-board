package com.kjy.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {

	@Scheduled(cron="0 * * * * *") // cron속성을 부여해서 주기를 제어
	public void checkFiles() throws Exception{
		log.warn("File Check Task run.........."); // 로그가 정상적으로 기록 되는지 확인하기 위해 실행중에 확인용 
		log.warn("====================================");
	}
}
