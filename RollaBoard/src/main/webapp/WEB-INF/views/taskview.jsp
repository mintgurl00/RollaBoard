<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>태스크보기</title>
<style>
#frame{position:absolute; top:30%; left:45%; width:500px; height:700px; overflow:hidden; background-color:#DAD9FF; margin-top:-150px; margin-left:-100px; text-align:center}
#content{width:400px; height:250px; background-color:#FFFFFF; margin-left:50px}
#comment{width:400px; height:250px; background-color:#FFFFFF; margin-left:50px; margin-top:20px}
#button{margin-top:20px}
</style>

</head>
<body>

<div id="frame"><h1>TASK 이름</h1>
	<div id="content">내용</div>
	<div id="comment">댓글</div>
	<div id="button">
		<input type=button value="확인" onclick = 'history.go(-1)'>
		<input type=button value="수정" onclick="location.href='./updatetask.do';">
		<input type=button value="삭제" onclick = 'history.go(-1)'>
	</div>
</div>
</body>
</html>