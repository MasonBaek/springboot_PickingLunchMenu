<%--
  Created by IntelliJ IDEA.
  User: mrsbok
  Date: 2022-01-04
  Time: 오후 3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<link rel="icon" href="./img/logo.png">
	<link href="./css/lunch.css" rel="stylesheet">
	<title>메뉴선택하기</title>
</head>
<body onload="printClock()">
	<div id="menu">
		<div class="dateAndTime">
			<div id="date"></div>
			<div id="clock"></div>
		</div><%--.dateAndTime--%>
		
		<div class="menu_container">
			<section class="office_section">
				<input type="radio" name="office" id="복부인" value="bok"><label for="복부인">복부인<span>식당이름</span></label>
				<input type="radio" name="office" id="더재무" value="the"><label for="더재무">더재무<span>식당이름</span></label>
			</section><%--.office_section--%>
			<section class="menu_section">
				<ul>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴12312</button></li>
					<li><button type="button" onclick="">메뉴12312312312312</button></li>
					<li><button type="button" onclick="">메뉴123123</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴123123</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴123123123</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴12312</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
					<li><button type="button" onclick="">메뉴</button></li>
				</ul>
			</section><%--.menu_section--%>
			<section class="subMenu_section">
			
			</section><%--.subMenu_section--%>
			<section class="orderList_section"></section><%--.orderList_section--%>
		</div><%--.menu_container--%>
	</div><%--#menu--%>
	
	<script>
    /* 날짜 및 시계  */
    function printClock() {  /* 시계  */
      let date = document.getElementById("date");
      let clock = document.getElementById("clock");  // 출력할 장소 선택
      let currentDate = new Date();  // 현재시간
      let calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth() + 1) + "-" + currentDate.getDate(); // 현재 날짜
      let amPm = 'AM'; // 초기값 AM
      let currentHours = addZeros(currentDate.getHours(), 2);
      let currentMinute = addZeros(currentDate.getMinutes(), 2);
      let currentSeconds = addZeros(currentDate.getSeconds(), 2);

      if(currentHours >= 12){ // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
        amPm = 'PM';
        // currentHours = addZeros(currentHours - 12,2);
      }

      // 실제로 10시 20분에 돌림판 돌리기
      if(currentMinute == 20){
        if(currentHours == 10){

        }
      }

      // 10시 21분부터는 메뉴페이지로 이동시키기
      /*
			if(currentMinute == 21){
					if(currentHours == 10){
							location.href = "./menu";
					}
			}
			*/
      /*
					if(currentSeconds >= 50){ // 50초 이상일 때 색을 변환해 준다.
					currentSeconds = '<span style="color:#de1951;">'+currentSeconds+'</span>'
					}
			*/
      let dateArr = calendar.split("-");
      let realDate = "";
      for(let i of dateArr){
        if(Number(i) < 10){
          i = "0" + i;
        }
        realDate += i + "-";
      }
      realDate = realDate.slice(0, -1);
      date.innerHTML = realDate;
      clock.innerHTML = currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size:50px;'>"+ amPm+"</span>"; //날짜를 출력해 줌

      setTimeout("printClock()",1000);         // 1초마다 printClock() 함수 호출
    }

    // 자릿수 맞춰주기
    function addZeros(num, digit) { // 자릿수 맞춰주기
      let zero = '';
      num = num.toString();
      if (num.length < digit) {
        for (let i = 0; i < digit - num.length; i++) {
          zero += '0';
        }
      }
      return zero + num;
    }
	
	</script>
</body>
</html>
