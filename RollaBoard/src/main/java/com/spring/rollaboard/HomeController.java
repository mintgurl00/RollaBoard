package com.spring.rollaboard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("*.do")
public class HomeController {
	
	@RequestMapping(value="/")
    public String home() {
        return "dashboard";
    }
	
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
