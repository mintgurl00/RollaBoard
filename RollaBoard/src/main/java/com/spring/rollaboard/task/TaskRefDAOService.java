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

/*	@Override
	public void addPreTask(int taskId, int preTaskId) {
		TaskRefMapper taskMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		if( isConnectedTask(preTaskId) )
			taskMapper.addPreTask(taskId, preTaskId);
		else
			createPreTask(taskId, preTaskId);
	}*/

/*	@Override
	public void addPostTask(int taskId, int postTaskId) {
		TaskRefMapper taskMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		if( isConnectedTask(postTaskId) ){
			taskMapper.addPostTask1of2(taskId, postTaskId);
			taskMapper.addPostTask1of2(taskId, postTaskId);
		} else
			createPostTask(taskId, postTaskId);
	}*/

	@Override
	public void insertByPreTask(int taskId, int preTaskId) {
		// preTask 지정 대상에 postTask가 있을 때
		TaskRefMapper taskMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskMapper.insertByPreTask1of2(preTaskId);
		taskMapper.insertByPreTask2of2(taskId, preTaskId);
	}

	@Override
	public void insertByPostTask(int taskId, int postTaskId) {
		// postTask 지정 대상에 preTask가 있을 때
		TaskRefMapper taskMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskMapper.insertByPreTask1of2(postTaskId);
		taskMapper.insertByPreTask2of2(taskId, postTaskId);
	}


	@Override
	public boolean isHavingPreTask(int taskId) {
		TaskRefMapper taskMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		if( taskMapper.isHavingPreTask( taskId ) > 0 )
			return true ;
		else
			return false;
	}

	@Override
	public boolean isHavingPostTask(int taskId) {
		TaskRefMapper taskMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		if( taskMapper.isHavingPostTask( taskId ) > 0 )
			return true ;
		else
			return false;
	}

	@Override
	public boolean isConnectedTask(int taskId) {
		TaskRefMapper taskMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		if( taskMapper.isConnectedTask( taskId ) > 0 )
			return true ;
		else
			return false;
	}

	@Override
	public void createPreTask(int taskId, int preTaskId) {
		TaskRefMapper taskMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskMapper.createPreTask(taskId, preTaskId);
		
		
	}

	@Override
	public void createPostTask(int taskId, int postTaskId) {
		createPreTask(postTaskId, taskId);
	}

	@Override
	public void addPreTask(int taskId, int preTaskId) {
		Case preTaskCase, taskCase ;
		preTaskCase = checkTaskConn(preTaskId);
		taskCase = checkTaskConn(taskId);
		if(preTaskCase==Case.PRECONN){
			if(taskCase==Case.POSTCONN){
				System.out.println( "대상[선].연결 : 선행T연결에 T연결을 뒤에잇기") ;
				linkConnection(preTaskId, taskId);
			}else{
				System.out.println( "대상[선].미연결 : 선행T연결에 T를 뒤에붙이기") ;
				appendTask(preTaskId, taskId);
			}
		}else if(preTaskCase==Case.POSTCONN){
			if(taskCase==Case.POSTCONN){
				System.out.println( "대상[후].연결 : *대상의후행T를끊고*선행T에 T연결을 뒤에잇기" ) ;
				cutPostTask(preTaskId);
				appendConnection(preTaskId, taskId);
			}else{
				System.out.println( "대상[후].미연결 : *대상의후행T를끊고*선행T에 T를 뒤에붙이기" ) ;
				cutPostTask(preTaskId);
				createConnection(preTaskId, taskId);
			}
		}else if(preTaskCase==Case.BOTHCONN){
			if(taskCase==Case.POSTCONN){
				System.out.println( "대상[선&후].연결 : *대상의후행T를끊고*선행T연결에 T연결을 뒤에잇기" ) ;
				cutPostTask(preTaskId);
				linkConnection(preTaskId, taskId);
			}else{
				System.out.println( "대상[선&후].미연결 : *대상의후행T를끊고*선행T연결에 T를 뒤에붙이기" ) ;
				cutPostTask(preTaskId);
				appendTask(preTaskId, taskId);
			}
		}else{
			if(taskCase==Case.POSTCONN){
				System.out.println( "대상[x].연결 : T연결에 선행T를 앞에붙이기" ) ;
				appendConnection(preTaskId, taskId);
			}else{
				System.out.println( "대상[x].미연결 : 선행T에 T를 뒤에붙이는 새 연결 만들기" ) ;
				createConnection(preTaskId, taskId);
			}
		}
		
	}

	@Override
	public void addPostTask(int taskId, int postTaskId) {
		Case postTaskCase, taskCase ;
		postTaskCase = checkTaskConn(postTaskId);
		taskCase = checkTaskConn(taskId);
		if(postTaskCase==Case.PRECONN){
			if(taskCase==Case.PRECONN){
				System.out.println( "대상[선].연결 : *대상의선행T를끊고*T연결에 후행T를 앞에붙이기") ;
				cutPreTask(postTaskId);
				appendTask(taskId, postTaskId);
			}else{
				System.out.println( "대상[선].연결 : *대상의선행T를끊고*T연결에 후행T를 앞에붙이기") ;
				createConnection(taskId, postTaskId);	
			}
		}else if(postTaskCase==Case.POSTCONN){
			if(taskCase==Case.PRECONN){
				System.out.println( "대상[후].연결 : T연결과 후행T연결을 잇기" ) ;
				linkConnection(taskId, postTaskId);
			}else{
				System.out.println( "대상[후].미연결 : 후행T연결에 T를 앞에붙이기" ) ;
				appendConnection(taskId, postTaskId);
			}
		}else if(postTaskCase==Case.BOTHCONN){
			if(taskCase==Case.PRECONN){
				System.out.println( "대상[선&후].연결 : *대상의선행T를끊고*T연결과 후행T연결을 잇기" ) ;
				cutPreTask(postTaskId);
				linkConnection(taskId, postTaskId);
			}else{
				System.out.println( "대상[선&후].미연결 : *대상의선행T를끊고*후행T연결에 T를 앞에붙이기" ) ;
				cutPreTask(postTaskId);
				appendConnection(taskId, postTaskId);
			}
		}else{
			if(taskCase==Case.PRECONN){
				System.out.println( "대상[x].연결 : T연결에 후행T를 뒤에붙이기" ) ;
				appendTask(taskId, postTaskId);
			}else{
				System.out.println( "대상[x].미연결 : T에 후행T가 뒤에붙는 새 연결 만들기" ) ;
				createConnection(taskId, postTaskId);
			}
		}
	}

	@Override
	public void cutPreTask(int taskId, int preTaskId) {
		Case preTaskCase, taskCase ;
		preTaskCase = checkTaskConn(preTaskId);
		taskCase = checkTaskConn(taskId);
		cutPreTask(taskId, taskCase, preTaskId, preTaskCase);
	}
	
	public void cutPreTask(int taskId, Case taskCase , int preTaskId, Case preTaskCase ) {
		if(preTaskCase==Case.BOTHCONN || preTaskCase==Case.PRECONN){
			if(taskCase==Case.BOTHCONN){
				System.out.println( "대상[선].연결 : 선행T연결과 T연결로 분리") ;
				divideConnction(preTaskId, taskId);
			}else{
				System.out.println( "대상[선].미연결 : T연결삭제") ;
				cutTail(taskId);
			}
		}else if(preTaskCase==Case.POSTCONN || preTaskCase==Case.NONE){
			if(taskCase==Case.BOTHCONN){
				System.out.println( "대상[x].연결 : 선행T연결삭제(+T연결재정렬)" ) ;
				cutHead(preTaskId);
			}else{
				System.out.println( "대상[x].미연결 : 선행T연결삭제, T연결삭제" ) ;
				perishConnection(preTaskId, taskId);
			}
		}
	}

	@Override
	public void cutPostTask(int taskId, int postTaskId) {
		Case postTaskCase, taskCase ;
		postTaskCase = checkTaskConn(postTaskId);
		taskCase = checkTaskConn(taskId);
		cutPostTask(taskId, taskCase, postTaskId, postTaskCase);
	}
	
	public void cutPostTask(int taskId) {
		int postTaskId = getPostTaskId(taskId) ;
		cutPostTask(taskId, postTaskId);
	}
	public void cutPreTask(int taskId) {
		int postTaskId = getPreTaskId(taskId) ;
		cutPreTask(taskId, postTaskId);
	}
	
	public void cutPostTask(int taskId, Case taskCase , int postTaskId, Case postTaskCase ) {
		if(postTaskCase==Case.BOTHCONN || postTaskCase==Case.POSTCONN){
			if(taskCase==Case.BOTHCONN){
				System.out.println( "대상[선].연결 : T연결과 후행T연결로 분리") ;
				divideConnction(taskId, postTaskId);
			}else{
				System.out.println( "대상[선].미연결 : T삭제, (+T연결재정렬)") ;
				cutHead(taskId);
			}
		}else if(postTaskCase==Case.PRECONN || postTaskCase==Case.NONE){
			if(taskCase==Case.BOTHCONN){
				System.out.println( "대상[x].연결 : 후행T연결삭제" ) ;
				cutTail(postTaskId);
			}else{
				System.out.println( "대상[x].미연결 : 후행T연결삭제, T연결삭제" ) ;
				perishConnection(taskId, postTaskId);
			}
		}
	}
	
	private Case checkTaskConn( int taskId ){
		if(isHavingPostTask(taskId)){
			if(isHavingPreTask(taskId))
				return Case.BOTHCONN ;
			else
				return Case.POSTCONN ; 
		}else{
			if(isHavingPreTask(taskId))
				return Case.PRECONN ;
			else
				return Case.NONE ;
		}
	}
	
	// 태스크의 연결상태 구분용
	enum Case{
		PRECONN, POSTCONN, BOTHCONN, 
		NONE,
		CONN
	}

	@Override
	public void linkConnection(int frontTask, int backTask) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskRefMapper.linkConnection(frontTask, backTask);
		turnBlocked(frontTask) ;
	}

	private void turnBlocked(int task_id) {
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		taskMapper.turnBlocked(task_id);
	}
	private void turnNormal(int task_id) {
		TaskMapper taskMapper = sqlSession.getMapper( TaskMapper.class ) ;
		taskMapper.turnNormal(task_id);
	}

	@Override
	public void appendTask(int tailId, int taskId) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskRefMapper.appendTask(tailId, taskId);
		turnBlocked(tailId) ;
	}

	@Override
	public void appendConnection(int taskId, int headId) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskRefMapper.appendConnection1of2(taskId, headId);
		taskRefMapper.appendConnection2of2(taskId, headId);
		turnBlocked(taskId) ;
	}

	@Override
	public void createConnection(int frontId, int backId) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskRefMapper.createConnection(frontId, backId);
		turnBlocked(frontId) ;
	}

	@Override
	public void divideConnction(int frontId, int backId) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskRefMapper.divideConnction(backId);
		turnNormal(backId);
	}

	@Override
	public void cutTail(int tailId) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskRefMapper.deleteTask(tailId);
		turnNormal(tailId);
	}

	@Override
	public void cutHead(int headId) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		int nextHeadId = taskRefMapper.getPostTaskId(headId);
		turnNormal(nextHeadId);turnNormal(headId);
		taskRefMapper.pullHead(headId);
		taskRefMapper.deleteTask(headId);
	}

	@Override
	public void perishConnection(int headId, int tailId) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		taskRefMapper.eraseConnection(headId);
		turnNormal(headId);turnNormal(tailId);
	}

	@Override
	public int getPreTaskId(int taskId) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		return taskRefMapper.getPreTaskId(taskId);
	}

	@Override
	public int getPostTaskId(int taskId) {
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		return taskRefMapper.getPostTaskId(taskId);
	}

	@Override
	public void pullFromConnection(int taskId) {	// 연결에서 뽑아내기(기존 연결은 유지)
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		if(taskRefMapper.isHavingPostTask(taskId)>0){
			taskRefMapper.hideFromConnection(taskId) ;
		}else{
		}
		taskRefMapper.deleteTask(taskId) ;
		turnNormal(taskId);
	}

	@Override
	public void breakConnection(int taskId) {	// 해당 Task를 없애고 연결을 분리시킴
		TaskRefMapper taskRefMapper = sqlSession.getMapper( TaskRefMapper.class ) ;
		if(isHavingPostTask(taskId)){
			int postTaskId = getPostTaskId(taskId);
			taskRefMapper.divideConnction(postTaskId);
			turnNormal(postTaskId);
		}
		turnNormal(taskId);
		taskRefMapper.deleteTask(taskId);
	}
}
