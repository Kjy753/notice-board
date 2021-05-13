package com.kjy.service;

import java.util.List;

import com.kjy.domain.BoardVO;

public interface BoardService {
	/* 게시글 작성 */
	public void register(BoardVO board);
	/* 특정 게시글 조회 */
	public BoardVO get(Long bno);
	/* 특정 게시글 수정 */
	public boolean modify(BoardVO board);
	/* 특정 게시글 삭제 */
	public boolean remove(Long bno);
	/* 게시글 목록 조회 */
	public List<BoardVO> getList();
	
	

}
