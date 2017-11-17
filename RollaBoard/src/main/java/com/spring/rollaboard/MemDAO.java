package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface MemDAO {
	public ArrayList<MemVO> getBoardMembers(int board_id);

	public MemVO getMember(MemVO memVO);
	
	public int chkMemberId(MemVO memVO); // 규성. 회원가입시 아이디 중복 체크

	public void insertMember(MemVO memVO);

	public void updateMember(MemVO memVO);

	public void deleteMember(String id);
	
	public MemVO getMemInfoToUpdate(String id);
}
