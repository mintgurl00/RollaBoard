package com.spring.rollaboard.section;

import java.util.ArrayList;

public interface SectionDAO {
	public ArrayList<SectionVO> getSections(int board_id);

	public SectionVO getSection(int id);
	
	public String getMaxSeqNum(int board_id);

	public void createSection(SectionVO sectionVO);

	public void deleteSection(int section_id);
	
	public void updateSection(int section_id, String section_name);
}
