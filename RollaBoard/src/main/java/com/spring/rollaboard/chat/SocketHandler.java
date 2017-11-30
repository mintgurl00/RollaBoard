package com.spring.rollaboard.chat;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.rollaboard.chat.list.ChatListDAOService;
import com.spring.rollaboard.chat.list.ChatListVO;


// 서버 단의 Socket Handler 정의
// Web Socket에서 서버 단의 프로세스를 정의할 수 있다.

public class SocketHandler extends TextWebSocketHandler {

	@Autowired
	private ChatListDAOService chatListDAOService;
	
	private final Logger logger = LogManager.getLogger( getClass() ) ;
	
	// 접속하는 사용자에 대한 세션을 보관하기 위해 정의
	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>() ;
	
	// 접속한 사용자에 대한 정보를 저장하기 위해 정의로움	// <memId, <chId>>
	private HashMap<String, HashSet<Integer>> chatRoomList = new HashMap<String, HashSet<Integer>>();
	private HashMap<String, Integer> currentChatRoomList = new HashMap<String, Integer>();
	private HashMap<String, String> sessionIdList = new HashMap<String, String>();	// 세션id로 빠르게 멤버id를 찾을 수 있도록 함
	
	public SocketHandler(){
		super() ;
		//this.logger.info( "create SocketHandler Instance" ) ;
		log("소켓 핸들러 인스턴스 생성");
	}
	
	// 클라이언트에서 연결을 종료할 경우 발생하는 이벤트
		
	@Override
	public void afterConnectionClosed( WebSocketSession session , CloseStatus status ) throws Exception {
		super.afterConnectionClosed(session, status);
		
		sessionSet.remove( session ) ;
		String targetMemId sessionIdList.get(clientSession.getId());
		
		// 같은 멤버아이디가 있는 웹소켓세션이 하나도 없어야 정의로움에서 제거할 수 있다.
		for(WebSocketSession clientSession : this.sessionSet){
			sessionIdList.get(clientSession.getId()).equals()
		}
		
		//this.logger.info( "Remove Session!" ) ;
		log("세션 제거");
	}

	// 클라이언트에서 접속을 하여 성공할 경우 발생하는 이벤트
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		
		sessionSet.add( session ) ;
		this.logger.info( "Add Session! : " + session.getAttributes() ) ;
		log("접속함. 세션 추가");
		
		//currentChatRoomList.put("", value)
		
		// 처음 세션이 들어오면
		// 01 id파악
		Map<String,Object> map = session.getAttributes();
		String memId = (String) map.get("id");	// 일단 아이디를 추출했어.
		int boardId = Integer.parseInt(map.get("board_id").toString());	// 그리고 리스트 부를 때 쓸 보드 아이디도

		// 현재 채팅 룸 id 저장.....은 지금 못하니까 나중에)
		// 02 갖고 있는 채팅 룸 리스트 id 확보
		if(chatRoomList.containsKey(memId))	// 근데 그 멤버가 이미 있으면 넘기기
			return;
		chatRoomList.put(memId, new HashSet<Integer>());
		ArrayList<ChatListVO> chatList = chatListDAOService.getChatList(memId, boardId);	// 추출
		for(ChatListVO chli : chatList)	// 샤샤샵입
			chatRoomList.get(memId).add(chli.getChId());

		// 03 id, 웹소켓세션id 기록해놓는다.
		sessionIdList.put(session.getId(), memId);
	}
	// 클라이언트에서 send를 이용해서 메시지 발송을 한 경우 이벤트 핸들링
	// 메시지를 받았다고 그러니까
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		super.handleMessage(session, message);
		// 그 메시지로 뭘 할까?
		/*
		 * 여기서 잠깐.
		 * 메시지는 {멤버아이디}|&|{채팅룸아이디}|&|{내용}으로 이루어져 있고
		 * 특수메시지는 {멤버아이디}|&|{채팅룸아이디}|&| |&|{신호} 로 이루어져 있다.
		 * */

		log("메시지 받음. : " + message.getPayload().toString());
		// 01 메시지 분해
		ArrayList<String> msgArray = new ArrayList<String>();
		StringTokenizer token = new StringTokenizer(message.getPayload().toString(), "|&|");
		while(token.hasMoreTokens()){
			msgArray.add(token.nextToken());
		}
		// 02 일반/특수 메시지 판별
		if(msgArray.size() == 4){	// 특수 메시지
			if(msgArray.get(3).equals("ENTER"))	// 새 채팅 룸 입장.
				enterChatRoom(msgArray);
		}else if(msgArray.size() == 3){	// 일반 메시지
			String chId = msgArray.get(1);
			// 자 이제 **선별해서 보낼*** 시간이야
			// 완전 중요 너무 중요... 잘 못 보내는 일이 없도록 매우 심혈을 기울이자!
			for( WebSocketSession clientSession : this.sessionSet ) {	// 접속한 웹소켓세션마다
				if( clientSession.isOpen() ){
					String memId = sessionIdList.get(clientSession.getId());
					if(chatRoomList.get(memId).contains(chId)){	// 보지는 않
						if(currentChatRoomList.get(memId).equals(chId)){	// 입장한 채팅룸
						}else{	// 리스트에 있는 채팅룸(입장하지는 않음)
							message = new TextMessage(chId + "|&|" + "BADGE") ;	// 보낸이, 내용을 지우고 채팅룸번호만 보낸다.
						}
						try {
							clientSession.sendMessage(message);	// 전송
						} catch ( Exception ignored ) {
							//this.logger.info( "Fail to send message!" , ignored );
							log("미지의 이유로 인해 전송에 실패하였다. : " + ignored.getMessage());
						}
					}
					
				}
			}
		}
		
		// 예쁘게 분해. 진짜 메시지와 채팅방번호
		//this.logger.info("메시지" + message.getPayload().toString() );
		//log("userId:" + userId + ", chId:" + chId);
		
		// 메시지 배포
/*		for( WebSocketSession client_session : this.sessionSet ) {
			if( client_session.isOpen() ){
				try {
					client_session.sendMessage(message);	// 전송
				} catch ( Exception ignored ) {
					//this.logger.info( "Fail to send message!" , ignored );
					log("미지의 이유로 인해 전송에 실패하였다. : " + ignored.getMessage());
				}
			}
		}*/
		// 보내고 뭘 할까?
		// .디비에 넣어야 하겠다.
	}
	
	// 채팅룸 입장 시
	private void enterChatRoom(ArrayList<String> msgArray) {
		String memId = msgArray.get(0);
		int chId = Integer.parseInt(msgArray.get(1));
		// 세션 만들 때 못했던 현재 채팅 룸 기록
		if(chatRoomList.get(memId).contains(chId) ){
			currentChatRoomList.put(memId, chId);
			log("채팅룸 입장 기록하였다.:" + memId + ", " + chId);
		}else{
			log("알 수 없는 이유로 현재 채팅 룸을 기록하지 못했다.");
		}
	}

	// 전송 에러 발생할 때 호출
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		//this.logger.error( "Web Socket Error!" , exception ) ;
		log("전송 에러ㅠㅠ 너무 슬프다..... 제발 진짜 왜이럴까? : " + exception.getMessage());
	}

	// 메시지가 긴 경우 분할해서 보낼 수 있는지 여부를 결정하는 메소드
	@Override
	public boolean supportsPartialMessages() {
		this.logger.info( "Call method!" ) ;
		return false ;
	}	
	
	private void log(String logmsg){
		System.out.println("★(Time)" + new Date() + "★CHATLOG★" + logmsg +"★");
	}
	

}
