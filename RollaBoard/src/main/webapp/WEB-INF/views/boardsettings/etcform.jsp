<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
ArrayList<BoardVO> refBoardList = (ArrayList<BoardVO>)request.getAttribute("refBoardList");
String visible = (String) request.getAttribute("visible");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>etc</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="reset.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script> 
<style>
body {
     font: 400 15px Lato, sans-serif;
     height:inherit;
     line-height: 1.8;

 }
 h2 {
     font-size: 24px;
     text-transform: uppercase;
     color: #303030;
     font-weight: 600;
     margin-bottom: 30px;
 }
 h4 {
     font-size: 19px;
     line-height: 1.375em;
     color: #303030;
     font-weight: 400;
     margin-bottom: 30px;
 }  
 .jumbotron {
     background-color: #F44336;
     color: #fff;
     padding: 40px 25px;
     font-family: Montserrat, sans-serif;
 }
 .container-fluid {
     padding: 60px 50px;
 }
 .logo-small {
     color: #F44336;
     font-size: 50px;
 }
 .logo {
     color: #F44336;
     font-size: 200px;
 }
 .navbar {
     margin-bottom: 0;
     background-color: #F44336;
     z-index: 9999;
     border: 0;
     font-size: 12px !important;
     line-height: 1.42857143 !important;
     letter-spacing: 4px;
     border-radius: 0;
     font-family: Montserrat, sans-serif;
 }
 .navbar li a, .navbar .navbar-brand {
     color: #fff !important;
 }
 .navbar-nav li a:hover, .navbar-nav li.active a {
     color: #F44336 !important;
     background-color: #fff !important;
 }
 .navbar-default .navbar-toggle {
     border-color: transparent;
     color: #fff !important;
 }
 footer .glyphicon {
     font-size: 20px;
     margin-bottom: 20px;
     color: #F44336;
 }
 .slideanim {visibility:hidden;}
 .slide {
     animation-name: slide;
     -webkit-animation-name: slide;
     animation-duration: 1s;
     -webkit-animation-duration: 1s;
     visibility: visible;
 }
 @keyframes slide {
   0% {
     opacity: 0;
     transform: translateY(70%);
   } 
   100% {
     opacity: 1;
     transform: translateY(0%);
   }
 }
 @-webkit-keyframes slide {
   0% {
     opacity: 0;
     -webkit-transform: translateY(70%);
   } 
   100% {
     opacity: 1;
     -webkit-transform: translateY(0%);
   }
 }
 @media screen and (max-width: 768px) {
   .col-sm-4 {
     text-align: center;
     margin: 25px 0;
   }
   .btn-lg {
       width: 100%;
       margin-bottom: 35px;
   }
 }
 @media screen and (max-width: 480px) {
   .logo {
       font-size: 150px;
   }
 }
</style>
<script type = "text/javascript">
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
<body data-spy="scroll" data-target=".navbar" data-offset="60">
<div class="container">
  <h2>참조 승인 여부</h2>
  <p>공개를 통해 다른BOARD에서 당신의 BOARD를 참조할 수 있게 할 수 있습니다. </p>  
  <br/><br/>
  <form id = "visibility" action = "visibility.do">
  <div class = "row">
  	<div class = "col-xs-4">공개여부</div>
  	<%if (visible.equals("TRUE")) {%>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "TRUE" checked>공개</div>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "FALSE">비공개</div>
  	<%} else if (visible.equals("FALSE")) {%>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "TRUE" >공개</div>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "FALSE" checked>비공개</div>
  	<%} else { %>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "TRUE" >공개</div>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "FALSE">비공개</div>
  	<%} %>
  	<div class = "col-xs-2"><input type = "submit" class = "btn btn-info" value = "저장" onclick="javascript:radio_chk()"></div>
  </div>
  </form>
</div>  
  <br/><br/>
  
 
    	
<div class="container">
  <h2>참조보드 목록</h2>
  <p>당신의 BOARD가 참조하고 있는 BOARD 목록입니다. 참조할 BOARD를 자유롭게 추가/삭제하세요.</p>            
  <table class="table table-striped">
    <thead>
      <tr>
        <th>참조 BOARD</th>
      </tr>
    </thead>
    <tbody>
    <%for (int i = 0; i < refBoardList.size(); i++) {
    	BoardVO boardVO = refBoardList.get(i);%>
      <tr>
        <td><%=boardVO.getName() %></td>
        
        <td align = right>
        <form action = "deleterefboard.do" method = "post">
        	<input type = hidden name = "ref_id" value = "<%=boardVO.getId() %>">
       		<input type = submit value = "삭제" class = "btn btn-default">
   		</form>
       	</td>
      </tr>
   
   <%} %>
    </tbody>
  </table>
  
  <form action = "addrefboard.do">
   	<table class="table table-striped">
   	  <tbody>
   	  	<td><input type = "text" class = "form-control" name = "name" placeholder = "추가할 BOARD명을 입력하세요(존재하는 BOARD명만 추가할 수 있습니다)"></td>
   	  	<td align = right>
        	<input type = submit class = "btn btn-info" value = "추가" >&nbsp;&nbsp;
       	</td>
      </tbody>
     </table>
   </form>
  
</div>
</body>
</html>