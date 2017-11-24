package com.spring.rollaboard.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.rollaboard.board.BoardDAOService;
import com.spring.rollaboard.board.BoardVO;
import com.spring.rollaboard.cmt.CmtDAOService;
import com.spring.rollaboard.mem.MemDAOService;
import com.spring.rollaboard.mem.MemVO;
import com.spring.rollaboard.role.RoleDAOService;
import com.spring.rollaboard.section.SectionDAOService;
import com.spring.rollaboard.section.SectionVO;
import com.spring.rollaboard.task.TaskDAOService;
import com.spring.rollaboard.task.TaskVO;

@Controller
public class ViewDashboardController {

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
	private BoardDAOService boardDAOService;
	
	private static final Logger logger = LoggerFactory.getLogger(ViewDashboardController.class);
	
	// 대시보드 관련 메소드--------------------------------------------
    	// 태스트용
		@RequestMapping("test.do")
	    public ModelAndView test(HttpSession session) {
	    	ModelAndView result = new ModelAndView();
	    	String mem_id = "cdcase";
	    	List<BoardVO> boardList = boardDAOService.getBoards(mem_id); //수민. 대시보드로 갈 때 보드리스트 받아옴
	    	ArrayList<TaskVO> taskList = taskDAOService.getMyTasks(mem_id);
	    	session.setAttribute("board_id", 1);
	    	session.setAttribute("id", mem_id);
	    	ArrayList<BoardVO> refBoardList = boardDAOService.getRefBoards( 1 );
	    	BoardVO boardVO = boardDAOService.getBoardInfo(1);
	    	result.addObject("boardVO", boardVO);
	    	result.addObject( "refBoardList" , refBoardList ) ;
	    	result.addObject("taskList", taskList);
	    	result.addObject("id", mem_id);
	    	result.addObject("boardList", boardList); //수민
	    	result.setViewName("test");
	        return result;
	    }
	
    @RequestMapping("dashboard.do")
    public ModelAndView dashboard(HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	if (session.getAttribute("id") == null) {
			result.setViewName("redirect:index.do");
		}
    	List<BoardVO> boardList = boardDAOService.getBoards((String)(session.getAttribute("id"))); //수민. 대시보드로 갈 때 보드리스트 받아옴
    	session.removeAttribute("board_id"); // 대쉬보드로 이동시 board_id 세션을 없앤다.
    	// 대쉬보드에 내 TASK 보기
    	
    	String mem_id = (String) session.getAttribute("id");
    	System.out.println("dashboard입니다.세션의 맴버아이디 : " + mem_id);
    	ArrayList<TaskVO> taskList = taskDAOService.getMyTasks(mem_id);
    	result.addObject("taskList", taskList);
    	result.addObject("id", session.getAttribute("id"));
    	result.addObject("boardList", boardList); //수민
    	result.setViewName("dashboard/dashboard");
        return result;
    }
    
    @RequestMapping("newboard.do")
    public ModelAndView newboard() {
    	ModelAndView result = new ModelAndView();
    	result.setViewName("dashboard/newboard");
        return result;
    }
    
    @RequestMapping("createboardform.do")
    public String createboardform() {
    	return "dashboard/createboardform";
    }
    
    @RequestMapping("createboard.do")
    public ModelAndView createboard(BoardVO boardVO, HttpSession session, HttpServletResponse response) throws Exception {
    	
    	ModelAndView result = new ModelAndView();
    	System.out.println("보드 이름 : " + boardVO.getName() + "아이디 : " + (String)(session.getAttribute("id")));

    	String board_name = boardVO.getName();
    	String mem_id = (String)(session.getAttribute("id"));
    	
    	if (boardDAOService.getBoard(board_name) != null) {
    		response.setContentType("text/html; charset-utf-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>alert('이미 사용중인 보드 이름입니다!'); history.go(-1);</script>");
        	out.flush();
        	result.setViewName("dashboard/createboard");
        	return result;
		}
    	boardDAOService.createBoard(board_name, mem_id);
    	
    	// 만들어진 보드 아이디를 갖고와서 초기 SECTION을 만드는 데 사용한다.
    	BoardVO createdBoardVO = boardDAOService.getBoard(board_name);
    	SectionVO sectionVO = new SectionVO();
    	// SECTION을 만들 때는 boardVO객체를 통해서 만든다.
    	sectionVO.setBoard_id(createdBoardVO.getId());
    	sectionVO.setName("대분류1");
    	sectionDAOService.createSection(sectionVO);
    	response.setContentType("text/html; charset-utf-8");
    	PrintWriter out = response.getWriter();
    	out.println("<script>alert('보드가 새로 생성되었습니다.');</script>");
    	out.flush();
    	
    	result.addObject("board", boardVO);
    	result.setViewName("dashboard/newboard");
    	
    	return result;
    }
    
    
    
    @RequestMapping("enterboard.do")
    public ModelAndView enterboard() {
    	ModelAndView result = new ModelAndView();
    	result.setViewName("dashboard/enterboard");
        return result;
    }
    
    // 기존 보드에 가입함
    @RequestMapping("joinboard.do")
    public ModelAndView joinboard(String name, HttpSession session, HttpServletResponse response) throws Exception {
    	ModelAndView result = new ModelAndView();
    	String mem_id = (String) session.getAttribute("id");
    	System.out.println("보드 네임 : " + name);
    	
    	// 1. 보드가 있는지 확인해본다.
    	BoardVO boardVO = boardDAOService.getBoard(name);
    	if (boardVO == null) {
    		
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('찾는 BOARD가 없습니다!(BOARD 이름을 다시 확인해주세요)');</script>");
            out.flush(); 
    		result.setViewName("dashboard/enterboard");
            return result;
		}
    	
    	// 2. 이미 보드에 등록되어있는지 확인한다.
    	int chk = boardDAOService.joinBoardChk(boardVO.getId(), mem_id);
    	if (chk != 0) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('이미 BOARD에 가입신청을 했습니다.');</script>");
            out.flush(); 
    		result.setViewName("dashboard/enterboard");
            return result;
		}
    	
    	// 3. 보드에 등록한다.
    	System.out.println("보드 등록 전 확인하자!");
    	System.out.println("보드아이디 : " + boardVO.getId());
    	System.out.println("맴버아이디 : " + mem_id);
    	boardDAOService.joinBoard(boardVO.getId(), mem_id);
    	
    	// alert처리단
		response.setContentType("text/html; charset-utf-8");
		PrintWriter out = response.getWriter();
        out.println("<script>alert('BOARD에 등록되었습니다. 관리자의 승인을 기다려주세요');</script>");
        out.flush(); 
    	result.setViewName("dashboard/newboard");
        return result;
    }
    
}

