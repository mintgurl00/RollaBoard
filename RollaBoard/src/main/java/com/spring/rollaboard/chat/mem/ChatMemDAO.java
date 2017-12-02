package com.spring.rollaboard.chat.mem;

import java.util.ArrayList;

public interface ChatMemDAO {
	
	// 사용자 조작
	public void addChatMem(int chId, String memId);	// 채팅 멤버 초대(사람id)
	public void addChatMem(int chId, int roleId);	// 채팅 멤버 초대(ROLEid)
	public void removeChatMem(int chId, String memId);	// 채팅 멤버 추방(사람id)
	public void removeChatMem(int chId, int roleId);	// 채팅 멤버 추방(ROLEid)
	
	public ArrayList<ChatMemVOEx> getChatMemExList(int chId);	// 채팅 멤버 리스트 확장 가져오기	
	// 내부 조작
	public void removeAllChatMem(int chId);	// 전부 추방(채팅룸 삭제 시)
	
}
