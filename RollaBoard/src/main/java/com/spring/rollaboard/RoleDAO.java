package com.spring.rollaboard;

import java.util.ArrayList;

public interface RoleDAO {
	
	public ArrayList<RoleVO> getRoles(int board_id);
	
	public RoleVO getRole(int id);
	
	public void createRole(RoleVO roleVO);
	
	public void updateRole(RoleVO roleVO);
	
	public void deleteRole(RoleVO roleVO);
	
	public void allocateRole(RoleVO roleVO, MemVO memVO);
	
	public ArrayList<RoleAndTaskVO> getRolesByBoard( int board_id ) ;	// 석원.
	
	
}
