package com.spring.rollaboard.chat.mem;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatMemDAOService implements ChatMemDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void addChatMem(int chId, String memId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addChatMem(int chId, int roleId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeChatMem(int chId, String memId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeChatMem(int chId, int roleId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeAllChatMem(int chId) {
		// TODO Auto-generated method stub
		
	}

}
