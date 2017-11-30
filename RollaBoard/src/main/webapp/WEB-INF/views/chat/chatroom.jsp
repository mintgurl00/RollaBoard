<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
/* int chId = Integer.parseInt(request.getParameter("chId").toString()); */
%>
<h3>${chId}</h3>
채팅의 방
<input type="text" id="input" /> <button id="send">전송</button>

<script>
//sw = new WebSocket( "ws://localhost:8080/rollaboard/broadcasting" ) ;
//w.send("살려줘") ;
$(document).ready(function(){
	w.send('안녕') ;
	w.send('${chId}') ;
	
	//엔터로 보내기
	$('#input').keypress( function(e){
		if( e.keyCode == 13 ){
			send($("#input").val());
			return false;
		}
	});
});

function send(text){
	if(text == "")
		return;
	w.send('${chId}'+'|&|'+text);
	$("#input").val("");
}

</script>