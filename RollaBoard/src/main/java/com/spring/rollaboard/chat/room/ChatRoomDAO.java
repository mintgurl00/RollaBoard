package com.spring.rollaboard.chat.room;

public interface ChatRoomDAO {

	public void createChatRoom(ChatRoomVO chatRoomVO);	// 채팅룸 추가
	public void deleteChatRoom(int chId);	// 채팅룸 제거
	public void updateChatRoom(ChatRoomVO chatRoomVO);	// 채팅룸 정보 수정
	
}
