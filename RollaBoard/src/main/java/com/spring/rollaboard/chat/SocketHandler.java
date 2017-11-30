package com.spring.rollaboard.chat;

import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


// 서버 단의 Socket Handler 정의
// Web Socket에서 서버 단의 프로세스를 정의할 수 있다.

public class SocketHandler extends TextWebSocketHandler {
	
	private final Logger logger = LogManager.getLogger( getClass() ) ;
	
	// 접속하는 사용자에 대한 세션을 보관하기 위해 정의
	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>() ;
	
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
		
		
	/*	// 메시지 배포
		for( WebSocketSession client_session : this.sessionSet ) {
			if( client_session.isOpen() ){
				try {
					client_session.sendMessage("ㄴㄴㄴ");	// 전송
				} catch ( Exception ignored ) {
					this.logger.info( "Fail to send message!" , ignored );
				}
			}
		}*/
	}

/*
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log("핸들텍스트메시지"+message.getPayload());
		Map<String,Object> map = session.getAttributes();
		String userId = (String) map.get("id");
		System.out.println("로그인 한 아이디 : " + userId);
	}*/
	// 클라이언트에서 send를 이용해서 메시지 발송을 한 경우 이벤트 핸들링
	// 메시지를 받았다고 그러니까
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		super.handleMessage(session, message);
		// 그 메시지로 뭘 할까?
		Map<String,Object> map = session.getAttributes();
		String userId = (String) map.get("id");	// 일단 아이디를 추출했어.
		int chId = Integer.parseInt((String)map.get("chId"));		
		
		// 예쁘게 분해. 진짜 메시지와 채팅방번호
		//this.logger.info("메시지" + message.getPayload().toString() );
		log("메시지 받음. : " + message.getPayload().toString());
		log("세션에 있는건가 이거? : " + userId );
		
		// 메시지 배포
		for( WebSocketSession client_session : this.sessionSet ) {
			if( client_session.isOpen() ){
				try {
					client_session.sendMessage(message);	// 전송
				} catch ( Exception ignored ) {
					//this.logger.info( "Fail to send message!" , ignored );
					log("미지의 이유로 인해 전송에 실패하였다. : " + ignored.getMessage());
				}
			}
		}
		// 보내고 뭘 할까?
		// .디비에 넣어야 하겠다.
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
