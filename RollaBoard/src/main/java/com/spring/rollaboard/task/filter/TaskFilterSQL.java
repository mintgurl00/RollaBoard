package com.spring.rollaboard.task.filter;

import java.util.HashMap;

public class TaskFilterSQL {
	private static TaskFilterSQL instance ;
	
	private static HashMap<TaskFilter, String> sql ;
	private static HashMap<String, TaskFilter> taskFilter ;
	
	/*
	 * 싱글톤
	 * */
	private TaskFilterSQL(){
		initSQL() ;
		initTaskFilter() ;
	}

	private void initTaskFilter() {
		taskFilter = new HashMap<String, TaskFilter>() ;
		taskFilter.put( "due" , TaskFilter.F_DUEDATE ) ;
		taskFilter.put( "priority" , TaskFilter.F_PRIORITY ) ;
	}

	public static TaskFilterSQL getInstance(){
		if( instance == null ){
			instance = new TaskFilterSQL() ;
		}
		return instance ;
	}
	
	private void initSQL() {
		sql = new HashMap<TaskFilter, String>() ;
		sql.put( TaskFilter.DUEDATE_ASC, "due_date ASC ") ;
		sql.put( TaskFilter.DUDATE_DESC, "due_date DESC ") ;
		sql.put( TaskFilter.PRIORITY_ASC, "priority ASC ") ;
		sql.put( TaskFilter.PRIORITY_DESC, "priority DESC ") ;
		sql.put( TaskFilter.STARTDATE_ASC, "start_date ASC ") ;
		sql.put( TaskFilter.STARTDATE_DESC, "start_date DESC ") ;
		sql.put( TaskFilter.CREDATE_ASC, "cre_date ASC ") ;
		sql.put( TaskFilter.CREDATE_DESC, "cre_date DESC ") ;
		sql.put( TaskFilter.NAME_ASC, "name ASC ") ;
		sql.put( TaskFilter.NAME_DESC, "name DESC ") ;
		sql.put( TaskFilter.STATUS_BNC, "DECODE(STATUS, 'BLOCKED', 1, 'NORMAL', 2, 'COMPLETE', 3 , 0 ) ASC ") ;
		sql.put( TaskFilter.STATUS_BCN, "DECODE(STATUS, 'BLOCKED', 1, 'NORMAL', 3, 'COMPLETE', 2 , 0 ) ASC ") ;
		sql.put( TaskFilter.STATUS_CBN, "DECODE(STATUS, 'BLOCKED', 3, 'NORMAL', 2, 'COMPLETE', 1 , 0 ) ASC ") ;
		sql.put( TaskFilter.STATUS_CNB, "DECODE(STATUS, 'BLOCKED', 2, 'NORMAL', 3, 'COMPLETE', 1 , 0 ) ASC ") ;
		sql.put( TaskFilter.STATUS_NBC, "DECODE(STATUS, 'BLOCKED', 2, 'NORMAL', 1, 'COMPLETE', 3 , 0 ) ASC ") ;
		sql.put( TaskFilter.STATUS_NCB, "DECODE(STATUS, 'BLOCKED', 3, 'NORMAL', 1, 'COMPLETE', 2 , 0 ) ASC ") ;
		sql.put( TaskFilter.STATUS_NA, "DECODE(STATUS, 'NORMAL', 1, 2 ) ASC ") ;
		sql.put( TaskFilter.STATUS_BA, "DECODE(STATUS, 'BLOCKED', 1, 2 ) ASC ") ;
		sql.put( TaskFilter.STATUS_CA, "DECODE(STATUS, 'COMPLETE', 1, 2 ) ASC ") ;
		sql.put( TaskFilter.STATUS_AN, "DECODE(STATUS, 'NORMAL', 1, 2 ) DESC ") ;
		sql.put( TaskFilter.STATUS_AB, "DECODE(STATUS, 'BLOCKED', 1, 2 ) DESC ") ;
		sql.put( TaskFilter.STATUS_AC, "DECODE(STATUS, 'COMPLETE', 1, 2 ) DESC ") ;
		
		sql.put( TaskFilter.F_DUEDATE, "AND due_date IS NOT NULL " ) ;
		sql.put( TaskFilter.F_PRIORITY, "AND priority IS NOT NULL " ) ;
	}
	
	public String get( TaskFilter taskFilter ){
		return sql.get( taskFilter ) ;
	}
	public TaskFilter get( String key ){
		return taskFilter.get( key ) ;
	}
	
	
}
