package com.kjy.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kjy.domain.BoardVO;
import com.kjy.domain.Criteria;
import com.kjy.domain.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		/* annotation 방식 */
		mapper.getList().forEach(board -> log.info(board));
	}

	@Test
	public void testGetList2() {
		/* mapper.xml 방식 */
		mapper.getList2().forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("new 사용자");
		
		mapper.insert(board);
		
		log.info(board);
	}

	@Test
	public void testInsertSelectKey() {
		
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글 select");
		board.setContent("새로 작성하는 내용select");
		board.setWriter("new 사용자");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	@Test
	public void testRead() {
		
		BoardVO board = mapper.read(5L);
	
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		log.info("Delete COUNT: "+ mapper.delete(3L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(4L);
		board.setTitle("새로 작성하는 글 update");
		board.setContent("새로 작성하는 내용 update");
		board.setWriter("update 사용자");
		
		int count = mapper.update(board);
		
		log.info("UPDATE COUNT:"+ count);
		
		
	}
	
	@Test
	public void testPaging() {
		
		Criteria cri = new Criteria();
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(b -> log.info(b));
	}
	
	@Test
	public void testPageDTO() {
		
		Criteria cri = new Criteria();
		cri.setPageNum(25);
		
		PageDTO pageDTO = new PageDTO(cri, 251);
		
		log.info(pageDTO);
	}
}
