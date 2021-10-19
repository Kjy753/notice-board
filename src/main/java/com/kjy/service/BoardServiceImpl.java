package com.kjy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjy.domain.BoardAttachVO;
import com.kjy.domain.BoardVO;
import com.kjy.domain.Criteria;
import com.kjy.mapper.BoardAttachMapper;
import com.kjy.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {
	
	//2개의 mapper 를 주입 하기 떄문에 생성자 자동 주입에서 변경
	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_= @Autowired)
	private BoardAttachMapper attachMapper; 
	
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		// 등록
		log.info("register ===>"+board);
		
		mapper.insertSelectKey(board);
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			log.info("실패");
			return;
		}
		board.getAttachList().forEach(attach ->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
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

	@Transactional
	@Override
	public boolean remove(Long bno) {
		// 게시글 삭제
		log.info("remove ==>" +bno);
		
		// 첨부파일 삭제
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList() {
		// 목록 구현
		log.info("목록 : ");
		return mapper.getList();
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		// 페이징 목록 구현
		log.info("목록 : ");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno" + bno	);
		
		return attachMapper.findByBno(bno);
	}
	
	
	
	

}
