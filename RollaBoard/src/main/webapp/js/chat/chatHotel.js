window.onload = function(){
	
	$("a").on("click", function(event){
		event.preventDefault();
		$("#chattingRoom").load(
				$(this).prop("href"),{}
		);
	})
	$(".testBtn").on("click", function(event){
		//w.send("버튼 누름");
	})
	
	$("#createChatListBtn").on("click", function(event){
		$("#none").load("createChatList.so",{
			description:"기본",
			type:"PUBLIC",
			visibility:"MEM_CHN"
		})
	})
}