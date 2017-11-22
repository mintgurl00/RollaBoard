<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.spring.rollaboard.BoardVO" %>
<%@ page import = "java.util.*" %>
<%
// 세션 아이디 체크
if(session.getAttribute("id") == null) {
	out.println("<script>alert('로그인이 필요합니다');");
	out.println("location.href='index.do'");
	out.println("</script>");
}
ArrayList<BoardVO> refBoardList = (ArrayList<BoardVO>)request.getAttribute("refBoardList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>etc</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
function radio_chk() {
	//라디오 버튼 name 가져오기
	var radio = document.getElementsByName("visibility");

	for (var i = 0; i < radio.length; i++) {
		if (radio[i].checked == true) {
			var visibility = radio[i].value; //visibility 변수에는 "TRUE"나 "FALSE" 값이 저장됨
			document.getElementById("visibility").submit(); //submit하면 etc.do로
		}
	}
	
	
}
</script>
</head>
<body>
<div class="container">
  <h2>참조 승인 여부</h2>
  <p>공개를 통해 다른BOARD에서 당신의 BOARD를 참조할 수 있게 할 수 있습니다. </p>  
  <br/><br/>
  <form id = "visibility" action = "visibility.do">
  <div class = "row">
  	<div class = "col-xs-4">공개여부</div>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "TRUE" >공개</div>
  	<div class = "col-xs-3"><input type = "radio" name = "visibility" value = "FALSE">비공개</div>
  	<div class = "col-xs-2"><input type = "submit" class = "btn btn-info" value = "저장" onclick="javascript:radio_chk()"></div>
  </div>
  </form>
</div>  
  <br/><br/>
  
 
    	
<div class="container">
  <h2>참조보드 목록</h2>
  <p>당신의 BOARD가 참조하고 있는 BOARD 목록입니다. 참조할 BOARD를 자유롭게 추가/삭제하세요.</p>            
  <table class="table table-striped">
    <thead>
      <tr>
        <th>참조 BOARD</th>
      </tr>
    </thead>
    <tbody>
    <%for (int i = 0; i < refBoardList.size(); i++) {
    	BoardVO boardVO = refBoardList.get(i);%>
      <tr>
        <td><%=boardVO.getName() %></td>
        
        <td align = right>
        <form action = "deleterefboard.do" method = "post">
        	<input type = hidden name = "ref_id" value = "<%=boardVO.getId() %>">
       		<input type = submit value = "삭제" class = "btn btn-default">
   		</form>
       	</td>
      </tr>
   
   <%} %>
    </tbody>
  </table>
  
  <form action = "addrefboard.do">
   	<table class="table table-striped">
   	  <tbody>
   	  	<td><input type = "text" class = "form-control" name = "board_name" placeholder = "추가할 BOARD명을 입력하세요"></td>
   	  	<td align = right>
        	<input type = submit class = "btn btn-info" value = "추가" >&nbsp;&nbsp;
       	</td>
      </tbody>
     </table>
   </form>
  
</div>

</body>
</html>