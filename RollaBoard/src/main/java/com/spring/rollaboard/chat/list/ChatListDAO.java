package com.spring.rollaboard.chat.list;

public interface ChatListDAO {
	//public ArrayList<SectionVO> getSections(int board_id);

	//public SectionVO getSection(int id);
	
	//public String getMaxSeqNum(int board_id);

	//public void createSection(SectionVO sectionVO);
	
	// 사용자 조작
	public void addChatList(ChatListVO chatListVO);	// 채팅룸 목록에 추가
	public void removeChatList(int chId, String memId);	// 채팅룸 목록에서 제거
	
	public void hideChatList(int chId, String memId);	// 채팅룸 숨김
	public void revealChatList(int chId, String memId);	// 채팅룸 숨김 해제 
	
	// 내부 접근
	public void outChatList(int chId, String memId);	// 추방(?) 처리
	public void inChatList(int chId, String memId);	// (다시)초대 처리
	//public void updateChatRoom(ChatRoomVO chatRoomVO);
	
}
