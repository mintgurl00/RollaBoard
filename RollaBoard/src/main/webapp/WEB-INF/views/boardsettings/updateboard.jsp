<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%@ page import="com.spring.rollaboard.section.SectionVO"%>
<%@ page import="com.spring.rollaboard.mem.MemVO"%>
<%@ page import="com.spring.rollaboard.role.RoleVO"%>
<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	
	// 세션 보드아이디 체크
	if (session.getAttribute("board_id") == null) {
		out.println("<script>location.href='dashboard.do'</script>");
	}
	BoardVO boardVO = null;
	if (request.getAttribute("boardVO") != null) {
		boardVO = (BoardVO) request.getAttribute("boardVO");
	} else {
		boardVO.setId(Integer.parseInt((String) session.getAttribute("board_id")));
	}
	String chkVal = (String) request.getAttribute("chkVal");
	ArrayList<RoleVO> roleList = (ArrayList<RoleVO>) request.getAttribute("roleList");
	ArrayList<MemVO> boardMemberList = (ArrayList<MemVO>) request.getAttribute("boardMemberList");
	ArrayList<MemVO> boardWaitingList = (ArrayList<MemVO>) request.getAttribute("boardWaitingList");
	ArrayList<SectionVO> sectionList = (ArrayList<SectionVO>) request.getAttribute("sectionList");
	ArrayList<BoardVO> refBoardList = (ArrayList<BoardVO>) request.getAttribute("refBoardList");
	String visible = (String) request.getAttribute("visible");
%>
<html lang="en">
<head>
	<title>updateboard</title>
	<meta charset="utf-8" >
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="css/reset.css" >
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
body {
      font: 400 15px Lato, sans-serif;
      height:inherit;
      line-height: 1.8;
	background-color:#EFEFEF;
  }
  h2 {
      font-size: 24px;
      text-transform: uppercase;
      color: #303030;
      font-weight: 600;
      margin-bottom: 30px;
  }
  h4 {
      font-size: 19px;
      line-height: 1.375em;
      color: #303030;
      font-weight: 400;
      margin-bottom: 30px;
  }  
  .jumbotron {

      background-color: #1294AB;
      color: #1294AB;
      padding: 40px 25px;
      font-family: Montserrat, sans-serif;
  }
  .container-fluid {
      padding: 60px 50px;
  }
  .logo-small {
      color: #1294AB;
      font-size: 50px;
  }
  .logo {
      color: #1294AB;
      font-size: 200px;
  }
  .navbar {
      margin-bottom: 0;
      background-color: #1294AB;
      z-index: 9999;
      border: 1;
      font-size: 12px !important;
      line-height: 1.42857143 !important;
      letter-spacing: 4px;
      border-radius: 0;
      font-family: Montserrat, sans-serif;
  }
  .navbar li a, .navbar .navbar-brand {
      color: #000;
  }
  .navbar-nav li a:hover, .navbar-nav li.active a {
      color: #1294AB;
      background-color: #fff;
  }
  .navbar-default .navbar-toggle {
      border-color: #fff;
      color: #fff;
  }
  footer .glyphicon {
      font-size: 20px;
      margin-bottom: 20px;
      color: #1294AB;
  }
  .slideanim {visibility:hidden;}
  .slide {
      animation-name: slide;
      -webkit-animation-name: slide;
      animation-duration: 1s;
      -webkit-animation-duration: 1s;
      visibility: visible;
  }
  @keyframes slide {
    0% {
      opacity: 0;
      transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      transform: translateY(0%);
    }
  }
  @-webkit-keyframes slide {
    0% {
      opacity: 0;
      -webkit-transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      -webkit-transform: translateY(0%);
    }
  }
  @media screen and (max-width: 768px) {
    .col-sm-4 {
      text-align: center;
      margin: 25px 0;
    }
    .btn-lg {
        width: 100%;
        margin-bottom: 35px;
    }
  }
  .boxing {
	  width: 300px;
	  height: 50px;
	  font-size: 10pt;
	  float: left;
	  color: #63717f;
	  padding-top: 12px;
	  -webkit-border-radius: 5px;
	  -moz-border-radius: 5px;
	  border-radius: 10px;
  }
  
  .btn.btn-info {
  	background-color:#1294AB;
  }
  
  input[type="text"], input[type="password"], input[type="email"],
   input[type="search"], input[type="image"],input[type="tel"], 
   textarea {-webkit-appearance:none;
   -webkit-border-radius:0;
   border:0;
   -webkit-box-shadow: 0 0 0 1000px #00000000 inset;
   } 
	#boardNameInput{
		background-color: #00000000;
		border: 2px solid #00000000;
		color: #ffffff;
		font-size: 25px;
		border-radius: 7px;
	}
	.swInputClicked{
		background-color: #ffffff !important;
		border: 2px solid #66aaee !important;
		color: #222222 !important;
	}
	:-webkit-autofill { background-color: none}
	.appearance (@value: none) {
	    -webkit-appearance:     @value;
	    -moz-appearance:        @value;
	    -ms-appearance:         @value;
	    -o-appearance:          @value;
	    appearance:             @value;
	}
	
	#boardNameInput:hover {
		color:#ffcc44;
		border: 2px solid #ffcc44 !important;
	}
	#boardNameSubmitBtn{
	}

	#navbar-brand:hover {
	color:orange;
	}
	
	#updating{
		position: relative;
	}
	
	.btn_small{
		padding: 0px 3px !important;
		font-size: 13px !important;
	}
	@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
	.BoardNameChangePannel{
		padding: 4px 10px;
		background-color: #ffffff;
		border: 0.5px solid #cccccc;
   		font-family: 'Nanum Gothic', sans-serif;
   		box-shadow: 2px 4px 5px rgba(0,0,0,.175);
   		display: none;
   		border-radius: 4px;
	}
	.BoardNameChangePannel span{
		letter-spacing: 1px;
		font-size: 15px;
	}
	.backBtn{
		
	}
