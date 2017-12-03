package com.spring.rollaboard.section;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface SectionMapper {

	public ArrayList<SectionVO> getSections(int board_id);

	public void createSection(SectionVO sectionVO);
	
	public void deleteSection(int board_id);
	
	public String getMaxSeqNum(@Param("board_id") int board_id);
	
	public void updateSection(@Param("section_id") int section_id, @Param("section_name") String section_name, @Param("color") String color);

	public ArrayList<SectionVO> getConnSecList(int board_id);

}
