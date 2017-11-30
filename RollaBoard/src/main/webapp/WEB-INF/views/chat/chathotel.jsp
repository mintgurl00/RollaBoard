<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.rollaboard.chat.list.ChatListVO2"%>
<%
ArrayList<ChatListVO2> chatList = (ArrayList<ChatListVO2>) request.getAttribute("chatList");
%>
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

<c:forEach items="${chatList }" var="chatroom">
	<div class="chatroomTest">
		chName:${chatroom.chName }<br/>
		chId:${chatroom.chId }<br/>
		visibility:${chatroom.visibility }<br/>
		status:${chatroom.status }<br/>
		notReadCount:${chatroom.notReadCount }<br/>
	</div>
</c:forEach>

<button class="testBtn">테스트버튼</button>

<div id="chattingRoom">채팅방이 채워지는 곳</div>
</body>
</html>






<%-- foreach태그 (List, Map, Enumeration) Test --%>
<%-- 

 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


 <html>
<head>
<meta http-equiv="Content-Type" 
    content="text/html; charset=EUC-KR">

 <title>JSTL Core - 흐름제어 - forEach</title>
</head>


 <body>
 
<%
    HashMap<String,User> ht = new HashMap<String,User>();
    ht.put("first",new User("아이디1","비밀번호1","이름1","이메일1"));
    ht.put("second",new User("아이디2","비밀번호2","이름2","이메일2"));
    ht.put("third",new User("아이디3","비밀번호3","이름3","이메일3"));    
    request.setAttribute("ht",ht);    
    
    Iterator it = ht.values().iterator();
    request.setAttribute("it",it);    
    
    ArrayList<User> list = new ArrayList<User>();
    list.add(new User("아이디4","비밀번호4","이름4","이메일4"));
    list.add(new User("아이디5","비밀번호5","이름5","이메일5"));
    request.setAttribute("list",list);
    
%>
    <H2>HashMap을 이용한 예</H2>
    <!-- items 항목의 요소가 Map형태이라면 반복 item의 타입은 Map.Entry가 되고 
        key(Map에 저장된 item의 key값)와 value(Map에 저장된 item의 value값)속성을 가진다.
    -->
    <c:forEach  items="${ht}" var="e1">
        ${e1.key}/${e1.value.userId}/${e1.value.name}<br/>
    </c:forEach>
    
    
    <H2>ArrayList을 이용한 예</H2>
    <c:forEach  items="${requestScope.list}" var="e2">
        ${e2.userId}/${e2.name}<br/>
    </c:forEach>
    ${2+3}
    
    <H2>Iterator 이용한 예</H2>
    <c:forEach  items="${it}" var="e3">
        ${e3.userId}/${e3.name}<br/>
    </c:forEach>
</body>
</html> --%>