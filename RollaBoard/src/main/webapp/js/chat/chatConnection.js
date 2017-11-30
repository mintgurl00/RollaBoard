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
	log( e.data.toString() ) ;	// log함수에 받은 메시지를 전달
}
w.onclose = function(e) {
	log( "WebSocket closed!!! : ") ;
}
w.onerror = function( e ) {
	log( "WebSocket error!!!" ) ;
}

window.onload = function() {
	document.getElementById("send_button").onclick = function(){
		if( document.getElementById( "nickname" ).value == "" ){
			alert( "별명을 입력하세요" ) ;
		} else {
			var nickname = document.getElementById( "nickname" ).value ;
			var input = document.getElementById( "input" ).value ;
			//w.send( nickname + "> " + input ) ;
			w.send( nickname + ", " + input ) ;	//☆★메시지를 전송하는 부분☆★
		}
	}
}

/////////////////////////////////////////////////////////////////////////// 연결부 끝


