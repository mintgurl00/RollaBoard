<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%@ page import="com.spring.rollaboard.section.SectionVO"%>
<%@ page import="com.spring.rollaboard.role.RoleVO"%>
<%@ page import="com.spring.rollaboard.role.RoleAndTaskVO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
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
	
	String board_id = (String) request.getAttribute( "board_id" ) ;
	String keyword = (String) request.getAttribute( "keyword" ) ;
	Date dt = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("M/dd"); 
%>

<!-- 
board_id : <%=board_id %> <br />
keyword : <%=keyword %> <br />
 -->


<!-- TASK클릭 시 함수 -->
<script>
function clicktaskinBoard(id) {/* 
	window.open("./taskview.do?task_id=" + id,
			"TASK",
			"resizeable = yes, menubar=no, width = 470, height = 800, left = 10, right = 10"); */
	$("#taskViewArea").load("taskview.do",{
		task_id:id
	});
	$("#myModal").modal();
}
function updatesectioninboard(cnt) {
	document.getElementById("updatesectioninboard" + cnt).submit();
}

function deletesectioninboard(cnt) {
	document.getElementById("deletesectioninboard" + cnt).submit();
}

</script>

<script>
function flip(cnt) {
	if( $('.nameview' + cnt).css("display") == "none") {
		$('.nameview' + cnt).css("display", "block");
		
	} 
	if( $('.origin' + cnt).css("display") == "none") {
		$('.origin' + cnt).css("display", "block");
	} else {
		$('.origin' + cnt).css("display", "none" );
	}
}
function createTask(cnt) {
	document.getElementById('modalCreate' + cnt).style.display='block';
}
// TASK생성 캔슬클릭시
function clickModalcancel(cnt) {
	document.getElementById('modalCreate' + cnt).style.display='none';
	// window.location.reload();
}
</script>

<style>
.fa.fa-plus-circle {
	font-size: 30px;
	color: #ABABAB;
	padding:20px;
}

.fa.fa-plus-circle:hover {
	color: black;
}



</style>
<link href="css/task.css" rel="stylesheet" type="text/css" >
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/reset.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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

