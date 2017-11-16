<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='loginForm.jsp'");
	out.println("</script>");
}
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
</head>
<body>
<div class="container">
  <h2>ROLE 관리</h2>
  <p>당신의 BOARD에서 업무수행을 지시할 ROLE을 관리해주세요</p>
  <table class="table table-striped">
    <thead>
      <tr>
        <th>ROLE 이름</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <%for(int i = 0; i < 5; i++) {%>
      <tr>
        <td>ROLE <%=i %></td>
        <td align = right>
        	<input type = button name = "role<%=i %>" value = "수정">&nbsp;&nbsp;
       		<input type = button name = "role<%=i %>" value = "삭제">
       	</td>
      </tr>
   <%} %>
    </tbody>
  </table>
</div>
</body>
</html>