<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.task.TaskVOLite"%>
<%@ page import="com.spring.rollaboard.role.RoleVO"%>
<%@ page import="com.spring.rollaboard.task.RefTaskVO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}

TaskVO taskVO = (TaskVO) request.getAttribute("taskVO");
ArrayList<RoleVO> roleList = (ArrayList<RoleVO>) request.getAttribute("roleList");
ArrayList<RoleVO> allocatedRole = (ArrayList<RoleVO>) request.getAttribute("allocatedRole");
ArrayList<TaskVOLite> taskIdList = (ArrayList<TaskVOLite>) request.getAttribute("taskIdList");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


// 관계 태스크 보여주기 위한 기능
RefTaskVO preTaskVO = null, postTaskVO = null ;
preTaskVO = (RefTaskVO) request.getAttribute("preTaskVO");
postTaskVO = (RefTaskVO) request.getAttribute("postTaskVO");

String preTaskName = "", postTaskName = "" ;
if( preTaskVO != null )
	preTaskName = preTaskVO.getRefTaskName();
if( postTaskVO != null )
	postTaskName = postTaskVO.getRefTaskName();

if (taskVO.getDescription() == null) {
	taskVO.setDescription("");
}
if (taskVO.getLocation() == null) {
	taskVO.setLocation("");
}

%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
@media (min-width:768px) {
	#frame{position:absolute; padding:10px; border-radius:4px; width:600px;height:695px; overflow:auto; background-color:whitesmoke; margin-right: 10px; text-align:center} 
	#content{border-radius:4px; width:500px; height:120px; background-color:#FFFFFF;text-align:left}
	#button{margin-top:20px}
}
@media (max-width:768px) {
  	#frame{position:absolute; padding:10px; border-radius:6px; width:300px;height:695px; overflow:auto; background-color:whitesmoke; margin-left: 9px; text-align:center; box-shadow: 1px 1px 5px #000; }
  	#content{border-radius:4px; width:250px; height:120px; background-color:#FFFFFF; margin-left:50px;text-align:left}
  	#completeArea{margin-left:185px;}
}
</style>

<!-- 테스크 제목, 설명 입력 바이트 수 제한 --> 
 <script>
   $(document).ready( function() {
       //글자 byte 수 제한
       $('.byteLimit').blur(function(){
                         
           var thisObject = $(this);
             
           var limit = thisObject.attr("limitbyte"); //제한byte를 가져온다.
           var str = thisObject.val();
           var strLength = 0;
           var strTitle = "";
           var strPiece = "";
           var check = false;
                     
           for (i = 0; i < str.length; i++){
               var code = str.charCodeAt(i);
               var ch = str.substr(i,1).toUpperCase();
               //체크 하는 문자를 저장
               strPiece = str.substr(i,1)
                 
               code = parseInt(code);
                 
               if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0)) ){
                   strLength = strLength + 3; //UTF-8 3byte 로 계산
               }else{
                   strLength = strLength + 1;
               }
                 
               if(strLength>limit){ //제한 길이 확인
                   check = true;
                   break;
               }else{
                   strTitle = strTitle+strPiece; //제한길이 보다 작으면 자른 문자를 붙여준다.
               }
                 
           }
             
           if(check){
               alert(limit+"byte 초과된 문자는 잘려서 입력 됩니다.");
           }
             
           thisObject.val(strTitle);
             
       });
       
       $(".checkDiff > input").blur(function(){
       	var oldVal = $(this).parent().children("input[type='hidden']").val() ;
       	var newVal = $(this).parent().children("input[type='text']").val() ;
       	if(oldVal!=newVal){
       		$(this).css("background-color", "#ff0000");
       	}else{
       		$(this).css("background-color", "#ffffff");
       	}
       });
   });
     
 </script>
<script>
// 수정 확인 버튼 클릭
function updating() {
	document.getElementById("updateTask").submit();
}
</script>

