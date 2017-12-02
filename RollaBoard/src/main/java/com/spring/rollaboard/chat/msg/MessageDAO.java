package com.spring.rollaboard.chat.msg;

import java.util.ArrayList;

public interface MessageDAO {
	
	// 사용자 조작
	public ArrayList<MessageVO> getMessageList(int chId);	// 채팅룸의 메시지를 불러오기
	public void insertMessage(MessageVO messageVO);	// 메시지 저장
	
	// 내부 조작
	
}
