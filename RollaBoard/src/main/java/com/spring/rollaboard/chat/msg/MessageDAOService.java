package com.spring.rollaboard.chat.msg;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageDAOService implements MessageDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<MessageVO> getMessageList(int chId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertMessage(MessageVO messageVO) {
		// TODO Auto-generated method stub
		
	}
}
