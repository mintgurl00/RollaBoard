<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.spring.rollaboard.*" %>
<%@ page import = "java.util.*" %>
<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	
	// 세션 보드아이디 체크
	if (session.getAttribute("board_id") == null) {
		out.println("<script>location.href='dashboard.do'</script>");
	}
	BoardVO boardVO = null;
	if (request.getAttribute("boardVO") != null) {
		boardVO = (BoardVO) request.getAttribute("boardVO");
	} else {
		boardVO.setId(Integer.parseInt((String) session.getAttribute("board_id")));
	}
	String chkVal = (String) request.getAttribute("chkVal");
	ArrayList<RoleVO> roleList = (ArrayList<RoleVO>) request.getAttribute("roleList");
	ArrayList<MemVO> boardMemberList = (ArrayList<MemVO>) request.getAttribute("boardMemberList");
	ArrayList<MemVO> boardWaitingList = (ArrayList<MemVO>) request.getAttribute("boardWaitingList");
	ArrayList<SectionVO> sectionList = (ArrayList<SectionVO>) request.getAttribute("sectionList");
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
	$('#resultBlock').load("rolelist.do", {board_id: "<%=boardVO.getId() %>"});
}

function allocatePage() {
	$('#resultBlock').load("allocation.do", {board_id: "<%=boardVO.getId() %>"});
}

function memberPage() {
	$('#resultBlock').load("memberlist.do", {board_id: "<%=boardVO.getId() %>"});
}

function admitPage() {
	$('#resultBlock').load("memberadmitform.do", {board_id: "<%=boardVO.getId() %>"});
}

function sectionPage() {
	$('#resultBlock').load("sectionlist.do", {board_id: "<%=boardVO.getId() %>"});
}

function ETCPage() {
	$('#resultBlock').load("etcform.do");
}
function updating() {
	document.getElementById("updating").submit();
}
</script>
<body>

<div class = "page-header">
	<div class = "row">
		<div class = "col-xs-1 col-sm-1"></div>
		<div class = "col-xs-8 col-sm-2">
		<form id = "updating" action = "updateboardname.do">
			<input type = "text" class = "form-control" name = "board_name" value = "<%=boardVO.getName() %>" placeholder = "Board명을 입력하세요" required>

		</form>
		</div>
		<div class = "col-xs-6 col-sm-1"><input type="button" name = "group" class="btn btn-primary" onclick = "rolePage()" value = "ROLE관리"/></div>
		<div class = "col-xs-6 col-sm-1"><input type="button" name = "group" class="btn btn-primary" onclick = "allocatePage()" value = "ROLE배정"/></div>
		<div class = "col-xs-6 col-sm-1"><input type="button" name = "group" class="btn btn-primary" onclick = "memberPage()" value = "MEMBER관리"/></div>
		<div class = "col-xs-6 col-sm-1"><input type="button" name = "group" class="btn btn-primary" onclick = "admitPage()" value = "MEMBER승인"/></div>
		<div class = "col-xs-6 col-sm-1"><input type="button" name = "group" class="btn btn-primary" onclick = "sectionPage()" value = "SECTION관리"/></div>
		<div class = "col-xs-6 col-sm-1"><input type="button" name = "group" class="btn btn-primary" onclick = "ETCPage()" value = "기타설정"/></div>

	</div>
</div>

<div id=resultBlock class="wrapper">
	<%if (chkVal == null) {%>
	<jsp:include page = "rolelist.jsp" flush = "false" >
			<jsp:param name="roleList" value="<%=roleList %>" />
	</jsp:include>
	<%} else if (chkVal.equals("memList")) { %>
	<jsp:include page = "memberlist.jsp" flush = "false" >
			<jsp:param name="boardMemberList" value="<%=boardMemberList %>" />
	</jsp:include>
	<%}else if (chkVal.equals("allocation")) { %>
	<jsp:include page = "allocation.jsp" flush = "false" >
			<jsp:param name="boardMemberList" value="<%=boardMemberList %>" />
			<jsp:param name="roleList" value="<%=roleList %>" />
	</jsp:include>
	<%}else if (chkVal.equals("memAdmit")) { %>
	<jsp:include page = "memberadmitform.jsp" flush = "false" >
			<jsp:param name="boardWaitingList" value="<%=boardWaitingList %>" />
	</jsp:include>
	<%}else if (chkVal.equals("section")) { %>
	<jsp:include page = "sectionlist.jsp" flush = "false" >
			<jsp:param name="sectionList" value="<%=sectionList %>" />
	</jsp:include>
	<%}else { %>
	<jsp:include page = "rolelist.jsp" flush = "false" >
			<jsp:param name="roleList" value="<%=roleList %>" />
	</jsp:include>
	<%} %>
</div>
<div class = "row" align = center>
	<div class = "col-xs-12 left">
	<input type = "submit" class = "btn btn-info" value = "확인" onclick = "javascript:updating()" >&nbsp; 
	<input type = "button" class = "btn btn-info" value = "돌아가기" onclick = "location.href='board.do?board_id=<%=boardVO.getId()%>'">
	</div>
</div>
<br/>
</body>
</html>