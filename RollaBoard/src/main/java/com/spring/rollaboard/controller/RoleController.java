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
import com.spring.rollaboard.role.RoleVO;
import com.spring.rollaboard.section.SectionDAOService;
import com.spring.rollaboard.task.TaskDAOService;

//깃 테스트
@Controller
public class RoleController {

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
	
	private static final Logger logger = LoggerFactory.getLogger(RoleController.class);
	
	// ROLE 관련 메소드 -----------------------------------------------------------------
    
    @RequestMapping("rolelist.do")
    public ModelAndView rolelist(String board_id) {
        ModelAndView result = new ModelAndView();
        System.out.println("롤 리스트  id :" + board_id);
        ArrayList<RoleVO> roleList = roleDAOService.getRoles(Integer.parseInt(board_id));
        result.addObject("roleList", roleList);
        result.setViewName("boardsettings/rolelist");
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
    			// alert처리단
    			response.setContentType("text/html; charset-utf-8");
    			PrintWriter out = response.getWriter();
    	        out.println("<script>alert('ROLE이름이 중복됩니다! 생성할 수 없습니다.');</script>");
    	        out.flush();
    	        result.addObject("chkVal", "role");
    	        result.setViewName("main/subMenu");
    			return result;
			}
    	}
    	if (updateRoleInfo.getDescription().equals("")) {
			updateRoleInfo.setDescription("없음");
		}
    	updateRoleInfo.setBoard_id(board_id);
    	System.out.println("insertRole 정보들");
    	System.out.println("board_id : " + updateRoleInfo.getBoard_id());
    	System.out.println("Name : " + updateRoleInfo.getName());
    	System.out.println("Desc : " + updateRoleInfo.getDescription());

    	roleDAOService.createRole(updateRoleInfo);
    	String chkVal = "rolelist";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("main/subMenu");
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
    			// alert처리단
    			response.setContentType("text/html; charset-utf-8");
    			PrintWriter out = response.getWriter();
    	        out.println("<script>alert('ROLE이름이 중복됩니다! 변경할 수 없습니다.');</script>");
    	        out.flush(); 
    			result.addObject("chkVal", "role");
    			result.setViewName("main/subMenu");
    			return result;
			}
    	}
    	roleDAOService.updateRole(updateRoleInfo);

        String chkVal = "role";
        result.addObject("chkVal", chkVal);
        result.setViewName("main/subMenu");
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
        result.setViewName("main/subMenu");
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
    	result.setViewName("boardsettings/allocation");
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
    	result.setViewName("boardsettings/rolemembers");
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
            String chkVal = "allocation";
        	result.addObject("chkVal", chkVal);
        	result.setViewName("main/subMenu");
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
            String chkVal = "allocation";
        	result.addObject("chkVal", chkVal);
        	result.setViewName("main/subMenu");
            return result;
		}
    	// 이미 배정하고자 하는 ROLE에 가입된 MEMBER인지 확인
    	int duplication = roleDAOService.chkAllocation(role_id, mem_id);
    	if (duplication != 0) {
    		response.setContentType("text/html; charset-utf-8");
    		PrintWriter out = response.getWriter();
            out.println("<script>alert('이미 배정되어 있는 MEMBER입니다.');</script>");
            out.flush(); 
            String chkVal = "allocation";
        	result.addObject("chkVal", chkVal);
        	result.setViewName("main/subMenu");
            return result;
		}
    	
    	
    	// DB의 role_mem 테이블에 삽입
    	roleDAOService.allocateRole(role_id, mem_id);
    	
    	// 현재 페이지에 머물 수 있는 앵커값 : chkVal
    	String chkVal = "allocation";
    	result.addObject("chkVal", chkVal);
    	result.setViewName("main/subMenu");
    	return result;
	}
    
    @RequestMapping("deletememtorole.do")
    public ModelAndView deletememtorole (HttpServletRequest request) {
    	ModelAndView result = new ModelAndView();
    	String mem_id = (String)request.getParameter("id");
    	int role_id = Integer.parseInt((String)request.getParameter("role_id"));
    	System.out.println("배정 해제할 롤의 아이디 : " + role_id);
    	System.out.println("배정 해제할 맴버의 아이디 : " + mem_id);
    	roleDAOService.deallocateRole(role_id, mem_id);
    	result.addObject("role_id", role_id);
    	result.setViewName("redirect:rolemembers.do");
    	return result;
    }
    
    
}

