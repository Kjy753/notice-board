package com.kjy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kjy.domain.Criteria;
import com.kjy.domain.ReplyVO;
import com.kjy.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class ReplyServiceImpl implements ReplyService{

	//생성자 주입 방식
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVO vo) {
		
		log.info("register....."+vo);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get.... "+ rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify....." + vo);
		
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
	
		log.info("remove...."+rno);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		log.info("get Reply List of a Board " + bno);
		
		return mapper.getListWithPaging(cri, bno);
	}
	
	
	
	
	
}