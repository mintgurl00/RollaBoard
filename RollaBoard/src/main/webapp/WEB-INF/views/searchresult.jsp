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
<%
	String board_id = (String) request.getAttribute( "board_id" ) ;
	String keyword = (String) request.getAttribute( "keyword" ) ;
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
</script>
</head>
<body>

<!-- <div id="filter">
	<a href=#>관계 TASK보기</a>&nbsp;<a href=#>마감날짜순</a>&nbsp;<a href=#>시작날짜순</a>&nbsp;<a href=#>중요도순</a>
	<input type="text" name="task_name" placeholder="task명을 입력하세요."><input type="button" value="검색">
</div> -->

board_id : <%=board_id %> <br />
keyword : <%=keyword %> <br />


<!-- 결과 나오는 부분 -->

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