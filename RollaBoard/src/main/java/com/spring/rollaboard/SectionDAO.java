package com.spring.rollaboard;

import java.util.ArrayList;

public interface SectionDAO {
	public ArrayList<SectionVO> getSections(int board_id);

	public SectionVO getSection(int id);
	
	public String getMaxSeqNum(int board_id);

	public void createSection(SectionVO sectionVO);

	public void updateSection(String section_id);

	public void deleteSection(String section_id);
	
	public void deleteSectionInBoard(int section_id);
	
	public void updateSectionInBoard(int section_id, String section_name);
}
