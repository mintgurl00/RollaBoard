package com.spring.rollaboard.chat.room;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface ChatRoomMapper {

	/*public ArrayList<SectionVO> getSections(int board_id);

	public void createSection(SectionVO sectionVO);
	
	public void deleteSection(int board_id);
	
	public String getMaxSeqNum(@Param("board_id") int board_id);
	
	public void updateSection(@Param("section_id") int section_id, @Param("section_name") String section_name);*/
	public void createChatRoom(ChatRoomVO chatRoomVO);
	public void deleteChatRoom(int chId);
	public void updateChatRoom(ChatRoomVO chatRoomVO);
	public int getCurrentChId();

}
