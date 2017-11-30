package com.spring.rollaboard.chat.room;

import org.springframework.stereotype.Component;

@Component
public class ChatRoomVO {
	
	private int id;
	private String name;
	private String description;
	private int boardId;
	private String visibility;
	private String creMemId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	public String getCreMemId() {
		return creMemId;
	}
	public void setCreMemId(String creMemId) {
		this.creMemId = creMemId;
	}
	
	
}
