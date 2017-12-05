<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
body {
	background-color: lightblue;
}
/* Full-width input fields */
input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

/* Set a style for all buttons */
/* button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}
 */
 
/* Extra styles for the cancel button */
.cancelbtn {
    padding: 14px 20px;
    color: black;
    background-color: white;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn,.signupbtn {
    float: left;
    width: 50%;
}

/* Add padding to container elements */
.container {
    padding: 16px;
    margin-top : 10%;
    margin-left: 30%;
}

/* Clear floats */
.clearfix::after {
    content: "";
    clear: both;
    display: table;
}
</style>

<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
function check_input() {
	var str, i, ch;
	//아이디 체크
	if (document.joinform.id.value == "") {
		alert("아이디를 입력하세요 !! ");
		document.joinform.id.value = "";
		document.joinform.id.focus();
		return false;
	}
	else {
		str = document.joinform.id.value;
		
		for(i=0; i <str.length; i ++) {
			ch = str.substring (i, i +1);
			if(! ((ch >="0" && ch <= "9") || (ch >= "a" && ch <= "z")
					|| (ch >= "A" && ch <= "Z"))) {
				alert ("특수문자가 포함, 다시 입력 !!! ");
				document.joinform.id.value = "";
				document.joinform.id.focus();
				return false;
			}
		}
	}	//아이디 체크 
	
	//패스워드 확인란 체크 --> 
	if (document.joinform.password.value != document.joinform.password2.value) {

		alert("패스워드를 다시 확인해주세요 !! ");
		document.joinform.password.value = "";
		document.joinform.password.focus();
		return false; 
	}
	
	  //패스워드  체크
	//joinform.submit();
  	//return; 
}

</script>
<body style = "background-color:#1294AB">
<div class="container-fluid" style="margin-top:10%">
  <div class = "row">
	<div class = "col-sm-offset-2">
  	<h2><b> JOIN </b></h2>
  </div>
  </div>
  <form class="form-horizontal" action="insertMember.do" name = "joinform">
    <div class="form-group">
      <label class="control-label col-sm-2" for="text" style = "color: white">ID </label>
      <div class="col-sm-3">
        <input type="text" class="form-control" id="id" placeholder="Enter ID" name="id" required>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd" style = "color: white">Password</label>
      <div class="col-sm-3">          
        <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password" required>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd" style = "color: white">Password 확인</label>
      <div class="col-sm-3">          
        <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password2" required>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd" style = "color: white">이름</label>
      <div class="col-sm-3">          
        <input type="text" class="form-control" id="pwd" placeholder="이름" name="name" required>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd" style = "color: white">Email</label>
      <div class="col-sm-3">          
        <input type="text" class="form-control" id="pwd" placeholder="Enter Email" name="email" >
      </div>
    </div>
    
    <div class="form-group" style="margin-top:40px">        
      <div class="col-sm-offset-2 col-sm-10">
     	<button type="submit" class="btn btn-default" onclick="javascript:check_input()" >JOIN</button>
      	<button type="reset" class="btn btn-default">RESET</button>
        <button type="button" class="btn btn-default" onclick="location.href='index.do'">BACK</button>
      </div>
    </div>
     
  </form>
</div>


</body>
</html>
    