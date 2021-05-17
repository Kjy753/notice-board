package com.kjy.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kjy.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	@Test
	public void testExist() {
		 log.info(service);
		 // 객체가 null 이 아닌지 체크하는 문법
		 assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("등록작업");
		board.setContent("등록작업 테스트");
		board.setWriter("테스터");
		
		service.register(board);
		
		log.info("생성된 게시물의 번호는: "+board.getBno());
	}
	
	@Test
	public void testGetList() {
		
		service.getList().forEach(board -> log.info(board));
	}
}
