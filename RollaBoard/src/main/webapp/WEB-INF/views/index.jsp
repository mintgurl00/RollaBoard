<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>로그인 페이지 </title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  

  
  
</head>
<body >

<div class="container-fluid" style="margin-top:10%">
	<br>  <br> <br> <br> <br>  <br> <br> <br>
  <div class = "row">
	<div class = "col-sm-offset-2">
  	<h1>RollaBoard <br></h1>  <h2> LOGIN </h2>
  </div>
  </div>
  <form class="form-horizontal" action="login.do" method = "post">
    <div class="form-group" >
      <label class="control-label col-sm-2" for="text">ID </label>
      <div class="col-sm-4">
        <input type="text" class="form-control" id="id" placeholder="Enter ID" name="id">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd">Password</label>
      <div class="col-sm-4">          
        <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password">
      </div>
    </div>
    
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default" action="dashboard.do">Login&nbsp;&nbsp;</button>
              

        <button type="button" class="btn btn-default" onclick="location.href='joinform.do'">Sign Up</button>

      </div>
    </div>
     
  </form>
</div>

</body>
</html>
  
    