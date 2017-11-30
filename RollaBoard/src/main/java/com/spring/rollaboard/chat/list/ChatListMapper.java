package com.spring.rollaboard.chat.list;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface ChatListMapper {

	public ArrayList<ChatListVO> getChatList(@Param("memId") String memId, @Param("boardId") int boardId);

	public void createChatList(ChatListVO chatListVO);
	public void updateChatList(ChatListVO chatListVO);
	
	public void deleteChatList(@Param("chId") int chId, @Param("memId") String memId);
	public void updateRecentDate(@Param("chId") int chId, @Param("memId") String memId);	
	
}
