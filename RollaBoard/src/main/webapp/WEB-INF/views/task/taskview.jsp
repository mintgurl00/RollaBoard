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
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


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
      .Btn {
        background-color: #DEDEDE;
		border-radius: 4px;
		padding: 5px 8px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 16px;
		-webkit-transition-duration: 0.2s; /* Safari */
		transition-duration: 0.2s;
		cursor: pointer;
		font-family: 'Roboto', sans-serif;      
      }
      .completeBtn {
		border: 2px solid #4CAF50;
		color: black;
      }
      .completeCancelBtn {
		border: 2px solid orange;
		color: black;
      }
      .blockedBtn {
      	background-color: #BBB;
      	border: 2px solid black;
		color: black;
      }
      .completeBtn:hover {background-color:#4CAF50;color:white;border-radius: 12px;}
      .completeCancelBtn:hover {background-color:orange;color:white;border-radius: 12px;}
      .blockedBtn:hover {background-color:black;color:white;border-radius: 12px;}
      #frame{position:absolute; padding:10px; border-radius:4px; width:600px;height:600px; overflow:auto; background-color:whitesmoke; margin-right: 10px; text-align:center; box-shadow: 1px 1px 5px #000; }
	  #content{border-radius:4px; width:500px; height:120px; background-color:#FFFFFF; margin-left:50px;text-align:left}
	  #button{margin-top:20px}
</style>

<title>태스크보기</title>

<script src="js/taskview.js"></script>

<script>

//처음 맵 상태
function initMap() {
	
  /* document.getElementById('submit').addEventListener('click', function() {
    	geocodeAddress(geocoder, map, address); //'검색' 버튼 클릭하면 아래 메소드 호출(geocoder, map 객체 전달)
  }); */
	  	
  var address = document.getElementById('addr1').value; //검색창에 입력한 주소를 address에 저장
  alert('위치:' + address);
  
  var map = new google.maps.Map(document.getElementById('map'), { //구글맵을 불러와 map에 저장
    zoom: 13
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
}/* 
function updateTask() {
	//document.getElementById("updatetask").submit();
}
 */

// 지도보기 버튼
function locationview() {
	 $('#taskLocation').css("display", "block");
	 $('#taskLocationButton').css("display", "none");
	 initMap();
}


</script>
</head>

<body>


<div id = "frame">
	
	<h2><%=taskVO.getName() %></h2>
	<div id="completeArea" align = "right"></div>
	<hr/>
	<div style = "font-family: Montserrat, sans-serif;">
		<b><textarea id="content" style = "font-family:Montserrat, sans-serif;resize:none;" readonly><%=taskVO.getDescription() %></textarea>
	</b>
	</div>
	<br/>
	<table class="table" style = "font-family: Montserrat, sans-serif; font-size:14px;">
	<tbody>
		<tr>
			<td><b><span class="glyphicon glyphicon-equalizer"> 상태 :  </b></td>
			<td><%=taskVO.getStatus() %> </td>
		</tr>
		<tr>
			<td><b><span class="glyphicon glyphicon-calendar"> 생성일 :</b></td>
			<td><%=taskVO.getCre_date() %> </td>
		</tr>
		<tr>
			<td><b><span class="glyphicon glyphicon-calendar"> 시작일 :</b></td>
			<td><%=taskVO.getStart_date() %> </td>
		</tr>
		<tr>
			<td><b><span class="glyphicon glyphicon-time"> 마감일 :</b></td>
			<td><%=taskVO.getDue_date() %> </td>
		</tr>
		<tr>
			<td><b><span class="glyphicon glyphicon-exclamation-sign"> 중요도 :</b></td>
			<td><%=taskVO.getPriority() %> </td>
		</tr>
		
		
	<% if(preTaskVO != null || postTaskVO != null) { %>			
		<% if(preTaskVO != null) { %>
			<tr>
				<td><b><span class="glyphicon glyphicon-arrow-left"> 선행TASK:</b></td>
				<td><%=preTaskVO.getRefTaskName() %></td>
			</tr>
		<% } %>		
		<% if(postTaskVO != null) { %>	
			<tr>
				<td><b><span class="glyphicon glyphicon-arrow-right"> 후행TASK:</b></td>
				<td><%=postTaskVO.getRefTaskName() %></td>	
			</tr>
		<% } 
	} %>
		</tbody>		
	</table>
	<!-- 수민 태스크 위치 추가 -->
	<%
	if (taskVO.getLocation() != null) {
	%>
	<a id = "taskLocationButton" href="javascript:locationview()" style = "display:block">
      <span class="glyphicon glyphicon-map-marker" style = "font-size:20px">지도보기</span>
    </a>
	<div id = "taskLocation" style = "display:none">
		<div id="status">
			위치: <%=taskVO.getLocation() %>
		</div>
	 
		<div id="floating-panel" hidden>
      		<input id="addr1" type="text" value="<%=taskVO.getLocation() %>">
      		<input id="submit" type="button" value="search">
    	</div>
    	 
		<div id="map"></div>
	</div>
	<%
	}
	%>
	<div id="button">

	<%if (session.getAttribute("board_id") != null) {%>
		<input type=button class = "btn btn-default" value="확인" onclick = "location.href='./board.do';">&nbsp;&nbsp;&nbsp;
		<% if (!taskVO.getStatus().equals("COMPLETE")) {%>
			<input type=button class = "btn btn-default" value="수정" id="goUpdateBtn">&nbsp;&nbsp;&nbsp;
		<%} %>
<!-- 	<input type=button value="수정" onclick = "javascript:updateTask()"> -->
		<input type=button class = "btn btn-default" value="삭제" onclick = "javascript:deleteTask()">
	<%} else { %>
		<input type=button class = "btn btn-default" value="확인" onclick = "location.href='./dashboard.do'">
	<%} %>
		
	</div>
	<form id = "updatetask" action = "updatetaskform.do" method="post">
		<input type = hidden id="h_id" name = "id" value = "<%=taskVO.getId() %>"><%-- 
		<input type = hidden id="h_name" name = "name" value = "<%=taskVO.getName() %>">
		<input type = hidden id="h_description" name = "description" value = "<%=taskVO.getDescription() %>">
		<input type = hidden id="h_status" name = "status" value = "<%=taskVO.getStatus() %>">
		<input type = hidden id="h_section_id" name = "section_id" value = "<%=taskVO.getSection_id() %>">
		<input type = hidden id="h_start_date" name = "start_date" value = "<%=taskVO.getStart_date() %>">
		<input type = hidden id="h_due_date" name = "due_date" value = "<%=taskVO.getDue_date() %>">
		<input type = hidden id="h_cre_date" name = "cre_date" value = "<%=taskVO.getCre_date() %>">
		<input type = hidden id="h_priority" name = "priority" value = "<%=taskVO.getPriority() %>">	
		<input type = hidden id="h_location" name = "location" value = "<%=taskVO.getLocation() %>">	 --%>
	</form>
	<form id = "deletetask" action = "deletetask.do">
		<input type = hidden id="task_id" name = "task_id" value = "<%=taskVO.getId() %>">
	</form>
	
	<input type="hidden" id="task_status" value="<%=taskVO.getStatus()%>" />
	
	
	
</div>
<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAusOrhQtlhsJhJl1UD0Es_b1As0thorrM&"></script>
<script type="text/javascript">

function updateTask2() {
	//document.getElementById("updatetask").submit();
	
}


$(document).ready( function() {
	/*var task_status = $("#task_status").val() ;
	var task_id = $("#task_id").val() ;
	alert(task_status);
	alert(task_id);*/
	$('#completeArea').load("setCompleteArea.do", {
		/*task_id: task_id,*/
		status: $("#task_status").val()
	});
});

$("#goUpdateBtn").click(function(){
	$('#taskViewArea').load("updatetaskform.do", {
		task_id:$("#h_id").val()
	});
});
</script>
</body>
</html>