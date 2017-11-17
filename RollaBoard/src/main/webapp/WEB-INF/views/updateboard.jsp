<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.spring.rollaboard.BoardVO" %>
<% String pageName = "rolelist.jsp"; %>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
BoardVO boardVO = (BoardVO) request.getAttribute("boardVO");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>updateboard</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script>
function changeRole() {
	$('#resultBlock').load("rolelist.do");
}

function changeMember() {
	$('#resultBlock').load("memberlist.do");
}

function changeAdmit() {
	$('#resultBlock').load("memberadmit.do");
}

function changeETC() {
	$('#resultBlock').load("etc.do");
}
</script>
<body>
<form class = form-horizental" action = "#">
<div class = "page-header">
	<div class = "row">
		<div class = "col-xs-1"></div>
		<div class = "col-xs-3"><input type = "text" class = "form-control" id = "board_name" value = "<%=boardVO.getName() %>" placeholder = "Board명을 입력하세요"></div>
		<div class = "col-xs-2"><input type="button" name = "group" class="btn btn-primary" onclick = "changeRole()" value = "ROLE관리"/></div>
		<div class = "col-xs-2"><input type="button" name = "group" class="btn btn-primary" onclick = "changeMember()" value = "MEMBER관리"/></div>
		<div class = "col-xs-2"><input type="button" name = "group" class="btn btn-primary" onclick = "changeAdmit()" value = "MEMBER승인"/></div>
		<div class = "col-xs-2"><input type="button" name = "group" class="btn btn-primary" onclick = "changeETC()" value = "기타설정"/></div>

	</div>
</div>
<div id=resultBlock class="wrapper">
	<jsp:include page="rolelist.jsp" >
			<jsp:param name="page" value="Result" />
	</jsp:include>
</div>
<div class = "row">
	<center><div class = "col-xs-12 left">
	<input type = "submit" class = "btn btn-info" value = "만들기"> &nbsp; 
	<input type = "button" class = "btn btn-info" value = "취소" onclick = "location.href='board.do?board_id=<%=boardVO.getId()%>'">
	</div></center>
	
</div>

</body>
</html>