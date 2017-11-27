<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>

<%
	String section_id = request.getParameter("section_id");
	
	ArrayList<TaskVO> Tasklist = (ArrayList<TaskVO>) request.getAttribute("tasklist");
%>

<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
Date dt = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 

%>


<!DOCTYPE html>
<html>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-teal.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

	<!-- 글자수제한 스크립트 -->
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  <script src = "js/rolelist.js"></script>
	

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/reset.css">
<title>task 생성</title>
<style>
#frame{width:500px; height:90%; background-color:#DAD9FF; margin-top:100px; margin-left:700px}
#taskname{margin-top:20px; margin-left:10px}
#description{margin-top:30px; margin-left:30px}
#role{margin-top:30px; margin-left:30px}
#settings{margin-top:5px; margin-left:380px}
#button{margin-top:20px; margin-left:200px}
</style>

<!-- 글자수제한 스크립트 -->
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  <script src = "js/rolelist.js"></script>


</head>
<body>

<form action="inserttask.do" name="inserttask" method="post">


<div id="frame">
	<div id="section_id">
		<input type="hidden" id="section_id" name="section_id" value = <%=section_id %> size="40">
	</div>
	
	<!-- <div id="task_id"> task id 
		<input type="text" id="task_id" name="task_id" size="40" name="name">
	</div>  -->
	
	<div id="taskname">
		<input type="text" id="name" placeholder="TASK 이름을 입력하시오." size="40" class="byteLimit" limitbyte="30"  name="name" required>
	</div>
	
	<div id="description">내용(필수X)<br/>
		<input type="text" maxlength="100" id="description" style="height:180px; width:380px;" class="byteLimit" limitbyte="100" name="description" >
		<input type="hidden" name="status" value="NORMAL" />
	</div>
	
	<h4>고급설정</h4>
	<div id ="start_date"> 시작날짜  <br/>
		<input type="date" id="start_date" placeholder="yyyy-mm-dd" size="40" name ="start_date" value = "<%=sdf.format(dt).toString()%>"><br/><br/><br/>
	</div>
	
	<div id ="due_date"> 마감날짜  <br/>

		<input type="date" id="due_date" placeholder="yyyy-mm-dd" size="40" name = "due_date" value = "<%=sdf.format(dt).toString()%>"><br/><br/><br/>

	</div>
	
	<div id ="cre_date"> 생성날짜  <br/>


		<input type="date" id="cre_date" placeholder="yyyy-mm-dd" size="40" name = "cre_date" value = "<%=sdf.format(dt).toString()%>" readonly><br/><br/><br/>


	</div>
	
	<div id ="priority"> 중요도  <br/>
		<input type="text" id="priority" placeholder="1~5중에 하나를 입력해주세요" size="40" name="priority" value = "3"><br/><br/><br/>
	</div>
	
	<!-- 수민 태스크 위치 추가 -->
	<div id ="location"> 위치 <br/>
		<input type="text" id="location" placeholder="위치를 입력해주세요 예)서울시 서초구 잠원동" size="40" name="location"><br/><br/><br/>
	</div>
	
<!--<div id ="pre_Task"> 선행TASK  <br/>
		<input type="text" id="pre_task" name="pre_task" placeholder="Task id를 입력하시오" size="40" value=""><br/><br/><br/>
	</div>
	
	<div id ="postTask"> 후행TASK  <br/>
		<input type="text" id="post_task" name="post_task" placeholder="Task id를 입력하시오" size="40" value=""><br/><br/><br/>
	</div> -->
	
	<!-- <div id="settings">
		<input type="button" value="고급설정" onclick="location.href='./detailtask.do';">
	</div> -->
	
	<div id="button">
		<input type="submit" value="확인" >
		<input type="button" value="취소" onclick='history.go(-1)'>
	</div>

</div>
</form>
</body>
</html>