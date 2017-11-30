package com.spring.rollaboard.chat.msg;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.rollaboard.chat.mem.ChatMemMapper;
import com.spring.rollaboard.section.SectionVO;

@Service
public class MessageDAOService implements MessageDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<MessageVO> getMessageList(int chId) {
		ArrayList<MessageVO> messageList = new ArrayList<MessageVO>() ;
		MessageMapper messageMapper = sqlSession.getMapper( MessageMapper.class ) ;
		messageList = messageMapper.getMessageList(chId);
		return messageList;
	}

	@Override
	public void insertMessage(MessageVO messageVO) {
		MessageMapper messageMapper = sqlSession.getMapper( MessageMapper.class ) ;
		messageMapper.insertMessage(messageVO);
	}
}
