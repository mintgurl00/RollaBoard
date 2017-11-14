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
  
  <script>
	function check_input() {
		var str, i, ch;
		//아이디 체크
		if (document.loginform.id.value == "") {
			alert("아이디를 입력하세요 !! ");
			document.loginform.id.focus();
			return;
		}
		else {
			str = document.loginform.id.value;
			
			for(i=0; i <str.length; i ++) {
				ch = str.substring (i, i +1);
				if(! ((ch >="0" && ch <= "9") || (ch >= "a" && ch <= "z")
						|| (ch >= "A" && ch <= "Z"))) {
					alert ("특수문자가 포함, 다시 입력 !!! ");
					document.loginform.id.focus();
					return;
				}
			}
		}	//아이디 체크 
		
		//패스워드 체크 --> 
		if (document.loginform.password.value=="") {
			alert("패스워드를 입력하세요 !! ");
			document.loginform.password.focus();
			return;
		}else {
			str = document.loginform.password.value;
			
			for (i = 0 ; i < str.length; i++) {
				ch = str.substring(i, i+1);
				if(! ((ch >="0" && ch <= "9") || (ch >= "a" && ch <= "z")
						|| (ch >= "A" && ch <= "Z"))) {
					alert ("특수문자가 포함, 다시 입력 !!! ");
					document.loginform.password.focus();
					return;
			}
		}
	  }//패스워드  체크.
		loginform.submit();
	}
	
	</script>
  
  
</head>
<body >
-member 테이블의 id,password  저장
-check input 
<div class="container" style="margin-top:10%; margin-left:30%">
	<br>  <br> <br> <br> <br>  <br> <br> <br>
  <h1>RollaBoard <br></h1>  <h2> LOGIN </h2>
  <form class="form-horizontal" action="dashboard.do">
    <div class="form-group" >
      <label class="control-label col-sm-2" for="text">ID </label>
      <div class="col-sm-5">
        <input type="text" class="form-control" id="id" placeholder="Enter ID" name="id">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd">Password</label>
      <div class="col-sm-5">          
        <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd">
      </div>
    </div>
    
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default" action="javascript:check_input()">Login&nbsp;&nbsp;
              

        <button type="button" class="btn btn-default" onclick="location.href='joinform.do'">Sign Up</button>

      </div>
    </div>
     
  </form>
</div>

</body>
</html>
  
    