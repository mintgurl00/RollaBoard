package com.spring.rollaboard.chat.list;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatListDAOService implements ChatListDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void addChatList(ChatListVO chatListVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeChatList(ChatListVO chatListVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateChatList(ChatListVO chatListVO) {
		// TODO Auto-generated method stub
		
	}

}
