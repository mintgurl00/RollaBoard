<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.spring.rollaboard.task.TaskVO"%>
<%
String location = request.getParameter("location");
System.out.println("태스크 위치2: " + location);
%>

<!DOCTYPE html>
<html>

  <head>
    <title>Geocoding service</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">

    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
    </style>
    
  </head>

  <body>

    <div id="floating-panel">
      <input id="address" type="textbox" value="<%=location %>">
      <input id="submit" type="button" value="search">
    </div>
    
    <div id="map"></div>
    <script>
    //처음 맵 상태
      function initMap() {
    	
    	
        var map = new google.maps.Map(document.getElementById('map'), { //구글맵을 불러와 map에 저장
          zoom: 15
          //center: {lat: -34.397, lng: 150.644} //이 때 지도 가운데에 위치할 위도, 경도값
        });
        
        var geocoder = new google.maps.Geocoder(); //지오코더 불러옴
        
        geocodeAddress(geocoder, map);

        document.getElementById('submit').addEventListener('click', function() {
          geocodeAddress(geocoder, map); //'검색' 버튼 클릭하면 아래 메소드 호출(geocoder, map 객체 전달)
        });
      }
   
    //주소 검색 시
      function geocodeAddress(geocoder, resultsMap) {
        var address = document.getElementById('address').value; //검색창에 입력한 주소를 address에 저장
        
        geocoder.geocode({'address': address}, function(results, status) { //지오코더의 geocode메소드를 이용해 address를 위도, 경도 정보로 변환
          if (status === 'OK') {
            resultsMap.setCenter(results[0].geometry.location); //resultsMap은 위에서 불러온 구글맵. 괄호 안의 위치를 지도 가운데로
            var marker = new google.maps.Marker({
              map: resultsMap,
              position: results[0].geometry.location //마커 포지션은 위에서 가져온 위치
            });
          } else {
            alert('Geocode was not successful for the following reason: ' + status);
          }
        });
      }
    </script>
    
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAusOrhQtlhsJhJl1UD0Es_b1As0thorrM&callback=initMap"></script>

  </body>
 
</html>
