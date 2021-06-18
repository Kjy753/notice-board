package com.kjy.mapper;

import com.kjy.domain.ReplyVO;

public interface ReplyMapper {
	
	// 댓글 등록
	public int insert(ReplyVO vo);
	// 댓글 조회
	public ReplyVO read(Long bno);
	// 댓글 수정
	public int update(ReplyVO vo);
	// 댓글 삭제
	public int delete(Long rno);
	

}
