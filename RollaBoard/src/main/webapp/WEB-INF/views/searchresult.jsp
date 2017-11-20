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
	
	ArrayList<ArrayList<TaskVO>> taskViewList = (ArrayList<ArrayList<TaskVO>>) request.getAttribute( "taskViewList" ) ;
	ArrayList<SectionVO> sectionList = (ArrayList<SectionVO>) request.getAttribute( "sectionList" ) ; 
	
%>
<%
	String board_id = (String) request.getAttribute( "board_id" ) ;
	String keyword = (String) request.getAttribute( "keyword" ) ;
%>

<!-- 
board_id : <%=board_id %> <br />
keyword : <%=keyword %> <br />
 -->


<!-- 결과 나오는 부분 -->
<%
if( keyword == "" ){ %>
<%
	
}%>
<%
if( sectionList.size() == 0) {	// 태스크가 없을 때
	if( keyword != "" ){	// 검색 결과라면
	%>
		<%=keyword %>에 대한 검색 결과가 없습니다.
	<%
	}else{%>
		새 태스크를 만들어보세요.<br />
		디폴트 섹션과 태스크 추가 버튼을 만들어 두자.
	<%
	}
}else{	// 태스크가 있을 때
	if( keyword != "" ){	// 검색 결과라면
	%>
		<%=keyword %>에 대한 검색 결과입니다.
	<%
	}
}%>

<!-- 본격적으로 표시 -->

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
