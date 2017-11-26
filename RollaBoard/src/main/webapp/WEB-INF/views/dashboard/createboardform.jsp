<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    
  <script>
  function chk() {
	if (document.getElementById("board_name").value == "") {
		alert("보드명을 입력해주세요.")
		return false;
	} else {
		document.createboard.submit();
	}
	  
  }
  
  
  </script>
  
  <!-- 글자수제한 스크립트 -->
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  <script src = "js/rolelist.js"></script>
  
</head>

<body>
<div class = "page-header">
	<center><h1>board 만들기  </h1></center>
</div>
<H4 align = center>새로 만들 Board의 이름을 입력하세요</H4>
<form name = "createboard" class = "form-horizental" action = "createboard.do">
<div class = "form-group">
	<div class = "row">
		<div class = "col-xs-1"></div>
		<div class = "col-xs-10"><input type = "text" class = "form-control byteLimit" limitbyte="50" id = "board_name" name = "name" placeholder = "Board명을 입력하세요"></div>
	</div>
</div>

<div class = "row">
	<center><div class = "col-xs-12 left">
	<input type = "button" class = "btn btn-info" value = "만들기" onclick = "chk()"> &nbsp; 
	<input type = "button" class = "btn btn-info" value = "취소" onclick = "location.href='newboard.do'">
	</div></center>
	
</div>
</form>
</body>
</html>