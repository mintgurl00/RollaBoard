package com.spring.rollaboard;

import java.util.ArrayList;

public interface TaskMapper {
	//다시 수정 필요 !!!!!!!
	
	ArrayList<TaskVO> getTasks();
	
	public void createTask(TaskVO taskVO);
	
	public TaskVO getTask(TaskVO taskVO);
	
	public void insertTask(TaskVO taskVO);
	
	public void updateTask(TaskVO TaskVO);
	
	public ArrayList<TaskVO> getTasksByBoard( int board_id ) ;	// 석원.
	
}
