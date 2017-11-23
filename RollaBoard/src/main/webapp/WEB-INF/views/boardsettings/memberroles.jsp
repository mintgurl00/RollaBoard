<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.role.*"%>
<%

	ArrayList<RoleVO> roleList = (ArrayList<RoleVO>) request.getAttribute("roleList");
	String board_name = (String) request.getAttribute("board_name");
	String mem_name = (String) request.getAttribute("mem_name");
	
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
<body>

<div class="container-fluid" style="margin-top:10%; margin-left:10%">
	<h2>'<%=mem_name %>'님 ROLE</h2>
	<h3>in '<%=board_name %>'</h3>
	
	<br/>
	<%if (roleList.size() == 0) { %>
	<center><h1>데이터가 없습니다</h1></center>
	<%} else { 
	for(int i = 0; i < roleList.size(); i++) { 
		RoleVO roleVO = roleList.get(i);
	%>
	<form class="form-horizontal" action="deletememtorole.do" method = "post">
	<div class="form-group">
      <label class="control-label col-sm-1" for="id">ROLE:</label>
      <div class="col-sm-3">
        <input type="text" class="form-control" id="name<%=roleVO.getId() %>"  name="id" value = "<%=roleVO.getName() %>" readonly>
      </div>
      <label class="control-label col-sm-2" for="id">DESCRIPTION:</label>
      <div class="col-sm-3">
        <input type="text" class="form-control" id="desc<%=roleVO.getId() %>"  name="name" value = "<%=roleVO.getDescription() %>" readonly>
      </div>
    </div>
    </form>
	<%} 
	}%>
</body>
</html>