package com.spring.rollaboard;

import java.util.ArrayList;

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

	@Override
	public BoardVO getBoard(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void createBoard(BoardVO boardVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateBoard(BoardVO boardVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoard(int id) {
		// TODO Auto-generated method stub
		
	}
}
