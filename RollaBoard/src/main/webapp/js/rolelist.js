

 $(document).ready( function() {
	 
        //글자 byte 수 제한
        $('.byteLimit').blur(function(){
                          
            var thisObject = $(this);
              
            var limit = thisObject.attr("limitbyte"); //제한byte를 가져온다.
            var str = thisObject.val();
            var strLength = 0;
            var strTitle = "";
            var strPiece = "";
            var check = false;
                      
            for (i = 0; i < str.length; i++){
                var code = str.charCodeAt(i);
                var ch = str.substr(i,1).toUpperCase();
                //체크 하는 문자를 저장
                strPiece = str.substr(i,1)
                  
                code = parseInt(code);
                  
                if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))){
                    strLength = strLength + 3; //UTF-8 3byte 로 계산
                }else{
                    strLength = strLength + 1;
                }
                  
                if(strLength>limit){ //제한 길이 확인
                    check = true;
                    alert(check);
                    break;
                }else{
                    strTitle = strTitle+strPiece; //제한길이 보다 작으면 자른 문자를 붙여준다.
                }
                  
            }
              
            if(check){
                alert(limit+"byte 초과된 문자는 잘려서 입력 됩니다.");
            }
            
            thisObject.val(strTitle);
              
        });
    });
 