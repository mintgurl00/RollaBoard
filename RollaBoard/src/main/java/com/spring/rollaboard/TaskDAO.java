package com.spring.rollaboard;

import java.util.ArrayList;

public interface TaskDAO {
	public ArrayList<TaskVO> getTasks(int id);

	public TaskVO getTask(int id, CmtVO cmtVO);

	public void createTask(TaskVO taskVO); // 고급사항에서 받은 값들도 처리해야함

	public void updateTask(TaskVO taskVO);

	public void deleteTask(int id); // 선행TASK와 후행 TASK가 존재하면 처리해서 지워야함
}
