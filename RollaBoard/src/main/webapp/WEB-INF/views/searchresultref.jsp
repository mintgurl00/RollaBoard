<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*, com.spring.rollaboard.*" %>
    
    
<%
/* 	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	String id = (String) session.getAttribute("id");
*/
	 
	System.out.println("searchresultref.jsp") ;	
	ArrayList<ArrayList<TaskVO>> taskViewList = (ArrayList<ArrayList<TaskVO>>) request.getAttribute( "taskViewListR" ) ;
	ArrayList<SectionVO> sectionList = (ArrayList<SectionVO>) request.getAttribute( "sectionListR" ) ; 

%>
<%
	String board_id = (String) request.getAttribute( "board_idR" ) ;
	String keyword = (String) request.getAttribute( "keywordR" ) ;
%>

<!-- 
board_id : <%=board_id %> <br />
keyword : <%=keyword %> <br />
 -->


<!-- 결과 나오는 부분 -->

<%
if( sectionList.size() == 0) {	// 태스크가 없을 때
	if( ! keyword.equals( "" ) ){	// 검색 결과라면
	%>
		<%=keyword %>에 대한 검색 결과가 없습니다.
	<%
	}else{%>
		새 태스크를 만들어보세요.<br />
	<%
	}
}else{	// 태스크가 있을 때
	if( ! keyword.equals( "" ) ){	// 검색 결과라면
	%>
		<%=keyword %>에 대한 검색 결과입니다.
	<%
	}
}%>

<!-- 본격적으로 표시 -->
<%
int sectionSize = sectionList.size() ;
%>
<%
for( int i = 0 ; i < sectionSize ; i++ ){
%>

<div id="section">
	<!-- 섹션 표시줄 -->
	<%=sectionList.get(i).getName() %>
	<br />
<%-- 	<form action="updatesectioninboard.do">
		<input type="hidden" name="section_id" value="<%=sectionList.get(i).getId() %>" />
		<input type="text" name="section_name" value="<%=sectionList.get(i).getName() %>" placeholder = "SECTION명을 입력하세요." />
		<input type="submit" value="수정" />
	</form>
	<form action="deletesectioninboard.do">
		<input type="hidden" name="section_id" value="<%=sectionList.get(i).getId() %>" />
		<input type="submit" value="삭제" />
	</form> --%>
	
	<!-- 태스크 표시 -->
	<%
	for( int j = 0 ; j < taskViewList.get( i ).size() ; j++ ){
	%>
		<div id="task" method = "post" onclick="location.href='./taskview.do?task_id=<%=taskViewList.get( i ).get( j ).getId() %>';" style="cursor:pointer">
			<h3>TASK명:<%=taskViewList.get( i ).get( j ).getName() %></h3>
			TASK내용:<%=taskViewList.get( i ).get( j ).getDescription() %><br />
			TASK_id:<%=taskViewList.get( i ).get( j ).getId() %><br />
			TASK상태:<%=taskViewList.get( i ).get( j ).getStatus() %><br />
		</div>
	<%
	} %>
	
	<!-- 새 태스크 추가 -->
	<%-- <br /><br />
	<form action ="createtask.do" method = "post" >

		<input type="hidden" name="section_id" value = "<%=sectionList.get(i).getId() %>" required></input>
		<input type="submit" value="TASK생성"  ></input>
		
	    
	</form> --%>
	

</div>

<%
}
%>