</style>

<script>
function rolePage() {
	$('#resultBlock').load("rolelist.do", {board_id: "<%=boardVO.getId() %>"});
}

function allocatePage() {
	$('#resultBlock').load("allocation.do", {board_id: "<%=boardVO.getId() %>"});
}

function memberPage() {
	$('#resultBlock').load("memberlist.do", {board_id: "<%=boardVO.getId() %>"});
}

function admitPage() {
	$('#resultBlock').load("memberadmitform.do", {board_id: "<%=boardVO.getId() %>"});
}

function sectionPage() {
	$('#resultBlock').load("sectionlist.do", {board_id: "<%=boardVO.getId() %>"});
}

function ETCPage() {
	$('#resultBlock').load("etcform.do", {board_id: "<%=boardVO.getId() %>"});
}

function updating() {
	document.getElementById("updating").submit();
}

$(document).ready(function(){
	//$("#boardNameSubmitBtn").css("display", "none");
	$("#boardNameInput").on("focus",function(){
		$("#boardNameInput").addClass("swInputClicked");
	});
	$("#boardNameInput").on("blur",function(){
		$("#boardNameInput").removeClass("swInputClicked");
		if($("#boardNameInput").val() != $("#oldBoardName").val())
			$(".BoardNameChangePannel").css("display", "block");
		else
			$(".BoardNameChangePannel").css("display", "none");
	});
	$("#boardNameResetBtn").on("click", function(){
		$("#boardNameInput").val($("#oldBoardName").val());
		$(".BoardNameChangePannel").css("display", "none");
	});
});
</script>

