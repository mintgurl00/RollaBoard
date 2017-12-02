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
		alert();
		$("#none").load("createChatRoom.so",{
			name:"테스트",
			description:"기본",
			visibility:"PUBLIC",
			type:"MEM_CHN"
		})
		alert();
	})
}