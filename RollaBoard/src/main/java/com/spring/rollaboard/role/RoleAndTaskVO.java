package com.spring.rollaboard.role;

import org.springframework.stereotype.Component;

@Component
public class RoleAndTaskVO {
	
	private int taskId, roleId, memId;
	private String roleName, memName, roleColor;
	
	public int getTaskId() {
		return taskId;
	}
	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public int getMemId() {
		return memId;
	}
	public void setMemId(int memId) {
		this.memId = memId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getRoleColor() {
		return roleColor;
	}
	public void setRoleColor(String roleColor) {
		this.roleColor = roleColor;
	}

}
