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
import com.spring.rollaboard.task.RefTaskVO;
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
    	if (board_name != null) {
	    	int board_id = boardDAOService.getBoard(board_name).getId();
	    	System.out.println("갖고온 보드아이디 : " + board_id);	
		}
    	TaskVO taskVO = taskDAOService.getTask(task_id);
    	
    	// 관계 있는지 확인하고 관계 TASK 정보 가져오기
    	RefTaskVO preTaskVO = null, postTaskVO = null ;
    	if( taskRefDAOService.isConnectedTask(task_id)){
    		preTaskVO = new RefTaskVO(1);
    		postTaskVO = new RefTaskVO(1);
        	result.addObject("isConnected", "TRUE");
    		taskRefDAOService.getConnectedTask(task_id, preTaskVO, postTaskVO);
    		if(preTaskVO.getRefTaskId() > 0)
    			result.addObject("preTaskVO", preTaskVO);
    		if(postTaskVO.getRefTaskId() > 0)
    			result.addObject("postTaskVO", postTaskVO);
    	}
    	
    	result.addObject("taskVO", taskVO);
    	result.setViewName("task/taskview");
        return result;
    }
    
      
    @RequestMapping("updatetaskform.do")
    public  ModelAndView updatetaskform(TaskVO taskVO, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("updatetaskform.do... taskVO.getId : " + taskVO.getId());
    	// 배정할 롤 리스트를 같이 첨부해서 전송한다.
		int board_id = Integer.parseInt((String)session.getAttribute("board_id"));
		System.out.println("board_id : " + board_id);
		ArrayList<RoleVO> roleList = roleDAOService.getRoles(board_id);
		
		// 석원.관계를 전달하는 중이다.
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
		else
			result.addObject("preTaskId", "");
		if( postTaskId > -1)
			result.addObject("postTaskId", postTaskId);
		else
			result.addObject("postTaskId", "");
		
		// 배정된 롤 리스트도 보여준다.
		ArrayList<RoleVO> allocatedRole = roleDAOService.getRolesByTask(taskVO.getId());
		result.addObject("allocatedRole", allocatedRole);
		result.addObject("roleList", roleList);
    	result.addObject("taskVO", taskVO);
    	result.setViewName("task/updatetask");
    	return result;
    }
    
    // 태스크 수정 처리
    @RequestMapping("updatetask.do")
    public ModelAndView updatetask(String taskToRole, TaskVO taskVO, HttpSession session, HttpServletRequest request) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("태스크에 배정할 롤 이름! : " + taskToRole);
    	System.out.println("업데이트할 task_id : " + taskVO.getId());
    	
    	/*
    	 *  태스크 관계 처리하는 부분
    	 * */
    	if(!request.getParameter("pre_task").equals(request.getParameter("hidden_pre_task"))){
			String oldPreTask = request.getParameter("hidden_pre_task");
			String newPreTask = request.getParameter("pre_task");
			if(!oldPreTask.equals(""))
				taskRefDAOService.cutPreTask(taskVO.getId(), Integer.parseInt(oldPreTask));	// 일단 기존 것은 지우고
			if(!newPreTask.equals(""))
				taskRefDAOService.addPreTask(taskVO.getId(), Integer.parseInt(newPreTask));	// 추가
		}
    	if(!request.getParameter("post_task").equals(request.getParameter("hidden_post_task"))){
			String oldPostTask = request.getParameter("hidden_post_task");
			String newPostTask = request.getParameter("post_task");
			if(!oldPostTask.equals(""))
				taskRefDAOService.cutPostTask(taskVO.getId(), Integer.parseInt(oldPostTask));	// 일단 기존 것은 지우고
			if(!newPostTask.equals(""))
				taskRefDAOService.addPostTask(taskVO.getId(), Integer.parseInt(newPostTask));	// 추가
		}
		/////////////////////////////////////////
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
    public ModelAndView deletetask(int task_id, HttpServletRequest request) {
    	System.out.println("지울 task_id : " + task_id);
    	ModelAndView result = new ModelAndView();

    	//////관계를 일단 먼저 삭제하는 중
    	if(taskRefDAOService.isConnectedTask(task_id)){
    		// 일단 관계 브레이크로 구현
    		if( request.getAttribute("pullOut")==null ){
    			taskRefDAOService.breakConnection(task_id);
    		} else {
    			taskRefDAOService.pullFromConnection(task_id);
			}
    	}
    	//////.
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

		taskVO.setStatus("NORMAL");
		// 태스크를 생성한다.
		taskDAOService.createTask(taskVO);    	
    	/*if (taskVO.getStatus() == null) {
			taskVO.setStatus("NORMAL");
		}*/

		ModelAndView result = new ModelAndView();
		result.setViewName("redirect:board.do");
		return result;	
    	
	}
	
	@RequestMapping("detailtask.do")
	public String detailtask() {
		return "task/detailtask";
	}
	
	@RequestMapping("deallocatetask.do")
	public ModelAndView deallocatetask(int role_id, int task_id) {
		ModelAndView result = new ModelAndView();
		System.out.println("deallocatetask.do... task_id : " + task_id);
		TaskVO taskVO = taskDAOService.getTask(task_id);
		roleDAOService.deallocateTask(role_id, task_id);
		System.out.println("TASK_ROLE 삭제완료");
		result.addObject("taskVO", taskVO);
		result.setViewName("redirect:updatetaskform.do");
		return result;
	}
	
	 //수민 구글맵스보기
    @RequestMapping("showgooglemaps.do")
    public ModelAndView showgooglemaps(HttpServletRequest request) throws Exception {
    	ModelAndView result = new ModelAndView();
    	
    	String location = request.getParameter("location");
    	System.out.println("태스크 위치: " + location);
    	
    	result.addObject("location", location);
		result.setViewName("task/showgooglemaps");
    	return result;
    }
    
}

