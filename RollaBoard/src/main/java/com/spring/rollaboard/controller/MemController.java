package com.spring.rollaboard.controller;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.spring.rollaboard.mem.MemVO;
import com.spring.rollaboard.role.RoleDAOService;
import com.spring.rollaboard.section.SectionDAOService;
import com.spring.rollaboard.task.TaskDAOService;

@Controller
public class MemController {

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
	
	private static final Logger logger = LoggerFactory.getLogger(MemController.class);
	
    // 맴버관련 메소드 -------------------------------------------------------------------
    
    @RequestMapping("memberlist.do")
    public ModelAndView memberlist(String board_id) {

    	System.out.println("멤버관리로 이동");
    	System.out.println("보드아이디" + board_id);
    	ModelAndView result = new ModelAndView();
    	ArrayList<MemVO> boardMemberList = memDAOService.getBoardMembers(Integer.parseInt(board_id));
    	
    	result.addObject("boardMemberList", boardMemberList);
    	result.setViewName("boardsettings/memberlist");
        return result;

    }
    

    @RequestMapping("admitmember.do")
    public ModelAndView admitmember(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String mem_id = (String)(request.getParameter("mem_id"));
    	System.out.println("승인할 멤버 아이디: " + mem_id);
    	ModelAndView result = new ModelAndView();
    	memDAOService.admitMember(mem_id);
    	
//    	response.setContentType("text/html; charset-utf-8");
//    	PrintWriter out = response.getWriter();
//    	out.println("<script>alert('멤버 승인에 성공했습니다.');</script>");
//    	out.flush();
    	
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "memAdmit";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("redirect:updateboard.do");
        return result;
    }
    
    @RequestMapping("deletemember.do")
    public ModelAndView deletemember(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
    	//System.out.println(request.getParameter("mem_id"));
		ModelAndView result = new ModelAndView();
    	String mem_id = (String)(request.getParameter("mem_id"));
    	System.out.println("강퇴/삭제할 멤버 아이디: " + mem_id);
    	memDAOService.deleteMember(mem_id);
  	
//    	response.setContentType("text/html; charset-utf-8");
//    	PrintWriter out = response.getWriter();
//    	out.println("<script>alert('멤버 강퇴/삭제에 성공했습니다.');</script>");
//    	out.flush();
    	
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "memList";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("redirect:updateboard.do");	
    	return result;
    	
    }

}

