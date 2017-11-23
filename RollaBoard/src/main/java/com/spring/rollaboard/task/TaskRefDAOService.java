package com.spring.rollaboard.task;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TaskRefDAOService implements TaskRefDAO {

	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스

	@Override
	public boolean CanAddPreTask(int TargetTaskId) {	// 선행 태스크 생성 시 해당 태스크가. 삭제시 본 태스크에
		if( isHavingPostTask( TargetTaskId ) )	// 후행 연결이 있을 경우
			return false ;	// addPreTask() or insertByPreTask(). deletePreTask() or pullFromPreTask()
		else
			return true ;	// addPreTask(). pullFromPreTask()
	}

	@Override
	public boolean CanAddPostTask(int TargetTaskId) {
		if( isHavingPreTask( TargetTaskId ) )
			return false ;
		else
			return true ;
	}

	@Override
	public boolean CanDeletePreTask(int TargetTaskId) {
		if( isHavingPreTask( TargetTaskId ) )
			return false ;
		else
			return true ;
	}

	@Override
	public boolean CanDeletePostTask(int TargetTaskId) {
		if( isHavingPostTask( TargetTaskId ) )
			return false ;
		else
			return true ;
	}

	@Override
	public void addPreTask(int taskId, int preTaskId) {
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		if( isConnectedTask(preTaskId) )
			taskMapper.addPreTask(taskId, preTaskId);
		else
			createPreTask(taskId, preTaskId);
	}

	@Override
	public void addPostTask(int taskId, int postTaskId) {
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		if( isConnectedTask(postTaskId) ){
			taskMapper.addPostTask1of2(taskId, postTaskId);
			taskMapper.addPostTask1of2(taskId, postTaskId);
		} else
			createPostTask(taskId, postTaskId);
	}

	@Override
	public void insertByPreTask(int taskId, int preTaskId) {
		// preTask 지정 대상에 postTask가 있을 때
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		taskMapper.insertByPreTask1of2(preTaskId);
		taskMapper.insertByPreTask2of2(taskId, preTaskId);
	}

	@Override
	public void insertByPostTask(int taskId, int postTaskId) {
		// postTask 지정 대상에 preTask가 있을 때
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		taskMapper.insertByPreTask1of2(postTaskId);
		taskMapper.insertByPreTask2of2(taskId, postTaskId);
	}


	@Override
	public boolean isHavingPreTask(int taskId) {
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		if( taskMapper.isHavingPreTask( taskId ) > 0 )
			return true ;
		else
			return false;
	}

	@Override
	public boolean isHavingPostTask(int taskId) {
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		if( taskMapper.isHavingPostTask( taskId ) > 0 )
			return true ;
		else
			return false;
	}

	@Override
	public boolean isConnectedTask(int taskId) {
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		if( taskMapper.isConnectedTask( taskId ) > 0 )
			return true ;
		else
			return false;
	}

	@Override
	public void createPreTask(int taskId, int preTaskId) {
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		taskMapper.createPreTask(taskId, preTaskId);
		
		
	}

	@Override
	public void createPostTask(int taskId, int postTaskId) {
		createPreTask(postTaskId, taskId);
	}

	@Override
	public void cutPreTask(int taskId, int preTaskId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void cutPostTask(int taskId, int postTaskId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void pullFromConnection(int taskId) {
		// TODO Auto-generated method stub
		
	}
}
