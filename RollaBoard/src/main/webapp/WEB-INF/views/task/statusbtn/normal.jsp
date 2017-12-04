<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<button id = "completeBtn" class="Btn completeBtn" style = "cursor:pointer ">
 완료하기
</button>

<script>
$("#completeBtn").click(function(){
	alert("완료하였습니다");
	$('#completeArea').load("complete.go.do", {
		task_id: $("#task_id").val()
	});
	location.reload();
});
</script>