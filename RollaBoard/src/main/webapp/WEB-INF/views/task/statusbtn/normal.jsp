<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<button id="completeBtn">
완료 버튼
</button>

<script>
$("#completeBtn").click(function(){
	alert("완료버튼 클릭함");
	$('#completeArea').load("complete.go.do", {
		task_id: $("#task_id").val()
	});
});
</script>