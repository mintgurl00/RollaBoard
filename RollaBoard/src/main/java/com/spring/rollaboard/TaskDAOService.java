package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashSet;

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
		TaskFilterSQL sql = TaskFilterSQL.getInstance() ;
		
		if( filter != null || filter != TaskFilter.NONE ){
			switch( filter ){
			case F_CONNECTED :	// **연결 태스크 보기
				System.out.println( "연결 태스크 보기 만들어야 함");
				break ;
			case F_PRIORITY :	// **우선순위 필터
				condition += sql.get( filter ) ;
				if( order == null ){	// 정렬이 비어있으면
					order = new TaskFilter[]{ TaskFilter.PRIORITY_ASC } ;	// 우선순위가 1에 가까운 것부터 정렬
				}
				break ;
			case F_DUEDATE :	// **마감일 우선 보기
				condition += sql.get( filter ) ;
				if( order == null ){
					order = new TaskFilter[]{ TaskFilter.STATUS_AC } ;
				}
				break ;
			case F_ROLE :	//** 롤별 보여주기
				System.out.println( "롤별 태스크 보기 만들어야 함");
				break ;
			default:
				break;
			}
		}
		
		if( order != null ){	// 자 이제 해석해야 해
			// 유효성 검사인데 굳이... 뭐...
			HashSet<TaskFilter> hs = new HashSet<TaskFilter>() ;
			for( TaskFilter tf : order ){
				if( ! hs.add( tf ) ){
					break ;
				}
			}
			if( hs.size() != order.length ){
				System.out.println( "정렬 사항에 중복있어요." ) ;
			}
			//////////////////////유효성 검사는 끝내고
			sort += "ORDER BY " ;
			for( int i = 0 ; i < order.length ; ){
				if( i > 0 && i == 2 )
				sort += sql.get( order[ i ] ) ;
			}
			
			int i = 0 ;
			do {
				sort += sql.get( order[ i ] ) ;
				if( ++i < order.length )
					sort += ", " ;
				else
					break ;
			} while ( true ) ;
		}
		
		taskList = taskMapper.getTasksByBoard3( board_id , keyword , condition , sort ) ;
		
		return taskList ;
	}
}
