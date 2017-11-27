<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%@ page import="com.spring.rollaboard.section.SectionVO"%>
<%@ page import="com.spring.rollaboard.mem.MemVO"%>
<%
	System.out.println("board");
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	// 회원정보수정시 필요한 정보들
	MemVO member = (MemVO) request.getAttribute("member");
	String name = member.getName();
	String email = member.getEmail();
	if (name == null) {
		name = "";
	}
	if (email == null) {
		email = "";
	}
	
	String id = (String) session.getAttribute("id");
	//
	
	BoardVO boardVO = (BoardVO) request.getAttribute("boardVO");
	// 석원.
	ArrayList<ArrayList<TaskVO>> taskViewList = (ArrayList<ArrayList<TaskVO>>) request.getAttribute( "taskViewList" ) ;
	ArrayList<SectionVO> sectionList = (ArrayList<SectionVO>) request.getAttribute( "sectionList" ) ; 
	ArrayList<BoardVO> refBoardList = (ArrayList<BoardVO>) request.getAttribute( "refBoardList" ) ;
%>
<html lang="en">
<head>
<!-- Theme Made By www.w3schools.com - No Copyright -->
<title>Board Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/reset.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/board.css" >

<script type = "text/javascript" language = "javascript">
function openPop() {
	window.open("./updatememberform.do",
			"UPDATE",
			"resizeable = yes, menubar=no, width = 800, height = 500, left = 10, right = 10");
}

/*
 * 석원.
 */
 
 
window.onload = function(){
    $("#myBtn").click(function(){
        $("#myModal").modal();
    });
	initRefBoard( "ref_board_select" ) ;
	initBoard();
	inputEnterToSearch();
	$( "#ref_board" ).click( function(){showRefBoard()} ) ;
}
/*
 * 참조보드 select태그에 넣기 
 */
function initRefBoard( selectName ){
	
	var name_arr = [] ;
	var id_arr = [] ;
	
	<%
	for( int i = 0 ; i < refBoardList.size() ; i++ ){

		%>name_arr.push( '<%=refBoardList.get( i ).getName() %>' ) ;<%
		%>id_arr.push( '<%=refBoardList.get( i ).getId() %>' ) ;<%
	}%>
	
	
	for( var i = 0 ; i < id_arr.length ; i++ ){
		var select_option = document.createElement( "option" ) ;
		select_option.setAttribute( "value" , id_arr[ i ] ) ;
		var select_option_text = document.createTextNode( name_arr[ i ] ) ;
		select_option.appendChild( select_option_text ) ;
		
		document.getElementById( selectName ).appendChild( select_option ) ;
	}
}

/*
 * 보드 그리기 
 */
function initBoard() {
	$('#work_board').load("searchresult.do", {
		board_id: '<%=boardVO.getId() %>',
		keyword:''
	});
}
/*
 * 검색 결과
 */
function loadSearchResult() {
	var filter = getFilter() ;
	$('#content').load("searchresult.do", {
		board_id: '<%=boardVO.getId() %>',
		keyword:$('#keyword').val(),
		filter: filter
	});
	
	$('#written_keyword').attr('value', $('#keyword').val() ) ;
	return false ;
}

function inputEnterToSearch(){
	$('#keyword').keypress( function(e){
		if( e.keyCode == 13 ){
			loadSearchResult();
		}
	});
}

/*
 * 필터 결과
 */

function filterResult( obj ){	// 필터버튼 클릭
	/* alert( obj.name + ' : ' + obj.value ) ; */
	// 01 필터 버튼에 값 설정
	if( obj.value == 'FALSE' )
		obj.value = 'TRUE' ;
	else
		obj.value = 'FALSE' ;
	// 02 전체 필터버튼의 값 확인해서 전달 필터 String 작성
	/* alert( obj.name + ' : ' + obj.value ) ; */
	var filter = getFilter() ;
	/* alert( '필터스트링 : ' + filter ) ; */
	// 03 페이지 로드
	$('#work_board').load("searchresult.do", {
		board_id: '<%=boardVO.getId() %>',
		keyword:$('#written_keyword').val(),
		filter: filter
	});
}
function getFilter(){
	var filterString = "" ;
	$( ".filter" ).each( function(){
/* 		alert( '필터' + $( this ).prop( "name" ) ) ; */
		if( $( this ).val() == 'TRUE' )
			filterString += $( this ).prop( "name" ) + " " ;
	} ) ;
	return filterString
}

/*
 * 참조 보드 부르기
 */
function showRefBoard(){
	var ref_board_id = $( "#ref_board_select option:selected" ).val() ;
	if( ref_board_id != $("#current_ref_board").val() ){
		ref_board_id != $("#current_ref_board").prop( "value" , ref_board_id ) ;
		alert( '참조보드 : ' + ref_board_id ) ;
		
		$("#content_ref").load("referenceboard.do", {
			board_id: '<%=boardVO.getId() %>',
			ref_board_id:ref_board_id
		}) ;
		
		alert( '작업 시작' ) ;
	}
}

