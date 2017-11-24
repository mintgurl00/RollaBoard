<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%@ page import="com.spring.rollaboard.section.SectionVO"%>
<%
	System.out.println("board");
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	String id = (String) session.getAttribute("id");

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
  <link href = "reset.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
#ref_board{width:280px; height:50px; background-color:#DAD9FF}
#filter{float:left; width:1860px; height:50px; background-color:#DAD9FF; text-align:right}
#content{overflow:auto; width:auto; height:auto; margin-top:0px;}
#section{overflow-x:hidden; float:left; width:300px; height:600px; margin-left:10px; margin-top:10px; background-color:#DAD9FF; text-align:center}
#task{width:260px; height:auto; margin-left:20px; margin-top:20px; background-color:#BDBDBF; text-align:center}
  
  body {
      font: 400 15px Lato, sans-serif;
      height:auto;
      line-height: 1.8;

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
      background-color: #F44336;
      color: #fff;
      padding: 40px 25px;
      font-family: Montserrat, sans-serif;
  }
  .container-fluid {
      padding: 60px 50px;
  }
  .logo-small {
      color: #F44336;
      font-size: 50px;
  }
  .logo {
      color: #F44336;
      font-size: 200px;
  }
  .navbar {
      margin-bottom: 0;
      background-color: #F44336;
      z-index: 9999;
      border: 0;
      font-size: 12px !important;
      line-height: 1.42857143 !important;
      letter-spacing: 4px;
      border-radius: 0;
      font-family: Montserrat, sans-serif;
  }
  .navbar li a, .navbar .navbar-brand {
      color: #fff !important;
  }
  .navbar-nav li a:hover, .navbar-nav li.active a {
      color: #F44336 !important;
      background-color: #fff !important;
  }
  .navbar-default .navbar-toggle {
      border-color: transparent;
      color: #fff !important;
  }
  footer .glyphicon {
      font-size: 20px;
      margin-bottom: 20px;
      color: #F44336;
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
  @media screen and (max-width: 480px) {
    .logo {
        font-size: 150px;
    }
  }
  </style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
	$('#content').load("searchresult.do", {
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
	$('#content').load("searchresult.do", {
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
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="./dashboard.do">ROLLABOARD</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <%if ( id.equals(boardVO.getAdmin()) ) {%>
        <li>
        <a onClick = "document.getElementById('boardSetting').submit()" style = "cursor:pointer">BOARD 설정</a>
        <form id = "boardSetting" action = "updateboard.do" method = "post" style = "margin-top:5px;">
			<input type = "hidden" name = "id" value = "<%=boardVO.getId()%>">
			<input type = "hidden" name = "name" value = "<%=boardVO.getName()%>">
			<input type = "hidden" name = "admin" value = "<%=boardVO.getAdmin()%>">
			<input type = "hidden" name = "visibility" value = "<%=boardVO.getVisibility()%>">
			<input type = "hidden" name = "chkVal" value = "role">
		</form>
		</li>
		<%} %>
        <li>
        <!-- 참조 보드 선택 -->
	<div >
	<input type="hidden" id="current_ref_board" value="-1" />
	<select id="ref_board_select">
    	<option value="-1">참조 BOARD 선택</option>
	</select>
	</div>
		</li>
        <li><a onClick = "openPop();" style = "cursor:pointer" >회원정보수정</a></li>
        <li><a href="logout.do">LOGOUT</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="jumbotron text-center">
  <h3><%=boardVO.getName() %></h3>  
  <form>
    <div class="input-group" >
      	<input type="text" name="keyword" id="keyword" class="form-control" size="50" placeholder="검색할 TASK 입력">
      	<input type="hidden" name="written_keyword" id="written_keyword" value=""/>
		<input type ="hidden" name="board_id" value="<%=boardVO.getId()%>" />
      <div class="input-group-btn">
        <button type="button" class="btn btn-danger" onclick="javascript:loadSearchResult()">검색</button>
      </div>
    </div> 
  </form>
  <div align = right>
      <input type="checkbox" class="filter" id="chk_duedate" name="due" value="FALSE" onclick="javascript:filterResult(this)"/>
		마감일순 보기
  </div>
</div>

<!-- 보드 -->
<div id="content">
	
</div>

<!-- 참조 보드 -->
<div id="content_ref">
	
</div>

<footer class="container-fluid text-center">
  <a href="#myPage" title="To Top">
    <span class="glyphicon glyphicon-chevron-up"></span>
  </a>
  <div class="w3-light-grey w3-container w3-padding-32" style="margin-top:75px;padding-right:58px"><p class="w3-right"><b>Rollaboard</b> all rights reserved </p></div>
</footer>

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
</script>

</body>
</html>
