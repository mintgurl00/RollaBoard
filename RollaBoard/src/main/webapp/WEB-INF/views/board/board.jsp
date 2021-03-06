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


<style>
.glyphicon.glyphicon-cog {
	font-size:20px;
	margin-left:10px;
}

.glyphicon.glyphicon-cog:hover {
	color:orange;
}


@media (max-width:768px) {
	body .myclass ul .refref {
		display:none;
	}
}


</style>
<script src="js/board.js"></script>


<script type = "text/javascript" language = "javascript">

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
	//alert($('#keyword').val());
	var filter = getFilter() ;
	$('#work_board').load("searchresult.do", {
		board_id: '<%=boardVO.getId() %>',
		keyword:$('#keyword').val(),
		filter: filter
	});
	//alert();
	
	$('#written_keyword').attr('value', $('#keyword').val() ) ;
	return false ;
}

function inputEnterToSearch(){
	$('#keyword').keypress( function(e){
		if( e.keyCode == 13 ){
			loadSearchResult();
			return false;
		}
	});
}

/*
 * 필터 결과
 */

function filterResult( obj ){	// 필터버튼 클릭
	//alert( obj.name + ' : ' + obj.value ) ;
	// 01 필터 버튼에 값 설정
	if( obj.value == 'FALSE' )
		obj.value = 'TRUE' ;
	else
		obj.value = 'FALSE' ;
	
	//doOpenCheck();
	
	// 02 전체 필터버튼의 값 확인해서 전달 필터 String 작성
	//alert( obj.name + ' : ' + obj.value ) ;
	var filter = getFilter() ;
	//alert( '필터스트링 : ' + filter ) ;
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
			filterString += $( this ).prop( "name" ) + " " ; //filterString에는 선택된 checkBox의 name이 저장됨 ex) due, priority, due priority
	} ) ;
	return filterString
}

//체크박스 하나만 선택되게
/* function doOpenCheck(chk) {
	var obj = document.getElementByName("task_filter");
	for (var i = 0; i < obj.length, i++) {
		if (obj[i] ! = chk) {
			obj[i].checked = false;
		}
	}
} */

/*
 * 참조 보드 부르기
 */
 
 //참조보드 선택 시 부르기 .수민
$(document).ready(function() {
	 $('#ref_board_select').change(function() {
		 var ref_board_id = $(this).val();
		 
		 $("#content_ref").load("referenceboard.do", {
				board_id: '<%=boardVO.getId() %>',
				ref_board_id:ref_board_id,
				keyword:''
		 }) ;
		 $("#myModal2").modal();
	 });
 });
 

