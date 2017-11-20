package com.spring.rollaboard;

import java.util.ArrayList;

public interface SectionDAO {
	public ArrayList<SectionVO> getSections(int board_id);

	public SectionVO getSection(int id);

	public void createSection(SectionVO sectionVO);

	public void updateSection(String section_id);

	public void deleteSection(String section_id);
}
