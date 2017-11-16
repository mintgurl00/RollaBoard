<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.spring.rollaboard.BoardVO" %>
<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='loginForm.jsp'");
		out.println("</script>");
	}
	String id = (String) session.getAttribute("id");

	BoardVO boardVO = (BoardVO) request.getAttribute("boardVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>board</title>
<style>
#header{float:left; width:1580px; height:70px; background-color:#B5B2FF}
#logout{float:left; width:280px; height:70px; background-color:#B5B2FF}
#ref_board{width:280px; height:50px; background-color:#DAD9FF}
#filter{float:left; width:1860px; height:50px; background-color:#DAD9FF; text-align:right}
#content{overflow:scroll; width:1880px; height:960px}
#section{float:left; width:400px; height:900px; margin-left:40px; margin-top:40px; background-color:#DAD9FF; text-align:center}
#task{width:350px; height:150px; margin-left:20px; margin-top:20px; background-color:#FFFFFF; text-align:center}

</style>
<script type = "text/javascript" language = "javascript">
function openPop() {
	window.open("./updatememberform.do",
			"UPDATE",
			"resizeable = yes, menubar=no, width = 800, height = 500, left = 10, right = 10");
	
}
</script>
</head>
<body>
<div id="header">
<a href="./dashboard.do">로고</a>&nbsp;&nbsp;&nbsp;
<font size="6"><%=boardVO.getName() %></font>
<%if ( id.equals(boardVO.getAdmin()) ) {%>
<form action = "updateboard.do" method = "post">
	<input type = "hidden" name = "id" value = "<%=boardVO.getId()%>">
	<input type = "hidden" name = "name" value = "<%=boardVO.getName()%>">
	<input type = "hidden" name = "admin" value = "<%=boardVO.getAdmin()%>">
	<input type = "hidden" name = "visibility" value = "<%=boardVO.getVisibility()%>">
	
	<button type="submit" class="btn btn-default" name = "name">BOARD설정</button>
</form>
<%} %>
</div>

<div id="logout" align="right">
	<a href = "#" onClick = "openPop();" >회원정보 수정</a> | <a href="logout.do">logout</a>&nbsp;
</div>

<div id="ref_board">
	<select name="ref_board">
    	<option value="">참조 BOARD 선택</option>
    	<option value="board4">BOARD4</option>
   	 	<option value="board5">BOARD5</option>
    	<option value="board6">BOARD6</option>
	</select>
</div>

<div id="filter">
	<a href=#>관계 TASK보기</a>&nbsp;<a href=#>마감날짜순</a>&nbsp;<a href=#>시작날짜순</a>&nbsp;<a href=#>중요도순</a>
	<input type="text" name="task_name" placeholder="task명을 입력하세요."><input type="button" value="검색">
</div>

<div id="content">
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<input type="button" value="TASK생성" onclick="location.href='createtask.do';">
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
</div>

</body>
</html>


<%

%>