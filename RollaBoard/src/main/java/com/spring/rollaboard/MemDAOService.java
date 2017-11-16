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
	public ArrayList<MemVO> getMembers(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemVO getMember(MemVO memVO) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		return memMapper.getMember(memVO);
	}
	
	@Override
	public int chkMemberId(MemVO memVO) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		return memMapper.chkMemberId(memVO);
	}
	@Override
	public void insertMember(MemVO memVO) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		memMapper.insertMember(memVO);
		
	}

	@Override
	public void updateMember(MemVO memVO) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		memMapper.updateMember(memVO);
		
	}

	@Override
	public void deleteMember(String id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemVO getMemInfoToUpdate(String id) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		return memMapper.getMemInfoToUpdate(id);
	}

	
	
	
}