</script>
</head>
<body>
	<nav style = "background-color:#1294AB; color: #fff !important; font-family: Montserrat, sans-serif; position:absolute; padding-top:0px;">
	<div class="container-fluid" style = "background-color:#1294AB; background-color:rgba{0,0,0,0.5};"> 
		<div class = "navbar-header" style="padding-top:1px; height:25px">
			<a style = "color: #fff; padding-top:1px" class="navbar-brand" href="./dashboard.do" >ROLLA<br>BOARD</a>

			<font size = "5px" color = "white"><%=boardVO.getName() %></font>
			
			<% if (id.equals(boardVO.getAdmin())) {%>
			<a style = "color: #fff; cursor:pointer" onClick="document.getElementById('boardSetting').submit()" style="cursor: pointer"><span class="glyphicon glyphicon-cog"></span></a>
			<form id="boardSetting" action="updateboard.do" method="post" style="margin-top: 5px;" hidden>
				<input type="hidden" name="id" value="<%=boardVO.getId()%>">
				<input type="hidden" name="name" value="<%=boardVO.getName()%>">
				<input type="hidden" name="admin" value="<%=boardVO.getAdmin()%>">
				<input type="hidden" name="visibility" value="<%=boardVO.getVisibility()%>">
				<input type="hidden" name="chkVal" value="role">
			</form>
			<% } %>
			

		</div>
		<div class = "myclass">
			<ul class="nav navbar-nav navbar-right" style="background-color:#1294AB; padding-bottom:10px;">			
				<li class = "refref"> 
					<a style = "color:#fff; cursor:pointer">
					<!-- 참조 보드 선택 -->
					<div class = "selectBox02" style="background-color:#1294AB">
					<input type="hidden" id="current_ref_board" value="-1" /> 
					<span style = "color: #fff; cursor:pointer" class = "glyphicon glyphicon-folder-open"></span>				
						<select id="ref_board_select">
							<option value="-1"></option>
						</select>
					</div>
					</a>
				</li>
				<li>
					<a align = "left" style = "color: #fff; cursor:pointer" onClick="document.getElementById('updateMember').style.display='block'"><span class="glyphicon glyphicon-user"></span></a>
				</li>
				<li>
					<a style = "color: #fff; cursor:pointer" href="logout.do"><span class="glyphicon glyphicon-log-out"></span></a>
				</li>
			</ul>
		</div>
	</div>
	
	
	<div style="background-color:#1294AB; height:65px;">
		<div class = "row" style="padding-top:1px"> 
	
			<div style = "padding-right:30px;">
				<div class="input-group form" style = " font-family: Montserrat, sans-serif;margin-bottom:7px" align=right>		
					<input type="text" name="keyword" id="keyword" class="form-control" placeholder="검색할 TASK 입력" style="width:170px">
					<input type="hidden" name="written_keyword" id="written_keyword" value=""/>
					<input type ="hidden" name="board_id" value="<%=boardVO.getId()%>" />
					<div class="input-group-btn">
			          <button class="btn btn-default" type="button" onclick="javascript:loadSearchResult()">
			            <i class="glyphicon glyphicon-search" style = "font-size:20px"></i>
			          </button>
			        </div>
				</div> 
				<div id = "filtering" align = "right">
					<input type="checkbox" class="filter" id="chk_duedate" name="due" value="FALSE" onclick="javascript:filterResult(this)"/>
					<span>마감일순 </span>
					<input type="checkbox" class="filter" id="chk_priority" name="priority" value="FALSE" onclick="javascript:filterResult(this)"/>
					<span>중요도순 </span>
					<input type="checkbox" class="filter" id="chk_connection" name="connection" value="FALSE" onclick="javascript:filterResult(this)"/>
					<span>관계 보기</span>
					<!-- <a href="./chattest.so">채팅테스트ㅜ</a> -->
				</div>
			</div>
		</div>
	</div>
	</nav>
	

<!-- MODAL TASK -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog" style="margin:55px auto;">
		<div class="modal-content" id="taskViewArea">
		</div> 
	</div>
</div>

<!-- MODAL 참조보드 -->
<div class="modal fade" id="myModal2" role="dialog">
	<div class="modal-dialog" style="margin:55px auto; width:90%">
		<div align=right style="margin-bottom:10px">
		<button type="button" class="btn btn-default" data-dismiss="modal" align=right>Close</button>
		</div>
		
		<div class="modal-content" id="content_ref" style="background-color:#1294AB;">
		</div>
	</div>
</div>

<div class="boards">
	<!-- 보드 -->
	<div id="work_board" style="background-color:#1294AB; padding-top:20px">		
	</div>
</div>

<!-- Modal창으로 회원정보수정 출력 -->
<div id="updateMember" class="w3-modal">
	<div class="w3-modal-content w3-animate-top w3-card-4" style = "max-width:550px;">
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
$(".selectBox02 select").change(function () {
	var changeTxt = $(this).find("option:selected").text();
	$(this).parent().find(".txt").text(changeTxt);
 });
$(".selectBox02 select").focus(function () {
	$(this).parent().addClass("focus");
});
$(".selectBox02 select").blur(function () {
	$(this).parent().removeClass("focus");
});

$(document).ready(function(){
  
})

// 회원정보수정 캔슬클릭시
function clickcancel() {
	document.getElementById('updateMember').style.display='none';
	window.location.reload();
}
</script>


</html>
