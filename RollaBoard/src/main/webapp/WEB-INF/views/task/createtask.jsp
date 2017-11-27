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
<title>W3.CSS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-teal.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

	<!-- 글자수제한 스크립트 -->
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  <script src = "js/rolelist.js"></script>
	
	
<style>
body {font-family: "Roboto", sans-serif}
.w3-bar-block .w3-bar-item{padding:16px;font-weight:bold}
</style>
<body>

<nav class="w3-sidebar w3-bar-block w3-collapse w3-animate-left w3-card" style="z-index:3;width:250px;" id="mySidebar">
  <a class="w3-bar-item w3-button w3-border-bottom w3-large" href="#">
  
  <a class="w3-bar-item w3-button w3-hide-large w3-large" href="javascript:void(0)" onclick="w3_close()">Close <i class="fa fa-remove"></i></a>
  <a class="w3-bar-item w3-button w3-teal" href="#"> 섹션아이디 </a>
  <a class="w3-bar-item w3-button" href="#">테스크 이름 1</a>
  <a class="w3-bar-item w3-button" href="#">테스크 이름  2</a>
  <a class="w3-bar-item w3-button" href="#">테스크 이름  3</a>
  <a class="w3-bar-item w3-button" href="#">테스크 이름  4</a>
  <a class="w3-bar-item w3-button" href="#">테스크 이름  5</a>
  <div>
    <a class="w3-bar-item w3-button" onclick="myAccordion('demo')" href="javascript:void(0)">Drop down <i class="fa fa-caret-down"></i></a>
    <div id="demo" class="w3-hide">
      <a class="w3-bar-item w3-button" href="#">Link</a>
      <a class="w3-bar-item w3-button" href="#">Link</a>
      <a class="w3-bar-item w3-button" href="#">Link</a>
    </div>
  </div>
</nav>

<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" id="myOverlay"></div>

<div class="w3-main" style="margin-left:250px;">

<div id="myTop" class="w3-container w3-top w3-theme w3-large">
  <p><i class="fa fa-bars w3-button w3-teal w3-hide-large w3-xlarge" onclick="w3_open()"></i>
  <span id="myIntro" class="w3-hide">W3.CSS: Introduction</span></p>
</div>

<header class="w3-container w3-theme" style="padding:64px 32px">
  <h1 class="w3-xxxlarge">W3.CSS</h1>
</header>

<div class="w3-container" style="padding:32px">

<h2>What is W3.CSS?</h2>

<p>W3.CSS is a modern CSS framework with built-in responsiveness:</p>

<ul class="w3-leftbar w3-theme-border" style="list-style:none">
 <li>Smaller and faster than other CSS frameworks.</li>
 <li>Easier to learn, and easier to use than other CSS frameworks.</li>
 <li>Uses standard CSS only (No jQuery or JavaScript library).</li>
 <li>Speeds up mobile HTML apps.</li>
 <li>Provides CSS equality for all devices. PC, laptop, tablet, and mobile:</li>
</ul>
<br>
어떤것일까요 ??????????
<img src="img_responsive.png" style="width:100%" alt="Responsive" >

<hr>
<h2>W3.CSS is Free</h2>
<p>W3.CSS is free to use. No license is necessary.</p>

<hr>
<h2>Easy to Use</h2>
<div class="w3-container w3-sand w3-leftbar">
<p><i>Make it as simple as possible, but not simpler.</i><br>
Albert Einstein</p>
</div>

<hr>
<h2>W3.CSS Web Site Templates</h2>

<p>We have created some responsive W3CSS templates for you to use.</p>
<p>You are free to modify, save, share, use or do whatever you want with them:</p> 
<h1> 여기까지 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 끝. Band Template 하기 전까지 끝</h1>


<div class="w3-panel w3-light-grey w3-padding-16 w3-card">
<h3 class="w3-center">Band Template</h3>
<div class="w3-content" style="max-width:800px">
<a href="tryw3css_templates_band.htm" target="_blank"  title="Band Demo"><img src="img_temp_band.jpg" style="width:98%;margin:20px 0" alt="Band Template"></a><br>
<div class="w3-row">
  <div class="w3-col m6">
    <a href="tryw3css_templates_band.htm" target="_blank" class="w3-button w3-padding-large w3-dark-grey" style="width:98.5%">Demo</a>
  </div>
  <div class="w3-col m6">
    <a href="w3css_templates.asp" class="w3-button w3-padding-large w3-dark-grey" style="width:98.5%">More Templates »</a>
  </div>
</div>
</div>
</div>

<div class="w3-container w3-padding-16 w3-card" style="background-color:#eee">
<h3 class="w3-center">Blog Template</h3>
<div class="w3-content" style="max-width:800px">
<img src="img_temp_blog.jpg" style="width:98%;margin:20px 0" alt="Blog Template"><br>
<div class="w3-row">
  <div class="w3-col m6">
    <a href="tryw3css_templates_blog.htm" target="_blank" class="w3-button w3-padding-large w3-dark-grey" style="width:98.5%">Demo</a>
  </div>
  <div class="w3-col m6">
    <a href="w3css_templates.asp" class="w3-button w3-padding-large w3-dark-grey" style="width:98.5%">More Templates »</a>
  </div>
</div>
</div>
</div>

</div>

<footer class="w3-container w3-theme" style="padding:32px">
  <p>Footer information goes here</p>
</footer>
     
</div>

<script>
// Open and close the sidebar on medium and small screens
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}

// Change style of top container on scroll
window.onscroll = function() {myFunction()};
function myFunction() {
    if (document.body.scrollTop > 80 || document.documentElement.scrollTop > 80) {
        document.getElementById("myTop").classList.add("w3-card-4", "w3-animate-opacity");
        document.getElementById("myIntro").classList.add("w3-show-inline-block");
    } else {
        document.getElementById("myIntro").classList.remove("w3-show-inline-block");
        document.getElementById("myTop").classList.remove("w3-card-4", "w3-animate-opacity");
    }
}

// Accordions
function myAccordion(id) {
    var x = document.getElementById(id);
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
        x.previousElementSibling.className += " w3-theme";
    } else { 
        x.className = x.className.replace("w3-show", "");
        x.previousElementSibling.className = 
        x.previousElementSibling.className.replace(" w3-theme", "");
    }
}
</script>
     
</body>
</html> 










































<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
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
		<input type="text" id="location" placeholder="위치를 입력해주세요 예)서울시 서초구 잠원동" size="40" name="location" value="서울시"><br/><br/><br/>
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