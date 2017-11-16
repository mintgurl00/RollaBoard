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

	/*
	 * 석원. 보드에서 각 태스크의 롤 정보를 친절하게 보여주기 위해 불러오는 메소드입니다.
	 * */
	@Override
	public ArrayList<RoleAndTaskVO> vetRolesByBoard(int board_id) {
		

		ArrayList<RoleAndTaskVO> roles = new ArrayList<RoleAndTaskVO>() ;
		RoleMapper roleMapper = sqlSession.getMapper(RoleMapper.class);
		roles = roleMapper.getRolesByBoard( board_id ) ;
		
		
		return roles ;
	}
	
	
}
