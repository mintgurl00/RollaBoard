<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.mem.MemVO"%>
<%
	ArrayList<MemVO> roleMem = (ArrayList<MemVO>) request.getAttribute("roleMem");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body style = "background-color:#EFEFEF;">

<div class="container-fluid" style="margin-top:10%; margin-left:10%">
	<h2>ROLE : '<%=request.getAttribute("role_name") %>'</h2>
	<br/>
	<%if (roleMem.size() == 0) { %>
	<center><h1>데이터가 없습니다</h1></center>
	<%} else { 
	for(int i = 0; i < roleMem.size(); i++) { 
		MemVO memVO = roleMem.get(i);
	%>
	<form class="form-horizontal" action="deletememtorole.do" method = "post">
	<div class="form-group">
      <label class="control-label col-sm-1" for="id">ID:</label>
      <div class="col-sm-3">
        <input type="text" class="form-control" id="id<%=memVO.getId() %>"  name="id" value = "<%=memVO.getId() %>" readonly>
      </div>
      <label class="control-label col-sm-1" for="id">NAME:</label>
      <div class="col-sm-3">
        <input type="text" class="form-control" id="name<%=memVO.getId() %>"  name="name" value = "<%=memVO.getName() %>" readonly>
      </div>
        <input type="hidden" class="form-control" id="role_id"  name="role_id" value = "<%=request.getAttribute("role_id") %>">
      <div class = "col-sm-3">
      	<button type = "submit" class="btn btn-default"><b>배정취소</b></button>
      </div>
    </div>
    </form>
	<%} 
	}%>
</body>
</html>