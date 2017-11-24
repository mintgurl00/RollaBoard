<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="com.spring.rollaboard.role.RoleVO"%>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}

ArrayList<RoleVO> roleList = (ArrayList<RoleVO>) request.getAttribute("roleList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>rolelist</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type = "text/javascript" language = "javascript">
function chkBox(cnt) {
	var chk = confirm("삭제하시겠습니까?");
	if (chk) {
		document.getElementById("deleteRole" + cnt).submit();
	} else {
		return;
	}
}
function updateRoleForm(cnt) {
	document.getElementById("updateRole" + cnt).submit();
}
$(document).ready(function () {
	$('.nameview').css("visibility", "hidden");
	$('#toggle').click(function(){
		if( $('.nameview').css("visibility") == "hidden") {
			$('.nameview').css("visibility", "visible");
		} else {
			$('.nameview').css("visibility", "hidden" );
		}
	})
})

</script>

<!-- 글자수제한 스크립트 -->
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
                  
                if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))){
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
    });
      
  </script>


</head>
<body>
<div class="container">
  <h2>ROLE 관리</h2>
  <p>당신의 BOARD에서 업무수행을 지시할 ROLE을 관리해주세요</p>
  <div class = "page-header">
      <div class = "row" >
        <div class = "col-xs-3" ><h3>ROLE 이름</h3></div>
        <div class = "col-xs-3"><h3>DESCRIPTION</h3></div>
        <div class = "col-xs-3"></div>
   	 </div>
    <%for(int i = 0; i < roleList.size(); i++) {
    	RoleVO roleVO = roleList.get(i);
    %>
    <form id = "none"></form>
      <div class = "row">
      	<form id = "updateRole<%=roleVO.getId() %>" action = "updaterole.do">
        <div class = "col-xs-3"  >
        	<%=roleVO.getName() %>
        	<input type = "text"  class = "byteLimit" limitbyte="20" name = "name" placeholder = "수정할 정보 입력(이름)" value = "<%=roleVO.getName() %>" style = "visibility: ">
        </div>
        <div class = "col-xs-3">
        	<%=roleVO.getDescription() %>
        	<input type = "text" class = "byteLimit" limitbyte="100" name = "description" placeholder = "수정할 정보 입력(설명)" value = "<%=roleVO.getDescription() %>" style = "visibility:">
        </div>
        
        <div class = "col-xs-3 nameview" align = right>
        
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
        	<button type = submit class = "btn btn-info" onclick = "javascript:updateRoleForm(<%=roleVO.getId() %>)" >수정</button>
		</div>
        </form>
        <form id = "deleteRole<%=roleVO.getId() %>" action = "deleteRole.do">
        <div class = "col-xs-1">
        	<input type = "text" name = "id" value = "<%=roleVO.getId() %>" hidden>
       		<input type = button class = "btn btn-default"  value = "삭제" onclick="javascript:chkBox(<%=roleVO.getId() %>)">
       	</div>
       	</form> 
      	</div>
      	<br/>
   <%} %>
   <%if (roleList.size() == 0) {%>
   <center><h1>데이터가 없습니다.</h1></center>
   <%} else { %>
   <div align = center><input type = button class = "btn btn-default" id = "toggle" value = "수정하기"></div>
   <%} %>
   <br/>
   <br/>

  <form id = "createRole" action = "createrole.do">
  	<div class="form-group" >
      <label class="control-label col-sm-2" for="text">이름 </label>
      <div class="col-sm-4">
        <input type="text" class = "byteLimit" limitbyte="20" name = "name" placeholder = "추가할 ROLE의 이름 입력" required>
      </div>
    </div>
    <div class="form-group" >
      <label class="control-label col-sm-2" for="text">설명 </label>
      <div class="col-sm-4">
        <input type="text" class = "byteLimit" limitbyte="100" name = "description" placeholder = "추가할 ROLE의 설명 입력">
      </div>
    </div>
  	<center><input type = submit class = "btn btn-default" value = "추가"></center>
  </form>

  </div>
</div>
</body>
</html>