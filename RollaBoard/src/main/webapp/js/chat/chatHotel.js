window.onload = function(){
	
	$("a").on("click", function(event){
		event.preventDefault();
		$("#chattingRoom").load(
				$(this).prop("href"),{}
		);
	})
	$(".testBtn").on("click", function(event){
		w.send("버튼 누름");
	})
}