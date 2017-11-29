package com.spring.rollaboard.chat.room;

public interface ChatRoomDAO {
	//public ArrayList<SectionVO> getSections(int board_id);

	//public SectionVO getSection(int id);
	
	//public String getMaxSeqNum(int board_id);

	//public void createSection(SectionVO sectionVO);

	public void createChatRoom(ChatRoomVO chatRoomVO);
	public void deleteChatRoom(int chId);
	public void updateChatRoom(ChatRoomVO chatRoomVO);
	
}
