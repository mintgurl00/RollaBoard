<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*, com.spring.rollaboard.*" %>
<%
	request.setCharacterEncoding("utf-8");
	MemVO memVO = (MemVO)request.getAttribute("member");
	session.setAttribute("id", memVO.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>updatememberform</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container" style="margin-top:10%; margin-left:20%">
  <h2>회원정보 수정</h2>
  <form class="form-horizontal" action="#">
    <div class="form-group">
      <label class="control-label col-sm-2" for="id">ID:</label>
      <div class="col-sm-10">
        <input type="id" class="form-control" id="id" placeholder="Enter id" name="id" value = "<%=memVO.getId()%>">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd">Password:</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="password" placeholder="Enter password" name="password">
      </div>
    </div>
    <div class="form-group"> 
      <label class="control-label col-sm-2" for="name">Name:</label>
      <div class="col-sm-10">
        <input type="name" class="form-control" id="name" placeholder="Enter name" name="name" value = "<%=memVO.getName()%>">
        </div>
      </div>
    
    <div class="form-group">        
      <label class="control-label col-sm-2" for="email">Email:</label>
        <div class="col-sm-10">
         <input type="email" class="form-control" id="email" placeholder="Enter email" name="email" value = "<%=memVO.getEmail()%>">
        </div>
      </div>
    <div class="form-group"  >        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default"  style="background-color: green">Submit</button>
        <button type="button" class="btn btn-default"  style="background-color: gray" onclick = "location.href='dashboard.do'">Cancel</button>
        
      </div>
    </div>
  </form>
</div>

</body>
</html>
    