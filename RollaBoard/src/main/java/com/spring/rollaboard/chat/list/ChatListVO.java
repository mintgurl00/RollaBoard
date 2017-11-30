package com.spring.rollaboard.chat.list;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class ChatListVO {

	private String memId;	//PRIMARY KEY(mem_id, ch_id, board_id)
	private int chId, board_id;
	private String status;
	private Date recentDate;
	
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
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
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
}
