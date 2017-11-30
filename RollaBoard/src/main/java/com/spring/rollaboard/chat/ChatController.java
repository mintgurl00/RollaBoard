package com.spring.rollaboard.chat;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.rollaboard.board.BoardDAOService;
import com.spring.rollaboard.chat.list.ChatListDAOService;
import com.spring.rollaboard.chat.list.ChatListVO;
import com.spring.rollaboard.cmt.CmtDAOService;
import com.spring.rollaboard.mem.MemDAOService;
import com.spring.rollaboard.role.RoleDAOService;
import com.spring.rollaboard.section.SectionDAOService;
import com.spring.rollaboard.task.TaskDAOService;

@Controller
public class ChatController {

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
	
	@Autowired
	private ChatListDAOService chatListDAOService;
	
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@RequestMapping("chattest.do")
    public ModelAndView memberadmitform(HttpServletRequest request) {
    	ModelAndView result = new ModelAndView();
    	result.setViewName("chat/client_chat");
        return result;
    }
	
	// 채팅의 세계로 입장
	@RequestMapping("chattest.so")
    public ModelAndView chatHallStart(HttpServletRequest request, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	System.out.println("☆채팅의 세계입니다.☆");
    	// 00 세션 체크 해야하기는 해.....(id랑, 보드 없으면 튕겨야 함)
    	
    	
    	// 01 세션에 채팅방 값(시작화면값 0) 추가(세션에 놔서 웹 소켓 세션이 처리할 수 있도록 할 예정이다.)
    	session.setAttribute("chId", 0);
    	
    /*	// request로 전달한 chId를 받아본다.(있으면 세션으로 올린다.) // 응 이걸 왜 여기서 하지. .ㄷ.
    	int chId = 0;
    	if(request.getParameter("chId") != null)
    		chId = Integer.parseInt((String)request.getParameter("chId"));*/
    	
		// 02 필요한 재료(memId, boardId)소환(전부 다 세션에 있지).
    	String memId = (String) session.getAttribute("id");
    	int boardId = Integer.parseInt((String) session.getAttribute("board_id"));
    	System.out.println("memId:" + memId + ", boardId:" + boardId/* + ", chId:" + chId*/);
    	// 03 채팅룸 리스트를 불러와(내게 맞는)
    	ArrayList<ChatListVO> chatList = chatListDAOService.getChatList(memId, boardId);
    	
    	// 04 채팅룸 리스트를 전달
    	result.addObject("chatList", chatList);
    	result.setViewName("chat/chathotel");
        return result;
    }
	
	// 본격적인 채팅 룸
	@RequestMapping("/chat/{chId}")
    public ModelAndView chatRoom(@PathVariable("chId") int chId, HttpServletRequest request, HttpSession session) {
    	ModelAndView result = new ModelAndView();
    	
    	// 01 chId를 보고 현재 접속한 방을 업데이트한다.
    	//session.setAttribute("chId", chId);
    	
    	
    	
    	result.addObject("chId", chId);
    	result.setViewName("chat/chatroom");
        return result;
    }
}
