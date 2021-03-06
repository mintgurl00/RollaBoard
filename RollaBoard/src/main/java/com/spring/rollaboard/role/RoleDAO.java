package com.spring.rollaboard.role;

import java.util.ArrayList;
import java.util.HashMap;

public interface RoleDAO {
	
	public ArrayList<RoleVO> getRoles(int board_id);
	
	public RoleVO getRole(int id);
	
	public void createRole(RoleVO roleVO); // 규성
	
	public void updateRole(RoleVO roleVO); // 규성
	
	public void deleteRole(int id); // 규성
	
	public int chkAllocation(int role_id, String mem_id);
	
	public void allocateRole(int role_id, String mem_id);
	
	public void deallocateRole(int role_id, String mem_id);
	
	public HashMap<Integer, ArrayList<RoleAndTaskVO>> getRATByTasks( int board_id ) ;	// 석원.
	
	public int getRoleIdByName(String name, int board_id); // 규성
	
	public ArrayList<RoleVO> getRolesByMem(String mem_id, int board_id); // 규성.

	public ArrayList<RoleVO> getRolesByTask(int task_id);

	public void deallocateTask(int role_id, int task_id);
	
}
