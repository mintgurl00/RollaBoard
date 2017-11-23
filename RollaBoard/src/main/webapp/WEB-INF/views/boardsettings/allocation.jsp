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