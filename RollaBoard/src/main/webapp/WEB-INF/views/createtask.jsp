<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*, com.spring.rollaboard.*" %>

<%
	String section_id = request.getParameter("section_id");
	
%>

<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>task 생성</title>
<style>
#frame{width:500px; height:700px; background-color:#DAD9FF; margin-top:100px; margin-left:700px}
#taskname{margin-top:20px; margin-left:10px}
#content{margin-top:30px; margin-left:30px}
#role{margin-top:30px; margin-left:30px}
#settings{margin-top:5px; margin-left:380px}
#button{margin-top:20px; margin-left:200px}
</style>
</head>
<body>

<form action="inserttask.do" name="inserttask" method="post">


<div id="frame">
	<div id="section_id">
		<input type="text" id="section_id" name="section_id" value = <%=section_id %> size="40">
	</div>
	<%-- <div id="taskid">
		<input type="text" id="taskid" name="task_id" value = <%task_id%> size="40" name="name">
	</div> --%>
	
	<div id="taskname">
		<input type="text" id="name" placeholder="TASK 이름을 입력하시오." size="40" name="name">
	</div>
	
	<div id="content">내용(필수X)<br/>
		<input type="textarea" id="description" style="height:180px; width:380px;" name="description">
	</div>
	
	<div id="role">Role 배정(필수X)<br/>
		<input type="textarea" id="role" style="height:180px; width:380px;">
	</div>
	
	<div id="settings">
		<input type="button" value="고급설정" onclick="location.href='./detailtask.do';">
	</div>
	
	<div id="button">
		<input type="submit" value="확인" >
		<input type="submit" value="취소" onclick='history.go(-1)'>
	</div>

</div>
</form>
</body>
</html>