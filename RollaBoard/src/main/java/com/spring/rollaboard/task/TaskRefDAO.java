package com.spring.rollaboard.task;

/*
 * 석원.
 * 태스크 관계 관련
 * */
public interface TaskRefDAO {
	
	// 바로 처리가 되는지 확인.
	public boolean CanAddPreTask( int TargetTaskId ) ;
	public boolean CanAddPostTask( int TargetTaskId ) ;
	public boolean CanDeletePreTask( int TargetTaskId ) ;
	public boolean CanDeletePostTask( int TargetTaskId ) ;

	// 새 선/후행 태스크 관계 생성
	public void createPreTask(int taskId, int preTaskId) ;
	public void createPostTask(int taskId, int postTaskId) ;
	
	// 추가 또는 연결에 삽입
	public void addPreTask(int taskId, int preTaskId) ;
	public void addPostTask(int taskId, int postTaskId) ;
	public void insertByPreTask(int taskId, int preTaskId) ;
	public void insertByPostTask(int taskId, int postTaskId) ;

	// 제거 또는 연결에서 제외
	public void cutPreTask(int taskId, int preTaskId) ;
	public void cutPostTask(int taskId, int postTaskId) ;
	public void pullFromConnection(int taskId) ;

	// 선/후행 태스크 있는지 확인
	public boolean isHavingPreTask(int taskId) ;
	public boolean isHavingPostTask(int taskId) ;
	// 관계 태스크인지 확인
	public boolean isConnectedTask(int taskId) ;
	
}
