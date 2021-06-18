package com.kjy.mapper;

import com.kjy.domain.ReplyVO;

public interface ReplyMapper {
	
	// 댓글 등록
	public int insert(ReplyVO vo);
	// 댁글 조회
	public ReplyVO read(Long bno);

}
