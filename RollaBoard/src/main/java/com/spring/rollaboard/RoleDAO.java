package com.spring.rollaboard;

import java.util.ArrayList;

public interface RoleDAO {
	
	public ArrayList<RoleVO> getRoles(int board_id);
	
	public RoleVO getRole(int id);
	
	public void createRole(RoleVO roleVO); // 규성
	
	public void updateRole(RoleVO roleVO); // 규성
	
	public void deleteRole(int id); // 규성
	
	public void allocateRole(int role_id, String mem_id);
	
	public ArrayList<RoleAndTaskVO> getRolesByBoard( int board_id ) ;	// 석원.
	
	public int getRoleIdByName(String name, int board_id); // 규성
	
}
