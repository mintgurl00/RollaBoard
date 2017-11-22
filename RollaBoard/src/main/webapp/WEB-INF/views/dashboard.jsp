<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.spring.rollaboard.*"%>
<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	request.setCharacterEncoding("utf-8");
	
	List<BoardVO> boardList = (ArrayList<BoardVO>)request.getAttribute("boardList");
	ArrayList<TaskVO> taskList = (ArrayList<TaskVO>) request.getAttribute("taskList");

%>
<script type = "text/javascript" language = "javascript">
function openPop() {
	window.open("./updatememberform.do",
			"UPDATE",
			"resizeable = yes, menubar=no, width = 800, height = 500, left = 10, right = 10");
	
}
function viewTask (cnt) {
	document.getElementById("taskview" + cnt).submit();	
}
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>dashboard</title>
<style>
#leftside{float:left; width:200px; height:960px; background-color:#B5B2FF}
#rightside{float:left; width:1280px; height:960px; background-color:#DAD9FF}
#task{float:left; width:200px; height:200px; margin-left:40px; margin-top:40px; background-color:#EAEAEA; text-align:center}
</style>
</head>
<body>

<div id="leftside">
<h2 align="center">내 BOARD 보기</h2><br/><br/><br/>
	<div style="text-align:center">
		
			<%
			for (int i=0; i<boardList.size(); i++) {
				BoardVO board = boardList.get(i);
			%>
			
			<a href="./board.do?board_id=<%=board.getId()%>" >
			<%=board.getName() %>
		
			</a><br/><br/><br/><br/><br/>
			<%
			}
			%>
		<a href = "newboard.do">추가</a>
	</div>
</div>

<div id="rightside">
<p align="right"><a href = "#" onClick = "openPop();" >회원정보수정</a> | <a href="logout.do">logout</a>&nbsp;</p>
<br/>
<% for (int k = 0; k < taskList.size(); k++) {
	TaskVO taskVO = taskList.get(k);
%>
<div id="task" onclick="javascript:viewTask(<%=taskVO.getId() %>)"><h3><%=taskVO.getName()%></h3><br/><br/>BOARD 이름:<%=taskVO.getDescription() %></div>
<form id = "taskview<%=taskVO.getId() %>" action = "taskview.do" hidden>
	<input type = hidden name = "task_id" value = "<%=taskVO.getId() %>">
	<input type = hidden name = "board_name" value = "<%=taskVO.getDescription()%>">
</form>
<%} %>


</div>


</body>
</html>