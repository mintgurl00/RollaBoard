package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SectionDAOService implements SectionDAO {
	
	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스

	@Override
	public ArrayList<SectionVO> getSections(int board_id) {	// 석원. 보드에 맞는 섹션 리스트 반환
		ArrayList<SectionVO> sectionList = new ArrayList<SectionVO>() ;
		SectionMapper sectionMapper = sqlSession.getMapper( SectionMapper.class ) ;
		sectionList = sectionMapper.getSections( board_id ) ;
		
		return sectionList ;
	}

	@Override
	public SectionVO getSection(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void createSection(SectionVO sectionVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateSection(SectionVO sectionVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteSection(int id) {
		// TODO Auto-generated method stub
		
	}
}
