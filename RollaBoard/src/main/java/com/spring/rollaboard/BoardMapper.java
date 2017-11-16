package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
public interface BoardMapper {
	
	ArrayList<BoardVO> getRefBoards( int id ) ;	// 석원. 참조보드 명단 가져오기
	
	public BoardVO getBoard(String name);

	
	public int joinBoardChk(@Param("board_id") int board_id, @Param("mem_id") String mem_id);
	
	public void joinBoard(@Param("board_id") int board_id, @Param("mem_id") String mem_id);
}
