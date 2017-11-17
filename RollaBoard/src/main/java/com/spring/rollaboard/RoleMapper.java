package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface RoleMapper {

	ArrayList<RoleAndTaskVO> getRolesByBoard( int board_id ) ;
	
	public ArrayList<RoleVO> getRoles(int board_id);
	
	public RoleVO getRole(int id);
	
	public void deleteRole(@Param("id") int id);
	
	public void updateRole(RoleVO roleVO);
}
