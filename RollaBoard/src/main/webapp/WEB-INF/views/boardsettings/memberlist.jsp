<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.mem.MemVO"%>

<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
ArrayList<MemVO> boardMemberList = (ArrayList<MemVO>)request.getAttribute("boardMemberList");

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>memberlist</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
      background-color: #1294AB;
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
      color: #1294AB !important;
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

</style>
<script type = "text/javascript" language = "javascript">

function chkBox(cnt) {
	var chk = confirm("정말 강퇴하시겠습니까?");
	if (chk) {
		document.getElementById("deletemember" + cnt).submit();
	} else {
		return;
	}
}

function roles(id) {
	window.open('memberroles.do?mem_id='+id, "roles",
			"resizeable = yes, scrollbars = yes, menubar=no, width = 800, height = 500, left = 10, right = 10");
}

</script>
</head>
<body>
<div class="container">
	<div class = "page-header">
		<h2>MEMBER 관리</h2>
		<p>당신의 BOARD에 가입된 MEMBER입니다.</p>  
	</div>           
  <table class="table table-striped">
    <thead>
      <tr>
        <th>MEMBER 이름</th>
        <th>MEMBER 아이디</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <%for (int i = 0; i < boardMemberList.size(); i++) { //보드멤버리스트 받아와야함
    	MemVO memVO = boardMemberList.get(i);%>
      <tr>
        <td><%=memVO.getName() %> </td>
        <td><%=memVO.getId() %></td>
        
        <td align = right>
        <div class = "row">
        	<form id = "getMemberRoles">
	       		<input type = button class = "btn btn-default" value = "ROLE확인" onclick = "javascript:roles('<%=memVO.getId() %>')" >
	        </form>
	        <form id = "deletemember<%=i %>" action = "deletemember.do" method = "post">
	        	<input type = hidden name = "mem_id" value = "<%=memVO.getId() %>">
	       		<input type = button value = "강퇴" class = "btn btn-default" onclick = "javascript:chkBox(<%=i %>)">
	   		</form>  		
    	</div>
       	</td>
      </tr>
   
   <%} %>
    </tbody>
  </table>
</div>
</body>
</html>