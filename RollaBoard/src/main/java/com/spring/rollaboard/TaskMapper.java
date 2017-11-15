package com.spring.rollaboard;

import java.util.ArrayList;

public interface TaskMapper {
	
	public ArrayList<TaskVO> getTasksByBoard( int board_id ) ;	// 석원.
	
}
