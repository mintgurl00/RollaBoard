package com.spring.rollaboard.role;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoleDAOService implements RoleDAO {

	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스

	@Override
	public ArrayList<RoleVO> getRoles(int board_id) {
		RoleMapper roleMapper = sqlSession.getMapper(RoleMapper.class);
		return roleMapper.getRoles(board_id);
	}

	@Override
	public RoleVO getRole(int id) {
		RoleMapper roleMapper = sqlSession.getMapper(RoleMapper.class);
		return roleMapper.getRole(id);
	}

	@Override
	public void createRole(RoleVO roleVO) {
		RoleMapper roleMapper = sqlSession.getMapper(RoleMapper.class);
		roleMapper.createRole(roleVO);
		
	}

	@Override
	public void updateRole(RoleVO roleVO) {
		RoleMapper roleMapper = sqlSession.getMapper(RoleMapper.class);
		roleMapper.updateRole(roleVO);
		
	}

	@Override
	public void deleteRole(int id) {
		RoleMapper roleMapper = sqlSession.getMapper(RoleMapper.class);
		roleMapper.deleteRole(id);
		
	}

	/*
	 * 석원. 보드에서 각 태스크의 롤 정보를 친절하게 보여주기 위해 불러오는 메소드입니다.
	 * */
	public HashMap<Integer, ArrayList<RoleAndTaskVO>> getRATByTasks( int board_id ) {
		HashMap<Integer, ArrayList<RoleAndTaskVO>> ratMap = new HashMap<Integer, ArrayList<RoleAndTaskVO>>() ; 
		RoleMapper roleMapper = sqlSession.getMapper( RoleMapper.class ) ;
		
		ArrayList<RoleAndTaskVO> ratList = new ArrayList<RoleAndTaskVO>() ;
		ratList = roleMapper.getRATByBoard( board_id ) ;
		
		for( RoleAndTaskVO rat : ratList ){
			int taskId = rat.getTaskId() ;
			if( ratMap.get( taskId ) == null ){
				ratMap.put(taskId, new ArrayList<RoleAndTaskVO>() ) ;
			}
			ratMap.get( taskId ).add( rat ) ;
		}
		
		return ratMap;
	}
	
	// 규성 MEMBER를 ROLE에 배정
	@Override
	public void allocateRole(int role_id, String mem_id) {
		RoleMapper roleMapper = sqlSession.getMapper(RoleMapper.class);
		roleMapper.allocateRole(role_id, mem_id);
		
	}

	@Override
	public int getRoleIdByName(String name, int board_id) {
		RoleMapper roleMapper = sqlSession.getMapper(RoleMapper.class);
		return roleMapper.getRoleIdByName(name, board_id);
	}
	
	
}
