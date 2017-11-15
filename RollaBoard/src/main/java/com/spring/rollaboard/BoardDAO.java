package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface BoardDAO {
	public ArrayList<BoardVO> getBoards(String id);

	public BoardVO getBoard(BoardVO boardVO);

	public void createBoard(BoardVO boardVO);

	public void updateBoard(BoardVO boardVO);

	public void deleteBoard(int id);
}