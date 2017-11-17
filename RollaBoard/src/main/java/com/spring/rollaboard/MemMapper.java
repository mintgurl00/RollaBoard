package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface MemMapper {
	
	public void insertMember(MemVO memVO);
	
	public MemVO getMember(MemVO memVO);
	
	public MemVO getMemInfoToUpdate(String id);
	
	public void updateMember(MemVO memVO);
	
	public int chkMemberId(MemVO memVO);
	
	public ArrayList<MemVO> getBoardMembers(@Param("board_id") int board_id); //수민-보드멤버리스트
}
