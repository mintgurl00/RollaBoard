package com.spring.rollaboard;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface SectionMapper {

	public ArrayList<SectionVO> getSections(int board_id);
	
	public void updateSection(String section_id);
	
	public void deleteSection(String section_id);
	
	public void createSection(SectionVO sectionVO);
	
	public int getMaxSeqNum(@Param("board_id") int board_id);

}
