/*
 * 웹 소켓 연결 
 * */



var log =function(s) {	// 메시지를 받았을 때 받은 메시지로 뭘 할지
	document.getElementById( "output" ).textContent += ( s + "\n" ) ;
	
}

w = new WebSocket( "ws://localhost:8080/rollaboard/broadcasting" ) ;
w.onopen = function() {
	alert( "WebSocket Connected!!!" ) ;
}
w.onmessage = function(e) {	// 메시지를 받았을 때
	//받은 메시지를 예쁘게 바꿔야 한다.
	// 01 메시지 분해
	var txtData = e.data.toString().split("|&|");
	// 02 처리
	if(txtData.length == 3){	// 보통 메시지일 때
		// 채팅 구역에 표시
		var msgLine1 = $("<b></b>").text(txtData[0]);
		var msgLine2 = txtData[2];
		$("#chatTextArea").append(msgLine1, msgLine2);
		
	}else if(txtData.length == 2){	// 특수 메시지일 때
		if(txtData[1] == "BADGE"){
			
		}
	}
	
	log( e.data.toString() ) ;	// log함수에 받은 메시지를 전달
}
w.onclose = function(e) {
	log( "WebSocket closed!!! : ") ;
}
w.onerror = function( e ) {
	log( "WebSocket error!!!" ) ;
}

window.onload = function() {
/*	document.getElementById("send_button").onclick = function(){
		if( document.getElementById( "nickname" ).value == "" ){
			alert( "별명을 입력하세요" ) ;
		} else {
			var nickname = document.getElementById( "nickname" ).value ;
			var input = document.getElementById( "input" ).value ;
			//w.send( nickname + "> " + input ) ;
			w.send( nickname + ", " + input ) ;	//☆★메시지를 전송하는 부분☆★
		}
	}*/
}

/////////////////////////////////////////////////////////////////////////// 연결부 끝


