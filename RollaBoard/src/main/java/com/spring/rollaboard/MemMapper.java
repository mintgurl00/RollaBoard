package com.spring.rollaboard;

import java.util.ArrayList;

public interface MemMapper {
	
	public void insertMember(MemVO memVO);
	
	public MemVO getMember(MemVO memVO);
	
	public MemVO getMemInfoToUpdate(String id);
	
	public void updateMember(MemVO memVO);
	
	public int chkMemberId(MemVO memVO);
	
	public ArrayList<MemVO> getBoardMembers(String board_id); //수민-보드멤버리스트
}
