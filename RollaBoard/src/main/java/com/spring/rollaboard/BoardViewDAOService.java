package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardViewDAOService implements BoardViewDAO {

	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스

	@Override
	public ArrayList<ArrayList<TaskVO>> getTasks(int board_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<String> getSections(int board_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<BoardVO> getRefBoards(int board_id) {
		/*BoardViewMapper boardViewMapper = sqlSession.getMapper(MemMapper.class);
		memMapper.insertMember(memVO);*/
		ArrayList<BoardVO> refBoardList = new ArrayList<BoardVO>() ;
		
		BoardMapper boardMapper = sqlSession.getMapper( BoardMapper.class ) ;
		boardMapper.getRefBoards( board_id ) ;
		return null ;
	}

}
