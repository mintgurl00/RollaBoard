<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<button id="completeCancelBtn">
완료 취소 버튼
</button>

<script>
$("#completeCancelBtn").click(function(){
	alert("완료취소버튼 클릭함");
	$('#completeArea').load("completecancel.go.do", {
		task_id: $("#task_id").val()
	});
});
</script>