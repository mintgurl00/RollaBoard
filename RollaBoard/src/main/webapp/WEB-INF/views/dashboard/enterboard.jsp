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
<div class="jumbotron" style = "background-color: orange;">
  <div class="container text-center">
    <h1><font color="white">Board 입장하기</font></h1>     
    <p><font color="white">입장할 Board의 이름을 입력하세요</font></p>    
  </div>
</div>

<form class = "form-horizental" action = "joinboard.do">
<div class = "form-group">
	<label for = "board_name" class = "control-label col-xs-2">BOARD 이름</label>
	<div class = "col-xs-8">
	<input type = "text" class = "form-control" id = "board_name" name = "name" placeholder="Board 이름을 정확히 입력하세요" required>
	</div>
	<div class = "col-xs-2">
	<button type = "submit" class = "btn btn-info">입장하기</button>
	</div>
</div>
<br/><br/>
<div class = "row">
	<center><div class = "col-xs-12 left">
	<input type = "button" class = "btn btn-info" value = "취소" onclick = "location.href='newboard.do'">
	</div></center>
	
</div>
</form>
</body>
</html>