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
	public ArrayList<MemVO> getBoardMembers(int board_id) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		return memMapper.getBoardMembers(board_id);
	}
	
	@Override
	public ArrayList<MemVO> waitingMembers(int board_id) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		return memMapper.waitingMembers(board_id);
	}
	
	@Override
	public void admitMember(String mem_id) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		memMapper.admitMember(mem_id);
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
	public void deleteMember(String mem_id) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		memMapper.deleteMember(mem_id);
	}

	@Override
	public MemVO getMemInfoToUpdate(String id) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		return memMapper.getMemInfoToUpdate(id);
	}

	@Override
	public ArrayList<MemVO> getRoleMembers(int role_id) {
		MemMapper memMapper = sqlSession.getMapper(MemMapper.class);
		return memMapper.getRoleMembers(role_id);
	}
		
}
