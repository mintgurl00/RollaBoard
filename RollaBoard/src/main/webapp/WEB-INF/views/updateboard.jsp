<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.spring.rollaboard.BoardVO" %>
<%@ page import = "com.spring.rollaboard.RoleVO" %>
<%@ page import = "java.util.*" %>
<% String pageName = "rolelist.jsp"; %>
<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}

	BoardVO boardVO = (BoardVO) request.getAttribute("boardVO");
	ArrayList<RoleVO> roleList = (ArrayList<RoleVO>) request.getAttribute("roleList");
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
function rolePage() {
	$('#resultBlock').load("rolelist.do", {id: "<%=boardVO.getId() %>"});
}

function memberPage() {
	$('#resultBlock').load("memberlist.do", {board_id: "<%=boardVO.getId() %>"});
}

function admitPage() {
	$('#resultBlock').load("memberadmit.do");
}

function ETCPage() {
	$('#resultBlock').load("etc.do");
}
</script>
<body>
<form class = form-horizental" action = "#">
<div class = "page-header">
	<div class = "row">
		<div class = "col-sm-1"></div>
		<div class = "col-xs-12 col-sm-3"><input type = "text" class = "form-control" id = "board_name" value = "<%=boardVO.getName() %>" placeholder = "Board명을 입력하세요"></div>
		<div class = "col-xs-6 col-sm-2"><input type="button" name = "group" class="btn btn-primary" onclick = "rolePage()" value = "ROLE관리"/></div>
		<div class = "col-xs-6 col-sm-2"><input type="button" name = "group" class="btn btn-primary" onclick = "memberPage()" value = "MEMBER관리"/></div>
		<div class = "col-xs-6 col-sm-2"><input type="button" name = "group" class="btn btn-primary" onclick = "admitPage()" value = "MEMBER승인"/></div>
		<div class = "col-xs-6 col-sm-2"><input type="button" name = "group" class="btn btn-primary" onclick = "ETCPage()" value = "기타설정"/></div>

	</div>
</div>
<div id=resultBlock class="wrapper">
	<jsp:include page = "rolelist.jsp" flush = "false" >
			<jsp:param name="roleList" value="<%=roleList %>" />
	</jsp:include>
</div>
<div class = "row">
	<center><div class = "col-xs-12 left">
	<input type = "submit" class = "btn btn-info" value = "저장"> &nbsp; 
	<input type = "button" class = "btn btn-info" value = "취소" onclick = "location.href='board.do?board_id=<%=boardVO.getId()%>'">
	</div></center>
	
</div>

</body>
</html>