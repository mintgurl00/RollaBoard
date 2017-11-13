package com.spring.rollaboard;

import java.util.ArrayList;

public interface RoleDAO {
	
	public ArrayList<RoleVO> getRoles(int id);
	
	public RoleVO getRole(int id);
	
	public void createRole(RoleVO roleVO);
	
	public void updateRole(RoleVO roleVO);
	
	public void deleteRole(RoleVO roleVO);
	
	public void allocateRole(RoleVO roleVO, MemVO memVO);
	
	
}
