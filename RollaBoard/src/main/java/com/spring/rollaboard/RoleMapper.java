package com.spring.rollaboard;

import java.util.ArrayList;

public interface RoleMapper {

	ArrayList<RoleAndTaskVO> getRolesByBoard( int board_id ) ;
}
