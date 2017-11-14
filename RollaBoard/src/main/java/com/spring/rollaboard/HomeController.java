package com.spring.rollaboard;

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
    	System.out.println("들어감");
    	ModelAndView result = new ModelAndView();
    	result.setViewName("index");
    	return result;
    }
    
    @RequestMapping("insertMember.do")
    public ModelAndView insertMember(MemVO memVO) {
    	memDAOService.insertMember(memVO);
		/*
		HashMap<String, String> map = new HashMap<String, String>(); // HashMap
		map.put("id", member.getId());
		map.put("name", member.getName());
		map.put("email", member.getEmail());
		map.put("phone", member.getPhone());
		memberDAOService.insertMember2(map);
		 */
    	
		ModelAndView result = new ModelAndView();
		result.setViewName("index");
    	return result;
    }
    
    
    @RequestMapping("joinform.do")
    public String joinform() {
        return "joinform";
    }
    
    @RequestMapping("dashboard.do")
    public String dashboard() {
        return "dashboard";
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
    	/* 1. 참조하는 보드
    	 * 2. 태스크 필터
    	 * 3. 태스크 예쁘게 보기
    	 * 4. 태스크 검색
    	 */
    	
    	ModelAndView result = new ModelAndView();
    	result.setViewName("board");
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
    public String updatememberform() {
        return "updatememberform";
    }
    
}

