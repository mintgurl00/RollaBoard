<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%@ page import="com.spring.rollaboard.section.SectionVO"%>

<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}

//SectionVO sectionVO = (SectionVO) request.getAttribute("sectionVO");

ArrayList<SectionVO> sectionlist = (ArrayList<SectionVO>)request.getAttribute("sectionList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>sectionlist</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
 function updatesection(cnt) {
  document.getElementById("updatesection" + cnt).submit();
 }
 
 function deletesection(cnt) {
  document.getElementById("deletesection" + cnt).submit();
 }
 
 </script>
 
 <!-- 글자수제한 스크립트 -->
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  <script src = "js/rolelist.js"></script>
 
</head>
<body>
<div class="container">
	<div class = "page-header">
		<h2>SECTION 관리</h2>
		<p>당신의 BOARD에 있는 SECTION 리스트입니다</p>  
 	</div>     
  <table class="table table-striped">
    <thead>
      <tr>
        <th>SECTION 이름</th>
        <th>SECTION COLOR</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <%for(int i = 0; i < sectionlist.size(); i++) {
    	SectionVO section = sectionlist.get(i);
    %>
      <tr>
       	<form id = "updatesection<%=section.getId() %>" action = "updatesection.do">
        <td>
        	<input type = "hidden" class = "form-control" name = "section_id" value =  "<%=section.getId() %>">
        	<input type = "text"  name = "section_name" value = "<%=section.getName() %>" class="byteLimit form-control" limitbyte="30" style="width:300px" placeholder = "수정할 Section명을 입력하세요">
        </td>	
        <td >
        	<% if (section.getColor() != null) { %>
        		<input type="text" name="color" value="<%=section.getColor() %>" placeholder = "ex:green, #1294AB" class="byteLimit form-control" limitbyte="30">
        	<% } else { %> 
        		<input type="text" name="color" value="#EAEAEA" placeholder = "ex:green, #1294AB" class="byteLimit form-control" limitbyte="30">
        	<% } %>
        </td>
       	</form>
        <td align = right>
       		<form id = "deletesection<%=section.getId() %>" action = "deletesection.do">
       			<input type = "hidden" class = "form-control" name = "section_id" value =  "<%=section.getId() %>">
       			
       		</form>
       		<input type = submit class = "btn btn-info" value = "수정" onclick = "javascript:updatesection(<%=section.getId() %>)">
       		<input type = submit class = "btn btn-default" value = "삭제" onclick = "javascript:deletesection(<%=section.getId() %>)" >
       	</td>
      </tr>
   <%} %>	
   </tbody>
   </table>    
   <form action = "createsection.do">
   	<table class="table table-striped">
   	  <tbody>
   	  	<td><input type = "text" name = "section_name"  class=" form-control byteLimit" limitbyte="30" class="byteLimit" limitbyte="30" placeholder = "추가할 Section명을 입력하세요" required></td>
   	  	<td align = right>
        	<input type = submit class = "btn btn-info" value = "추가" >&nbsp;&nbsp;
       	</td>
      </tbody>
     </table>
   </form>
  
</div>
</body>
</html>