package com.kjy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.kjy.domain.BoardVO;

public interface BoardMapper {

	@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();
	
	public List<BoardVO> getList2();
	
	
	public void insert(BoardVO board);
	/* insert 만 처리되고 생성된 pk 값을 알 필요가 없는 경우 */
	
	public void insertSelectKey(BoardVO board);
	/* insert 처리되고 생성된 pk 값을 알아야 하는 경우 */
	
	public BoardVO read(Long bno);
}
