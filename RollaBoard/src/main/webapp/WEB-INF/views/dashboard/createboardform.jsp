<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 세션 아이디 체크
	if(session.getAttribute("id") == null) {
		out.println("<script>alert('로그인이 필요합니다');");
		out.println("location.href='index.do'");
		out.println("</script>");
	}
	String id = (String) session.getAttribute("id");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>createboard</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    
  <script>
  function chk() {
	if (document.getElementById("board_name").value == "") {
		alert("보드명을 입력해주세요.")
		return false;
	} else {
		document.createboard.submit();
	}
	  
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
<form name = "createboard" class = form-horizental" action = "createboard.do">
<div class = "page-header">
	<div class = "row">
		<div class = "col-xs-1"></div>
		<div class = "col-xs-3"><input type = "text" class = "byteLimit" limitbyte="50" id = "board_name" name = "name" placeholder = "Board명을 입력하세요"></div>
	</div>
</div>

<div class = "row">
	<center><div class = "col-xs-12 left">
	<input type = "button" class = "btn btn-info" value = "만들기" onclick = "chk()"> &nbsp; 
	<input type = "button" class = "btn btn-info" value = "취소" onclick = "location.href='dashboard.do'">
	</div></center>
	
</div>
</form>
</body>
</html>