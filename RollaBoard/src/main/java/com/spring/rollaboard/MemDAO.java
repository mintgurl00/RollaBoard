package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface MemDAO {
	public ArrayList<MemVO> getMembers();

	public MemVO getMember(int id);

	public void insertMember(MemVO memVO);

	public void updateMember(MemVO memVO);

	public void deleteMember(int id);
}
