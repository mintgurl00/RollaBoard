package com.spring.rollaboard.chat.mem;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface ChatMemMapper {

	public void createChatMem(@Param("chId") int chId, @Param("memId") String memId, @Param("roleId") int roleId);
	public void deleteChatMem(@Param("chId") int chId, @Param("memId") String memId, @Param("roleId") int roleId);
	
	public ArrayList<ChatMemVOEx> getChatMemEx(@Param("chId") int chId);
	
}
