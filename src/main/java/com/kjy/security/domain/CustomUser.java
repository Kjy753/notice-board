package com.kjy.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.kjy.domain.MemberVO;

import lombok.Getter;

@Getter
public class CustomUser extends User{



	private static final long serialVersionUID = 1L;
	
	private MemberVO member;

	/*
	 * org.springframework.security.core.userdetails.User 를 상속하기 떄문에 부모 클래스의 생성자를
	 * 호출후에야 밑에 정상적인 객체를 생성 가능.
	 */
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		
	}
	
	/* AuthVO 인스턴스는 GarntedAuthority 객체로 변환해야 하므로 stream()과 map() 를 이용해서 처리 */
	public CustomUser(MemberVO vo) {
		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		
		this.member = vo;
	}
}
