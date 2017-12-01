package com.spring.rollaboard.chat.room;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatRoomDAOService implements ChatRoomDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void createChatRoom(ChatRoomVO chatRoomVO) {
		ChatRoomMapper chatRoomMapper = sqlSession.getMapper( ChatRoomMapper.class ) ;
		chatRoomMapper.createChatRoom(chatRoomVO);
	}

	@Override
	public void deleteChatRoom(int chId) {
		ChatRoomMapper chatRoomMapper = sqlSession.getMapper( ChatRoomMapper.class ) ;
		chatRoomMapper.deleteChatRoom(chId);
	}

	@Override
	public void updateChatRoom(ChatRoomVO chatRoomVO) {
		ChatRoomMapper chatRoomMapper = sqlSession.getMapper( ChatRoomMapper.class ) ;
		chatRoomMapper.updateChatRoom(chatRoomVO);
	}

}
