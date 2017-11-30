package com.spring.rollaboard.chat.list;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.rollaboard.chat.mem.ChatMemMapper;
import com.spring.rollaboard.chat.msg.MessageMapper;
import com.spring.rollaboard.chat.msg.MessageVO;

@Service
public class ChatListDAOService implements ChatListDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void addChatList(ChatListVO chatListVO) {
		ChatListMapper chatListMapper = sqlSession.getMapper( ChatListMapper.class ) ;
		chatListMapper.createChatList(chatListVO);
	}

	@Override
	public void removeChatList(int chId, String memId) {
		ChatListMapper chatListMapper = sqlSession.getMapper( ChatListMapper.class ) ;
		chatListMapper.deleteChatList(chId, memId);
	}
	

	@Override
	public void updateChatList(ChatListVO chatListVO) {
		ChatListMapper chatListMapper = sqlSession.getMapper( ChatListMapper.class ) ;
		chatListMapper.updateChatList(chatListVO);
	}

/*
	@Override
	public void hideChatList(int chId, String memId) {
		ChatListMapper chatListMapper = sqlSession.getMapper( ChatListMapper.class ) ;
	}

	@Override
	public void revealChatList(int chId, String memId) {
		// TODO Auto-generated method stub
		
	}
*/
	@Override
	public void setOutChatList(int chId, String memId) {
		ChatListMapper chatListMapper = sqlSession.getMapper( ChatListMapper.class ) ;
		ChatListVO tempCLVO = new ChatListVO(memId, chId);
		tempCLVO.setStatus("OUT");
		chatListMapper.updateChatList(tempCLVO);
	}

	@Override
	public void setInChatList(int chId, String memId) {
		ChatListMapper chatListMapper = sqlSession.getMapper( ChatListMapper.class ) ;
		ChatListVO tempCLVO = new ChatListVO(memId, chId);
		tempCLVO.setStatus("IN");
		chatListMapper.updateChatList(tempCLVO);
	}

	@Override
	public void readChatList(int chId, String memId) {
		ChatListMapper chatListMapper = sqlSession.getMapper( ChatListMapper.class ) ;
		chatListMapper.updateRecentDate(chId, memId);
	}

	@Override
	public ArrayList<ChatListVO> getChatList(String memId, int boardId) {
		ArrayList<ChatListVO> chatList = new ArrayList<ChatListVO>() ;
		ChatListMapper chatListMapper = sqlSession.getMapper( ChatListMapper.class ) ;
		chatList = chatListMapper.getChatList(memId, boardId);
		return chatList;
	}


}
