package com.spring.rollaboard;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

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
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	// 시작화면
    @RequestMapping("index.do")
    public ModelAndView index() {
    	ModelAndView result = new ModelAndView();
    	result.setViewName("index");
    	return result;
    }
    
    @RequestMapping("login.do")
    public ModelAndView login(MemVO memVO) {
    	System.out.println("login...memVO.getID : " + memVO.getId());
    	MemVO member = memDAOService.getMember(memVO);
    	ModelAndView result = new ModelAndView();
    	if (member == null) {
			result.setViewName("index");
    		return result;
		}
    	result.addObject("id", member.getId());
    	result.setViewName("dashboard");
    	return result;
    }
    
    
    @RequestMapping("insertMember.do")
    public ModelAndView insertMember(MemVO memVO) {
    	memDAOService.insertMember(memVO);
		ModelAndView result = new ModelAndView();
		result.setViewName("index");
    	return result;
    }
    
    @RequestMapping("joinform.do")
    public String joinform() {
        return "joinform";
    }
    
    @RequestMapping("dashboard.do")
    public ModelAndView dashboard(HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	
    	result.addObject("id", session.getAttribute("id"));
    	result.setViewName("dashboard");
        return result;
    }
    
    @RequestMapping("newboard.do")
    public String newboard() {
        return "newboard";
    }
    
    @RequestMapping("createboard.do")
    public String createboard() {
        return "createboard";
    }
    
    @RequestMapping("rolelist.do")
    public String rolelist() {
        return "rolelist";
    }
    
    @RequestMapping("memberlist.do")
    public String memberlist() {
        return "memberlist";
    }
    
    @RequestMapping("memberadmit.do")
    public String memberadmit() {
        return "memberadmit";
    }
    
    @RequestMapping("etc.do")
    public String etc() {
        return "etc";
    }
    
    @RequestMapping("enterboard.do")
    public String enterboard() {
        return "enterboard";
    }
    
    @RequestMapping("board.do")
    public ModelAndView board( String id ) {	// 석원
    	// TODO 석원이 지금 하고 있는 부분
    	/* 1. 참조하는 보드 명단 가져오기. 함
    	 * 2. 태스크 필터
    	 * 3. 태스크 예쁘게 보기
    	 * 4. 태스크 검색
    	 */
    	
    	
    	ModelAndView result = new ModelAndView();
    	result.setViewName("board");
    	
    	ArrayList<BoardVO> refBoardList = boardDAOService.getRefBoards( Integer.parseInt( id ) );
        return result ;
    }
    
    @RequestMapping("updateboard.do")
    public String updateboard() {
        return "updateboard";
    }
    
    @RequestMapping("taskview.do")
    public String taskview() {
        return "taskview";
    }
    
    @RequestMapping("updatetask.do")
    public String updatetask() {
        return "updatetask";
    }
    
	@RequestMapping("createtask.do")
	public String createtask() {
		return "createtask";
	}
	
	@RequestMapping("detailtask.do")
	public String detailtask() {
		return "detailtask";
	}
    
    @RequestMapping("updatememberform.do")
    public ModelAndView updatememberform(HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	MemVO memVO = memDAOService.getMemInfoToUpdate((String)session.getAttribute("id"));
    	result.addObject("member", memVO);
    	result.setViewName("updatememberform");
        return result;
    }
    
}

