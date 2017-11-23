<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.role.RoleVO"%>
<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	request.setCharacterEncoding("utf-8");
	RoleVO roleVO = (RoleVO) request.getAttribute("roleVO");
	String name = roleVO.getName();
	String description =roleVO.getDescription();
	if (name == null) {
		name = "";
	}
	if (description == null) {
		description = "";
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>update member form</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container-fluid" style="margin-top:10%; margin-left:20%">
  <h2>회원정보 수정</h2>

  <form class="form-horizontal" action="updaterole.do" method = "post">

    <div class="form-group"> 
      <label class="control-label col-sm-2" for="name">Name:</label>
      <div class="col-sm-6">
        <input type="name" class="form-control" id="name" placeholder="Enter name" name="name" value = "<%=name%>">
        </div>
      </div>
    
    <div class="form-group">        
      <label class="control-label col-sm-2" for="description">Description:</label>
        <div class="col-sm-6">
         <input type="email" class="form-control" id="description" placeholder="Enter description" name="description" value = "<%=description%>">
        </div>
      </div>
    <div class="form-group"  >        
      <div class="col-sm-offset-2 col-sm-10">

        <button type="submit" class="btn btn-default"  style="background-color: green"><b>변경하기</b></button>
        <button type="button" class="btn btn-default"  style="background-color: gray" onclick = "history.go(-1)"><b>취소</b></button>

        

      </div>
    </div>
  </form>
</div>

</body>
</html>
    