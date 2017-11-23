package com.spring.rollaboard.task.ref;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.rollaboard.task.TaskMapper;

@Service
public class TaskRefDAOService implements TaskRefDAO {

	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스

	@Override
	public boolean CanAddPreTask(int TargetTaskId) {
		if( isHavingPostTask( TargetTaskId ) )
			return false ;
		else
			return true ;
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
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addPostTask(int taskId, int postTaskId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertByPreTask(int taskId, int preTaskId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertByPostTask(int taskId, int postTaskId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePreTask(int taskId, int preTaskId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePostTask(int taskId, int postTaskId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void pullPreTask(int taskId, int preTaskId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void pullPostTask(int taskId, int postTaskId) {
		// TODO Auto-generated method stub
		
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
	
	
	
}
