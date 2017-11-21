<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.util.*" %>
<%@ page import="java.util.*, com.spring.rollaboard.*"%>

<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}

//SectionVO sectionVO = (SectionVO) request.getAttribute("sectionVO");
ArrayList<SectionVO> sectionlist = (ArrayList<SectionVO>)request.getAttribute("sectionlist");
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
        <input type = "text" class = "form-control" name = "section_name" value = "<%=section.getName() %>" placeholder = "수정할 Section명을 입력하세요">
        <input type = "hidden" class = "form-control" name = "section_id" value =  "<%=section.getId() %>">
        </td>
        <td align = right>
        	<input type = button value = "수정" onclick = "location.href='./updatesection.do?section_id=<%=section.getId()%>'">&nbsp;&nbsp;
       		<input type = button value = "삭제" onclick = "location.href='./deletesection.do?section_id=<%=section.getId()%>'">
       	</td>
      </tr>
   <%} %>	
   </tbody>
   </table>    
   <form action = "createsection.do">
   	<table class="table table-striped">
   	  <tbody>
   	  	<td><input type = "text" class = "form-control" name = "section_name" placeholder = "추가할 Section명을 입력하세요"></td>
   	  	<td align = right>
        	<input type = submit value = "추가" >&nbsp;&nbsp;
       	</td>
      </tbody>
     </table>
   </form>
  
</div>
</body>
</html>
