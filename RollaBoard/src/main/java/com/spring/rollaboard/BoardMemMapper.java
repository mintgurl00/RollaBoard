package com.spring.rollaboard;

public interface BoardMemMapper {

	public int joinBoardChk(int board_id, String mem_id);
	
	public void joinBoard(int board_id, String mem_id);
	
}
