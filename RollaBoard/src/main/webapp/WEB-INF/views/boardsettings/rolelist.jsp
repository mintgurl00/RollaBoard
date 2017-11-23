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
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
	$('.nameview').css("visibility", "hidden");
	$('#toggle').click(function(){
		if( $('.nameview').css("visibility") == "hidden") {
			$('.nameview').css("visibility", "visible");
		} else {
			$('.nameview').css("visibility", "hidden" );
		}
	})
})

</script>
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
        	<%=roleVO.getName() %>
        	<input type = "text"  class = "form-control nameview" name = "name" placeholder = "수정할 정보 입력(이름)" value = "<%=roleVO.getName() %>" style = "visibility: ">
        </div>
        <div class = "col-xs-3">
        	<%=roleVO.getDescription() %>
        	<input type = "text" class = "form-control nameview" name = "description" placeholder = "수정할 정보 입력(설명)" value = "<%=roleVO.getDescription() %>" style = "visibility:">
        </div>
        
        <div class = "col-xs-3 nameview" align = right>
        
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
        	<button type = submit class = "btn btn-info" onclick = "javascript:updateRoleForm(<%=roleVO.getId() %>)" >수정</button>
		</div>
        </form>
        <form id = "deleteRole<%=roleVO.getId() %>" action = "deleteRole.do">
        <div class = "col-xs-1">
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
       		<input type = button class = "btn btn-default"  value = "삭제" onclick="javascript:chkBox(<%=roleVO.getId() %>)">
       	</div>
       	</form> 
      	</div>
      	<br/>
   <%} %>
   <div align = center><input type = button class = "btn btn-default" id = "toggle" value = "수정하기"></div>
   <br/>
   <br/>
  <center>
  <form id = "createRole" action = "createrole.do">
  	<div class="form-group" >
      <label class="control-label col-sm-2" for="text">이름 </label>
      <div class="col-sm-4">
        <input type="text" class="form-control" name = "name" placeholder = "추가할 ROLE의 이름 입력" required>
      </div>
    </div>
    <div class="form-group" >
      <label class="control-label col-sm-2" for="text">설명 </label>
      <div class="col-sm-4">
        <input type="text" class="form-control" name = "description" placeholder = "추가할 ROLE의 설명 입력">
      </div>
    </div>
  	<input type = submit class = "btn btn-default" value = "추가" >	
  </form>
  </center>
  </div>
</div>
</body>
</html>