package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface BoardMapper {
	
	public ArrayList<BoardVO> getRefBoards() ;	// 석원. 참조보드 명단 가져오기
	
	public ArrayList<BoardVO> getBoards(@Param("id") String id); //수민. 보드 명단 가져오기
	
	public BoardVO getBoard(String name);
	
	public int joinBoardChk(@Param("board_id") int board_id, @Param("mem_id") String mem_id);
	
	public void joinBoard(@Param("board_id") int board_id, @Param("mem_id") String mem_id);
	
	public void createBoard(@Param("board_name") String board_name, @Param("mem_id") String mem_id);
	
}
