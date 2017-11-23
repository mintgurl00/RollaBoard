package com.spring.rollaboard.controller;

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
import com.spring.rollaboard.board.BoardVO;
import com.spring.rollaboard.cmt.CmtDAOService;
import com.spring.rollaboard.mem.MemDAOService;
import com.spring.rollaboard.mem.MemVO;
import com.spring.rollaboard.role.RoleDAOService;
import com.spring.rollaboard.role.RoleVO;
import com.spring.rollaboard.section.SectionDAOService;
import com.spring.rollaboard.section.SectionVO;
import com.spring.rollaboard.task.TaskDAOService;

//깃 테스트
@Controller
public class BoardSettingController {

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
	
	private static final Logger logger = LoggerFactory.getLogger(BoardSettingController.class);
	
	@RequestMapping("updateboard.do")
    public ModelAndView updateboard(BoardVO boardVO, String chkVal, HttpSession session) {
    	if (chkVal == null) {
			chkVal = "role";
		}
    	ModelAndView result = new ModelAndView();
    	System.out.println("체크벨류 : " + chkVal);
    	System.out.println("업데이트보드 session 보드아이디 : " + session.getAttribute("board_id"));
    	int board_id;
    	if (session.getAttribute("board_id") == null) {
    		if (boardVO.getId() != 0) {	
    			board_id = boardVO.getId();
    		} else {
    			result.setViewName("index");
    			return result;
    		}
		} else {
			board_id = Integer.parseInt((String)session.getAttribute("board_id"));
		}
    	// role 관리페이지 관련 정보들
    	ArrayList<RoleVO> roleList = roleDAOService.getRoles(board_id);
    	// member 관리페이지 관련 정보들
    	ArrayList<MemVO> boardMemberList = memDAOService.getBoardMembers(board_id);
    	// member 승인페이지 관련 정보들
    	ArrayList<MemVO> boardWaitingList = memDAOService.waitingMembers(board_id);
    	// SECTION 관리페이지 관련 정보들
    	ArrayList<SectionVO> sectionList = sectionDAOService.getSections(board_id);
    	//기타설정 페이지 관련 정보들
    	ArrayList<BoardVO> refBoardList = boardDAOService.getRefBoards(board_id);
    	
    	boardVO = boardDAOService.getBoardInfo(board_id);
    	System.out.println("업데이트보드 id = " + board_id);
    	result.addObject("chkVal", chkVal);
    	result.addObject("boardVO", boardVO);
    	result.addObject("roleList", roleList); // role 관리페이지 관련 정보들
    	result.addObject("boardMemberList", boardMemberList); // member 관리페이지 관련 정보들
    	result.addObject("boardWaitingList", boardWaitingList); // member 승인페이지 관련 정보들
    	result.addObject("sectionList", sectionList); // SECTION 관리페이지 관련 정보들
    	result.addObject("refBoardList", refBoardList); // 기타설정 페이지 관련 정보들
    	result.setViewName("boardsettings/updateboard");
        return result;
    }
	
	@RequestMapping("updateboardname.do")
    public ModelAndView updateboardname(String board_name, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("업데이트 보드 네임 : " + board_name);
    	BoardVO boardVO = new BoardVO();
    	boardVO.setId(Integer.parseInt((String)session.getAttribute("board_id")));
    	boardVO.setName(board_name);
    	boardDAOService.updateBoard(boardVO);
    	result.setViewName("redirect:board.do");
        return result;
    }
	
	@RequestMapping("memberadmitform.do")
    public ModelAndView memberadmitform(String board_id) {
    	System.out.println("멤버승인으로 이동");
    	System.out.println("보드아이디" + board_id);
    	ModelAndView result = new ModelAndView();
    	ArrayList<MemVO> boardMemberList = memDAOService.waitingMembers(Integer.parseInt(board_id));
    	
    	result.addObject("boardWaitingList", boardMemberList);
    	result.setViewName("boardsettings/memberadmitform");
        return result;
    }
	    

	    
	
    //기타설정 뷰로 이동
    @RequestMapping("etcform.do")
    public ModelAndView etcform(HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	
    	int board_id = Integer.parseInt((String) session.getAttribute("board_id"));
    	ArrayList<BoardVO> refBoardList = boardDAOService.getRefBoards(board_id);
    	
    	result.addObject("refBoardList" , refBoardList) ;
    	result.setViewName("boardsettings/etcform");
    	
        return result;
    }
    

    //보드 공개여부 설정
    @RequestMapping("visibility.do")
    public ModelAndView visibility(HttpServletRequest request, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	String visibility = request.getParameter("visibility");
    	String board_id = (String) session.getAttribute("board_id");

    	System.out.println("공개여부 설정할 보드 아이디: " + board_id);
    	System.out.println("공개여부 : " + visibility);
    	boardDAOService.visibility(visibility, board_id);
    	
       	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "etc";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("redirect:updateboard.do");
        return result;
    	
    }
    
    //참조보드 추가
    @RequestMapping("addrefboard.do")
    public ModelAndView addrefboard() {
    	ModelAndView result = new ModelAndView();
    	
        return result;
    	
    }
    
    //참조보드 삭제
    @RequestMapping("deleterefboard.do")
    public ModelAndView deleterefboard(HttpSession session, HttpServletRequest request) {
    	ModelAndView result = new ModelAndView();
    	
    	System.out.println("참조보드 아이디: " + Integer.parseInt((String)request.getParameter("ref_id")));
    	System.out.println("내 보드 아이디: " + Integer.parseInt((String)session.getAttribute("board_id")));
    	
    	int ref_id = Integer.parseInt((String)request.getParameter("ref_id"));
    	int board_id = Integer.parseInt((String)session.getAttribute("board_id"));
    	

    	boardDAOService.deleteRefBoard(ref_id, board_id);

    	
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "etc";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("redirect:updateboard.do");
        return result;
    	
    }
    
    
}

