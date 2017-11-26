<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%@ page import="com.spring.rollaboard.section.SectionVO"%>
<%@ page import="com.spring.rollaboard.role.RoleVO"%>
<%@ page import="com.spring.rollaboard.role.RoleAndTaskVO"%>

<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	String id = (String) session.getAttribute("id");
	BoardVO boardVO = (BoardVO) request.getAttribute("boardVO");
	ArrayList<ArrayList<TaskVO>> taskViewList = (ArrayList<ArrayList<TaskVO>>) request.getAttribute( "taskViewList" ) ;
	ArrayList<SectionVO> sectionList = (ArrayList<SectionVO>) request.getAttribute( "sectionList" ) ; 
	ArrayList<ArrayList<ArrayList<RoleAndTaskVO>>> roleAndTaskList = 
			(ArrayList<ArrayList<ArrayList<RoleAndTaskVO>>>) request.getAttribute( "roleAndTaskList" ) ;
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
if( sectionList.size() == 0) {	// 태스크가 없을 때
	if( ! keyword.equals( "" ) ){	// 검색 결과라면
	%>
		<%=keyword %>에 대한 검색 결과가 없습니다.
	<%
	}else{%>
		새 태스크를 만들어보세요.<br />
		디폴트 섹션과 태스크 추가 버튼을 만들어 두자.
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

<!-- 글자수제한 스크립트 -->
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  <script src = "js/rolelist.js"></script>

<!-- TASK클릭 시 함수 -->
<script>
function clicktask(id) {
	window.open("./taskview.do?task_id=" + id,
			"TASK",
			"resizeable = yes, menubar=no, width = 470, height = 800, left = 10, right = 10");

}

</script>

<div id="section" class="input-group" >
	<!-- 섹션 표시줄 -->
	<h4><%=sectionList.get(i).getName() %></h4>
	<%if ( id.equals(boardVO.getAdmin()) ) {%>
	<form action="updatesectioninboard.do">
		<input type="hidden" name="section_id" 	value="<%=sectionList.get(i).getId() %>" />
		<input type="text" name="section_name"  class="byteLimit form-control" limitbyte="30" value="<%=sectionList.get(i).getName() %>" placeholder = "SECTION명을 입력하세요." />
		<input type="submit" value="수정" class="btn btn-default" />
	</form>
	<form action="deletesectioninboard.do">
		<input type="hidden" name="section_id" value="<%=sectionList.get(i).getId() %>" />
		<input type="submit" value="삭제" class="btn btn-default"/>
	</form>
	<%} %>
	<!-- 태스크 표시 -->
	<%
	for( int j = 0 ; j < taskViewList.get( i ).size() ; j++ ){
	%>

		<div id="task" method = "post" onclick="javascript:clicktask('<%=taskViewList.get( i ).get( j ).getId() %>')" style="cursor:pointer">

			<h3><%=taskViewList.get( i ).get( j ).getName() %></h3>
			내용:<%=taskViewList.get( i ).get( j ).getDescription() %><br />
			STATUS:<%=taskViewList.get( i ).get( j ).getStatus() %><br />
			
			<%
			if( roleAndTaskList.get( i ).get( j ) != null && roleAndTaskList.get( i ).get( j ).size() > 0 ){ %>
				<b>ROLE</b><br />
				<%
				for( int k = 0 ; k < roleAndTaskList.get( i ).get( j ).size() ; k++ ){%>
					<b><%=roleAndTaskList.get( i ).get( j ).get( k ).getRoleName() %> : </b>
					<%=roleAndTaskList.get( i ).get( j ).get( k ).getMemName() %>
					<br/>
				<%
				}%>
				
			<%
			}%>
			<div id="id01" class="w3-modal">
		    <div class="w3-modal-content">
		      <div class="w3-container">
		        <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-display-topright">&times;</span>
		        <p>Some text. Some text. Some text.</p>
		        <p>Some text. Some text. Some text.</p>
		      </div>
		    </div>
		  </div>
		</div>
	<%
	} %>
	
	<!-- 새 태스크 추가 -->
	<br /><br />
	<form action ="createtask.do" method = "post" >

		<input type="hidden" name="section_id" value = "<%=sectionList.get(i).getId() %>" required></input>
		<%-- <input type="hidden" name="task_id" value = "<%= %>" required></input> --%>
		
		<input type="submit" class = "btn btn-default" value="TASK생성"  ></input>	
	    
	</form>
	
	<%-- <form action="taskview.do">
		<input type="text" name="task_id" value="<%=taskViewList.get(i).getId() %>" />
		<input type="text" name="task_name" value="<%=taskViewList.get(i).getName() %>" placeholder = "SECTION명을 입력하세요." />
		<input type="submit" value="수정" />
	</form> --%>

</div>

<%
}
%>

<%
if( keyword.equals( "" ) ){	// 검색 결과가 *아니*라면
%>
	<br/>
	<div>
	<button type="button" class = "btn btn-info" onclick="location.href='createsectioninboard.do';">추가+</button>
	</div>
<% 
}%>