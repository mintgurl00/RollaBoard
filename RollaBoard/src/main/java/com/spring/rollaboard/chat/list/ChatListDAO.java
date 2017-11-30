package com.spring.rollaboard.chat.list;

public interface ChatListDAO {
	//public ArrayList<SectionVO> getSections(int board_id);

	//public SectionVO getSection(int id);
	
	//public String getMaxSeqNum(int board_id);

	//public void createSection(SectionVO sectionVO);

	public void addChatList(ChatListVO chatListVO);
	public void removeChatList(ChatListVO chatListVO);
	public void updateChatList(ChatListVO chatListVO);
	//public void updateChatRoom(ChatRoomVO chatRoomVO);
	
}
