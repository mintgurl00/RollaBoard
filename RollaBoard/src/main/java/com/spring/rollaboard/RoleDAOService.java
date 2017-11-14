package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoleDAOService implements RoleDAO {

	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스

	@Override
	public ArrayList<RoleVO> getRoles(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RoleVO getRole(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void createRole(RoleVO roleVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateRole(RoleVO roleVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteRole(RoleVO roleVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void allocateRole(RoleVO roleVO, MemVO memVO) {
		// TODO Auto-generated method stub
		
	}
	
	
}
