<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>enterboard</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class = "page-header">
	<center><h1>board 입장하기  </h1></center>
</div>

<H4 align = center>입장할 Board의 이름을 입력하세요</H4>

<form class = form-horizental" action = "joinboard.do">
<div class = "form-group">
	<label for = "board_name" class = "control-label col-xs-2">BOARD 이름</label>
	<div class = "col-xs-10">
	<input type = "text" class = "form-control" id = "board_name" name = "name" placeholder="Board 이름을 정확히 입력하세요">
	</div>
</div>
<div class = "form-group">
	<div class = "col-xs-offset-2 col-xs-10">
	<button type = "submit" class = "btn btn-info">입장하기</button>
	</div>
</div>
<div class = "row">
	<center><div class = "col-xs-12 left">
	<input type = "button" class = "btn btn-info" value = "취소" onclick = "location.href='newboard.do'">
	</div></center>
	
</div>
</form>
</body>
</html>