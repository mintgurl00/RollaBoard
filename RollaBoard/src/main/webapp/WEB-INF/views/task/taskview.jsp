<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
	TaskVO taskVO = (TaskVO) request.getAttribute("taskVO");
	request.setAttribute("taskVO", taskVO);
	/* ArrayList<taskVO> taskViewList = (ArrayList<taskVO>)request.getAttribute("taskViewList"); */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>태스크보기</title>
<style>
#frame{position:absolute; top:30%; left:45%; width:500px; height:700px; overflow:hidden; background-color:#DAD9FF; margin-top:-150px; margin-left:-100px; text-align:center}
#content{width:400px; height:250px; background-color:#FFFFFF; margin-left:50px}
#comment{width:400px; height:250px; background-color:#FFFFFF; margin-left:50px; margin-top:20px}
#button{margin-top:20px}
</style>
<script>
function deleteTask() {
	var chk = confirm("정말 삭제하시겠습니까?");
	if(chk){
		document.getElementById("deletetask").submit();
	} else {
		return;
	}
}
function updateTask() {
	document.getElementById("updatetask").submit();
}

</script>
</head>
<body>


<div id = ""><h1>TASK 이름 :  <%=taskVO.getName() %> </h1>
	<div id="status">내용 :  <%=taskVO.getDescription() %> </div>
	<div id="status">상태: <%=taskVO.getStatus() %> </div>	
	<div id="status">댓글 : 해야 됨</div>
	<div id="status">생성날짜: <%=taskVO.getCre_date() %> </div>	
	<div id="status">시작날짜: <%=taskVO.getStart_date() %> </div>	
	<div id="status">마감날짜: <%=taskVO.getDue_date() %> </div>	
	<div id="status">중요도: <%=taskVO.getPriority() %> </div>	
	<div id="status">선행TASK: 만들 것 </div>	
	<div id="status">후행TASK: 만들 것 </div>	

	<div id="button">

	<%if (session.getAttribute("board_id") != null) {%>

		<input type=button value="확인" onclick = "location.href='./board.do';">
		<input type=button value="수정" onclick = "javascript:updateTask()">
		<input type=button value="삭제" onclick = "javascript:deleteTask()">
	<%} else { %>
		<input type=button value="확인" onclick = "location.href='./dashboard.do'">
	<%} %>

	</div>
	<form id = "updatetask" action = "updatetaskform.do" method="post">
		<input type = hidden name = "id" value = "<%=taskVO.getId() %>">
		<input type = hidden name = "name" value = "<%=taskVO.getName() %>">
		<input type = hidden name = "description" value = "<%=taskVO.getDescription() %>">
		<input type = hidden name = "status" value = "<%=taskVO.getStatus() %>">
		<input type = hidden name = "section_id" value = "<%=taskVO.getSection_id() %>">
		<input type = hidden name = "start_date" value = "<%=taskVO.getStart_date() %>">
		<input type = hidden name = "due_date" value = "<%=taskVO.getDue_date() %>">
		<input type = hidden name = "cre_date" value = "<%=taskVO.getCre_date() %>">
		<input type = hidden name = "priority" value = "<%=taskVO.getPriority() %>">	
	</form>
	<form id = "deletetask" action = "deletetask.do">
		<input type = hidden name = "task_id" value = "<%=taskVO.getId() %>">
	</form>
</div>
</body>
</html>