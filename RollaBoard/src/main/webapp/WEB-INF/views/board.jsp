<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*, com.spring.rollaboard.*" %>
    
    
<%
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
	
	<button type="submit" class="btn btn-default" name = "name">BOARD설정</button>
</form>
<%} %>
</div>

<div id="logout" align="right">
	<a href = "#" onClick = "openPop();" >회원정보 수정</a> | <a href="logout.do">logout</a>&nbsp;
</div>

<div id="ref_board">
	<select id="ref_board_select">
    	<option value="">참조 BOARD 선택</option>
    	<option value="board4">BOARD4</option>
   	 	<option value="board5">BOARD5</option>
    	<option value="board6">BOARD6</option>
	</select>
</div>

<!-- 필터와 검색 -->
<div id="filter">
	<form action="searchresult.do" method="post">
	<a href=#>관계 TASK보기</a>&nbsp;
	<a href=#>마감날짜순</a>&nbsp;
	<a href=#>시작날짜순</a>&nbsp;
	<a href=#>중요도순</a>	
	<input type="text" name="keyword" placeholder="task명을 입력하세요." />
	<input type ="hidden" name="board_id" value="<%=boardVO.getId()%>" />
	<input type="submit" value="검색" />
	</form>
</div>

<div id="content">
 아래로 내려가면 보임
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<input type="button" value="TASK생성" onclick="location.href='createtask.do';">
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
	
	<div id="section">
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
		<div id="task" onclick="location.href='./taskview.do';"><h3>TASK 이름</h3></div>
	</div>
</div>

<!-- 석원의 테스트..... 지우면 머지할 때 자꾸 Conflict 뜰거임 -->
<div id="content">
ㅎㅎㅎ
	<%
	for( int i = 0 ; i < sectionList.size() ; i++ ){
	%>
	<div id="section">
		<%=sectionList.get(i).getName() %>
		<%
		for( int j = 0 ; j < taskViewList.get( i ).size() ; j++ ){
		%>
			<div id="task" onclick="location.href='./taskview.do';">
				<h3>TASK명:<%=taskViewList.get( i ).get( j ).getName() %></h3>
				TASK내용:<%=taskViewList.get( i ).get( j ).getDescription() %><br />
				TASK_id:<%=taskViewList.get( i ).get( j ).getId() %><br />
				TASK상태:<%=taskViewList.get( i ).get( j ).getStatus() %><br />
			</div>
		<%
		}
		%>
		<input type="button" value="TASK생성" onclick="location.href='createtask.do';" />
	</div>
	<%
	}
	%>
</div>


</body>
</html>


<%

%>