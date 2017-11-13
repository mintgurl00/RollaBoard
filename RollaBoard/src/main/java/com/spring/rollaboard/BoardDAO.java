package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface BoardDAO {
	public ArrayList<BoardVO> getBoards();

	public BoardVO getBoard(int id);

	public void createBoard(BoardVO boardVO);

	public void updateBoard(BoardVO boardVO);

	public void deleteBoard(int id);
}
