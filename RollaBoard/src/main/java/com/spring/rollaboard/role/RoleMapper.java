package com.spring.rollaboard.role;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface RoleMapper {

	ArrayList<RoleAndTaskVO> getRolesByBoard( @Param("board_id") int board_id ) ;
	
	public ArrayList<RoleVO> getRoles(int board_id);
	
	public RoleVO getRole(int id);
	
	public void createRole(RoleVO roleVO);
	
	public void deleteRole(@Param("id") int id);
	
	public void updateRole(RoleVO roleVO);
	
	public void allocateRole(@Param("role_id") int role_id, @Param("mem_id") String mem_id);
	
	public void deallocateRole(@Param("role_id") int role_id, @Param("mem_id") String mem_id);
	
	public int getRoleIdByName(@Param("name") String name, @Param("board_id") int board_id);
	
	public ArrayList<RoleAndTaskVO> getRATByBoard( @Param("board_id") int board_id );	//석원
}