</script>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">

<nav class="navbar navbar-default navbar-fixed-top">
<div class="container">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="./dashboard.do">ROLLABOARD</a>
	</div>
	<div class="collapse navbar-collapse" id="myNavbar">
		<ul class="nav navbar-nav navbar-right"><%
			if (id.equals(boardVO.getAdmin())) {%>
				<li>
					<a onClick="document.getElementById('boardSetting').submit()" style="cursor: pointer">BOARD 설정</a>
					<form id="boardSetting" action="updateboard.do" method="post" style="margin-top: 5px;">
						<input type="hidden" name="id" value="<%=boardVO.getId()%>">
						<input type="hidden" name="name" value="<%=boardVO.getName()%>">
						<input type="hidden" name="admin" value="<%=boardVO.getAdmin()%>">
						<input type="hidden" name="visibility" value="<%=boardVO.getVisibility()%>">
						<input type="hidden" name="chkVal" value="role">
					</form>
				</li><%
			}%>
			<li>
				<!-- 참조 보드 선택 -->
				<div>
					<input type="hidden" id="current_ref_board" value="-1" /> <select
						id="ref_board_select">
						<option value="-1">참조 BOARD 선택</option>
					</select>
				</div>
			</li>
			<li>
				<a onClick="document.getElementById('updateMember').style.display='block'" style="cursor: pointer">회원정보수정</a>
			</li>
				<li><a href="logout.do">LOGOUT</a></li>
		</ul>
	</div>
</div>
</nav>

<div class="jumbotron text-center">
<br/>
  <h3><%=boardVO.getName() %></h3>  
  <form>
    <div class="input-group" >
      	<input type="text" name="keyword" id="keyword" class="form-control" size="50" placeholder="검색할 TASK 입력">
      	<input type="hidden" name="written_keyword" id="written_keyword" value=""/>
		<input type ="hidden" name="board_id" value="<%=boardVO.getId()%>" />
      <div class="input-group-btn">
        <input type="button" class="btn btn-danger" onclick="javascript:loadSearchResult()" value = "검색">
      </div>
    </div> 
  </form>
  <div align = right>
      <input type="checkbox" class="filter" id="chk_duedate" name="due" value="FALSE" onclick="javascript:filterResult(this)"/>
		마감일순 보기
  </div>
</div>

<!-- MODAL TASK -->

<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog" style="margin:55px auto;">
		<div class="modal-content" id="taskViewArea">
			<!-- <div class="modal-header" style="padding:35px 50px;">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<h4><span class="glyphicon glyphicon-lock"></span> Login</h4>
			</div>
			<div class="modal-body" style="padding:40px 50px;">
				<form role="form">
					<div class="form-group">
						<label for="usrname"><span class="glyphicon glyphicon-user"></span> Username</label>
						<input type="text" class="form-control" id="usrname" placeholder="Enter email">
					</div>
					<div class="form-group">
						<label for="psw"><span class="glyphicon glyphicon-eye-open"></span> Password</label>
						<input type="text" class="form-control" id="psw" placeholder="Enter password">
					</div>
					<div class="checkbox">
						<label><input type="checkbox" value="" checked>Remember me</label>
					</div>
				    <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> Login</button>
				</form>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
				<p>Not a member?<a href="#">Sign Up</a></p>
				<p>Forgot <a href="#">Password?</a></p>
			</div> -->
		</div> 
	</div>

</div>
<!-- 보드 -->
<div id="work_board">
	
</div>

<!-- 참조 보드 -->
<div id="content_ref">
	
</div>

<!-- Modal창으로 회원정보수정 출력 -->
<div id="updateMember" class="w3-modal">
	<div class="w3-modal-content w3-animate-top w3-card-4" style = "max-width:550px">
		<header class="w3-container w3-teal">
			<span onclick="javascript:clickcancel()" class="w3-button w3-display-topright">&times;</span>
			<h3>회원정보 수정</h3>
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











</body>
<script>
$(document).ready(function(){
  // Add smooth scrolling to all links in navbar + footer link
  $(".navbar a, footer a[href='#myPage']").on('click', function(event) {
    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 900, function(){
   
        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;
      });
    } // End if
  });
  
  $(window).scroll(function() {
    $(".slideanim").each(function(){
      var pos = $(this).offset().top;

      var winTop = $(window).scrollTop();
        if (pos < winTop + 600) {
          $(this).addClass("slide");
        }
    });
  });
})

// 회원정보수정 캔슬클릭시
function clickcancel() {
	document.getElementById('id01').style.display='none';
	window.location.reload();
}
</script>


</html>
