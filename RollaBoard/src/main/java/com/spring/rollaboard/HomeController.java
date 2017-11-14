package com.spring.rollaboard;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("*.do")
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
    public String index() {
        return "index";
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
    public String board() {
        return "board";
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

