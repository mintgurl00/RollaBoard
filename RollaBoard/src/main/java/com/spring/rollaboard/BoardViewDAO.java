package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.rollaboard.board.BoardVO;
import com.spring.rollaboard.section.SectionVO;
import com.spring.rollaboard.task.TaskVO;

/*
 * 석원
 * 보드 페이지에 나올 내용을 불러온다. (예쁘게 보여주기)
 * */

public interface BoardViewDAO {
	
	public ArrayList< ArrayList<TaskVO> > getTasks( int board_id );	// 태스크 리스트. 섹션 순서대로 TaskVO ArrayList를 모아 둔다.
	public ArrayList<SectionVO> getSections( int board_id ) ;	// 섹션 리스트. 인덱스는 getTasks 반환 ArrayList와 같으니 주의.

	public ArrayList<BoardVO> getRefBoards( int board_id );	// 참조보드 불러오기
	
	//이거 막 해야해
	public class TaskAndRole{
		TaskVO task ;
		String roleName ;
		String name ;
		public String mem_id ;
	}
}