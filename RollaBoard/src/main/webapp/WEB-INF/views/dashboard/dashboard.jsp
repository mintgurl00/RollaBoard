<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	request.setCharacterEncoding("utf-8");
	
	List<BoardVO> boardList = (ArrayList<BoardVO>)request.getAttribute("boardList");
	ArrayList<TaskVO> taskList = (ArrayList<TaskVO>) request.getAttribute("taskList");

%>
<!DOCTYPE html>
<html>
<title>Dashboard</title>
<meta charset="UTF-8">
<link href = "reset.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
<style>
mycolor {background-color: #f4511e;}
body,h1,h2,h3,h4,h5 {font-family: "Poppins", sans-serif}
body {font-size:16px;}
.w3-half img{margin-bottom:-6px;margin-top:16px;opacity:0.8;cursor:pointer}
.w3-half img:hover{opacity:1}
.image {
position:relative;
float:left; /* optional */
}

.image .text {
position:absolute;
top:20px; /* in conjunction with left property, decides the text position */
left:25px;
width:700px; /* optional, though better have one */
}
#task{float:left; width:250px; height:250px; margin-left:40px; margin-top:40px; background-color:#BDBDBF; text-align:center; cursor:pointer}

</style>
<body>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-red w3-collapse w3-top w3-large w3-padding mycolor" style="z-index:3;width:300px;font-weight:bold;" id="mySidebar"><br>
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-button w3-hide-large w3-display-topleft" style="width:100%;font-size:19px">Close Menu</a>
  <p class="w3-display-topleft w3-hide-medium w3-hide-small" style="font-size:15px;cursor:pointer"><a onClick = "openPop();">회원정보수정</a> | <a href="logout.do">logout</a></p>
  <div class="w3-container">
    <h2 class="w3-padding-64"><b>My<br>Board</b></h2>
  </div>
  <div class="w3-bar-block">
  	<% for (int i = 0; i < boardList.size(); i++) {
				BoardVO board = boardList.get(i); %>
	<a onclick = "location.href='./board.do?board_id=<%=board.getId()%>'" class="w3-bar-item w3-button w3-hover-white"><%=board.getName()%></a>
    <% }%>
    <br/>
	<p align="center"><a href = "newboard.do" class="w3-bar-item w3-center w3-button w3-hover-white">추가</a></p>
  </div>
</nav>

<!-- Top menu on small screens -->
<header class="w3-container w3-top w3-hide-large w3-red w3-xlarge w3-padding">
  <a href="javascript:void(0)" class="w3-button w3-red w3-margin-right" onclick="w3_open()">☰</a>
  <p class="w3-display-topleft w3-hide-medium w3-hide-small" style="font-size:15px"><a onClick = "openPop();" class = "w3-button">회원정보수정</a> | <a href="logout.do" class = "w3-button">logout</a></p>
  <span>MY BOARD</span>
  <span class = "w3-display-topright">
  	<a onClick = "openPop();" style="font-size:12px;cursor:pointer">회원정보수정</a>&nbsp;<a href="logout.do" style="font-size:12px;cursor:pointer">logout</a>
  </span>
</header>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:340px;margin-right:40px">

  <!-- Header -->
  <div class="w3-container" style="margin-top:40px" id="showcase">
    <h1 class="w3-jumbo"><b>My Tasks</b></h1>
    <hr style="width:50px;border:5px solid orange" class="w3-round">
  </div>
  
  <!-- Photo grid (modal) -->
  <div class="w3-row-padding">
  	<div >
  	<% if (taskList.size() == 0) {%>
  		<h2 class="w3-jumbo"><b>No Tasks</b></h2>
  	<%} else { %>
	<% for (int k = 0; k < taskList.size(); k++) {
		TaskVO taskVO = taskList.get(k);
	%>
    <div id="task" onclick="javascript:viewTask(<%=taskVO.getId() %>)"><br/><h3><%=taskVO.getName()%></h3><br/>in <%=taskVO.getDescription() %></div>
    <form id = "taskview<%=taskVO.getId() %>" action = "taskview.do" hidden>
		<input type = hidden name = "task_id" value = "<%=taskVO.getId() %>">
		<input type = hidden name = "board_name" value = "<%=taskVO.getDescription()%>">
	</form>
    <%} 
    }%>
    </div>
  </div>

  <!-- Modal for full size images on click-->
  <div id="modal01" class="w3-modal w3-black" style="padding-top:0" onclick="this.style.display='none'">
    <span class="w3-button w3-black w3-xxlarge w3-display-topright">×</span>
    <div class="w3-modal-content w3-animate-zoom w3-center w3-transparent w3-padding-64">
      <img id="img01" class="w3-image">
      <p id="caption"></p>
    </div>
  </div>

<!-- End page content -->
</div>

<!-- Rollaboard Container -->
<div class="w3-light-grey w3-container w3-padding-32" style="margin-top:75px;padding-right:58px"><p class="w3-right"><b>Rollaboard</b> all rights reserved </p></div>

<script>
// Script to open and close sidebar
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}

// Modal Image Gallery
function onClick(element) {
  document.getElementById("img01").src = element.src;
  document.getElementById("modal01").style.display = "block";
  var captionText = document.getElementById("caption");
  captionText.innerHTML = element.alt;
}

// 회원정보 수정창 오픈
function openPop() {
	window.open("./updatememberform.do",
			"UPDATE",
			"resizeable = yes, menubar=no, width = 800, height = 500, left = 10, right = 10");
	
}

// 태스크 보기
function viewTask (cnt) {
	document.getElementById("taskview" + cnt).submit();	
}


</script>

</body>
</html>
