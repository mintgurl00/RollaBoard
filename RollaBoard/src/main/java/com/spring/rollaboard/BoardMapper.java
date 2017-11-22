package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
public interface BoardMapper {

	ArrayList<BoardVO> getRefBoards( int board_id ) ;	// 석원. 참조보드 명단 가져오기
	
	public ArrayList<BoardVO> getBoards(@Param("id") String id); //수민. 보드 명단 가져오기
	
	public BoardVO getBoard(String name);

	public void updateBoard(BoardVO boardVO); // 보드 이름 바꾸는거
	
	public BoardVO getBoardInfo(int board_id);
	
	public int joinBoardChk(@Param("board_id") int board_id, @Param("mem_id") String mem_id);
	
	public void createBoard(@Param("board_name") String board_name, @Param("mem_id") String mem_id);
	
	public void joinBoard(@Param("board_id") int board_id, @Param("mem_id") String mem_id);
	
	public String permitChk(@Param("board_id") int board_id, @Param("mem_id") String mem_id); // 규성. 보드에 허가된 사람인지 체크
	
	public void visibility(@Param("visibility") String visibility, @Param("board_id") String board_id);
	
	public void deleteRefBoard(@Param("ref_id") int ref_id, @Param("board_id") int board_id);
	
//	public void addRefBoard(@Param("ref_id") int ref_id, @Param("board_id") String board_id);
//	
//	public int getRefBoardId(@Param("ref_board_name") String ref_Board_name);
}
