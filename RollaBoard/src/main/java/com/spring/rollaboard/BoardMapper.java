package com.spring.rollaboard;

import java.util.ArrayList;

public interface BoardMapper {
	
	ArrayList<BoardVO> getRefBoards( int id ) ;	// 석원. 참조보드 명단 가져오기
	
	public BoardVO getBoard(String name);

	
	
	
}
