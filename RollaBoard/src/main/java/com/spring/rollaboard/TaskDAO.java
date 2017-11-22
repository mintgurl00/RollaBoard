package com.spring.rollaboard;

import java.util.ArrayList;

public interface TaskDAO {
	public ArrayList<TaskVO> getTasks(int id);
	
	public ArrayList<TaskVO> getTasksByBoard( int board_id ) ;	// 석원.

	public TaskVO getTask(int id);
	
	ArrayList<TaskVO> getTasks();

	public void createTask(TaskVO taskVO); // 고급사항에서 받은 값들도 처리해야함

	public void updateTask(TaskVO taskVO);

	public void deleteTask(int id); // 선행TASK와 후행 TASK가 존재하면 처리해서 지워야함

	void insertTask(TaskVO taskVO);

	
}
