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
	 * 매개변수3,4는 new TaskFilter[]{~,~,...}형태로 입력하면 됨.
	 * */
	public ArrayList<TaskVO> getTasksByBoard2(int board_id, String keyword, TaskFilter[] filters, TaskFilter[] orders ) {	// 석원
		ArrayList<TaskVO> taskList = new ArrayList<TaskVO>() ;
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		String condition = "" ;
		String sort = "" ;
		TaskFilterSQL sql = TaskFilterSQL.getInstance() ;
		
		// 01 필터(조건) 처리
		if( filters != null ){
			// 유효성 검사인데 굳이... 뭐...
			HashSet<TaskFilter> hs = new HashSet<TaskFilter>() ;
			for( TaskFilter tf : filters ){
				if( ! hs.add( tf ) ){
					break ;
				}
			}
			if( hs.size() != filters.length ){
				System.out.println( "필터(조건) 사항에 중복있어요." ) ;
			}
			//////////////////////유효성 검사는 끝내고
			for( TaskFilter filter : filters ){
			switch( filter ){
				case F_CONNECTED :	// **연결 태스크 보기
					System.out.println( "연결 태스크 보기 만들어야 함");
					break ;
				case F_PRIORITY :	// **우선순위 필터
					condition += sql.get( filter ) ;
					if( orders == null ){	// 정렬이 비어있으면
						orders = new TaskFilter[]{ TaskFilter.PRIORITY_ASC } ;	// 우선순위가 1에 가까운 것부터 정렬
					}
					break ;
				case F_DUEDATE :	// **마감일 우선 보기
					condition += sql.get( filter ) ;
					if( orders == null ){
						orders = new TaskFilter[]{ TaskFilter.STATUS_AC } ;
					}
					break ;
				case F_ROLE :	//** 롤별 보여주기
					System.out.println( "롤별 태스크 보기 만들어야 함");
					break ;
				default:
					break;
				}
			}
		}
		
		// 02 정렬 처리
		if( orders != null ){	// 자 이제 해석해야 해
			// 유효성 검사인데 굳이... 뭐...
			HashSet<TaskFilter> hs = new HashSet<TaskFilter>() ;
			for( TaskFilter tf : orders ){
				if( ! hs.add( tf ) ){
					break ;
				}
			}
			if( hs.size() != orders.length ){
				System.out.println( "정렬 사항에 중복있어요." ) ;
			}
			//////////////////////유효성 검사는 끝내고
			//sort += "ORDER BY " ;
			
			int i = 0 ;
			do {
				sort += sql.get( orders[ i ] ) ;
				if( ++i < orders.length )
					sort += ", " ;
				else
					break ;
			} while ( true ) ;
		}
		if( ! sort.equals( "" ) ){
			if( ! condition.equals( "") ){	// 조건, 정렬 모두 있음
				taskList = taskMapper.getTasksByBoard3( board_id , keyword , condition , sort ) ;
			}else{	// 조건만 있음
				taskList = taskMapper.getTasksByBoard4( board_id , keyword , condition ) ;
			}
		}else{
			if( ! condition.equals( "") ){	// 정렬만 있음
				taskList = taskMapper.getTasksByBoard5( board_id , keyword , sort ) ;
			}else{	// 모두 없음
				taskList = taskMapper.getTasksByBoard2( board_id , keyword ) ;
			}
		}
		return taskList ;
	}
	
	public ArrayList<TaskVO> getTasksByBoard2(int board_id, String keyword, String filterString, String[] orderString ){
		
		return getTasksByBoard2(board_id, keyword, new String[]{ filterString } , orderString) ;
	}
	
	public ArrayList<TaskVO> getTasksByBoard2(int board_id, String keyword, String[] filterString, String[] orderString ){
		TaskFilterSQL taskFilter = TaskFilterSQL.getInstance() ;
		
		TaskFilter[] filter = null ;
		TaskFilter[] order = null ;
		
		
		if( filterString != null && filterString.length > 0 ){
			filter = new TaskFilter[ filterString.length ] ;
			for( int i = 0 ; i < filterString.length ; i++ ){
				// 필터(조건) 스트링에 이상한 문자열이 있는지 매번 검사까지 합니다.
				if( ( filter[ i ] = taskFilter.get( filterString[ i ] ) ) == null ){
					System.out.println( "조건 필터 문자열을 다시 확인해주세요." ) ;
				}
			}
		}
		 
		if( orderString != null && orderString.length > 0 ){
			order = new TaskFilter[ orderString.length ] ;
			for( int i = 0 ; i < orderString.length ; i++ ){
				// 오더 스트링에 이상한 문자열이 있는지 매번 검사까지 합니다.
				if( ( order[ i ] = taskFilter.get( orderString[ i ] ) ) == null ){
					System.out.println( "정렬 필터 문자열을 다시 확인해주세요." ) ;
				}
			}
		}
			
		return getTasksByBoard2(board_id, keyword, filter, order) ;
	}
	
	public ArrayList<TaskVO> getTasksByBoard2(int board_id, String keyword, TaskFilter filter, TaskFilter[] orders ){
		return getTasksByBoard2( board_id, keyword, new TaskFilter[]{ filter }, orders ) ;
	}
}
