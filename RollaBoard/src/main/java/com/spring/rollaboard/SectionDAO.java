package com.spring.rollaboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface SectionDAO {
	public ArrayList<SectionVO> getSections(int id);

	public SectionVO getSection(int id);

	public void createSection(SectionVO sectionVO);

	public void updateSection(SectionVO sectionVO);

	public void deleteSection(int id);
}
