package com.spring.rollaboard.chat.list;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class ChatListVO {

	private String memId;	//PRIMARY KEY(mem_id, ch_id)
	private int chId;
	private String visibility, status;
	private Date recentDate;
	
	public ChatListVO(){}
	public ChatListVO(String memId, int chId){
		this.memId = memId;
		this.chId = chId;
	}
	
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public int getChId() {
		return chId;
	}
	public void setChId(int chId) {
		this.chId = chId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getRecentDate() {
		return recentDate;
	}
	public void setRecentDate(Date recentDate) {
		this.recentDate = recentDate;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	public ChatListVO setKey(String memId, int chId){
		this.memId = memId;
		this.chId = chId;
		return this;
	}
	
}
