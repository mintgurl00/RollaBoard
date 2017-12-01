package com.spring.rollaboard.chat.msg;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface MessageMapper {

	public ArrayList<MessageVO> getMessageList(@Param("chId") int chId);
	
	public void insertMessage(MessageVO messageVO);
	
}
