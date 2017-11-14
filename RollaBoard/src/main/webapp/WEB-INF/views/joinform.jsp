<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
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

<body>

-member 테이블, id, password, name, email 값 저장

<form action="insertMember.do" >

  <div class="container">
  <h2> 회원가입</h2>
    <label><b>ID</b></label>
    <input type="text" placeholder="Enter ID" name="id" required>

    <label><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="password" required>

    <label><b>이름</b></label>
    <input type="text" placeholder="이름" name="name" required>
    
    <label><b>Email</b></label>
    <input type="text" placeholder="Enter Email" name="email" required>
  
    <div class="clearfix">
      <button type="reset" class="btn btn-default">다시 작성 </button>&nbsp;&nbsp;&nbsp; 
      <button type="submit" class="btn btn-default">회원가입</button>
    </div>
  </div>
</form>

</body>
</html>
    