<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%@ page import="com.spring.rollaboard.task.RefTaskVO"%>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
	TaskVO taskVO = (TaskVO) request.getAttribute("taskVO");
	request.setAttribute("taskVO", taskVO);
	/* ArrayList<taskVO> taskViewList = (ArrayList<taskVO>)request.getAttribute("taskViewList"); */
	
	// 관계 태스크 보여주기 위한 기능
	RefTaskVO preTaskVO = null, postTaskVO = null ;
	preTaskVO = (RefTaskVO) request.getAttribute("preTaskVO");
	postTaskVO = (RefTaskVO) request.getAttribute("postTaskVO");/* 
	if(preTaskVO == null)
		preTaskVO = new RefTaskVO(1);
	if(postTaskVO == null)
		postTaskVO = new RefTaskVO(1); */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="reset.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
      	left: 20%;
        height: 35%;
        width: 60%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
      
      #frame{position:absolute; border-radius:10px; width:450px; height:550px; overflow:auto; background-color:#DAD9FF; margin-right: 10px; text-align:center}
	  #content{width:400px; height:250px; background-color:#FFFFFF; margin-left:50px}
	  #comment{width:400px; height:250px; background-color:#FFFFFF; margin-left:50px; margin-top:20px}
	  #button{margin-top:20px}
</style>

<title>태스크보기</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="js/taskview.js"></script>

<script>

//처음 맵 상태
function initMap() {
	
  /* document.getElementById('submit').addEventListener('click', function() {
    	geocodeAddress(geocoder, map, address); //'검색' 버튼 클릭하면 아래 메소드 호출(geocoder, map 객체 전달)
  }); */
	  	
  var address = document.getElementById('addr1').value; //검색창에 입력한 주소를 address에 저장
  
  var map = new google.maps.Map(document.getElementById('map'), { //구글맵을 불러와 map에 저장
    zoom: 15
    //center: {lat: -34.397, lng: 150.644} //이 때 지도 가운데에 위치할 위도, 경도값
  });

  
 var geocoder = new google.maps.Geocoder(); //지오코더 불러옴
  
 geocodeAddress(geocoder, map, address);
  
  //var s =  document.getElementById('submit');

  
}

//주소 검색 시
function geocodeAddress(geocoder, resultsMap, address) {
  //alert("address:" + address);
  //var address = document.getElementById('addr1').value; //검색창에 입력한 주소를 address에 저장
  
  geocoder.geocode({'address': address}, function(results, status) { //지오코더의 geocode메소드를 이용해 address를 위도, 경도 정보로 변환
    if (status === 'OK') {
      resultsMap.setCenter(results[0].geometry.location); //resultsMap은 위에서 불러온 구글맵. 괄호 안의 위치를 지도 가운데로
      var marker = new google.maps.Marker({
        map: resultsMap,
        position: results[0].geometry.location //마커 포지션은 위에서 가져온 위치
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function deleteTask() {
	var chk = confirm("정말 삭제하시겠습니까?");
	if(chk){
		document.getElementById("deletetask").submit();
	} else {
		return;
	}
}
function updateTask() {
	document.getElementById("updatetask").submit();
}





</script>
</head>

<body>


<div id = "frame"><h1>TASK 이름 :  <%=taskVO.getName() %> </h1>
	<div id="status">내용 :  <%=taskVO.getDescription() %> </div>
	<div id="status">상태: <%=taskVO.getStatus() %> </div>	
	<div id="status">댓글 : 해야 됨</div>
	<div id="status">생성날짜: <%=taskVO.getCre_date() %> </div>	
	<div id="status">시작날짜: <%=taskVO.getStart_date() %> </div>	
	<div id="status">마감날짜: <%=taskVO.getDue_date() %> </div>	
	<div id="status">중요도: <%=taskVO.getPriority() %> </div>
	
	<!-- 수민 태스크 위치 추가 -->
	<%
	if (taskVO.getLocation() != null) {
	%>
	
		<div id="status">
			위치: <%=taskVO.getLocation() %>
		</div>
		
		<div><input type="button" value="지도보기" onclick= "initMap()" hidden/></div>
		
		 
		<div id="floating-panel" hidden>
      		<input id="addr1" type="text" value="<%=taskVO.getLocation() %>">
      		<input id="submit" type="button" value="search">
    	</div>
    	 
		<div id="map"></div>
	
	<%
	}
	%>

	
	<%
	if(preTaskVO != null || postTaskVO != null) {
		%>
		<b>관계 있는 태스크입니다.</b>
		<%
		if(preTaskVO != null) {
			%>
			<div id="status">선행TASK: <%=preTaskVO.getRefTaskName() %> </div>
			<%
		}
		if(postTaskVO != null) {
			%>	
			<div id="status">후행TASK: <%=postTaskVO.getRefTaskName() %> </div>	
			<%
		}
	}%>
	<div id="button">

	<%if (session.getAttribute("board_id") != null) {%>

		<input type=button value="확인" onclick = "location.href='./board.do';">
		<input type=button value="수정" onclick = "javascript:updateTask()">
		<input type=button value="삭제" onclick = "javascript:deleteTask()">
	<%} else { %>
		<input type=button value="확인" onclick = "location.href='./dashboard.do'">
	<%} %>

	</div>
	<form id = "updatetask" action = "updatetaskform.do" method="post">
		<input type = hidden name = "id" value = "<%=taskVO.getId() %>">
		<input type = hidden name = "name" value = "<%=taskVO.getName() %>">
		<input type = hidden name = "description" value = "<%=taskVO.getDescription() %>">
		<input type = hidden name = "status" value = "<%=taskVO.getStatus() %>">
		<input type = hidden name = "section_id" value = "<%=taskVO.getSection_id() %>">
		<input type = hidden name = "start_date" value = "<%=taskVO.getStart_date() %>">
		<input type = hidden name = "due_date" value = "<%=taskVO.getDue_date() %>">
		<input type = hidden name = "cre_date" value = "<%=taskVO.getCre_date() %>">
		<input type = hidden name = "priority" value = "<%=taskVO.getPriority() %>">	
		<input type = hidden name = "location" value = "<%=taskVO.getLocation() %>">	
	</form>
	<form id = "deletetask" action = "deletetask.do">
		<input type = hidden id="task_id" name = "task_id" value = "<%=taskVO.getId() %>">
	</form>
	
	<input type="hidden" id="task_status" value="<%=taskVO.getStatus()%>" />
	<div id="completeArea">
	</div>
</div>
<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAusOrhQtlhsJhJl1UD0Es_b1As0thorrM&callback=initMap"></script>
</body>
</html>