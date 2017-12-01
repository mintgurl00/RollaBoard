<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%@ page import="com.spring.rollaboard.mem.MemVO"%>
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
	MemVO member = (MemVO) request.getAttribute("member");
	String name = member.getName();
	String email = member.getEmail();
	if (name == null) {
		name = "";
	}
	if (email == null) {
		email = "";
	}

%>
<!DOCTYPE html>
<html>
<title>Dashboard</title>
<meta charset="UTF-8">
<link href = "reset.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://use.fontawesome.com/e39dcf78fa.js"></script> <!-- Font Awesome 사용. 수민 -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
<link href="css/task.css" rel="stylesheet" type="text/css" >
<link href="reset.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
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

#task{
	float:left;
	width:250px;
	height:250px;
	margin-left:40px;
	margin-top:40px;
	padding-left:30px;
	background-color:#E1E1E1;
	cursor:pointer;
	border-radius:10px;
}

.fa.fa-plus-circle {
	font-size:30px;
}

</style>
<body>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-top w3-large w3-padding mycolor" style="z-index:3;width:270px;font-weight:bold; background-color: #1294AB; color:white;" id="mySidebar"><br>
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-button w3-hide-large w3-display-topleft" style="width:100%;font-size:19px">Close Menu</a>
  <p class="w3-display-topleft w3-hide-medium w3-hide-small" style="font-size:15px;cursor:pointer"><a onclick="document.getElementById('id01').style.display='block'">&nbsp;&nbsp;&nbsp;<i class="fa fa-user"></i></a>&nbsp;&nbsp;&nbsp;<a href="logout.do" style="text-decoration:none">logout</a></p>
  <div class="w3-container">
    <h2 class="w3-padding-64"><b>My<br>Board</b></h2>
  </div>
  <div class="w3-bar-block">
  	<% for (int i = 0; i < boardList.size(); i++) {
				BoardVO board = boardList.get(i); %>
	<a onclick = "location.href='./board.do?board_id=<%=board.getId()%>'" class="w3-bar-item w3-button w3-hover-white"><%=board.getName()%></a>
    <% }%>
    <br/>
	<p align="center"><a href = "newboard.do" class="w3-bar-item w3-center w3-button w3-hover-white"><i class="fa fa-plus-circle"></i></a></p>
  </div>
</nav>

<!-- MODAL TASK -->
<div class="modal fade" id="myModal2" role="dialog">
	<div class="modal-dialog" style="margin:55px auto;">
		<div class="modal-content" id="taskViewArea2">
		</div> 
	</div>
</div>

<!-- Modal창으로 회원정보수정 출력 -->
<div id="id01" class="w3-modal">
    <div class="w3-modal-content w3-animate-top w3-card-4" style = "max-width:550px">
      <header class="w3-container w3-teal">
        <span onclick="javascript:clickcancel()" class="w3-button w3-display-topright">&times;</span>
        <h3><i class="fa fa-user"></i>&nbsp;&nbsp;회원정보 수정</h3>
      </header>
	  <form class="w3-container" action="updatemember.do" method = "post">
	    <div class="w3-section">
	      <label>ID:</label>
	        <input class = "w3-input w3-border w3-margin-bottom" type="id" id="id" placeholder="Enter id" name="id" value = "<%=member.getId()%>" readonly>
	      <label>Password:</label>      
	        <input class = "w3-input w3-border w3-margin-bottom" type="password" id="password" placeholder="Enter password" name="password">
	      <label>Name:</label>
	        <input class = "w3-input w3-border w3-margin-bottom" type="name" id="name" placeholder="Enter name" name="name" value = "<%=name%>">       
	      <label>Email:</label>
	         <input class = "w3-input w3-border w3-margin-bottom" type="email"  id="email" placeholder="Enter email" name="email" value = "<%=email%>">
	        <button type="submit" class="w3-button w3-block w3-green w3-section w3-padding"  style="background-color: green"><b>변경하기</b></button>
	    	<button onclick="javascript:clickcancel()" type="button" class = "w3-button w3-block w3-red"><b>취소</b></button>
	    </div>
	  </form>
 	 </div>
</div>
  
<!-- Top menu on small screens -->
<header class="w3-container w3-top w3-hide-large w3-xlarge w3-padding w3-opacity" style = "background-color: #1294AB; color:white;">
  <a href="javascript:void(0)" class="w3-button w3-margin-right" onclick="w3_open()">☰</a>
  <p class="w3-display-topleft w3-hide-medium w3-hide-small" style="font-size:15px"><a onClick = "openPop();" class = "w3-button"><i class="fa fa-user"></i></a>&nbsp;&nbsp;&nbsp;<a href="logout.do" class = "w3-button">logout</a></p>
  <span>MY BOARD</span>
  <span class = "w3-display-topright">
  	<a onclick="document.getElementById('id01').style.display='block'" style="cursor:pointer;padding-right:10px; padding-top:10px;"><i class="fa fa-user"></i></a>&nbsp;<a href="logout.do" style="cursor:pointer;text-decoration:none; padding-right:10px; padding-top:10px">logout</a>
  </span>
</header>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:340px;margin-right:40px">

  <!-- Header -->
  <div class="w3-container w3-animate-left" style="margin-top:40px" id="showcase">
    <h1><b>My Tasks</b></h1>
    <hr style="width:50px;border:5px solid orange" class="w3-round">
  </div>
  
  <!-- Photo grid (modal) -->
  <div class="w3-row-padding">
  	<div>
  	<% if (taskList.size() == 0) {%>
  		<center><h2>No Tasks</h2></center>
  	<%} else { %>
	<% for (int k = 0; k < taskList.size(); k++) {
		TaskVO taskVO = taskList.get(k);
	%>
	
    <div id="task" onclick="javascript:clicktask('<%=taskVO.getId() %>')" class = "w3-animate-zoom">
    	<br/><h5><b><%=taskVO.getName()%></b></h5>
    	in <%=taskVO.getDescription() %>
    	<br/>
    <% if( taskVO.getStatus().equals("BLOCKED")){%>
		<div class="task_status_blocked" style="margin-top:60px; margin-left:30px" align=center>
			BLOCKED <i class="fa fa-lock" aria-hidden="true"></i>
		</div>				
	<% } else if ( taskVO.getStatus().equals("COMPLETE")) {%>
		<div class="task_status_complete" style="margin-top:60px;; margin-left:30px" align=center>
			COMPLETE <i class="fa fa-check" aria-hidden="true"></i>
		</div> 
	<% } %>
    </div>
    
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
<div style="margin-top:430px;padding-right:40px"><p class="w3-right"><b>Rollaboard</b> all rights reserved </p></div>

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

// 태스크 보기
function viewTask (cnt) {
	document.getElementById("taskview" + cnt).submit();	
}

// 회원정보수정 캔슬클릭시
function clickcancel() {
	document.getElementById('id01').style.display='none';
	window.location.reload();
}
</script>
<!-- TASK클릭 시 함수 -->
<script>
function clicktask(id) {/* 
	window.open("./taskview.do?task_id=" + id,
			"TASK",
			"resizeable = yes, menubar=no, width = 470, height = 800, left = 10, right = 10"); */
	$("#taskViewArea2").load("taskview.do",{
		task_id:id
	});
	$("#myModal2").modal();
}
function updatesectioninboard(cnt) {
	document.getElementById("updatesectioninboard" + cnt).submit();
}

function deletesectioninboard(cnt) {
	document.getElementById("deletesectioninboard" + cnt).submit();
}

</script>
</body>
</html>
