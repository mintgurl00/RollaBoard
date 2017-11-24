package com.spring.rollaboard.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.rollaboard.board.BoardDAOService;
import com.spring.rollaboard.cmt.CmtDAOService;
import com.spring.rollaboard.mem.MemDAOService;
import com.spring.rollaboard.role.RoleDAOService;
import com.spring.rollaboard.role.RoleVO;
import com.spring.rollaboard.section.SectionDAOService;
import com.spring.rollaboard.task.TaskDAOService;
import com.spring.rollaboard.task.TaskRefDAOService;
import com.spring.rollaboard.task.TaskVO;

//깃 테스트
@Controller
public class TaskController {

	@Autowired
	private CmtDAOService cmtDAOService;
	@Autowired
	private MemDAOService memDAOService;
	@Autowired
	private RoleDAOService roleDAOService;
	@Autowired
	private SectionDAOService sectionDAOService;
	@Autowired
	private TaskDAOService taskDAOService;
	@Autowired
	private TaskRefDAOService taskRefDAOService;
	@Autowired
	private BoardDAOService boardDAOService;
	
	private static final Logger logger = LoggerFactory.getLogger(TaskController.class);
	
	// TASK 관련 메소드 ----------------------------------------------------------------
    
    @RequestMapping(value = "taskview.do" )
    public ModelAndView taskview(HttpServletRequest request, HttpSession session) {	
    	ModelAndView result = new ModelAndView();
    	int task_id = Integer.parseInt((String) request.getParameter("task_id"));
    	String board_name = (String) request.getParameter("board_name");
    	System.out.println("태스크뷰 아이디 : " + task_id);
    	System.out.println("태스크뷰.. board_name : " + board_name);
    	if (board_name == null) {	
    		TaskVO taskVO = taskDAOService.getTask(task_id);
        	result.addObject("taskVO", taskVO);
        	result.setViewName("task/taskview");
            return result;
		} else {
	    	int board_id = boardDAOService.getBoard(board_name).getId();
	    	System.out.println("갖고온 보드아이디 : " + board_id);

	    	TaskVO taskVO = taskDAOService.getTask(task_id);
	    	result.addObject("taskVO", taskVO);
	    	result.setViewName("task/taskview");
	        return result;
		}
    }
    
      
    @RequestMapping("updatetaskform.do")
    public  ModelAndView updatetaskform(TaskVO taskVO, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("updatetaskform.do... taskVO.getId : " + taskVO.getId());
    	// 배정할 롤 리스트를 같이 첨부해서 전송한다.
		int board_id = Integer.parseInt((String)session.getAttribute("board_id"));
		ArrayList<RoleVO> roleList = roleDAOService.getRoles(board_id);
		
		int taskId = taskVO.getId() ;
		int preTaskId = -1, postTaskId = -1 ;
		if(taskRefDAOService.isConnectedTask(taskId)){
			if(taskRefDAOService.isHavingPostTask(taskId))
				postTaskId = taskRefDAOService.getPostTaskId(taskId);
			if(taskRefDAOService.isHavingPreTask(taskId))
				preTaskId = taskRefDAOService.getPreTaskId(taskId);
		}
		if( preTaskId > -1)
			result.addObject("preTaskId", preTaskId);
		if( postTaskId > -1)
			result.addObject("preTaskId", postTaskId);
		result.addObject("roleList", roleList);
    	result.addObject("taskVO", taskVO);
    	result.setViewName("task/updatetask");
    	return result;
    }
    
    @RequestMapping("updatetask.do")
    public ModelAndView updatetask(String taskToRole, TaskVO taskVO, HttpSession session, HttpServletRequest request) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("태스크에 배정할 롤 이름! : " + taskToRole);
    	System.out.println("업데이트할 task_id : " + taskVO.getId());
    	
		if(!request.getParameter("pre_task").equals("")){
			taskRefDAOService.addPreTask(taskVO.getId(), Integer.parseInt(request.getParameter("pre_task")));
		}
		if(!request.getParameter("post_task").equals("")){
			taskRefDAOService.addPostTask(taskVO.getId(), Integer.parseInt(request.getParameter("post_task")));
		}
    	
    	if (taskVO.getStatus() == null) {
			taskVO.setStatus("NORMAL");
		}
    	System.out.println("스테이터스 :" + taskVO.getStatus());	
    	// 롤 이름이 없으면 수행 안한다.
    	if (taskToRole == null || (taskToRole == "")) {
    		taskDAOService.updateTask(taskVO);
        	result.setViewName("redirect:board.do");
        	return result;
    		
    	} else{
	    	// 태스크 수정사항 업데이트
	    	System.out.println("널이아니야!!(롤배정을 설정했어)");
	    	// updatetask에서 가져온 롤 이름으로 롤 아이디 찾는다.
			int role_id = roleDAOService.getRoleIdByName(taskToRole, Integer.parseInt((String)session.getAttribute("board_id")));
			// 태스크에 롤을 배정한다.
			taskDAOService.taskToRole(taskVO.getId(), role_id);	
			result.setViewName("redirect:board.do");
        	return result;
    	}
    }
    
    @RequestMapping("deletetask.do")
    public ModelAndView deletetask(int task_id) {
    	System.out.println("지울 task_id : " + task_id);
    	ModelAndView result = new ModelAndView();
    	taskDAOService.deleteTask(task_id);
    	result.setViewName("redirect:board.do");
    	return result;
    }
    
    // 태스크 만들 폼을 가져오는 메소드이다.
	@RequestMapping("createtask.do")
	public ModelAndView createtask(HttpServletRequest request, HttpSession session) {
		
		System.out.println("리쿼스트 섹션아이디 : " + request.getParameter("section_id"));
		String section_id = request.getParameter("section_id");  
		ModelAndView result = new ModelAndView();
		
		result.addObject("section_id",section_id);
        result.setViewName("task/createtask");
		return result;
	}
	
	// 실제로 만드는 메소드
	@RequestMapping("inserttask.do")
	public ModelAndView insertTask(String taskToRole, HttpSession session, TaskVO taskVO, HttpServletRequest request) {
		System.out.println("만들 태스크의 이름 : " + taskVO.getName());
		
		// 태스크를 생성한다.
		taskDAOService.createTask(taskVO);

		ModelAndView result = new ModelAndView();
		result.setViewName("redirect:board.do");
		return result;	
    	
	}
	
	@RequestMapping("detailtask.do")
	public String detailtask() {
		return "task/detailtask";
	}
    
    
}

