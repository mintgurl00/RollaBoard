<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="com.spring.rollaboard.role.RoleVO"%>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
ArrayList<RoleVO> roleList = (ArrayList<RoleVO>) request.getAttribute("roleList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>rolelist</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="reset.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-1.10.2.js">     </script>
  
  <script type = "text/javascript" language = "javascript">
  function chkBox(cnt) {
	var chk = confirm("삭제하시겠습니까?");
	if (chk) {
		document.getElementById("deleteRole" + cnt).submit();
	} else {
		return;
	}
}
function updateRoleForm(cnt) {
	document.getElementById("updateRole" + cnt).submit();
}
$(document).ready(function () {

	$('#toggle').click(function(){
		if( $('#nameview' + cnt).css("display") == "none") {
			$('#nameview' + cnt).css("display", "block");
		} else {
			$('#nameview' + cnt).css("display", "none" );
		}
	});
	
	
})

function flip(cnt) {
	if( $('.nameview' + cnt).css("display") == "none") {
		$('.nameview' + cnt).css("display", "block");
		
	} 
	if( $('.origin' + cnt).css("display") == "none") {
		$('.origin' + cnt).css("display", "block");
	} else {
		$('.origin' + cnt).css("display", "none" );
	}
	$('#focus' + cnt).focus();
	
}

function fadeout (cnt) {
	if( $('.nameview' + cnt).css("display") != "none") {
		$('.nameview' + cnt).css("display", "none");	
	} 
	if( $('.origin' + cnt).css("display") == "none") {
		$('.origin' + cnt).css("display", "block");
	}
}

function descfadeout(cnt) {
	if( $('.nameview' + cnt).css("display") != "none") {
		$('.nameview' + cnt).css("display", "none");	
	} 
	if( $('.origin' + cnt).css("display") == "none") {
		$('.origin' + cnt).css("display", "block");
	}
}
</script>
  
<!-- 글자수제한 스크립트 -->
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  <script src = "js/rolelist.js"></script>
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
  <h2>ROLE 관리</h2>
  <p>당신의 BOARD에서 업무수행을 지시할 ROLE을 관리해주세요</p>
  <div class = "page-header">
      <div class = "row" >
        <div class = "col-xs-3" ><h3>ROLE 이름</h3></div>
        <div class = "col-xs-3"><h3>DESCRIPTION</h3></div>
        <div class = "col-xs-3"></div>
   	 </div>
    <%for(int i = 0; i < roleList.size(); i++) {
    	RoleVO roleVO = roleList.get(i);
    %>
    <form id = "none"></form>
      <div class = "row">
      	<form id = "updateRole<%=roleVO.getId() %>" action = "updaterole.do">
        <div class = "col-xs-3"  >
        <div class= "origin<%=roleVO.getId() %> " style = "display:block; cursor:pointer" onclick = "javascript:flip(<%=roleVO.getId() %>)">
        	<%=roleVO.getName() %>
        </div>
        	<input type = "text" id = "focus<%=roleVO.getId() %>" class = "byteLimit nameview<%=roleVO.getId() %>" 
        	 limitbyte="20" name = "name" placeholder = "수정할 정보 입력(이름)" value = "<%=roleVO.getName() %>" style = "display:none" >
        </div>
        <div class = "col-xs-3">
        <div class= "origin<%=roleVO.getId() %>" style = "display:block">
        	<%=roleVO.getDescription() %>
       	</div>
        	<input type = "text" id = "desc<%=roleVO.getId() %>" class = "byteLimit nameview nameview<%=roleVO.getId() %>" 
        	limitbyte="100" name = "description" placeholder = "수정할 정보 입력(설명)" value = "<%=roleVO.getDescription() %>" style = "display:none" >
        </div>
        
        <div class = "col-xs-2 nameview<%=roleVO.getId() %>" align = right style = "display:none">
        
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
        	<button type = button class = "btn btn-info" onclick = "javascript:updateRoleForm(<%=roleVO.getId() %>)" >수정</button>
		</div>
        </form>
        <div class = "nameview<%=roleVO.getId() %> col-xs-2" style = "display:none">
        	<input type = "button" class = "btn btn-default"  value = "취소" onclick = "javascript:fadeout('<%=roleVO.getId() %>')" >
        </div>
        <form id = "deleteRole<%=roleVO.getId() %>" action = "deleteRole.do">
        <div class = "col-xs-1">
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
       		<input type = button class = "btn btn-default"  value = "삭제" onclick="javascript:chkBox(<%=roleVO.getId() %>)">
       	</div>
       	</form> 
      	</div>
      	<br/>
   <%} %>
   <%if (roleList.size() == 0) {%>
   <center><h1>데이터가 없습니다.</h1></center>
   <%} else { %>
   
   <%} %>
   <br/>
   <br/>

  <form id = "createRole" action = "createrole.do">
  	<div class="form-group" >
      <label class="control-label col-sm-2" for="text">이름 </label>
      <div class="col-sm-4">
        <input type="text" class = "byteLimit" limitbyte="20" name = "name" placeholder = "추가할 ROLE의 이름 입력" required>
      </div>
    </div>
    <div class="form-group" >
      <label class="control-label col-sm-2" for="text">설명 </label>
      <div class="col-sm-4">
        <input type="text" class = "byteLimit" limitbyte="100" name = "description" placeholder = "추가할 ROLE의 설명 입력">
      </div>
    </div>
  	<center><input type = submit class = "btn btn-default" value = "추가"></center>
  </form>

  </div>
</div>
</body>
</html>