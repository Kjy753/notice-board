package com.kjy.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.kjy.domain.MemberVO;
import com.kjy.mapper.MemberMapper;
import com.kjy.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService  implements UserDetailsService{
	
	@Setter(onMethod_ =@Autowired)
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		
		log.warn("Load user By UserName : " + userName);
		
		// userName 의 의미는 userid 
		MemberVO vo = memberMapper.read(userName);
		
		log.warn("queried by member mapper: "+ vo);
		
		return vo == null ? null : new CustomUser(vo);
	}

}