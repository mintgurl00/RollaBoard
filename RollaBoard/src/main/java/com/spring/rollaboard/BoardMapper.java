package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface BoardMapper {
	
	ArrayList<BoardVO> getRefBoards() ;	// 석원. 참조보드 명단 가져오기
	
	ArrayList<BoardVO> getBoards(String id); //수민. 보드 명단 가져오기
	
	public BoardVO getBoard(String name);
	
}
