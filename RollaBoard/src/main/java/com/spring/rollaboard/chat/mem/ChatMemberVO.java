package com.spring.rollaboard.chat.mem;

import org.springframework.stereotype.Component;

@Component
public class ChatMemberVO {
	
	private int chId, roleId;
	private String memId;
	public int getChId() {
		return chId;
	}
	public void setChId(int chId) {
		this.chId = chId;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}	
}
