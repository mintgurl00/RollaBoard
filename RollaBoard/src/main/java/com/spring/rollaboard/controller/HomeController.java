package com.spring.rollaboard.controller;

import java.io.PrintWriter;
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
import com.spring.rollaboard.task.TaskDAOService;

//깃 테스트
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
    	ModelAndView result = new ModelAndView();/*
    	Date date = new Date();
    	System.out.println("현재 시간! : " + date);*/
    	return result;
    }
    // 로그아웃
    @RequestMapping("logout.do")
    public ModelAndView logout(HttpSession session, HttpServletResponse response) {
    	ModelAndView result = new ModelAndView();

        // 아이디가 저장된 session값을 초기화
    	session.invalidate();
    	result.setViewName("index");
    	return result;
    }
    
    @RequestMapping("login.do")
    public ModelAndView login(MemVO memVO, HttpServletResponse response, HttpSession session) throws Exception {
    	System.out.println("login...memVO.getID : " + memVO.getId());
    	MemVO member = memDAOService.getMember(memVO);
    	ModelAndView result = new ModelAndView();
    	if (member == null) {
    		
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('아이디 또는 비밀번호가 틀립니다.');</script>");
            out.flush(); 
            //developerdon.tistory.com/entry/JAVA-단에서-alert-처리하기-–-
			result.setViewName("index");
    		return result;
		}
    	
    	session.setAttribute("id", member.getId());
    	List<BoardVO> boardList = boardDAOService.getBoards((String)(session.getAttribute("id"))); //수민. login 후 대시보드로 갈 때 보드리스트 받아옴
    	
    	///테스트
    	/*TaskFilterSQL tfSQL = TaskFilterSQL.getInstance() ;
    	System.out.println( tfSQL.get( TaskFilter.CREDATE_ASC ) ) ;*/
    	
    	result.addObject("boardList", boardList); //수민
    	result.setViewName("redirect:dashboard.do");
    	return result;
    }
    
    @RequestMapping("joinform.do")
    public String joinform() {
        return "main/joinform";
    }
    
	// (개인)회원정보 수정 처리
    @RequestMapping("updatemember.do")
	public void updatemember(MemVO updateMemInfo, HttpServletResponse response) throws Exception {
    	ModelAndView result = new ModelAndView();
    	MemVO memPwChk = memDAOService.getMember(updateMemInfo);

    	if (memPwChk == null) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('Password incorrect !'); history.go(-1); </script>");
            out.flush(); 
    		return;
            //developerdon.tistory.com/entry/JAVA-단에서-alert-처리하기-–-
		}
    	System.out.println(memPwChk.getId() + "의 회원정보 수정");
 	
    	memDAOService.updateMember(updateMemInfo);
    	String chkVal = "dash";
    	// alert처리단
    	response.setContentType("text/html; charset-utf-8");

		PrintWriter out = response.getWriter();
    	out.println("<script>history.go(-1);");
    	out.println("document.getElementById('id01').style.display='none';</script>");
        out.flush();      
        result.addObject("chkVal", chkVal);
        result.addObject("id", updateMemInfo.getId());
        result.setViewName("main/submenu2");
		return;
	}
    
    //회원정보 수정 창으로 이동
    @RequestMapping("updatememberform.do")
    public ModelAndView updatememberform(HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	// 회원정보수정시 기존 정보를 불러오기 위해 memDAOService.getMemInfoToUpdate를 사용한다(세션에서 ).
    	MemVO memVO = memDAOService.getMemInfoToUpdate((String)session.getAttribute("id"));
    	result.addObject("member", memVO);
    	result.setViewName("main/updatememberform");
        return result;
    }
    
    @RequestMapping("insertMember.do")
    public ModelAndView insertMember(MemVO memVO, HttpServletResponse response) throws Exception {
    	ModelAndView result = new ModelAndView();
    	int chk = memDAOService.chkMemberId(memVO);   // memVO 
    	System.out.println("chk = " + chk);
    	if (chk != 0) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('이미 존재하는 아이디입니다.');</script>");
            out.flush(); 
    		result.setViewName("main/joinform");
    		return result;
		}
    	memDAOService.insertMember(memVO);	
    	response.setContentType("text/html; charset-utf-8");
		PrintWriter out = response.getWriter();
        out.println("<script>alert('회원가입 되었습니다!');</script>");
        out.flush();
		result.setViewName("index");
    	return result;
    }
    
    
}

