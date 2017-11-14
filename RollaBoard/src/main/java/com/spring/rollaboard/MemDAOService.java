package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemDAOService implements MemDAO {
	
	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스

	@Override
	public ArrayList<MemVO> getMembers(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemVO getMember(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertMember(MemVO memVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMember(MemVO memVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMember(int id) {
		// TODO Auto-generated method stub
		
	}
	
	
}
