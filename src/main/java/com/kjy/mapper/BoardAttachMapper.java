package com.kjy.mapper;

import java.util.List;

import com.kjy.domain.BoardAttachVO;

// 첨부파일 정보 관련 메퍼
public interface BoardAttachMapper {

	// 추가
	public void insert(BoardAttachVO vo);
	//삭제
	public void delete(String uuid);
	// 특정 게시물번호로 찾기
	public List<BoardAttachVO> findByBno(Long bno);
	
	// 첨부파일 삭제 
	public void deleteAll(Long bno);
	
	// 첨부파일의 목록 구하기 
	public List<BoardAttachVO> getOldFiles();
	
}
