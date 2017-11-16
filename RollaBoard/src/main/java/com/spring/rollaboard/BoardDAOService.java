package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardDAOService implements BoardDAO {

	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스

	@Override //수민 board 명단 가져오기
	public ArrayList<BoardVO> getBoards(String id) {
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.getBoards(id);
	}

	@Override // 규성.
	public BoardVO getBoard(String name) {
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.getBoard(name);
	}
	
	@Override // 규성.
	public BoardVO getBoardInfo(int board_id) {
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.getBoardInfo(board_id);
	}
	
	@Override// 규성.
	public String permitChk(int board_id, String mem_id) {
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		System.out.println("board_id : " + board_id + " mem_id : " + mem_id);
		return boardMapper.permitChk(board_id, mem_id);
	}

	@Override
	public void createBoard(String board_name, String mem_id) {
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.createBoard(board_name, mem_id);
		
	}

	@Override
	public void updateBoard(BoardVO boardVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoard(int id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ArrayList<BoardVO> getRefBoards(int id) {	// 석원
		ArrayList<BoardVO> refBoardList = new ArrayList<BoardVO>() ;
		BoardMapper boardMapper = sqlSession.getMapper( BoardMapper.class ) ;
		refBoardList = boardMapper.getRefBoards( id ) ;
		return refBoardList;
	}
	public int joinBoardChk(int board_id, String mem_id) {
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.joinBoardChk(board_id, mem_id);
	}

	@Override
	public void joinBoard(int board_id, String mem_id) {
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.joinBoard(board_id, mem_id);
	}

	

	
}
