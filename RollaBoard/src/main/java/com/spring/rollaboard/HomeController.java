package com.spring.rollaboard;


import java.io.IOException;
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
    public ModelAndView insertMember(MemVO memVO, HttpServletResponse response) throws Exception {
    	ModelAndView result = new ModelAndView();
    	int chk = memDAOService.chkMemberId(memVO);
    	System.out.println("chk = " + chk);
    	if (chk != 0) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('이미 존재하는 아이디입니다.');</script>");
            out.flush(); 
    		result.setViewName("joinform");
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
    
    @RequestMapping("createboardform.do")
    public String createboardform() {
    	return "createboardform";
    }
    
    @RequestMapping("createboard.do")
    public ModelAndView createboard(BoardVO boardVO, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	//System.out.println(boardVO.getName() + (String)(session.getAttribute("id")));

    	String board_name = boardVO.getName();
    	String mem_id = (String)(session.getAttribute("id"));
    	
    	//System.out.println(board_name + mem_id);
    	
    	boardDAOService.createBoard(board_name, mem_id);
    	
    	result.addObject("board", boardVO);
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
    	String mem_id = (String) session.getAttribute("id");
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
    	result.setViewName("newboard");
        return result;
    }
    
    @RequestMapping("board.do")
    public ModelAndView board( HttpSession session , HttpServletRequest request, HttpServletResponse response ) throws Exception {
    	/*
    	 * 석원이 지금 하고 있는 부분
    	 * 1. 참조하는 보드 명단 가져오기. 함. model만
    	 * 2. 태스크 예쁘게 보기. 하는 중
    	 * 2-1 섹션
    	 * 2-2 태스크
    	 * 2-3 롤
    	 * 3. 검색 & 필터
    	 * */
    	
    	
    	ModelAndView result = new ModelAndView();
    	System.out.println(session.getAttribute("id"));
    	String id = session.getAttribute( "id" ).toString() ;	// 멤버 id 여기서 문제발생했다!!!!!!!!!!!
    	int board_id = Integer.parseInt( request.getParameter( "board_id" ) ) ;	// 보드 id
    	   	
    	// 보드에 승인이 안되어 있으면 들어갈 수 없다.
    	String permission = boardDAOService.permitChk(board_id, id);
    	System.out.println("허가여부 : " + permission);
    	if (permission.equals("FALSE")) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('아직 승인되지 않았습니다.');</script>");
            out.flush(); 
            System.out.println("승인안됨. 세션은? " + session.getAttribute("id"));
        	List<BoardVO> boardList = boardDAOService.getBoards(id); // 보드리스트 받아옴
        	result.addObject("boardList", boardList);
            result.setViewName("dashboard");
            return result;
		}
    	BoardVO boardVO = boardDAOService.getBoardInfo(board_id);
    	System.out.println( "id:" + id + ", board_id:" + board_id );
    	
    	/* ******************************************************************** */
    	// 아래부터는 석원 구역. 보드에 태스크 보여주기
    	
    	/*
    	 * 사실 이 부분에 보드멤버가 맞는지 확인하는 부분이 들어가야 한다.
    	 * (뭐, 어서 일단 넘어가구요.)
    	 * */
    	
    	// 01. 참조 보드 리스트 추출
    	//ArrayList<BoardVO> refBoardList = boardDAOService.getRefBoards( board_id );
    	//System.out.println("참조보드리스트추출");
    	
    	// 02. 섹션 리스트 추출
    	//ArrayList<SectionVO> sectionList = sectionDAOService.getSections( board_id ) ;
    	//System.out.println("섹션리스트추출");
    	
    	// 03. 태스크 리스트 추출
    	//ArrayList<TaskVO> taskList = taskDAOService.getTasksByBoard(board_id) ;
    	//System.out.println("태스크리스트추출");
    	// 04. 롤 배치 리스트 추출
    	
    	
    	/*    	
    	// 태스크 배치
    	ArrayList<ArrayList<TaskVO>> taskViewList ;
    	
    	// 롤 배치
    	ArrayList<ArrayList<ArrayList<RoleVO>>> roleViewList ;
    	*/
    	
		// ....을 전달
    	//result.addObject( "refBoardList" , refBoardList ) ;
    	//result.addObject( "sectionList" , sectionList ) ;
    	
    	// 여기까지 석원구역.
    	/* ******************************************************************** */
    	
    	result.addObject( "boardVO" , boardVO ) ;	// 쓸 데가 많을 것 같아서 전달합니다. view에서 request객체를 통해 참조할 수 있습니다.
    	result.setViewName("board");
        return result;
    }
    
    @RequestMapping("updateboard.do")
    public ModelAndView updateboard(BoardVO boardVO) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("업데이트보드 name = " + boardVO.getName());
    	result.addObject("boardVO", boardVO);
    	result.setViewName("updateboard");
        return result;
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
	
	@RequestMapping("inserttask.do")
	public ModelAndView insertTask(HttpSession session, HttpServletResponse response, TaskVO taskVO) {
		taskDAOService.insertTask(taskVO);
		ModelAndView result = new ModelAndView();				
		List<TaskVO> taskList = taskDAOService.getTasks();
		result.addObject("taskList", taskList);
		result.setViewName("board");
		return result;
		
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
    	System.out.println(memPwChk.getId() + "의 회원정보 수정");
 	
    	memDAOService.updateMember(updateMemInfo);
    	// alert처리단
    	response.setContentType("text/html; charset-utf-8");
		PrintWriter out = response.getWriter();
    	out.println("<script>alert('회원정보가 수정되었습니다.');");
    	out.println("window.close();</script>");
        out.flush();
        result.addObject("id", updateMemInfo.getId());
    	result.setViewName("dashboard");
		return result;
	}
    
}

