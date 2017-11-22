package com.spring.rollaboard;

import java.util.ArrayList;

public interface BoardDAO {
	public ArrayList<BoardVO> getBoards(String id);

	public BoardVO getBoard(String name); // 규성. 보드이름으로 보드정보 가져옴(joinboard에 사용)

	public void createBoard(String board_name, String mem_id);

	public BoardVO getBoardInfo(int board_id); // 규성. 보드아이디로 보드정보 가져옴
	
	public String permitChk(int board_id, String mem_id); // 규성. 보드에 허가된 사람인지 체크

	public void updateBoard(BoardVO boardVO);

	public void deleteBoard(int id);
	
	public int joinBoardChk(int board_id, String mem_id);
	
	public void joinBoard(int board_id, String mem_id);

	public ArrayList<BoardVO> getRefBoards(int id);
	
	public void visibility(String visibility, String board_id);
	
	public void deleteRefBoard(int ref_id, int board_id);
	
//	public void addRefBoard(int ref_id, String board_id);
//	
//	public int getRefBoardId(String ref_board_name);


}