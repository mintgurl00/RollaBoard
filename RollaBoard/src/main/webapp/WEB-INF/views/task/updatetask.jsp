<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.task.TaskVOLite"%>
<%@ page import="com.spring.rollaboard.role.RoleVO"%>
<%@ page import="com.spring.rollaboard.task.RefTaskVO"%>
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



// 관계 태스크 보여주기 위한 기능
RefTaskVO preTaskVO = null, postTaskVO = null ;
preTaskVO = (RefTaskVO) request.getAttribute("preTaskVO");
postTaskVO = (RefTaskVO) request.getAttribute("postTaskVO");

String preTaskName = "", postTaskName = "" ;
if( preTaskVO != null )
	preTaskName = preTaskVO.getRefTaskName();
if( postTaskVO != null )
	postTaskName = postTaskVO.getRefTaskName();




%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
#frame{width:500px; height:700px; background-color:#DAD9FF}
#taskname{margin-top:20px; margin-left:10px}
#content{margin-top:30px; margin-left:30px}
#role{margin-top:30px; margin-left:30px}
#settings{margin-top:5px; margin-left:380px}
#button{margin-top:20px; margin-left:200px}
</style>

<!-- 테스크 제목, 설명 입력 바이트 수 제한 --> 
 <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
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





<div id="frame">
	<div id = "allocated">배정된 ROLE
    	<%for(int h = 0; h < allocatedRole.size(); h++) {
    		RoleVO allocRole = allocatedRole.get(h);
    	%>
    	<form id = "deleteAllocation" action = "deallocatetask.do">
    	<input class = "form-control" type = "text" name = "role_name" value = "<%=allocRole.getName() %>" readonly>
    	<input type = "hidden" name = "role_id" value = "<%=allocRole.getId() %>">
    	<input type = "hidden" name = "task_id" value = "<%=taskVO.getId() %>">
    	<input type = "submit" value = "배정취소">
    	</form>
    	<%} %>
    </div>
	<form action = "updatetask.do">
	<div id="id">
		<input type="hidden" id="id" name="id" value = <%=taskVO.getId() %> size="40">
	</div>
	<div id="section_id">
		<input type="hidden" id="section_id" name="section_id" value = <%=taskVO.getSection_id() %> size="40">
	</div>
    <div id="taskname">
        <input type="text" id="taskname" name="name" placeholder="TASK 이름을 입력하시오." size="40" class="byteLimit" limitbyte="30" value = "<%=taskVO.getName()%>">
    </div>
    
    <div id="content">내용(필수X)
        <input type="textarea" id="content" name="description" style="height:180px; width:380px;" class="byteLimit" limitbyte="100"   value = "<%=taskVO.getDescription()%>">
    </div>
    
    <h4>고급설정</h4>
	<div id ="start_date"> 시작날짜
		<input type="date" id="start_date" name="start_date" placeholder="yyyy-mm-dd" size="40" name ="start_date" value = "<%=taskVO.getStart_date()%>"><br/><br/><br/>
	</div>
	
	<div id ="due_date"> 마감날짜

		<input type="date" id="due_date" placeholder="yyyy-mm-dd" size="40" name = "due_date" value = "<%=taskVO.getDue_date()%>"><br/><br/><br/>

	</div>
	
	<div id ="cre_date"> 생성날짜

		<input type="date" id="cre_date" placeholder="yyyy-mm-dd" size="40" name = "cre_date" value = "<%=taskVO.getCre_date()%>" readonly><br/><br/><br/>

	</div>
	
	<div id ="priority"> 중요도
		<input type="text" id="priority" placeholder="1~5중에 하나를 입력해주세요" size="40" name="priority" value = "<%=taskVO.getPriority()%>"><br/><br/><br/>
	</div>
	
	
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
	
	
	<div id ="pre_Task" class="checkDiff"> 선행TASK
		<input type="text" name="pre_task_name" value="<%=preTaskName %>" list="taskNameList"/>
		<input type="hidden" name="hidden_pre_task_name" value="<%=preTaskName %>" />
		<!-- <input type="number" id="pre_task" name="pre_task" value="" placeholder="Task id를 입력하시오" size="40"><br/><br/><br/> -->
	</div>
	
	<div id ="post_Task" class="checkDiff"> 후행TASK
		<input type="text" name="post_task_name" value="<%=postTaskName %>" list="taskNameList"/>
		<input type="hidden" name="hidden_post_task_name" value="<%=postTaskName %>" />
		<!-- <input type="number" id="post_task" name="post_task" value="" placeholder="Task id를 입력하시오" size="40">
		 -->
	</div>
    
    
    <div id="role">Role 배정(필수X)
		<input list="roleList" name="taskToRole" >
		<datalist id = "roleList">
		<%for(int i = 0; i < roleList.size(); i++) {
			RoleVO roleVO = roleList.get(i);
		%>
			<option value = "<%=roleVO.getName()%>">
		<%} %>
		</datalist>
	</div>
	<div id="button">
        <input type="submit" value="확인">
        <input type="button" value="취소" onclick='history.go(-1)'>
    </div>
	</form>
</div>