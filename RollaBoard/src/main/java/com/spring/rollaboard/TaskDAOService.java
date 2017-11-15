package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TaskDAOService implements TaskDAO {

	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis)라이브러리가 제공하는 클래스

	@Override
	public ArrayList<TaskVO> getTasks(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TaskVO getTask(int id, CmtVO cmtVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void createTask(TaskVO taskVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateTask(TaskVO taskVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTask(int id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ArrayList<TaskVO> getTasksByBoard(int board_id) {	// 석원.
		ArrayList<TaskVO> taskList = new ArrayList<TaskVO>() ;
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		taskList = taskMapper.getTasksByBoard( board_id ) ;
		return taskList ;
	}
}
