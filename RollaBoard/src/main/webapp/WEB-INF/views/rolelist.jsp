<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.spring.rollaboard.RoleVO" %>
<%@ page import = "java.util.*" %>
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
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type = "text/javascript" language = "javascript">
function chkBox() {
	var chk = confirm("삭제하시겠습니까?");
	if (chk) {
		document.getElementById("deleteRole").submit();
	} else {
		return;
	}
}
function updateRoleForm() {
	document.getElementById("updateRole").submit();
}

</script>
</head>
<body>
<div class="container">
  <h2>ROLE 관리</h2>
  <p>당신의 BOARD에서 업무수행을 지시할 ROLE을 관리해주세요</p>
  <div class = "page-header">
      <div class = "row" >
        <div class = "col-xs-3">ROLE 이름</div>
        <div class = "col-xs-3">DESCRIPTION</div>
        <div class = "col-xs-3"></div>
   	 </div>
    <%for(int i = 0; i < roleList.size(); i++) {
    	RoleVO roleVO = roleList.get(i);
    %>
    <form id = "이것은쓰레기"></form>
      <div class = "row">
      	<form id = "updateRole" action = "updaterole.do">
        <div class = "col-xs-3">
        	<%=roleVO.getName() %>
        	<input type = "text" class = "form-control" name = "name">
        </div>
        <div class = "col-xs-3">
        	<%=roleVO.getDescription() %>
        	<input type = "text" class = "form-control" name = "description">
        </div>
        <div class = "col-xs-3" align = right>
        
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
        	<button type = submit class = "btn btn-default" onclick = "javascript:updateRoleForm()" >수정</button>
		</div>
        </form>
        <form id = "deleteRole" action = "deleteRole.do">
        <div class = "col-xs-1">
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
       		<input type = button class = "btn btn-info"  value = "삭제" onclick="javascript:chkBox()">
       	</div>
       	</form> 
      	</div>
      	<br/>
   <%} %>
  <center>
  <input type = button class = "btn btn-default" value = "추가" onclick = "#">
  </center>
  </div>
</div>
</body>
</html>