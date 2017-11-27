

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
 
function deleteTask() {
	var chk = confirm("정말 삭제하시겠습니까?");
	if(chk){
		document.getElementById("deletetask").submit();
	} else {
		return;
	}
}
function updateTask() {
	document.getElementById("updatetask").submit();
}