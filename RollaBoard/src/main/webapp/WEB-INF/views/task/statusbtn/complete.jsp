<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<button id = "completeCancelBtn" class="Btn completeCancelBtn">
완료 취소
</button>

<script>
$("#completeCancelBtn").click(function(){
	alert("완료가 취소되었습니다");
	$('#completeArea').load("completecancel.go.do", {
		task_id: $("#task_id").val()
	});
	location.reload();
});
</script>