<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.board.BoardVO"%>
<%@ page import="com.spring.rollaboard.section.SectionVO"%>

<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}

//SectionVO sectionVO = (SectionVO) request.getAttribute("sectionVO");

ArrayList<SectionVO> sectionlist = (ArrayList<SectionVO>)request.getAttribute("sectionList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>memberadmit</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script> 
 <script>
 function updatesection(cnt) {
  document.getElementById("updatesection" + cnt).submit();
 }
 
 function deletesection(cnt) {
  document.getElementById("deletesection" + cnt).submit();
 }
 
 
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
  <h2>SECTION 관리</h2>
  <p>당신의 BOARD에 있는 SECTION 리스트입니다</p>       
  <table class="table table-striped">
    <thead>
      <tr>
        <th>SECTION 이름</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <%for(int i = 0; i < sectionlist.size(); i++) {
    	SectionVO section = sectionlist.get(i);
    %>
      <tr>
        <td>
        <form id = "updatesection<%=section.getId() %>" action = "updatesection.do">
        	<input type = "hidden" class = "form-control" name = "section_id" value =  "<%=section.getId() %>">
        	<input type = "text"  name = "section_name" value = "<%=section.getName() %>" class="byteLimit" limitbyte="30" placeholder = "수정할 Section명을 입력하세요">
       	</form>
        </td>
        <td align = right>
       		<form id = "deletesection<%=section.getId() %>" action = "deletesection.do">
       			<input type = "hidden" class = "form-control" name = "section_id" value =  "<%=section.getId() %>">
       			
       		</form>
       		<input type = submit class = "btn btn-info" value = "수정" onclick = "javascript:updatesection(<%=section.getId() %>)">
       		<input type = submit class = "btn btn-default" value = "삭제" onclick = "javascript:deletesection(<%=section.getId() %>)" >
       	</td>
      </tr>
   <%} %>	
   </tbody>
   </table>    
   <form action = "createsection.do">
   	<table class="table table-striped">
   	  <tbody>
   	  	<td><input type = "text" name = "section_name"  class="byteLimit" limitbyte="30" class="byteLimit" limitbyte="30" placeholder = "추가할 Section명을 입력하세요" required></td>
   	  	<td align = right>
        	<input type = submit class = "btn btn-info" value = "추가" >&nbsp;&nbsp;
       	</td>
      </tbody>
     </table>
   </form>
  
</div>
</body>
</html>
