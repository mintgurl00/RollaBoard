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

	public ArrayList<TaskVOLite> getTaskIdList( @Param("board_id") int board_id, @Param("task_name") String task_name ) ;
	//public TaskVOLite getTaskId( @Param("task_name") String task_name, @Param("board_id") int board_id ) ;
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

	public void turnBlocked(@Param("task_id") int task_id);	// 석원 normal,complete->blocked
	public void turnNormal(@Param("task_id") int task_id);	// 석원 blocked,complete->normal
	public void turnComplete(@Param("task_id") int task_id);	// 석원 normal->complete
	public void turnStatusPostTask(@Param("task_id") int task_id, 
			@Param("status") String status, @Param("cond_status") String cond_status);	// 석원.
	public int checkStatus(@Param("task_id") int task_id, @Param("cond_status") String cond_status);	// 석원
	//public void turnBlockPostTask(@Param("task_id") int task_id);	//
	//public void cancelComplete(@Param("task_id") int task_id);	// 석원 complete->normal
	
}
