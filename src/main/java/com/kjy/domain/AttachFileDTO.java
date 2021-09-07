package com.kjy.domain;

import lombok.Data;

@Data
public class AttachFileDTO { // 첨부파일을 정보를 저장하는 클래스

	private String fileName; // 원본 파일의 이름
	private String uploadPath;  // 업로드 경로
	private String uuid; //uuid 값 
	private boolean image; // image인지 아닌지 구별 여부 
}
