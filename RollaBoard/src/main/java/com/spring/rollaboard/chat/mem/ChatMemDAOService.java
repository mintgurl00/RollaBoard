package com.spring.rollaboard.chat.mem;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.rollaboard.chat.room.ChatRoomMapper;

@Service
public class ChatMemDAOService implements ChatMemDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void addChatMem(int chId, String memId) {
		ChatMemMapper chatMemMapper = sqlSession.getMapper( ChatMemMapper.class ) ;
		chatMemMapper.createChatMem(chId, memId, 0);
	}

	@Override
	public void addChatMem(int chId, int roleId) {
		ChatMemMapper chatMemMapper = sqlSession.getMapper( ChatMemMapper.class ) ;
		chatMemMapper.createChatMem(chId, null, roleId);
		
	}

	@Override
	public void removeChatMem(int chId, String memId) {
		ChatMemMapper chatMemMapper = sqlSession.getMapper( ChatMemMapper.class ) ;
		chatMemMapper.deleteChatMem(chId, memId, 0);
	}

	@Override
	public void removeChatMem(int chId, int roleId) {
		ChatMemMapper chatMemMapper = sqlSession.getMapper( ChatMemMapper.class ) ;
		chatMemMapper.deleteChatMem(chId, null, roleId);
	}

	@Override
	public void removeAllChatMem(int chId) {
		ChatMemMapper chatMemMapper = sqlSession.getMapper( ChatMemMapper.class ) ;
		chatMemMapper.deleteChatMem(chId, null, 0);
	}

}