<div id="frame">
<form id = "updateTask" action = "updatetask.do">
	<input type="hidden" id="id" name="id" value = <%=taskVO.getId() %> >
	<input type="hidden" id="section_id" name="section_id" value = <%=taskVO.getSection_id() %> >
	<h2><b>TASK 수정</b></h2>
	<table class="table" style = "font-family: Montserrat, sans-serif; font-size:14px;">
	<tr>
		<th><font style = "font-family:Montserrat, sans-serif;">제목</font></th>
		<th>
			<input type = "text" id="taskname" name="name" placeholder="TASK 이름을 입력하세요" class="byteLimit" limitbyte="30" value = "<%=taskVO.getName()%>">
		</th>
	</tr>
	</table>
	<hr/>
	<div style = "font-family: Montserrat, sans-serif;" align = "center">
		<font style = "font-family:Montserrat, sans-serif;">
			<textarea id="content" name="description" class="byteLimit" limitbyte="100" placeholder = "내용 입력" style = "resize:none;margin-left:20px;"><%=taskVO.getDescription()%></textarea>
		</font> 
	</div>
	<br/>
	<table class="table" style = "font-family: Montserrat, sans-serif; font-size:14px;">
	<tbody>
		<tr>
			<td><b>시작일 :</b></td>
			<td><input type="date" id="start_date" name="start_date" placeholder="yyyy-mm-dd" name ="start_date" value = "<%=sdf.format(taskVO.getCre_date())%>"></td>
		</tr>
		<tr>
			<td><b>마감일 :</b>
			<td><input type="date" id="due_date" placeholder="yyyy-mm-dd" name = "due_date" value = "<%=sdf.format(taskVO.getDue_date())%>"></td>
		<tr>
			<td><b>생성일: </b>
			<td><input type="date" id="cre_date" placeholder="yyyy-mm-dd" name = "cre_date" value = "<%=sdf.format(taskVO.getCre_date())%>" readonly></td>
		</tr>
		<tr>
			<td><b>중요도:</b>
			<%if (taskVO.getPriority() == 5) {%>
			<td>
				<input type="radio"  name="priority" value = "1">1
				<input type="radio"  name="priority" value = "2">2
				<input type="radio"  name="priority" value = "3">3
				<input type="radio"  name="priority" value = "4">4
				<input type="radio"  name="priority" value = "5" checked>5
			</td>
			<%}else if (taskVO.getPriority() == 4) {%>
			<td>
				<input type="radio"  name="priority" value = "1">1
				<input type="radio"  name="priority" value = "2">2
				<input type="radio"  name="priority" value = "3">3
				<input type="radio"  name="priority" value = "4" checked>4
				<input type="radio"  name="priority" value = "5">5
			</td>
			<%}else if (taskVO.getPriority() == 2) {%>
			<td>
				<input type="radio"  name="priority" value = "1">1
				<input type="radio"  name="priority" value = "2" checked>2
				<input type="radio"  name="priority" value = "3">3
				<input type="radio"  name="priority" value = "4">4
				<input type="radio"  name="priority" value = "5">5
			</td>
			<%}else if (taskVO.getPriority() == 1) {%>
			<td>
				<input type="radio"  name="priority" value = "1" checked>1
				<input type="radio"  name="priority" value = "2">2
				<input type="radio"  name="priority" value = "3">3
				<input type="radio"  name="priority" value = "4">4
				<input type="radio"  name="priority" value = "5">5
			</td>
			<%}else {%>
			<td>
				<input type="radio"  name="priority" value = "1">1
				<input type="radio"  name="priority" value = "2">2
				<input type="radio"  name="priority" value = "3" checked>3
				<input type="radio"  name="priority" value = "4">4
				<input type="radio"  name="priority" value = "5">5
			</td>
			<%} %>
		</tr>
		<tr>
			<td><b>위치정보:</b>
			<td>
				<input type = "text" id="location" name="location" placeholder="ex)서울시 강북구 월계로" class="byteLimit" limitbyte="30" value = "<%=taskVO.getLocation()%>">
		<datalist id="taskNameList">
			<%
			for(int i = 0; i < taskIdList.size(); i++) {
				
				if(taskIdList.get(i).getName().equals(taskVO.getName()))
					continue;
				/* 
				TaskVOLite taskVOLite = taskIdList.get(i);
				String labelContents = "";
				if(taskVOLite.getStatus().equals("COMPLETE"))
					labelContents += "(완료)" ;
				labelContents += taskVOLite.getSectionName(); */
			%>
				<option value="<%=taskIdList.get(i).getName()%>" <%-- label="<%=labelContents%>" --%>>
			<%
			} %>
		</datalist>
		
		<tr>
			<td><b>선행TASK</b></td>
			<td>
				<input type="text" name="pre_task_name" value="<%=preTaskName %>" list="taskNameList"/>
				<input type="hidden" name="hidden_pre_task_name" value="<%=preTaskName %>" />
				<span style = "opacity:0.5">(삭제 : 공백지정) </span>
			</td>
		</tr>
		<tr>
			<td><b>후행TASK</b></td>
			<td>
				<input type="text" name="post_task_name" value="<%=postTaskName %>" list="taskNameList"/>
				<input type="hidden" name="hidden_post_task_name" value="<%=postTaskName %>" />
				<span style = "opacity:0.5">(삭제 : 공백지정) </span>
			</td>
		</tr>
		<tr>
			<td><b>ROLE배정</b></td>
			<td>
				<div id="role">
					<input list="roleList" name="taskToRole" >
					<datalist id = "roleList">
					<%for(int i = 0; i < roleList.size(); i++) {
						RoleVO roleVO = roleList.get(i);
					%>
						<option value = "<%=roleVO.getName()%>">
					<%} %>
					</datalist>
				</div>
			</td>
		</tr>
	</tbody>
	</table>
</form>	
<div id = "allocated">
	<span style = "font-family: Montserrat, sans-serif;"><b>배정된 ROLE</b></span>
   	<%for(int h = 0; h < allocatedRole.size(); h++) {
   		RoleVO allocRole = allocatedRole.get(h);
   	%>
   	
   	<form id = "deleteAllocation" action = "deallocatetask.do">  
   	<div class = "row">
   	<div class = "col-xs-8">
	   	<input class = "form-control" type = "text" name = "role_name" value = "<%=allocRole.getName() %>" readonly>
	   	<input type = "hidden" name = "role_id" value = "<%=allocRole.getId() %>">
	   	<input type = "hidden" name = "task_id" value = "<%=taskVO.getId() %>">
	</div>
	<div class = "col-xs-4">
	   	<input type = "submit" class = "btn btn-default" value = "배정취소" onclick = "javascript:">
   	</div>
   	</div>
   	</form>   	
   	<%} %>
</div>
<br/>
<div id = "button-group">
	<input type="button" class = "btn btn-default" value="확인" onclick = "javascript:updating()">&nbsp;&nbsp;
	<input type="button" class = "btn btn-default" data-dismiss="modal" value="취소" >
</div>
</div>


