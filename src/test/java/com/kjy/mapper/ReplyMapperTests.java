package com.kjy.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kjy.domain.Criteria;
import com.kjy.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	/* 테스트를 위해 미리 찾아본 게시글 번호 배열 */
	private Long[] bnoArr = {40L, 38L, 37L, 36L, 35L, 34L };

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info("================");
		log.info(mapper);
		log.info("================");
	}
	
	@Test
	public void testCreate() {
		
		IntStream.rangeClosed(1, 10).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
			
			// 게시물의 번호
			vo.setBno(bnoArr[i %5]);
			vo.setReply("댓클 테스트");
			vo.setReplyer("replyer" + i);
			
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testRead() {
		
		Long targetRno = 5L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
		
	}
	
	@Test
	public void testUpdate() {
		
		Long targetRno = 5L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		vo.setReply("테스트");
		
		int count = mapper.update(vo);
		
		log.info("update count : " + count);
		
	}
	
	@Test
	public void testDelte() {
		
		Long targetRno = 1L;
		
		mapper.delete(targetRno);
		
	}
	
	@Test
	public void testList() {
		
		Criteria cri = new Criteria();
		
		// 저장된 bno 배열의 N번째 조회
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2, 10); 
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 37L);
		
		replies.forEach(reply -> log.info(reply));
	}
}
