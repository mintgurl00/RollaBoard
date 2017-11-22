package com.spring.rollaboard;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
    	Date date = new Date();
    	System.out.println("시간! : " + date);
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
    
    @RequestMapping("joinform.do")
    public String joinform() {
        return "joinform";
    }
    
    // ROLE 관련 메소드 -----------------------------------------------------------------
    
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
	public ModelAndView createrole(RoleVO updateRoleInfo, HttpSession session, HttpServletResponse response) throws Exception {
    	ModelAndView result = new ModelAndView();
    	int board_id;
    	if (session.getAttribute("board_id") == null) {
			result.setViewName("index");
			return result;
		}
    	board_id = Integer.parseInt((String)session.getAttribute("board_id"));
    	// 롤 이름이 중복되는 값이면 만들어지지 않게 한다.
    	ArrayList<RoleVO> roleList = roleDAOService.getRoles(board_id);	
    	for (int i = 0; i < roleList.size(); i++) {
    		RoleVO role = roleList.get(i);
    		if (role.getName().equals(updateRoleInfo.getName())) {
//    			// alert처리단
//    			response.setContentType("text/html; charset-utf-8");
//    			PrintWriter out = response.getWriter();
//    	        out.println("<script>alert('ROLE이름이 중복됩니다! 생성할 수 없습니다.');</script>");
//    	        out.flush(); 
    	        result.setViewName("redirect:updateboard.do");
    			return result;
			}
    	}
    	updateRoleInfo.setBoard_id(board_id);
    	System.out.println("insertRole 정보들");
    	System.out.println("board_id : " + updateRoleInfo.getBoard_id());
    	System.out.println("Name : " + updateRoleInfo.getName());
    	System.out.println("Desc : " + updateRoleInfo.getDescription());

    	roleDAOService.createRole(updateRoleInfo);
    	String chkVal = "rolelist";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("redirect:updateboard.do");
		return result;
	}
    
    @RequestMapping("updaterole.do")
	public ModelAndView updaterole(RoleVO updateRoleInfo, HttpServletResponse response, HttpSession session) throws Exception {
    	ModelAndView result = new ModelAndView();
    	System.out.println("업데이트롤 정보들");
    	System.out.println("id : " + updateRoleInfo.getId());
    	System.out.println("Name : " + updateRoleInfo.getName());
    	System.out.println("Desc : " + updateRoleInfo.getDescription());
    	int board_id;
    	if (session.getAttribute("board_id") == null) {
			result.setViewName("index");
			return result;
		}
    	board_id = Integer.parseInt((String)session.getAttribute("board_id"));
    	// 롤 이름이 중복되는 값이면 만들어지지 않게 한다.
    	ArrayList<RoleVO> roleList = roleDAOService.getRoles(board_id);	
    	for (int i = 0; i < roleList.size(); i++) {
    		RoleVO role = roleList.get(i);
    		if (role.getName().equals(updateRoleInfo.getName())) {
//    			// alert처리단
//    			response.setContentType("text/html; charset-utf-8");
//    			PrintWriter out = response.getWriter();
//    	        out.println("<script>alert('ROLE이름이 중복됩니다! 생성할 수 없습니다.');</script>");
//    	        out.flush(); 
    	        result.setViewName("redirect:updateboard.do");
    			return result;
			}
    	}
    	roleDAOService.updateRole(updateRoleInfo);

        String chkVal = "role";
        result.addObject("chkVal", chkVal);
        result.setViewName("redirect:updateboard.do");
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
//    		response.setContentType("text/html; charset-utf-8");
//    		PrintWriter out = response.getWriter();
//            out.println("<script>alert('BOARD에 가입된 회원이 아닙니다.');</script>");
//            out.flush(); 
            String chkVal = "allocation";
        	result.addObject("chkVal", chkVal);
        	result.setViewName("redirect:updateboard.do");
            return result;
		}
    	// 보드에 승인된 사람인지 확인한다.
    	String permission = boardDAOService.permitChk(board_id, mem_id);
    	System.out.println("허가여부 : " + permission);
    	if (permission.equals("FALSE")) {
    		// alert처리단
//    		response.setContentType("text/html; charset-utf-8");
//    		PrintWriter out = response.getWriter();
//            out.println("<script>alert('아직 BOARD에 승인되지 않은 MEMBER입니다.');</script>");
//            out.flush(); 
            String chkVal = "allocation";
        	result.addObject("chkVal", chkVal);
        	result.setViewName("redirect:updateboard.do");
            return result;
		}
    	
    	// DB의 role_mem 테이블에 삽입
    	roleDAOService.allocateRole(role_id, mem_id);
    	
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "allocation";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("redirect:updateboard.do");
    	return result;
	}
    
    // 맴버관련 메소드 -------------------------------------------------------------------
    
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
    
    @RequestMapping("memberadmitform.do")
    public ModelAndView memberadmitform(String board_id) {
    	System.out.println("멤버승인으로 이동");
    	System.out.println("보드아이디" + board_id);
    	ModelAndView result = new ModelAndView();
    	ArrayList<MemVO> boardMemberList = memDAOService.waitingMembers(Integer.parseInt(board_id));
    	
    	result.addObject("boardWaitingList", boardMemberList);
    	result.setViewName("memberadmitform");
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
    
    // SECTION 관련 메소드 ---------------------------------------------------------------
    
    //섹션 리스트 보기
    @RequestMapping("sectionlist.do")
    public ModelAndView sectionlist(String board_id) {
    	ModelAndView result = new ModelAndView();
    	ArrayList<SectionVO> sectionlist = sectionDAOService.getSections(Integer.parseInt(board_id));
    	
    	result.addObject("sectionList", sectionlist);
    	
    	result.setViewName("sectionlist");
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
    	result.setViewName("redirect:updateboard.do");
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
    public ModelAndView updatesection(int section_id, String section_name) {
    	
    	System.out.println("수정할 섹션 아이디: " + section_id);
    	ModelAndView result = new ModelAndView();
    	sectionDAOService.updateSection(section_id, section_name);
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "section";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("redirect:updateboard.do");
    	return result;
    	
    }
    
    // board.jsp에서 섹션 수정
    @RequestMapping("updatesectioninboard.do")
    public ModelAndView updatesectioninboard(int section_id, String section_name) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("updatesection section_id : " + section_id);
    	sectionDAOService.updateSection(section_id, section_name);

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
    	result.setViewName("redirect:updateboard.do");
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
    
    //기타설정 뷰로 이동
    @RequestMapping("etcform.do")
    public ModelAndView etcform(HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	
    	int board_id = Integer.parseInt((String) session.getAttribute("board_id"));
    	ArrayList<BoardVO> refBoardList = boardDAOService.getRefBoards(board_id);
    	
    	result.addObject("refBoardList" , refBoardList) ;
    	result.setViewName("etcform");
    	
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
    public ModelAndView addrefboard(HttpServletRequest request, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("addrefboard.do 진입했는지 확인");
    	System.out.println("내 보드 아이디: " + Integer.parseInt((String)session.getAttribute("board_id")));
    	int board_id = Integer.parseInt((String)session.getAttribute("board_id"));
    	
    	String ref_board_name = request.getParameter("ref_board_name");
    	System.out.println("추가할 참조보드 이름 : " + ref_board_name);
    	
    	int ref_id = boardDAOService.getRefBoardId(ref_board_name);
    	System.out.println("참조보드 아이디 : " + ref_id);
    	
    	boardDAOService.addRefBoard(ref_id, board_id);
    	
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "etc";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("redirect:updateboard.do");
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
    
    
    // TASK 관련 메소드 ----------------------------------------------------------------
    
    @RequestMapping(value = "taskview.do" )
    public ModelAndView taskview(int task_id) {	
    	ModelAndView result = new ModelAndView();
    	System.out.println("태스크뷰 아이디 : " + task_id);
    	TaskVO taskVO = taskDAOService.getTask(task_id);
    	result.addObject("taskVO", taskVO);
    	result.setViewName("taskview");
        return result;
    }
    
      
    @RequestMapping("updatetaskform.do")
    public  ModelAndView updatetaskform(TaskVO taskVO, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("updatetaskform.do... taskVO.getId : " + taskVO.getId());
    	// 배정할 롤 리스트를 같이 첨부해서 전송한다.
		int board_id = Integer.parseInt((String)session.getAttribute("board_id"));
		ArrayList<RoleVO> roleList = roleDAOService.getRoles(board_id);
		result.addObject("roleList", roleList);
    	result.addObject("taskVO", taskVO);
    	result.setViewName("updatetask");
    	return result;
    }
    
    @RequestMapping("updatetask.do")
    public ModelAndView updatetask(String taskToRole, TaskVO taskVO, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("태스크에 배정할 롤 이름! : " + taskToRole);
    	System.out.println("업데이트할 task_id : " + taskVO.getId());
    	if (taskVO.getStatus() == null) {
			taskVO.setStatus("NORMAL");
		}
    	System.out.println("스테이터스 :" + taskVO.getStatus());	
    	// 롤 이름이 없으면 수행 안한다.
    	if (taskToRole != null) {
	    	// createtask에서 가져온 롤 이름으로 롤 아이디 찾는다.
			int role_id = roleDAOService.getRoleIdByName(taskToRole, Integer.parseInt((String)session.getAttribute("board_id")));
			// 태스크에 롤을 배정한다.
			taskDAOService.taskToRole(taskVO.getId(), role_id);	
    	}
    	// 태스크 수정사항 업데이트
    	taskDAOService.updateTask(taskVO);
    	result.setViewName("redirect:board.do");
    	return result;
    }
    
    @RequestMapping("deletetask.do")
    public ModelAndView deletetask(int task_id) {
    	System.out.println("지울 task_id : " + task_id);
    	ModelAndView result = new ModelAndView();
    	taskDAOService.deleteTask(task_id);
    	result.setViewName("redirect:board.do");
    	return result;
    }
    
	@RequestMapping("createtask.do")
	public ModelAndView createtask(HttpServletRequest request, HttpSession session) {
		
		System.out.println("리쿼스트 섹션아이디 : " + request.getParameter("section_id"));
		String section_id = request.getParameter("section_id");  
		System.out.println("111111");
		ModelAndView result = new ModelAndView();
		
		result.addObject("section_id",section_id);
        result.setViewName("createtask");
        System.out.println("222222");
		return result;
	}
	
	@RequestMapping("inserttask.do")
	public ModelAndView insertTask(String taskToRole, HttpSession session, TaskVO taskVO, HttpServletRequest request) {
		System.out.println("만들 태스크의 이름 : " + taskVO.getName());
		
		
		/*int section_id = Integer.parseInt( request.getParameter( "section_id" ) ) ;*/
		
		// 태스크를 생성한다.
		taskDAOService.insertTask(taskVO);
		
		System.out.println("3333333");
		ModelAndView result = new ModelAndView();
		System.out.println("444");
		result.setViewName("redirect:board.do");
		return result;
		
		
		/*ModelAndView result = new ModelAndView();
    	String id = session.getAttribute( "id" ).toString() ;
    	int board_id = Integer.parseInt( request.getParameter( "board_id" ) ) ;	// 보드 id
    	
    	String board_name = boardVO.getName();
    	String mem_id = (String)(session.getAttribute("id"));*/
    	
	}
	
	@RequestMapping("detailtask.do")
	public String detailtask() {
		return "detailtask";
	}
    
	
	// 보드관련 메소드--------------------------------------------
    
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
        	out.println("<script>alert('이미 사용중인 보드 이름입니다!'); history.go(-1);</script>");
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
            out.println("<script>alert('찾는 BOARD가 없습니다!(BOARD 이름을 다시 확인해주세요)');</script>");
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
    	result.setViewName("updateboard");
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
    	String filter = (String) request.getParameter( "filter" ) ;
    	String[] filters = null ;
    	String[] orders = null ;	// 나중에 해야함
    	if( filter != null ){
	    	System.out.println( "필터 값 : " + filter ); // test
	    	StringTokenizer st = new StringTokenizer(filter," ");
	    	filters = new String[ st.countTokens() ] ; 
	    	for( int i = 0 ; i < filters.length ; i++ ){
	    		// st.hasMoreTokens() ;
	    		filters[ i ] = st.nextToken() ;
	    	}
	    	System.out.println( "전달된 필터 : " + filters.length +"개" );
	    	for( String filterString : filters ){
	    		System.out.print( filterString + " ");
	    	}
	    	System.out.println() ;
    	}else{
    		System.out.println( "전달된 필터는 없습니다." ) ;
    	}
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
    	ArrayList<TaskVO> taskList ;
    	if( filters == null && orders == null ){
    		taskList = taskDAOService.getTasksByBoard2( board_id , keyword ) ;	// sql문에서 섹션별로 그룹해야 편할듯 + 섹션순서번호 정렬
    	} else {
    		taskList = taskDAOService.getTasksByBoard2( board_id , keyword , filters , orders ) ;	
    	}
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

