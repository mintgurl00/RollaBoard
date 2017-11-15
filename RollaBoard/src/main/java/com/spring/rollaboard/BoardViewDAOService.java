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
	public ArrayList<SectionVO> getSections(int board_id) {
		ArrayList<SectionVO> sectionList = new ArrayList<SectionVO>() ;
		
		SectionMapper sectionMapper = sqlSession.getMapper( SectionMapper.class ) ;
		sectionList = sectionMapper.getSections( board_id ) ;
		return sectionList ;
	}

	@Override
	public ArrayList<BoardVO> getRefBoards(int board_id) {
		ArrayList<BoardVO> refBoardList = new ArrayList<BoardVO>() ;
		
		BoardMapper boardMapper = sqlSession.getMapper( BoardMapper.class ) ;
		refBoardList = boardMapper.getRefBoards( board_id ) ;
		return refBoardList ;
	}

}
