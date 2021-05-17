package com.kjy.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kjy.domain.BoardVO;
import com.kjy.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	// 생성자 주입 방식
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {
		// 등록
		log.info("register ===>"+board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		// 게시글 조회
		log.info("get  ==>"+bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		// 게시글 수정
		log.info("modify  ==>"+ board);
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<BoardVO> getList() {
		// 목록 구현
		log.info("목록 : ");
		return mapper.getList();
	}
	
	
	
	

}
