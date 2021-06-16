package com.kjy.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum; 
	private int amount;
	
	// 검색 조건 추가로 인해 추가되는 변수 
	private String type;
	private String keyword;
	
	
	public Criteria() {
		this(1,10);
	}

	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
	
		return type == null? new String[] {}: type.split("");
	}

	// 리다이렉션을 할때 여러개의 파라미터를 한번에 연결해서 URI 형태로 만들어주는 UriComponentsBuilder 사용
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
}
