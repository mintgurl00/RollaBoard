package com.spring.rollaboard;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
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
    	
    	result.addObject("id", member.getId());
    	result.addObject("boardList", boardList); //수민
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
    	List<BoardVO> boardList = boardDAOService.getBoards((String)(session.getAttribute("id"))); //수민. 대시보드로 갈 때 보드리스트 받아옴
    	
    	result.addObject("id", session.getAttribute("id"));
    	result.addObject("boardList", boardList); //수민
    	result.setViewName("dashboard");
        return result;
    }
    
    @RequestMapping("newboard.do")
    public ModelAndView newboard() {
    	ModelAndView result = new ModelAndView();
    	result.setViewName("newboard");
        return result;
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
    public ModelAndView enterboard() {
    	ModelAndView result = new ModelAndView();
    	result.setViewName("enterboard");
        return result;
    }
    
    // 기존 보드에 가입함
    @RequestMapping("joinboard.do")
    public ModelAndView joinboard(String name, HttpSession session, HttpServletResponse response) throws Exception {
    	ModelAndView result = new ModelAndView();
    	String mem_id = session.getId();
    	System.out.println("보드 네임 : " + name);
    	
    	// 1. 보드가 있는지 확인해본다.
    	BoardVO boardVO = boardDAOService.getBoard(name);
    	if (boardVO == null) {
    		
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('찾는 BOARD가 존재하지 않습니다!(BOARD 이름을 다시 확인해주세요)');</script>");
            out.flush(); 
    		result.setViewName("enterboard");
            return result;
		}
    	
    	// 2. 이미 보드에 등록되어있는지 확인한다.
    	int chk = boardDAOService.joinBoardChk(boardVO.getId(), mem_id);
    	if (chk != 0) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('이미 BOARD에 가입신청을 했습니다.');</script>");
            out.flush(); 
    		result.setViewName("enterboard");
            return result;
		}
    	
    	// 3. 보드에 등록한다.
    	System.out.println("보드 등록 전 확인하자!");
    	System.out.println("보드아이디 : " + boardVO.getId());
    	System.out.println("맴버아이디 : " + mem_id);
    	boardDAOService.joinBoard(boardVO.getId(), mem_id);
    	
    	// alert처리단
		response.setContentType("text/html; charset-utf-8");
		PrintWriter out = response.getWriter();
        out.println("<script>alert('BOARD에 등록되었습니다. 관리자의 승인을 기다려주세요');</script>");
        out.flush(); 
    	result.setViewName("dashboard");
        return result;
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