<div class="w3-animate-left">
<div id="section" style="text-align:left">
	<!-- 섹션 표시줄 -->
	<div class = "row origin<%=sectionList.get(i).getId() %>" style = "display:block; cursor:pointer" <%if ( id.equals(boardVO.getAdmin()) ) {%> onclick = "javascript:flip(<%=sectionList.get(i).getId() %>)" <%} %>>
		<div style="padding-top:10px; padding-left:30px; padding-bottom:15px" onMouseover="this.style.color='#1294AB';" onMouseout="this.style.color='black';">
			<h5><b><%=sectionList.get(i).getName() %></b></h5>
		</div>
	</div>
	<%if ( id.equals(boardVO.getAdmin()) ) {%>
		<div class = "row nameview<%=sectionList.get(i).getId() %>" style = "display:none">
			<div class = "col-xs-offset-1 col-xs-5">
				<form id = "updatesectioninboard<%=sectionList.get(i).getId() %>" action="updatesectioninboard.do">
					<input type="hidden" name="section_id" 	value="<%=sectionList.get(i).getId() %>" />
					<input type="text" name="section_name"  class="byteLimit form-control" limitbyte="30" value="<%=sectionList.get(i).getName() %>" placeholder = "SECTION명을 입력하세요." required/>		
				</form>	
			</div>
	
			<input type="button" onclick = "javascript:updatesectioninboard(<%=sectionList.get(i).getId() %>)" value="수정" class="btn btn-default" />
			<input type="button" onclick = "javascript:deletesectioninboard(<%=sectionList.get(i).getId() %>)" value="삭제" class="btn btn-default"/>
	
		</div>
		<div style = "display:none">
		<form id = "deletesectioninboard<%=sectionList.get(i).getId() %>" action="deletesectioninboard.do">
			<input type="hidden" name="section_id" value="<%=sectionList.get(i).getId() %>" />	
		</form>
		</div>
	<%} %>
	<!-- 태스크 표시 -->
	<%
	for( int j = 0 ; j < taskViewList.get( i ).size() ; j++ ){
		String status = taskViewList.get( i ).get( j ).getStatus();	// 태스크 상태
	%>
		<div method ="post" 
		class="task <%=status %>" 
		onclick="javascript:clicktaskinBoard('<%=taskViewList.get( i ).get( j ).getId() %>')">

			<div class="task_title" style="text-align:left;">
				<span style = "font-family: Montserrat, sans-serif; font-size:15">
					<b><%=taskViewList.get( i ).get( j ).getName() %></b>&nbsp;
					<small style="text-align:right"><%=sdf.format(taskViewList.get( i ).get( j ).getDue_date()) %></small>
				</span>
			</div>
			
			<!-- 롤 표시 -->
			<%
			if( roleAndTaskList.get( i ).get( j ) != null && roleAndTaskList.get( i ).get( j ).size() > 0 ){ %>
				<div class="allocated_area">
				<div align = "left">
				<%
				for( int k = 0 ; k < roleAndTaskList.get( i ).get( j ).size() ; k++ ){%>
					<span class="badge role_badge">
						<b><%=roleAndTaskList.get( i ).get( j ).get( k ).getRoleName() %> : </b>
						<%=roleAndTaskList.get( i ).get( j ).get( k ).getMemName() %>
						<br/>
					</span>
					<br/>
				<%
				}%>
				</div>
				</div>
			<%
			}%>
			
			<!-- 상태 표시 -->
			<%
			
			if( status.equals("BLOCKED")){%>
				<div class="task_status_blocked" style="margin-top:10px">
					BLOCKED <i class="fa fa-lock" aria-hidden="true"></i>
				</div>				
				<%
			}else if( status.equals("COMPLETE") ){%>
				<div class="task_status_complete" style="margin-top:10px">
					COMPLETE <i class="fa fa-check" aria-hidden="true"></i>
				</div>
				<%
			}
			%>
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
	<br />
	<div id = "letsMakeTask" >

		<input type="hidden" name="section_id" value = "<%=sectionList.get(i).getId() %>" required></input>
		<%-- <input type="hidden" name="task_id" value = "<%= %>" required></input> --%>
		
		<div style="text-align:center">
			<a href="javascript:createTask(<%=sectionList.get(i).getId()%>)"><i class="fa fa-plus-circle" aria-hidden="true"></i></a>	
		</div>
		
	    
	</div>
	<!-- Modal창으로 새로운 TASK생성 -->
	<div id="modalCreate<%=sectionList.get(i).getId()%>" class="w3-modal">
		<div class="w3-modal-content w3-animate-top w3-card-4" style = "max-width:550px">
			<header class="w3-container w3-teal">
				<span onclick="javascript:clickModalcancel('<%=sectionList.get(i).getId()%>')" class="w3-button w3-display-topright">&times;</span>
				<h3>TASK in <%=sectionList.get(i).getName() %></h3>
				<p>TASK 생성 후에 수정을 통해 필요한 작업들을 추가로 진행하세요!</p>
			</header>
			<div class="w3-section">
			<form class="w3-container" action="inserttask.do" method = "post">			
					<input type="hidden" id="section_id" name="section_id" value = <%=sectionList.get(i).getId() %> size="40">
					<input type="hidden" name="status" value="NORMAL" />
					<label>TASK 제목:</label>
					<input type="text" id="name" placeholder="TASK 제목을 입력하시오." class = "w3-input w3-border w3-margin-bottom byteLimit" limitbyte="30"  name="name" required>
					<input type="hidden" maxlength="100" id="description" class="byteLimit" limitbyte="100" name="description" >								     
					<input type="date" id="start_date" placeholder="yyyy-mm-dd" class = "w3-input w3-border w3-margin-bottom" name ="start_date" value = "<%=sdf.format(dt).toString()%>" style = "display:none">       
					<input type="date" id="due_date" placeholder="yyyy-mm-dd" class = "w3-input w3-border w3-margin-bottom" name = "due_date" value = "<%=sdf.format(dt).toString()%>" style = "display:none">
					<input type="date" id="cre_date" placeholder="yyyy-mm-dd" class = "w3-input w3-border w3-margin-bottom" name = "cre_date" value = "<%=sdf.format(dt).toString()%>" style = "display:none">
					<input type="hidden" id="priority" placeholder="1~5중에 하나를 입력해주세요" class = "w3-input w3-border w3-margin-bottom" name="priority" value = "3">
					<label>위치정보:</label>
					<input type="text" id="location" placeholder="ex)서울시 서초구 잠원동" class = "w3-input w3-border w3-margin-bottom" name="location">
					<button type="submit" class="w3-button w3-block w3-green w3-section w3-padding"  style="background-color: green"><b>생성하기</b></button>
					<button onclick="javascript:clickModalcancel('<%=sectionList.get(i).getId()%>')" type="button" class = "w3-button w3-block w3-red"><b>취소</b></button>			
			</form>
			</div>
		</div>
	</div>

</div>
</div>

<%
}
%>
<%
if( keyword.equals( "" ) ){	// 검색 결과가 *아니*라면
	if ( id.equals(boardVO.getAdmin()) ) {%>
		<div id="newsection">			
			<a href="createsectioninboard.do"><i class="fa fa-plus-circle" aria-hidden="true"></i></a>
		</div>
<%	} 
}%>