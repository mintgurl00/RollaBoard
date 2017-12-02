package com.spring.rollaboard.chat.list;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface ChatListDAO {
	
	// 사용자 조작
	public void addChatList(ChatListVO chatListVO);	// 채팅룸 목록에 추가
	public void removeChatList(int chId, String memId);	// 채팅룸 목록에서 제거
	
	//public void hideChatList(int chId, String memId);	// 채팅룸 숨김
	//public void revealChatList(int chId, String memId);	// 채팅룸 숨김 해제 ]
	
	public void updateChatList(ChatListVO chatListVO);	// 수정
	
	public ArrayList<ChatListVO> getChatList(String memId, int board_id);	// 채팅리스트 불러오기
	public ArrayList<ChatListVO2> getChatList2(String memId, int board_id);
	
	// 내부 접근
	public void setOutChatList(int chId, String memId);	// 추방됨(?) 처리
	public void setInChatList(int chId, String memId);	// (다시)초대됨 처리
	
	public void readChatList(int chId, String memID);	// 읽기. 마지막으로 읽은 시간 갱신
	//public void updateChatRoom(ChatRoomVO chatRoomVO);
	public void updatePublicChLi(int chId);	// PUBLIC 채팅방 개설로 보드 멤버 전원에게 리스트 추가
	
}
