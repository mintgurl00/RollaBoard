

$(document).ready( function() {
	/*var task_status = $("#task_status").val() ;
	var task_id = $("#task_id").val() ;
	alert(task_status);
	alert(task_id);*/
	$('#completeArea').load("setCompleteArea.do", {
		/*task_id: task_id,*/
		status: $("#task_status").val()
	});
});
 