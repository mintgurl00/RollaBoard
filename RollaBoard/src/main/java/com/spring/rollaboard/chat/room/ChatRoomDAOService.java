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
		// 생성 후에는 그 접근권한이 PUBLIC이라면 보드 멤버 모두에게 채팅 리스트 데이터를 추가해야한다.
		int chId = chatRoomMapper.getCurrentChId();
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
