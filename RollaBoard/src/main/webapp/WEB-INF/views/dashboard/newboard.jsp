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
  <title>NewWorkboard</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>


<div class="jumbotron" style = "background-color: orange;">
  <div class="container text-center">
    <h1><font color="white">Workboard</font></h1>      
    <p><font color="white">새로운 Workboard를 만들거나 기존의 Workboard에 참가해보세요!</font></p>
    
  </div>
</div>
<br/>
<div class = "container">
<div class = "row">
	<div class = "col-xs-12 col-sm-6">
		<div class = "thumbnail">
			<a href ="createboardform.do"> <!-- 수민 -->
			<img src = "image/light.jpg" class="w3-animate-left" alt = "CREATE BOARD" height = 700>
			<center><h2>Workboard 생성</h2></center>

			</a>
		</div>
	</div>
	
	<div class = "col-xs-12 col-sm-6">
		<div class = "thumbnail">	
			<a href ="enterboard.do">
			<img src = "image/people.jpg" class="w3-animate-right" alt = "ENTER BOARD" height = 700>
			<center><h2>Workboard 입장</h2></center>
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
