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

ArrayList<MemVO> boardMemberList = (ArrayList<MemVO>)request.getAttribute("boardWaitingList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>memberadmit</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type = "text/javascript" language = "javascript">
function chkBox1() {
	var chk = confirm("정말 승인하시겠습니까?");
	if (chk) {
		document.getElementById("admitmember").submit();
	} else {
		return;
	}
}

function chkBox2() {
	var chk = confirm("정말 삭제하시겠습니까?");
	if (chk) {
		document.getElementById("deletemember").submit();
	} else {
		return;
	}
}
</script>
</head>
<body>
<div class="container">
  <h2>MEMBER 승인</h2>
  <p>당신의 BOARD에 가입을 원하는 MEMBER입니다.</p>            
  <table class="table table-striped">
    <thead>
      <tr>
        <th>MEMBER 이름</th>
        <th>MEMBER 아이디</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <%for(int i = 0; i < boardMemberList.size(); i++) {
    	MemVO memVO = boardMemberList.get(i);
    %>
      <tr>
        <td><%=memVO.getName() %></td>
        <td><%=memVO.getId() %></td>
        
        <td align = right>
        <form id = "admitmember" action = "admitmember.do?mem_id=<%=memVO.getId() %>" method = "post">
        	<input type = button value = "승인" onclick = "javascript:chkBox1()">&nbsp;&nbsp;
        </form>
        <form id = "deletemember" action = "deletemember.do?mem_id=<%=memVO.getId() %>" method = "post">
       		<input type = button name = "role<%=i %>" value = "삭제" onclick = "javascript:chkBox2()">
       	</td>
      </tr>
    </form>
   <%} %>
    </tbody>
  </table>
</div>
</body>
</html>

