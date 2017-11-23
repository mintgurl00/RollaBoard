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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>board</title>
<style>
#header{float:left; width:1580px; height:70px; background-color:#B5B2FF}
#logout{float:left; width:280px; height:70px; background-color:#B5B2FF}
#ref_board{width:280px; height:50px; background-color:#DAD9FF}
#filter{float:left; width:1860px; height:50px; background-color:#DAD9FF; text-align:right}
#content{overflow:scroll; width:1880px; height:960px}
#section{float:left; width:400px; height:900px; margin-left:40px; margin-top:40px; background-color:#DAD9FF; text-align:center}
#task{width:350px; height:150px; margin-left:20px; margin-top:20px; background-color:#FFFFFF; text-align:center}

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
<body>
<div id="header">
<a href="./dashboard.do">로고</a>&nbsp;&nbsp;&nbsp;
<font size="6"><%=boardVO.getName() %></font>
<%if ( id.equals(boardVO.getAdmin()) ) {%>
<form action = "updateboard.do" method = "post">
	<input type = "hidden" name = "id" value = "<%=boardVO.getId()%>">
	<input type = "hidden" name = "name" value = "<%=boardVO.getName()%>">
	<input type = "hidden" name = "admin" value = "<%=boardVO.getAdmin()%>">
	<input type = "hidden" name = "visibility" value = "<%=boardVO.getVisibility()%>">
	<input type = "hidden" name = "chkVal" value = "role">
	<button type="submit" class="btn btn-default" name = "name">BOARD설정</button>
</form>
<%} %>
</div>

<div id="logout" align="right">
	<a href = "#" onClick = "openPop();" >회원정보 수정</a> | <a href="logout.do">logout</a>&nbsp;
</div>

<!-- 참조 보드 선택 -->
<div id="ref_board">
	<input type="hidden" id="current_ref_board" value="-1" />
	<select id="ref_board_select">
    	<option value="-1">참조 BOARD 선택</option>
	</select>
</div>

<!-- 필터와 검색 -->

<div id="filter">
	<!-- <a href=#>관계 TASK보기</a>&nbsp;
	<a href=#>마감날짜순</a>&nbsp; -->
	<input type="checkbox" class="filter" id="chk_duedate" name="due" value="FALSE" onclick="javascript:filterResult(this)"/>
	마감일 보기
	<!-- <a href=#>시작날짜순</a>&nbsp;
	<a href=#>중요도순</a>	 -->
	<input type="text" name="keyword" id="keyword" placeholder="task명을 입력하세요." value=""/>
	<input type="hidden" name="written_keyword" id="written_keyword" value=""/>
	<input type ="hidden" name="board_id" value="<%=boardVO.getId()%>" />
	<button type="button" onclick="javascript:loadSearchResult()">검색버튼2</button>
</div>


<!-- 보드 -->
<div id="content">
	
</div>

<!-- 참조 보드 -->
<div id="content_ref">
	
</div>

</body>
</html>