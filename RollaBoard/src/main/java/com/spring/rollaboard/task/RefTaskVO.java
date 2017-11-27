package com.spring.rollaboard.task;

import org.springframework.stereotype.Component;

@Component
public class RefTaskVO {
	
	private int refTaskId, refTaskSecId;
	private String refTaskName, refTaskSecName, refTaskStatus ;
	
	public int getRefTaskId() {
		return refTaskId;
	}
	public void setRefTaskId(int refTaskId) {
		this.refTaskId = refTaskId;
	}
	public int getRefTaskSecId() {
		return refTaskSecId;
	}
	public void setRefTaskSecId(int refTaskSecId) {
		this.refTaskSecId = refTaskSecId;
	}
	public String getRefTaskName() {
		return refTaskName;
	}
	public void setRefTaskName(String refTaskName) {
		this.refTaskName = refTaskName;
	}
	public String getRefTaskSecName() {
		return refTaskSecName;
	}
	public void setRefTaskSecName(String refTaskSecName) {
		this.refTaskSecName = refTaskSecName;
	}
	
	public RefTaskVO(){}	// 기본 생성자
	public RefTaskVO(int value){
		this.refTaskId = 0 ;
		this.refTaskName = "" ;
		this.refTaskSecId = 0 ;
		this.refTaskSecName = "" ;
		this.refTaskStatus = "" ;
	}
	
	public RefTaskVO copyFrom(RefTaskVO refTaskVO){
		this.refTaskId = refTaskVO.refTaskId ;
		this.refTaskName = refTaskVO.refTaskName ;
		this.refTaskSecId = refTaskVO.refTaskSecId ;
		this.refTaskSecName = refTaskVO.refTaskSecName ;
		this.refTaskStatus = refTaskVO.refTaskStatus ;
		return this;
	}
	
	public String getRefTaskStatus() {
		return refTaskStatus;
	}
	public void setRefTaskStatus(String refTaskStatus) {
		this.refTaskStatus = refTaskStatus;
	}
	
}
