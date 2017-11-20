<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.spring.rollaboard.*"%>
<%
	ArrayList<MemVO> roleMem = (ArrayList<MemVO>) request.getAttribute("roleMem");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>'<%=request.getAttribute("role_name") %>' 명단</h1>
<%for(int i = 0; i < roleMem.size(); i++) { 
	MemVO memVO = roleMem.get(i);
%>
	<h2>아이디 : <%=memVO.getId() %>  이름 : <%=memVO.getName() %></h2>
<%} %>
</body>
</html>