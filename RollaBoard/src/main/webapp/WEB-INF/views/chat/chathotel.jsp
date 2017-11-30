<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹 소켓</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="js/chat/chatConnection.js" type="text/javascript"></script>
<script src="js/chat/chatHotel.js" type="text/javascript"></script>

</head>
<body>

여기는 채팅 리스트가 쫙 나와야 하는 곳
<a class="chRoomBtn" href="./chat/111">채팅룸1</a>

<button class="testBtn">테스트버튼</button>

<div id="chattingRoom">채팅방이 채워지는 곳</div>
</body>
</html>