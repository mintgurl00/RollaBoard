package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface MemDAO {
	public ArrayList<MemVO> getMembers(int id);

	public MemVO getMember(MemVO memVO);

	public void insertMember(MemVO memVO);

	public void updateMember(MemVO memVO);

	public void deleteMember(int id);
}
