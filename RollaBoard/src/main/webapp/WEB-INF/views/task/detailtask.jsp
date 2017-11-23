<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>고급설정</title>
<style>
#frame{position:absolute; top:30%; left:45%; width:500px; height:600px; overflow:hidden; background-color:#DAD9FF; margin-top:-150px; margin-left:-100px; text-align:center}
</style>
</head>
<body>
<div id="frame">
<h1>TASK 이름</h1><br/><br/>
시작날짜 <input type="text" id="startDate" placeholder="yyyy/mm/dd" size="40"><br/><br/><br/>
마감날짜 <input type="text" id="dueDate" placeholder="yyyy/mm/dd" size="40"><br/><br/><br/>
중요도 <input type="text" id="priority" placeholder="1~5중에 하나를 입력해주세요" size="40"><br/><br/><br/>
선행TASK <input type="text" id="preTask" placeholder="Task id를 입력하시오" size="40"><br/><br/><br/>
후행TASK <input type="text" id="postTask" placeholder="Task id를 입력하시오" size="40"><br/><br/><br/>
<input type="submit" value="확인" onclick="location.href='./createtask.do';">
<input type="button" value="취소" onclick='history.go(-1)'>
</div>
</body>
</html>