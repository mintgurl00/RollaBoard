package com.spring.rollaboard;

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
import org.springframework.web.servlet.view.RedirectView;


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
    	
    	///테스트
    	/*TaskFilterSQL tfSQL = TaskFilterSQL.getInstance() ;
    	System.out.println( tfSQL.get( TaskFilter.CREDATE_ASC ) ) ;*/
    	
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
    	session.removeAttribute("board_id"); // 대쉬보드로 이동시 board_id 세션을 없앤다.
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
    public ModelAndView createboard(BoardVO boardVO, HttpSession session, HttpServletResponse response) throws Exception {
    	
    	ModelAndView result = new ModelAndView();
    	System.out.println("보드 이름 : " + boardVO.getName() + "아이디 : " + (String)(session.getAttribute("id")));

    	String board_name = boardVO.getName();
    	String mem_id = (String)(session.getAttribute("id"));
    	
    	if (boardDAOService.getBoard(board_name) != null) {
    		response.setContentType("text/html; charset-utf-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script>alert('이미 사용중인 보드 이름입니다!');</script>");
        	out.flush();
        	result.setViewName("createboard");
        	return result;
		}
    	boardDAOService.createBoard(board_name, mem_id);
    	
    	// 만들어진 보드 아이디를 갖고와서 초기 SECTION을 만드는 데 사용한다.
    	BoardVO createdBoardVO = boardDAOService.getBoard(board_name);
    	SectionVO sectionVO = new SectionVO();
    	// SECTION을 만들 때는 boardVO객체를 통해서 만든다.
    	sectionVO.setBoard_id(createdBoardVO.getId());
    	sectionVO.setName("대분류1");
    	sectionDAOService.createSection(sectionVO);
    	response.setContentType("text/html; charset-utf-8");
    	PrintWriter out = response.getWriter();
    	out.println("<script>alert('보드가 새로 생성되었습니다.');</script>");
    	out.flush();
    	
    	result.addObject("board", boardVO);
    	result.setViewName("newboard");
    	
    	return result;
    }
    
    @RequestMapping("rolelist.do")
    public ModelAndView rolelist(String board_id) {
        ModelAndView result = new ModelAndView();
        System.out.println("롤 리스트  id :" + board_id);
        ArrayList<RoleVO> roleList = roleDAOService.getRoles(Integer.parseInt(board_id));
        result.addObject("roleList", roleList);
        result.setViewName("rolelist");
        return result;
    }
 
    @RequestMapping("createrole.do")
	public ModelAndView insertrole(RoleVO updateRoleInfo, HttpSession session) throws Exception {
    	ModelAndView result = new ModelAndView();
    	int board_id;
    	if (session.getAttribute("board_id") == null) {
			result.setViewName("index");
			return result;
		}
    	board_id = Integer.parseInt((String)session.getAttribute("board_id"));
    	updateRoleInfo.setBoard_id(board_id);
    	System.out.println("insertRole 정보들");
    	System.out.println("board_id : " + updateRoleInfo.getBoard_id());
    	System.out.println("Name : " + updateRoleInfo.getName());
    	System.out.println("Desc : " + updateRoleInfo.getDescription());

    	roleDAOService.createRole(updateRoleInfo);
    	result.setViewName("subMenu");
		return result;
	}
    
    @RequestMapping("updaterole.do")
	public ModelAndView updaterole(RoleVO updateRoleInfo, HttpServletResponse response) throws Exception {
    	ModelAndView result = new ModelAndView();
    	System.out.println("업데이트롤 정보들");
    	System.out.println("id : " + updateRoleInfo.getId());
    	System.out.println("Name : " + updateRoleInfo.getName());
    	System.out.println("Desc : " + updateRoleInfo.getDescription());
    	
    	roleDAOService.updateRole(updateRoleInfo);
    	// alert처리단
    	response.setContentType("text/html; charset-utf-8");
		PrintWriter out = response.getWriter();
    	out.println("<script>alert('ROLE 정보가 수정되었습니다.');");
    	out.println("</script>");
        out.flush();
    	result.setViewName("subMenu");
		return result;
	}
    
    @RequestMapping("deleteRole.do")
    public ModelAndView deleteRole(int id, HttpServletResponse response) throws Exception {
		ModelAndView result = new ModelAndView();
    	System.out.println("딜리트 롤 id : " + id);
		
		roleDAOService.deleteRole(id);
		// alert처리단
		response.setContentType("text/html; charset-utf-8");
		PrintWriter out = response.getWriter();
        out.println("<script>alert('ROLE 삭제에 성공하였습니다');</script>");
        out.flush(); 
        result.setViewName("subMenu");
        return result;
	}
    
    @RequestMapping("allocation.do")
    public ModelAndView allocation(String board_id) {
    	ModelAndView result = new ModelAndView();
    	int board_id1 = Integer.parseInt(board_id);
    	// 보드에 가입된 맴버 가져옴
    	ArrayList<MemVO> boardMemberList = memDAOService.getBoardMembers(board_id1); 
    	// 보드의 롤 리스트 가져옴
    	ArrayList<RoleVO> roleList = roleDAOService.getRoles(board_id1);
    	
    	result.addObject("boardMemberList", boardMemberList);
    	result.addObject("roleList", roleList);
    	result.setViewName("allocation");
    	return result;
	}
    
    @RequestMapping("rolemembers.do")
    public ModelAndView rolemembers(int role_id) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("롤아이디~~! : " + role_id);
    	RoleVO roleVO = roleDAOService.getRole(role_id);
    	String role_name = roleVO.getName();
    	ArrayList<MemVO> roleMem = memDAOService.getRoleMembers(role_id);
    	result.addObject("role_name", role_name);
    	result.addObject("roleMem", roleMem);
    	result.addObject("role_id", role_id);
    	result.setViewName("rolemembers");
    	return result;
    }
    
    @RequestMapping("insertmemtorole.do")
    public ModelAndView rolemember(int role_id, String mem_id, HttpSession session, HttpServletResponse response) throws Exception {
    	System.out.println("roleId : " + role_id + "  memId : " + mem_id);
    	ModelAndView result = new ModelAndView();
    	// 받아온 아이디가 우리 보드의 맴버인지 확인
    	
    	// 보드에 등록되어있는지 확인한다.
    	int board_id = Integer.parseInt((String)session.getAttribute("board_id"));
    	int chk = boardDAOService.joinBoardChk(board_id, mem_id);
    	if (chk == 0) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('BOARD에 가입된 회원이 아닙니다.');</script>");
            out.flush(); 
    		result.setViewName("subMenu");
            return result;
		}
    	// 보드에 승인된 사람인지 확인한다.
    	String permission = boardDAOService.permitChk(board_id, mem_id);
    	System.out.println("허가여부 : " + permission);
    	if (permission.equals("FALSE")) {
    		// alert처리단
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('아직 BOARD에 승인되지 않은 MEMBER입니다.');</script>");
            out.flush(); 
            result.setViewName("subMenu");
            return result;
		}
    	
    	// DB의 role_mem 테이블에 삽입
    	roleDAOService.allocateRole(role_id, mem_id);
    	
    	
    	result.setViewName("subMenu");
    	return result;
	}
    
    
    @RequestMapping("memberlist.do")
    public ModelAndView memberlist(String board_id) {

    	System.out.println("멤버관리로 이동");
    	System.out.println("보드아이디" + board_id);
    	ModelAndView result = new ModelAndView();
    	ArrayList<MemVO> boardMemberList = memDAOService.getBoardMembers(Integer.parseInt(board_id));
    	
    	result.addObject("boardMemberList", boardMemberList);
    	result.setViewName("memberlist");
        return result;

    }
    
    @RequestMapping("memberadmitform.do")
    public ModelAndView memberadmitform(String board_id) {
    	System.out.println("멤버승인으로 이동");
    	System.out.println("보드아이디" + board_id);
    	ModelAndView result = new ModelAndView();
    	ArrayList<MemVO> boardMemberList = memDAOService.waitingMembers(Integer.parseInt(board_id));
    	
    	result.addObject("boardMemberList", boardMemberList);
    	result.setViewName("memberadmitform");
        return result;
    }
    
    @RequestMapping("admitmember.do")
    public ModelAndView admitmember(String mem_id, HttpServletResponse response) throws Exception {
    	System.out.println("멤버승인 성공");
    	System.out.println("멤버아이디" + mem_id);
    	ModelAndView result = new ModelAndView();
    	memDAOService.admitMember(mem_id);
    	
    	response.setContentType("text/html; charset-utf-8");
    	PrintWriter out = response.getWriter();
    	out.println("<script>alert('멤버 승인에 성공했습니다.');</script>");
    	out.flush();
    	
    	result.setViewName("updateboard");
        return result;
    }
    
    @RequestMapping("deletemember.do")
    public ModelAndView deletemember(String mem_id, String board_id, HttpServletResponse response) throws Exception {
    	
    	System.out.println("강퇴할 멤버 아이디: " + mem_id);
    	ModelAndView result = new ModelAndView();
    	memDAOService.deleteMember(mem_id);
    	
    	response.setContentType("text/html; charset-utf-8");
    	PrintWriter out = response.getWriter();
    	out.println("<script>alert('멤버 강퇴/삭제에 성공했습니다.');</script>");
    	out.flush();
    	
    	ArrayList<MemVO> boardMemberList = memDAOService.getBoardMembers(Integer.parseInt(board_id));
    	
    	result.setView(new RedirectView("memberlist.do?method=list"));
    	//result.addObject("board_id", board_id);
    	result.addObject("boardMemberList", boardMemberList);
    	//result.setViewName("updateboard");
    	return result;
    	
    }
    
    //섹션 리스트 보기
    @RequestMapping("sectionlist.do")
    public ModelAndView sectionlist(String board_id) {
    	ModelAndView result = new ModelAndView();
    	ArrayList<SectionVO> sectionlist = sectionDAOService.getSections(Integer.parseInt(board_id));
    	
    	result.addObject("sectionlist", sectionlist);
    	
    	result.setViewName("sectionlist");
        return result;
    }
    
    //섹션 추가
    @RequestMapping("createsection.do")
    public ModelAndView createsection(SectionVO sectionVO, String board_id) {
    	
    	String section_name = sectionVO.getName();
    	System.out.println("추가할 섹션 이름: " + section_name);
    	ModelAndView result = new ModelAndView();
    	sectionDAOService.createSection(sectionVO);
    	
    	result.setViewName("sectionlist");
    	return result;
    	
    }
    
    //섹션 수정
    @RequestMapping("updatesection.do")
    public ModelAndView updatesection(String section_id, String board_id) {
    	
    	System.out.println("수정할 섹션 아이디: " + section_id);
    	ModelAndView result = new ModelAndView();
    	sectionDAOService.updateSection(section_id);
    	
    	result.setViewName("sectionlist");
    	return result;
    	
    }
    
    //섹션 삭제
    @RequestMapping("deletesection.do")
    public ModelAndView deletesection(String section_id, String board_id) {
    	
    	System.out.println("삭제할 섹션 아이디: " + section_id);
    	ModelAndView result = new ModelAndView();
    	sectionDAOService.deleteSection(section_id);
    	
    	result.setViewName("sectionlist");
    	return result;
    	
    }
    
    //기타설정 뷰로 이동
    @RequestMapping("etcform.do")
    public String etcform() {
        return "etcform";
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
    	int board_id = 0;
    	System.out.println("세션 보드아이디 : " + session.getAttribute("board_id"));
    	System.out.println("리쿼스트 보드아이디 : " + request.getParameter("board_id"));
    	if (request.getParameter("board_id") == null) {
    		if (session.getAttribute("board_id") == null) {
    			List<BoardVO> boardList = boardDAOService.getBoards((String)(session.getAttribute("id"))); //수민. 대시보드로 갈 때 보드리스트 받아옴
    			result.addObject("boardList", boardList);
				result.setViewName("dashboard");
				return result;
			}
    		board_id = Integer.parseInt((String) session.getAttribute( "board_id" ) ) ;	// 보드 id
		} else {
			board_id = Integer.parseInt((String) request.getParameter("board_id"));
		}
    	// board_id를 어디서도 받지 못했다면 대쉬보드로 간다.
    	if (board_id == 0) {
    		List<BoardVO> boardList = boardDAOService.getBoards((String)(session.getAttribute("id"))); //수민. 대시보드로 갈 때 보드리스트 받아옴
			result.addObject("boardList", boardList);
			result.setViewName("dashboard");
			return result;
		}
    	String board_id2 = "" + board_id;
    	session.setAttribute("board_id", board_id2);
    	
    	String id = session.getAttribute( "id" ).toString() ;
    	  	
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
    	// 참조 보드 리스트 추출
    	// 01. 참조 보드 리스트 추출
    	ArrayList<BoardVO> refBoardList = boardDAOService.getRefBoards( board_id );
    	System.out.println("참조보드리스트추출");
    	
		// ....을 전달
    	result.addObject( "refBoardList" , refBoardList ) ;
    	// 여기까지 석원구역.
    	/* ******************************************************************** */
    	
    	result.addObject( "boardVO" , boardVO ) ;	// 쓸 데가 많을 것 같아서 전달합니다. view에서 request객체를 통해 참조할 수 있습니다.
    	result.setViewName("board");
        return result;
    }
    
    @RequestMapping("updateboard.do")
    public ModelAndView updateboard(BoardVO boardVO, HttpSession session) {
    	ModelAndView result = new ModelAndView();
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
    	boardVO = boardDAOService.getBoardInfo(board_id);
		ArrayList<RoleVO> roleList = roleDAOService.getRoles(board_id);
    	System.out.println("업데이트보드 id = " + board_id);
    	result.addObject("boardVO", boardVO);
    	result.addObject("roleList", roleList); // 롤 리스트 넘겨줌
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
    
    /*
     * 석원. 검색 결과
     * */
    @RequestMapping("searchresult.do")
	public ModelAndView searchresult( HttpServletRequest request ) {
    	ModelAndView result = new ModelAndView();
    	
    	int board_id = Integer.parseInt( (String) request.getParameter( "board_id" ) ) ;
    	String keyword = (String) request.getParameter( "keyword" ) ;
    	
    	/* ******************************************************************** */
    	// 아래부터는 석원 구역. 보드에 태스크 보여주기
    	
    	/*
    	 * 사실 이 부분에 보드멤버가 맞는지 확인하는 부분이 들어가야 한다.
    	 * (뭐, 어서 일단 넘어가구요.)
    	 * */
    	
    	// 01. 참조 보드 리스트 추출...은 할 필요 없고
    	// 02. 섹션 리스트 추출
    	ArrayList<SectionVO> sectionList = sectionDAOService.getSections( board_id ) ;
    	System.out.println("섹션리스트추출");
    	
    	
    	// 03. 태스크 리스트 추출
    	ArrayList<TaskVO> taskList = taskDAOService.getTasksByBoard2( board_id , keyword ) ;	// sql문에서 섹션별로 그룹해야 편할듯 + 섹션순서번호 정렬
    	//ArrayList<TaskVO> taskList = taskDAOService.getTasksByBoard( board_id ) ;
    	System.out.println("태스크리스트추출");
    	System.out.println("보드id:" + board_id + ", 키워드:" + keyword );
    	// 04. 롤 배치 리스트 추출
    	
    	
    	
    	// 태스크 배치
    	ArrayList<ArrayList<TaskVO>> taskViewList = new ArrayList<ArrayList<TaskVO>>() ;	// 태스크리스트 저장객체 생성
    	for( int i = 0 ; i < sectionList.size() ; i++ ){
    		taskViewList.add( new ArrayList<TaskVO>() ) ;	// 섹션 수만큼 칸을 만들고
    	}
    	for( TaskVO task : taskList ){
    		int t_sid = task.getSection_id() ;	// 태스크의 섹션아이디
    		for( int j = 0 ; j < sectionList.size() ; j++ ){	// 섹션리스트 하나하나 섹션아이디 확인
    			int sid = sectionList.get( j ).getId() ;
    			if( sid == t_sid ){
    				taskViewList.get( j ).add( task ) ;
    				break ;
    			}
    		}
    	}
    	if( ! keyword.equals( "" ) ){
	    	for( int i = 0 ; i < taskViewList.size() ; i++ ){	// 태스크 없는 섹션은 지우기
	    		if( taskViewList.get(i).isEmpty() ){
	    			taskViewList.remove( i ) ;
	    			sectionList.remove( i ) ;
	    			i-- ;
	    		}
	    	}
    	}
    	// 롤 배치(나중에 하려고 함)
    	//ArrayList<ArrayList<ArrayList<RoleVO>>> roleViewList ;
    	
		// ....을 전달
    	//result.addObject( "refBoardList" , refBoardList ) ;
    	result.addObject( "sectionList" , sectionList ) ;
    	result.addObject( "taskViewList" , taskViewList ) ;
    	
    	// 여기까지 석원구역.
    	/* ******************************************************************** */
    	
    	
    	result.addObject( "board_id" , board_id + "" ) ;
    	result.addObject( "keyword" , keyword ) ;
    	result.setViewName("searchresult");
		return result;
	}

    
}

