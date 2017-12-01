<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.chat.msg.MessageVO"%>
<%@ page import="com.spring.rollaboard.chat.mem.ChatMemVOEx"%>
<%
ArrayList<MessageVO> oldMessageList = (ArrayList<MessageVO>) request.getAttribute("oldMessageList");
ArrayList<ChatMemVOEx> chatMemListEx = (ArrayList<ChatMemVOEx>) request.getAttribute("chatMemListEx");	// 멤버 이름 맵핑용
%>

<script>
// id와 name맵핑
var roleId = new Array();
var roleName = new Array();
var memId = new Array();
var memName = new Array();
<%
for(ChatMemVOEx cmx : chatMemListEx){
%>
	memId[memId.length] = <%=cmx.getMemId()%>
	memName[memName.length] = <%=cmx.getMemName()%>
	roleId[roleId.length] = <%=cmx.getRoleId()%>
	roleName[roleName.length] = <%=cmx.getRoleName()%>
<%
}%>

</script>

<h3>${chId}</h3>
채팅의 방
<div id="chatArea">
	<div id="chatTextArea">
		<c:forEach items="#{oldMessageList }" var="message">
			<div class="message">
				chId:${message.chId }<br/>
				memId:${message.memId }<br/>
				roleId:${message.roleId }<br/>
				text:${message.text }<br/>
				creDate:${message.creDate }<br/>
			</div>
		</c:forEach>
	</div>
	<input type="text" id="input" /> <button id="sendBtn">전송</button>
</div>


<script>


$(document).ready(function(){
	w.send('${id}|&|${chId}|&| |&|ENTER') ;	// 입장 신호
	
	//엔터로 보내기
	$('#input').keypress( function(e){
		if( e.keyCode == 13 ){
			send($("#input").val());
			return false;
		}
	});
	//전송버튼
	$("#sendBtn").on("click",function(){
		send($("#input").val());
		$("#input").focus();
	})
	
});

function send(text){
	if(text == "")
		return;
	w.send('${id}|&|${chId}|&|'+text);
	$("#input").val("");
}

function setMemberList(){
	
}

</script>