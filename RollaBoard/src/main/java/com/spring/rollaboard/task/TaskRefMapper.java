package com.spring.rollaboard.task;

import org.apache.ibatis.annotations.Param;

public interface TaskRefMapper {
	
	/////////// 관계
	public int isHavingPreTask( int id ) ;
	public int isHavingPostTask( int id ) ;
	public int isConnectedTask( int id ) ;
	
	public void addPostTask1of2(@Param("taskId") int taskId, @Param("postTaskId") int postTaskId) ;
	public void addPostTask2of2(@Param("taskId") int taskId, @Param("postTaskId") int postTaskId) ;
	public void addPreTask(@Param("taskId") int taskId, @Param("preTaskId") int preTaskId) ;

	public void createPreTask(@Param("taskId") int taskId, @Param("preTaskId") int preTaskId);
	
	public void insertByPreTask1of2(@Param("preTaskId") int preTaskId);
	public void insertByPreTask2of2(@Param("taskId") int taskId, @Param("preTaskId") int preTaskId);
	public void insertByPostTask1of2(@Param("postTaskId") int postTaskId);
	public void insertByPostTask2of2(@Param("taskId") int taskId, @Param("postTaskId") int postTaskId);
	
	
	////////////
	public void linkConnection(@Param("frontId") int frontId, @Param("backId") int backId);
	public void appendTask(@Param("tailId") int tailId, @Param("taskId") int taskId) ;
	public void appendConnection1of2(@Param("taskId") int taskId, @Param("headId") int headId) ;
	public void appendConnection2of2(@Param("taskId") int taskId, @Param("headId") int headId) ;
	public void createConnection(@Param("frontId") int frontId, @Param("backId") int backId);
	
	public void divideConnction(@Param("backId") int backId);
	public void deleteTask(@Param("taskId") int taskId);
	public void hideFromConnection(@Param("taskId") int taskId);
	public void pullHead(@Param("headId") int headId);
	public void eraseConnection(@Param("headId") int headId);
	
	public int getPreTaskId(int id);
	public int getPostTaskId(int id);
	
}
