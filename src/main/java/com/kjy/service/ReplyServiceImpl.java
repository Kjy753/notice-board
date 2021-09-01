package com.kjy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kjy.domain.Criteria;
import com.kjy.domain.ReplyPageDTO;
import com.kjy.domain.ReplyVO;
import com.kjy.mapper.BoardMapper;
import com.kjy.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class ReplyServiceImpl implements ReplyService{

	//replyMapper만 주입 받던 방식에서 boardmapper도 추가로 주입 받아야 해서 setter 주입 방식으로 변경
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register....."+vo);
		boardMapper.updateReplyCnt(vo.getBno(), 1); //댓글 등록시 전달받은 replyvo 내의 게시물 번호를 이용하여 댓글을 추가.
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

	@Transactional
	@Override
	public int remove(Long rno) {
	
		log.info("remove...."+rno);
		
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1); // 댓글 삭제시 rno 만 받고 있기 떄문에 replyvo 에서 bno 를 알아와서 댓글을 삭제.
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		log.info("get Reply List of a Board " + bno);
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(
				mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno));
	}
	
	
	
	
	
}
