package com.kjy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.kjy.domain.BoardVO;
import com.kjy.domain.Criteria;

public interface BoardMapper {

	@Select("select * from tbl_board order by bno desc")
	public List<BoardVO> getList();
	
	public List<BoardVO> getList2();
	
	
	public void insert(BoardVO board);
	/* insert 만 처리되고 생성된 pk 값을 알 필요가 없는 경우 */
	
	public void insertSelectKey(BoardVO board);
	/* insert 처리되고 생성된 pk 값을 알아야 하는 경우 */
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
}
