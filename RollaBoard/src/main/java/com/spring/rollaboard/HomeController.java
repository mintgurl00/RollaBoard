package com.spring.rollaboard;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "dashboard";
	}
	
	@RequestMapping("dashboard.do")
	public String gotoDashboard() {
		return "dashboard";
	}
	
	@RequestMapping("board.do")
	public String gotoBoard() {
		return "board"; //수민
	}
	
}
