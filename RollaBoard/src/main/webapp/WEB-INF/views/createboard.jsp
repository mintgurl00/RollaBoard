<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String pageName = "rolelist.jsp"; %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>newboard</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script>
function changeRole() {
	$('#resultBlock').load("rolelist.jsp");
	pageName = "rolelist.jsp"
}
function changeMember() {
	$('#resultBlock').load("memberlist.jsp");
	pageName = "memberlist.jsp"
}
</script>
<body>
<form class = form-horizental" action = "#">
<div class = "page-header">
	<div class = "row">
		<div class = "col-xs-4"><input type = "text" class = "form-control" id = "board_name" placeholder = "Board명을 입력하세요"></div>
		<div class = "col-xs-3"><input type="button" name = "group" class="btn btn-primary" onclick = "changeRole()" value = "ROLE관리"/></div>
		<div class = "col-xs-3"><input type="button" name = "group" class="btn btn-primary" onclick = "changeMember()" value = "MEMBER관리"/></div>
		<div class = "col-xs-2"><input type="button" name = "group" class="btn btn-primary" onclick = "changeETC()" value = "기타설정"/></div>
	</div>
</div>
<div id=resultBlock class="wrapper">
	<jsp:include page="<%=pageName %>" >
			<jsp:param name="page" value="Result" />
	</jsp:include>
</div>
<div class = "row">
	<center><div class = "col-xs-12 left"><input type = "submit" value = "만들기"> &nbsp; <input type = "reset"></div></center>
	
</div>

</body>
</html>