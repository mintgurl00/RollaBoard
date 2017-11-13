<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>etc</title>
  <meta charset="utf-8" Encoding = "UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
  <h2>참조 승인 여부 | 참조 BOARD 입력</h2>
  <p>공개를 통해 다른BOARD에서 당신의 BOARD를 참조할 수 있게 하고 참조할 BOARD명을 입력하세요 </p>  
  <br/><br/>  
  <div class = "row">
  	<div class = "col-xs-4">공개여부</div>
  	<div class = "col-xs-4"><input type = "radio" name = "visibility" value = "TRUE" >공개</div>
  	<div class = "col-xs-4"><input type = "radio" name = "visibility" value = "FALSE" checked>비공개</div>
  </div>
  <br/><br/>
  <div class = "row">
  	<div class = "col-xs-4">BOARD참조</div>
  	<div class = "col-xs-8"><input type = "text" class = "form-control" name = "ref_board" placeholder = "참조할 board명 입력"></div>	
  </div>
  <br/><br/>
</div>
</body>
</div>
</html>