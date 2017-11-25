package com.spring.rollaboard.task;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class RefTaskVO {
	
	private int preTaskId, preTaskSecId;
	private String preTaskName, preTaskSecName ;
	private int postTaskId, postTaskSecId;
	
	public int getPreTaskId() {
		return preTaskId;
	}
	public void setPreTaskId(int preTaskId) {
		this.preTaskId = preTaskId;
	}
	public int getPreTaskSecId() {
		return preTaskSecId;
	}
	public void setPreTaskSecId(int preTaskSecId) {
		this.preTaskSecId = preTaskSecId;
	}
	public String getPreTaskName() {
		return preTaskName;
	}
	public void setPreTaskName(String preTaskName) {
		this.preTaskName = preTaskName;
	}
	public String getPreTaskSecName() {
		return preTaskSecName;
	}
	public void setPreTaskSecName(String preTaskSecName) {
		this.preTaskSecName = preTaskSecName;
	}
	public int getPostTaskId() {
		return postTaskId;
	}
	public void setPostTaskId(int postTaskId) {
		this.postTaskId = postTaskId;
	}
	public int getPostTaskSecId() {
		return postTaskSecId;
	}
	public void setPostTaskSecId(int postTaskSecId) {
		this.postTaskSecId = postTaskSecId;
	}
	public String getPostTaskName() {
		return postTaskName;
	}
	public void setPostTaskName(String postTaskName) {
		this.postTaskName = postTaskName;
	}
	public String getPostTaskSecName() {
		return postTaskSecName;
	}
	public void setPostTaskSecName(String postTaskSecName) {
		this.postTaskSecName = postTaskSecName;
	}
	private String postTaskName, postTaskSecName ;
	
}
