package com.kjy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjy.domain.Criteria;
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
	
	// 댓글 목록 조회
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri, 
			@Param("bno") Long bno);
	// 댓글의 숫자 파악
	public int getCountByBno(Long bno);

}
