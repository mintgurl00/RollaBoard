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
  <table class="table table-striped">
    <thead>
      <tr>
        <th>ROLE 이름</th>
        <th>DESCRIPTION</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <%for(int i = 0; i < roleList.size(); i++) {
    	RoleVO roleVO = roleList.get(i);
    %>
      <tr>
        <td><%=roleVO.getName() %></td>
        <td><%=roleVO.getDescription() %></td>
        <td align = right>
        <form id = "updateRole" action = "updateroleform.do">
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
        	<input type = submit class = "btn btn-default" value = "수정" onclick = "javascript:updateRoleForm()">
        </form>
        <form id = "deleteRole" action = "deleteRole.do">
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
       		<input type = button class = "btn btn-info"  value = "삭제" onclick="javascript:chkBox()">
       	 </form>
       	</td>
      </tr>
   <%} %>
    </tbody>
  </table>
</div>
</body>
</html>