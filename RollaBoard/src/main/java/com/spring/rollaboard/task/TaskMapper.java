package com.spring.rollaboard.task;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface TaskMapper {
	//다시 수정 필요 !!!!!!!
	
	ArrayList<TaskVO> getTasks();

	public void createTaskWithRole(TaskVO taskVO, int role_id); // 규성
	
	public TaskVO getTask(int id);
	
	public ArrayList<TaskVO> getMyTasks(String mem_id);
	
	public void createTask(TaskVO taskVO);
	
	public void updateTask(TaskVO TaskVO);
	
	public void deleteTask(int id);
	
	public ArrayList<TaskVO> getTasksByBoard( @Param("board_id") int board_id ) ;	// 석원.

	public ArrayList<TaskVO> getTasksByBoard2(
			@Param("board_id") int board_id, @Param("keyword") String keyword );	// 석원

	public ArrayList<TaskVO> getTasksByBoard3(
			@Param("board_id") int board_id, @Param("keyword") String keyword,
			@Param("conditionQuery") String conditionQuery, @Param("sortQuery") String sortQuery );	// 석원

	public ArrayList<TaskVO> getTasksByBoard4(
			@Param("board_id") int board_id, @Param("keyword") String keyword,
			@Param("conditionQuery") String conditionQuery );	// 석원
	
	public ArrayList<TaskVO> getTasksByBoard5(
			@Param("board_id") int board_id, @Param("keyword") String keyword,
			@Param("sortQuery") String sortQuery );	// 석원
	
	public void taskToRole(@Param("task_id") int task_id, @Param("role_id") int role_id);

	//public ArrayList<RoleAndTaskVO> getRATByBoard( @Param("board_id") int board_id );	//석원
	
	public int isHavingPreTask( int id ) ;
	public int isHavingPostTask( int id ) ;
	
}
