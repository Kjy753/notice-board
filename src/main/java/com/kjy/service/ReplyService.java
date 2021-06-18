package com.kjy.service;

import java.util.List;

import com.kjy.domain.Criteria;
import com.kjy.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remoe(Long rno);
	
	public List<ReplyVO> getList(Criteria cri, Long bno);
}
