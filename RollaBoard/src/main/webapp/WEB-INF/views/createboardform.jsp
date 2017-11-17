<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	String id = (String) session.getAttribute("id");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>createboard</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body>
<form class = form-horizental" action = "createboard.do">
<div class = "page-header">
	<div class = "row">
		<div class = "col-xs-1"></div>
		<div class = "col-xs-3"><input type = "text" class = "form-control" id = "board_name" name = "name" placeholder = "Board명을 입력하세요"></div>
	</div>
</div>

<div class = "row">
	<center><div class = "col-xs-12 left">
	<input type = "submit" class = "btn btn-info" value = "만들기"> &nbsp; 
	<input type = "button" class = "btn btn-info" value = "취소" onclick = "location.href='dashboard.do'">
	</div></center>
	
</div>

</body>
</html>