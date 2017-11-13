<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <h2>ROLE 입력</h2>
  <p>당신의 BOARD에서 업무수행을 지시할 ROLE을 입력해주세요</p>            
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