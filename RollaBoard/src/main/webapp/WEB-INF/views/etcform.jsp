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
<!DOCTYPE html>
<html lang="en">
<head>
  <title>etc</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
function radio_chk() {
	//라디오 버튼 name 가져오기
	var radio = document.getElementsByName("visibility");

	for (var i = 0; i < radio.length; i++) {
		if (radio[i].checked == true) {
			var visibility = radio[i].value; //visibility 변수에는 "TRUE"나 "FALSE" 값이 저장됨
			document.getElementById("visibility").submit(); //submit하면 etc.do로
		}
	}
	
	
}
</script>
</head>
<body>
<div class="container">
  <h2>참조 승인 여부 | 참조 BOARD 입력</h2>
  <p>공개를 통해 다른BOARD에서 당신의 BOARD를 참조할 수 있게 하고 참조할 BOARD명을 입력하세요 </p>  
  <br/><br/>
  <form id = "visibility" action = "etc.do">
  <div class = "row">
  	<div class = "col-xs-4">공개여부</div>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "TRUE" >공개</div>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "FALSE">비공개</div>
  	<div class = "col-xs-2"><input type = "submit" class = "btn btn-info" value = "저장" onclick="javascript:radio_chk()"></div>
  </div>
  </form>
  
  <br/><br/>
  
  <form>
  <div class = "row">
  	<div class = "col-xs-4">BOARD참조</div>
  	<div class = "col-xs-6"><input type = "text" class = "form-control" name = "ref_board" placeholder = "참조할 board명 입력"></div>	
  	<div class = "col-xs-2"><input type = "submit" class = "btn btn-info" value = "저장"></div>
  </div>
  </form>
  <br/><br/>
</div>
</body>
</div>
</html>