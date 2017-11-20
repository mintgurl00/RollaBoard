package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface TaskMapper {
	//다시 수정 필요 !!!!!!!
	
	ArrayList<TaskVO> getTasks();
	
	public void createTask(TaskVO taskVO);
	
	public TaskVO getTask(TaskVO taskVO);
	
	public void insertTask(TaskVO taskVO);
	
	public void updateTask(TaskVO TaskVO);
	
	public ArrayList<TaskVO> getTasksByBoard( @Param("board_id") int board_id ) ;	// 석원.

	public ArrayList<TaskVO> getTasksByBoard2(
			@Param("board_id") int board_id, @Param("keyword") String keyword );	// 석원
	
	public ArrayList<TaskVO> getTasksByBoard3(
			@Param("board_id") int board_id, @Param("keyword") String keyword,
			@Param("conditionQuery") String conditionQuery, @Param("sortQuery") String sortQuery );	// 석원
	
}
