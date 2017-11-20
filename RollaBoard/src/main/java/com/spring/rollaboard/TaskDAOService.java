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
	public ArrayList<TaskVO> getTasks(int id) {	// 석원. 이거 곧 지울 듯
		
		return null;
	}
	
	public ArrayList<TaskVO> getTasks() {
		ArrayList<TaskVO> taskList = new ArrayList<TaskVO>();
		TaskMapper taskMapper = sqlSession.getMapper(TaskMapper.class);	
		taskList = taskMapper.getTasks();
		return taskList;
	}


	@Override
	public void createTask(TaskVO taskVO) {
		TaskMapper taskMapper = sqlSession.getMapper(TaskMapper.class);
		taskMapper.createTask(taskVO);
		
	}
	
	@Override
	public void insertTask(TaskVO taskVO) {
		TaskMapper taskMapper = sqlSession.getMapper(TaskMapper.class);
		taskMapper.insertTask(taskVO);
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

	@Override
	public TaskVO getTask(int id, CmtVO cmtVO) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<TaskVO> getTasksByBoard2(int board_id, String keyword) {	// 석원
		ArrayList<TaskVO> taskList = new ArrayList<TaskVO>() ;
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		taskList = taskMapper.getTasksByBoard2( board_id , keyword ) ;
		return taskList ;
	}
	
	/*
	 * 조건, 정렬까지 포함해서 SELECT
	 * 매개변수4는 new TaskFilter[]{~,~,...}형태로 입력하면 됨.
	 * */
	public ArrayList<TaskVO> getTasksByBoard2(int board_id, String keyword, TaskFilter filter, TaskFilter[] order ) {	// 석원
		ArrayList<TaskVO> taskList = new ArrayList<TaskVO>() ;
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		String condition = "" ;
		String sort = "" ;
		
		taskList = taskMapper.getTasksByBoard3( board_id , keyword , condition , sort ) ;
		filter = TaskFilter.F_DUEDATE ;
		return taskList ;
	}
}
