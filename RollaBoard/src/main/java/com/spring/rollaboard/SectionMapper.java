package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface SectionMapper {

	ArrayList<SectionVO> getSections(int board_id);
	
	public void createSection(SectionVO sectionVO);
	
	public int getMaxSeqNum(@Param("board_id") int board_id);

}