<!-- 글자수제한 스크립트 -->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src = "js/rolelist.js"></script>
</head>
<body>
<div class="whole_wrapper">
<div class="upper_wrapper">
<nav class="navbar navbar-fixed-top">
<a style = "color: #fff; padding-top:1px" class="navbar-brand" href="board.do?board_id=<%=boardVO.getId()%>" >ROLLA<br>BOARD</a>
	<div class="container">
		<div class="navbar-header">
			<button id = "myToggle" type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar2">
				<font style = "color:#fff">
					LIST
					<i class="fa fa-envelope"></i>  
				</font>                      
			</button>
			<form id="updating" action="updateboardname.do" class="boxing">
				<input type="hidden" id="oldBoardName" value="<%=boardVO.getName() %>"/>
				<div>
					<ul>
						<li>
							<input id="boardNameInput" type = "text" class = "byteLimit form-control swInputN" limitbyte="50" name = "board_name" value = "<%=boardVO.getName() %>" placeholder = "Board명을 입력하세요" required>
						</li>
						<li class="BoardNameChangePannel">
							<span>보드 이름을 수정할까요?
								<input id="boardNameSubmitBtn" type="button" class="btn btn-warning btn_small" value="수정" onclick="javascript:updating()" />
								<input id="boardNameResetBtn" type="button" class="btn btn-default btn_small" value="취소" />
							</span>
						</li>
					</ul>
				</div>		
			</form>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar2">
			<ul class="nav navbar-nav navbar-right">
				<li>
					<a onclick = "rolePage()" style = "cursor:pointer">ROLE관리</a>
				</li>
				<li>
					<a onclick = "allocatePage()" style = "cursor:pointer">ROLE배정</a>
				</li>
				<li>
					<a onclick = "memberPage()" style = "cursor:pointer">MEMBER관리</a>
				</li>
				<li>
					<a onclick = "admitPage()" style = "cursor:pointer">MEMBER승인</a>
				</li>
				<li>
					<a onclick = "sectionPage()" style = "cursor:pointer">SECTION관리</a>
				</li>
				<li>
					<a onclick = "ETCPage()" style = "cursor:pointer">ETC</a>
				</li>
			</ul>
		</div>
	</div>
</nav>
</div>
<div id=resultBlock class="wrapper" style = "padding-top:100px">
	<%if (chkVal == null) {%>
	<jsp:include page = "rolelist.jsp" flush = "false" >
			<jsp:param name="roleList" value="<%=roleList %>" />
	</jsp:include>
	<%} else if (chkVal.equals("memList")) { %>
	<jsp:include page = "memberlist.jsp" flush = "false" >
			<jsp:param name="boardMemberList" value="<%=boardMemberList %>" />
	</jsp:include>
	<%}else if (chkVal.equals("allocation")) { %>
	<jsp:include page = "allocation.jsp" flush = "false" >
			<jsp:param name="boardMemberList" value="<%=boardMemberList %>" />
			<jsp:param name="roleList" value="<%=roleList %>" />
	</jsp:include>
	<%}else if (chkVal.equals("memAdmit")) { %>
	<jsp:include page = "memberadmitform.jsp" flush = "false" >
			<jsp:param name="boardWaitingList" value="<%=boardWaitingList %>" />
	</jsp:include>
	<%}else if (chkVal.equals("section")) { %>
	<jsp:include page = "sectionlist.jsp" flush = "false" >
			<jsp:param name="sectionList" value="<%=sectionList %>" />
	</jsp:include>
	<%}else if (chkVal.equals("etc")) { %>
	<jsp:include page = "etcform.jsp" flush = "false" >
			<jsp:param name="refBoardList" value="<%=refBoardList %>" />
			<jsp:param name="visible" value="<%=visible %>" />
	</jsp:include>
	<%}else { %>
	<jsp:include page = "rolelist.jsp" flush = "false" >
			<jsp:param name="roleList" value="<%=roleList %>" />
	</jsp:include>
	<%} %>
</div>
<footer class="container-fluid text-center">
	<!-- <input type = "submit" class = "btn btn-info" value = "확인" onclick = "javascript:updating()" >&nbsp;  -->
	<input type = "button" class = "btn btn-info" value = "돌아가기" onclick = "location.href='board.do?board_id=<%=boardVO.getId()%>'">
</footer>
<br/>
</div>
</body>
<script>
// 회원정보수정 캔슬클릭시
function clickcancel() {
	document.getElementById('id01').style.display='none';
	window.location.reload();
}

$("#myToggle").click(function(event){
	event.stopPropagation();
	$('#myNavbar2').toggle();
});

 
$(document).click(function(){
    $('#myNavbar2').hide();
});
</script>

</html>