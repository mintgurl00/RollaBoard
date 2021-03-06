package com.spring.rollaboard.task;

import org.apache.ibatis.annotations.Param;

public interface TaskRefMapper {
	
	/////////// 관계
	public int isHavingPreTask( int id ) ;
	public int isHavingPostTask( int id ) ;
	public int isConnectedTask( int id ) ;
	public int getConnLength( int id ) ;
	public int checkSameConn(@Param("taskId1") int taskId1, @Param("taskId2") int taskId2) ;
	
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
	public void hideFromConnection(@Param("taskId") int taskId);	// 해당Task보다 큰 ref_level을가지고 있으면 ref_level-=1
	public void pullHead(@Param("headId") int headId);
	public void turnNormalConnByRoot(@Param("rootId") int rootId);	// *관계 제거하기 전에* normal 설정
	public void turnNormalConn(@Param("taskId") int taskId);
	public void eraseConnectionByRoot(@Param("rootId") int rootId);	// root TASK인 관계 전부 삭제
	public void eraseConnection(@Param("taskId") int taskId);
	
	public int getPreTaskId(int id);
	public int getPostTaskId(int id);
	
	/////////////관계태스크정보 가져오기
	public RefTaskVO getRefTask(@Param("taskId") int taskId, @Param("offset") int offset); // offset. -1:선행, +1:후행 
	
}
