package com.spring.rollaboard.chat.list;

import org.springframework.stereotype.Component;

@Component
public class ChatListVO2 {

	private String chName;	//PRIMARY KEY(mem_id, ch_id)
	private int chId;
	private String visibility, status;
	private int notReadCount;
	
	public String getChName() {
		return chName;
	}
	public void setChName(String chName) {
		this.chName = chName;
	}
	public int getChId() {
		return chId;
	}
	public void setChId(int chId) {
		this.chId = chId;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getNotReadCount() {
		return notReadCount;
	}
	public void setNotReadCount(int notReadCount) {
		this.notReadCount = notReadCount;
	}
	
	
}
