package com.spring.rollaboard;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.*;

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
    public ModelAndView login(MemVO memVO, HttpServletResponse response) throws Exception {
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
    
	//회원정보 수정 창으로 이동
    @RequestMapping("updatememberform.do")
    public ModelAndView updatememberform(HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	// 회원정보수정시 기존 정보를 불러오기 위해 memDAOService.getMemInfoToUpdate를 사용한다(세션에서 ).
    	MemVO memVO = memDAOService.getMemInfoToUpdate((String)session.getAttribute("id"));
    	result.addObject("member", memVO);
    	result.setViewName("updatememberform");
        return result;
    }
    
    // 회원정보 수정 처리
    @RequestMapping("updatemember.do")
	public ModelAndView updatemember(MemVO updateMemInfo, HttpServletResponse response) throws Exception {
    	ModelAndView result = new ModelAndView();
    	MemVO memPwChk = memDAOService.getMember(updateMemInfo);

    	if (memPwChk == null) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('비밀번호가 틀립니다.');</script>");
            out.flush(); 
            result.addObject("member", updateMemInfo);
            result.setViewName("updatememberform");
    		return result;
            //developerdon.tistory.com/entry/JAVA-단에서-alert-처리하기-–-
		}
    	System.out.println("수정");
    	System.out.println("아이디: " + updateMemInfo.getId());
    	System.out.println("비밀번호: " + updateMemInfo.getPassword());
    	System.out.println("이름: " + updateMemInfo.getName());
    	System.out.println("이메일: " + updateMemInfo.getEmail());
    	
    	memDAOService.updateMember(updateMemInfo);
    	// alert처리단
    	response.setContentType("text/html; charset-utf-8");
		PrintWriter out = response.getWriter();
    	out.println("<script>alert('회원정보가 수정되었습니다.');</script>");
        out.flush();
        result.addObject("id", updateMemInfo.getId());
    	result.setViewName("dashboard");
		return result;
	}
    
    
}

