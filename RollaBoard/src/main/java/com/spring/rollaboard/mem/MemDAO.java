package com.spring.rollaboard.mem;

import java.util.ArrayList;
import java.util.HashMap;

public interface MemDAO {
	public ArrayList<MemVO> getBoardMembers(int board_id);
	
	public ArrayList<MemVO> waitingMembers(int board_id);
	
	public void admitMember(String mem_id);

	public MemVO getMember(MemVO memVO);
	
	public int chkMemberId(MemVO memVO); // 규성. 회원가입시 아이디 중복 체크
	
	public ArrayList<MemVO> getRoleMembers(int role_id); //규성. 롤에 부여된 회원 명단 출력

	public void insertMember(MemVO memVO);

	public void updateMember(MemVO memVO);

	public void deleteMember(String mem_id);
	
	public MemVO getMemInfoToUpdate(String id);
	
	public int chkRoleToExpel(String mem_id, int board_id);
	
}
