package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CmtDAOService implements CmtDAO {

	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스
	
	@Override
	public ArrayList<CmtVO> getCmts(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void createCmt(CmtVO cmtVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateCmt(CmtVO cmtVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCmt(int id) {
		// TODO Auto-generated method stub
		
	}

}
