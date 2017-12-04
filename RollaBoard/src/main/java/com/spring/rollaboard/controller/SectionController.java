package com.spring.rollaboard.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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
import com.spring.rollaboard.board.BoardVO;
import com.spring.rollaboard.cmt.CmtDAOService;
import com.spring.rollaboard.mem.MemDAOService;
import com.spring.rollaboard.mem.MemVO;
import com.spring.rollaboard.role.RoleDAOService;
import com.spring.rollaboard.section.SectionDAOService;
import com.spring.rollaboard.section.SectionVO;
import com.spring.rollaboard.task.TaskDAOService;

//깃 테스트
@Controller
public class SectionController {

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
	
	private static final Logger logger = LoggerFactory.getLogger(SectionController.class);
	
	// SECTION 관련 메소드 ---------------------------------------------------------------
    
    //섹션 리스트 보기
    @RequestMapping("sectionlist.do")
    public ModelAndView sectionlist(String board_id) {
    	ModelAndView result = new ModelAndView();
    	ArrayList<SectionVO> sectionlist = sectionDAOService.getSections(Integer.parseInt(board_id));
    	
    	result.addObject("sectionList", sectionlist);
    	
    	result.setViewName("boardsettings/sectionlist");
        return result;
    }
    
    
    // 섹션 만들기
    @RequestMapping("createsection.do")
    public ModelAndView createsection(String section_name, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	int board_id = Integer.parseInt((String) session.getAttribute("board_id"));
    	int maxNum;
    	System.out.println("맥스넘 나온거 : "+sectionDAOService.getMaxSeqNum(board_id));
    	if (sectionDAOService.getMaxSeqNum(board_id) == null) {
			maxNum = 1;
		} else {
			maxNum = Integer.parseInt(sectionDAOService.getMaxSeqNum(board_id)) + 1;
		}
    	if (section_name.equals("null")) {
			section_name = "대분류" + maxNum;
		}
    	SectionVO sectionVO = new SectionVO();
    	sectionVO.setBoard_id(board_id);
    	sectionVO.setSeq_num(maxNum);
    	sectionVO.setName(section_name);
    	sectionDAOService.createSection(sectionVO);
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "section";
    	result.addObject("chkVal", chkVal);
    	result.addObject("board_id", board_id);
    	result.setViewName("main/subMenu");
    	return result;
    }
    
    // board.jsp에서 섹션 만들기
    @RequestMapping("createsectioninboard.do")
    public ModelAndView createsectioninboard(HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	int board_id = Integer.parseInt((String) session.getAttribute("board_id"));
    	int maxNum;
    	System.out.println("맥스넘 나온거 : "+sectionDAOService.getMaxSeqNum(board_id));
    	if (sectionDAOService.getMaxSeqNum(board_id) == null) {
			maxNum = 1;
		} else {
			maxNum = (Integer.parseInt(sectionDAOService.getMaxSeqNum(board_id)) + 1);
		}
    	System.out.println("맥스넘 보정값 : " + maxNum);
    	SectionVO sectionVO = new SectionVO();
    	sectionVO.setBoard_id(board_id);
    	sectionVO.setSeq_num(maxNum);
    	sectionVO.setName("대분류" + maxNum);
    	sectionDAOService.createSection(sectionVO);
    	result.addObject("board_id", board_id);
    	result.setViewName("redirect:board.do");
    	return result;
    }
    
    //섹션 수정
    @RequestMapping("updatesection.do")
    public ModelAndView updatesection(int section_id, String section_name, String color) {
    	System.out.println("섹션 아이디 int : "+section_id);
    	System.out.println("섹션 네임 : " + section_name);
    	ModelAndView result = new ModelAndView();
    	sectionDAOService.updateSection(section_id, section_name, color);
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "section";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("main/subMenu");
    	return result;
    	
    }
    
    // board.jsp에서 섹션 수정
    @RequestMapping("updatesectioninboard.do")
    public ModelAndView updatesectioninboard(int section_id, String section_name, String color) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("updatesection section_id : " + section_id);
    	sectionDAOService.updateSection(section_id, section_name, color);

    	result.setViewName("redirect:board.do");
    	return result;
    }
    
    //섹션 삭제
    @RequestMapping("deletesection.do")
    public ModelAndView deletesection(int section_id) {
    	
    	System.out.println("삭제할 섹션 아이디: " + section_id);
    	ModelAndView result = new ModelAndView();
    	sectionDAOService.deleteSection(section_id);
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "section";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("main/subMenu");
    	return result;
    }
    
    // board.jsp에서 섹션 삭제
    @RequestMapping("deletesectioninboard.do")
    public ModelAndView deletesectioninboard(int section_id) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("딜리트섹션InBoard. section_id : " + section_id);
    	sectionDAOService.deleteSection(section_id);
    	
    	result.setViewName("redirect:board.do");
    	return result;
    }
    
    
}

