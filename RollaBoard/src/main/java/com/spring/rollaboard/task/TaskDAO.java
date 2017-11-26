package com.spring.rollaboard.task;

import java.util.ArrayList;

public interface TaskDAO {
	
	public ArrayList<TaskVO> getMyTasks(String mem_id);
	
	public ArrayList<TaskVO> getTasksByBoard( int board_id ) ;	// 석원.

	public TaskVO getTask(int id);
	
	ArrayList<TaskVO> getTasks();

	public void createTaskWithRole(TaskVO taskVO, int role_id);
	
	public void updateTask(TaskVO taskVO);

	public void deleteTask(int id); // 선행TASK와 후행 TASK가 존재하면 처리해서 지워야함

	public void createTask(TaskVO taskVO);
	
	public void taskToRole(int task_id, int role_id);

	public void pushComplete(int task_id);
	public void cancelComplete(int task_id);
	
	public boolean checkStatus(int task_id, String status);
}
