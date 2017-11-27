<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.mem.MemVO"%>
<%@ page import="com.spring.rollaboard.role.RoleVO"%>

<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
ArrayList<MemVO> boardMemberList = (ArrayList<MemVO>)request.getAttribute("boardMemberList");
ArrayList<RoleVO> roleList = (ArrayList<RoleVO>)request.getAttribute("roleList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>allocation</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type = "text/javascript" language = "javascript">
function members(id) {
	window.open('rolemembers.do?role_id='+id, "members",
			"resizeable = yes, scrollbars = yes, menubar=no, width = 800, height = 500, left = 10, right = 10");
}
</script>
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
</head>
<body>
<div class="container">
  <h2>ROLE 배정</h2>
  <p>ROLE에 MEMBER를 배정하세요.</p>            
  <table class="table table-striped">
    <thead>
      <tr>
        <th>ROLE 명단</th>
        <th>배정하기</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <%for (int i = 0; i < roleList.size(); i++) { //보드멤버리스트 받아와야함
    	RoleVO roleVO = roleList.get(i);%>
      <tr>
        <td><%=roleVO.getName() %> </td>
        <td>
        	<form id = "insertMemToRole" action = "insertmemtorole.do">
        		<input type = "hidden" name = "role_id" value = "<%=roleVO.getId() %>" >
	        	<input type = "text" class = "form-control" name = "mem_id" placeholder = "맴버아이디 입력" required>
	       		<input type = submit class = "btn btn-info" value = "배정" >
       		</form>
        </td>
        <td align = right>
        <form id = "getRoleMembers">
       		<input type = button class = "btn btn-info" value = "배정된 맴버보기" onclick = "members(<%=roleVO.getId()%>)">
        </form>
       	</td>
      </tr>
   <%} %>
    </tbody>
  </table>
</div>
</body>
</html>