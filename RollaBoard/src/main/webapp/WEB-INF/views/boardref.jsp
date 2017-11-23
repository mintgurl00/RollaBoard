<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.section.SectionVO"%>

    
    
<%
	System.out.println("boardref");
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	String id = (String) session.getAttribute("id");
	
	String boardIdR = (String) request.getAttribute( "ref_board_id" ) ;
	
	ArrayList<ArrayList<TaskVO>> taskViewList = (ArrayList<ArrayList<TaskVO>>) request.getAttribute( "taskViewList" ) ;
	ArrayList<SectionVO> sectionList = (ArrayList<SectionVO>) request.getAttribute( "sectionList" ) ; 
%>

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
$("#contentR").ready( function(){
	alert() ;
	initBoardR();
	inputEnterToSearch();
	$( "#ref_board" ).click( function(){showRefBoard()} ) ;
}) ;

/*
 * 보드 그리기 
 */
function initBoardR() {
	$('#contentR').load("searchresultref.do", {
		board_idR: '<%=boardIdR %>',
		keywordR:''
	});
}

/*
 * 검색 결과
 */
function loadSearchResultR() {
	var filter = getFilter() ;
	$('#contentR').load("searchresult.do", {
		board_idR: '<%=boardIdR %>',
		keywordR:$('#keyword').val(),
		filterR: filter
	});
	
	$('#written_keywordR').attr('value', $('#keywordR').val() ) ;
	return false ;
}

function inputEnterToSearchR(){
	$('#keyword').keypress( function(e){
		if( e.keyCode == 13 ){
			loadSearchResult();
		}
	});
}

/*
 * 필터 결과
 */

function filterResultR( obj ){	// 필터버튼 클릭
	/* alert( obj.name + ' : ' + obj.value ) ; */
	// 01 필터 버튼에 값 설정
	if( obj.value == 'FALSE' )
		obj.value = 'TRUE' ;
	else
		obj.value = 'FALSE' ;
	// 02 전체 필터버튼의 값 확인해서 전달 필터 String 작성
	/* alert( obj.name + ' : ' + obj.value ) ; */
	var filter = getFilterR() ;
	/* alert( '필터스트링 : ' + filter ) ; */
	// 03 페이지 로드
	$('#contentR').load("searchresultref.do", {
		board_id: '<%=boardIdR %>',
		keyword:$('#written_keyword').val(),
		filter: filter
	});
}
function getFilterR(){
	var filterString = "" ;
	$( ".filterR" ).each( function(){
/* 		alert( '필터' + $( this ).prop( "name" ) ) ; */
		if( $( this ).val() == 'TRUE' )
			filterString += $( this ).prop( "name" ) + " " ;
	} ) ;
	return filterString ;
}


</script>



<!-- 필터와 검색 -->

<div id="filterR">
	<!-- <a href=#>관계 TASK보기</a>&nbsp;
	<a href=#>마감날짜순</a>&nbsp; -->
	<input type="checkbox" class="filterR" id="chk_duedate" name="due" value="FALSE" onclick="javascript:filterResultR(this)"/>
	마감일 보기
	<!-- <a href=#>시작날짜순</a>&nbsp;
	<a href=#>중요도순</a>	 -->
	<input type="text" name="keywordR" id="keywordR" placeholder="task명을 입력하세요." value=""/>
	<input type="hidden" name="written_keywordR" id="written_keywordR" value=""/>
	<input type ="hidden" name="ref_board_id" value="<%=boardIdR%>" />
	<button type="button" onclick="javascript:loadSearchResultR()">검색버튼2</button>
</div>

참조보드 막 나오게 하기
<!-- 보드 -->
<div id="contentR">
	
</div>

