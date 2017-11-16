<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='loginForm.jsp'");
	out.println("</script>");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>newboard</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class = "page-header">
	<center><h1>새로운 BOARD</h1></center>
</div>
<br/>
<div class = "container">
<div class = "row">
	<div class = "col-xs-6 col-sm-6">
		<div class = "thumbnail">
			<a href ="createboardform.do"> <!-- 수민 -->
			<img src = "image/new.jpg">
			<center><p>새 board 생성</p></center>

			</a>
		</div>
	</div>
	
	<div class = "col-xs-6 col-sm-6">
		<div class = "thumbnail">	
			<a href ="enterboard.do">
			<img src = "image/people.jpg" alt = "ENTER BOARD" height = 700>
			<center><p> BOARD 입장</p></center>
			</a>
		</div>
	</div>
</div>
</div>
<div class = "row">
	<div class = col-xs-12>
		<center> <input type="button" class="btn btn-info" onclick = "location.href='dashboard.do'" value="돌아가기"></center>	
	</div>
</div>
<br/>
<footer class = "page-footer center-on=small-only stylish-color-dark">
	<div class = "footer-copyright">
	</div>
</footer>

</body>
</html>
