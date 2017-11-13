package com.spring.rollaboard;

import java.util.ArrayList;

public interface CmtDAO {
	public ArrayList<CmtVO> getCmts();

	// Cmt 하나를 따로 보는 method는 만들지 않음
	
	public void createCmt(CmtVO cmtVO);

	public void updateCmt(CmtVO cmtVO);

	public void deleteCmt(int id);
	

}
