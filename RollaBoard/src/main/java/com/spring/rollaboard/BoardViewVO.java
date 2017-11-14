package com.spring.rollaboard;

import java.util.ArrayList;

/*
 * 석원.
 * 이거 조금 어려워 보일 수도 있는데 너무 놀라지 마세요.
 * section{ task{ role{} } } 대충 이런 겁니다.
 * */
// Component가 아닙니다. 이름은 비슷해도.
public class BoardViewVO {
	ArrayList<SectionMini> sectionList ;
	ArrayList<ArrayList<TaskMini>> taskList ;
	ArrayList<ArrayList<ArrayList<RoleMini>>> rolesList ;
	
	public class SectionMini{
		String name ;
		String id ;
	}
	public class TaskMini{
		String title ;
		String taskId ;
		// 여러가지 뭐 필요한 거 생각한 거. 막 그런 거
	}
	public class RoleMini{
		String roleName ;
		String roleId ;
		String Name ;
	}
}
