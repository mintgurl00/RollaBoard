package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface RoleMapper {

	ArrayList<RoleAndTaskVO> getRolesByBoard( int board_id ) ;
	
	public ArrayList<RoleVO> getRoles(int board_id);
	
	public void deleteRole(@Param("id") int id);
}
