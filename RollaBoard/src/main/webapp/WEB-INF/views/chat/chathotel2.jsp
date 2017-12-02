<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹 소켓</title>

<script src="js/chat.js" type="text/javascript"></script>

</head>
<body>
<input type="text" id="input" placeholder="input message..." size="55" />

<button id="send_button">Send</button>
대화명<input type="text" id="nickname" placeholder="대화명 입력" size="10">
<p />
<textarea id="output" readonly rows="30" cols="80"></textarea>



</body>
</html>