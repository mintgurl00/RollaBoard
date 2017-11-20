<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.util.*, com.spring.rollaboard.*"%>

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
</head>
<body>
<div class="container">
  <h2>MEMBER 관리</h2>
  <p>당신의 BOARD에 가입된 MEMBER입니다.</p>            
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
    	MemVO member = boardMemberList.get(i);%>
      <tr>
        <td><%=member.getName() %> </td>
        <td><%=member.getId() %></td>
        <td align = right>
       		<input type = submit class = "btn btn-info" name = "<%=member.getId() %>" value = "강퇴">
       	</td>
       	</form>
      </tr>
   <%} %>
    </tbody>
  </table>
</div>
</body>
</html>