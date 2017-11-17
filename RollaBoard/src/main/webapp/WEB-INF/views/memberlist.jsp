<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*, com.spring.rollaboard.MemVO" %>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
ArrayList<MemVO> memList = (ArrayList<MemVO>)request.getAttribute("memList");
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
</head>
<body>
<div class="container">
  <h2>MEMBER 관리</h2>
  <p>당신의 BOARD에 가입된 MEMBER입니다.</p>            
  <table class="table table-striped">
    <thead>
      <tr>
        <th>MEMBER 이름</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <%for(int i = 0; i < memList.size(); i++) {
    	MemVO memVO = memList.get(i);
    %>
      <tr>
        <td><%=memVO.getName() %></td>
        <form name = "deleteMem" action = "deleteMem.do">
        <td align = right>
       		<input type = submit class = "btn btn-info" name = "<%=memVO.getId() %>" value = "강퇴">
       	</td>
       	</form>
      </tr>
   <%} %>
    </tbody>
  </table>
</div>
</body>
</html>