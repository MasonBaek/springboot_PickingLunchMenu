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
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body onload="printClock()">
	<div id="menu">
		<div class="dateAndTime">
			<div id="date"></div>
			<div id="clock"></div>
		</div><%--.dateAndTime--%>
		
		<div class="menu_container">
			<section class="office_section">
				<input type="radio" name="office" id="복부인" value="bok"><label for="복부인" class="office">복부인<span class="${bokStore}">${bokStore}</span></label>
				<input type="radio" name="office" id="더재무" value="the"><label for="더재무" class="office">더재무<span class="${theStore}">${theStore}</span></label>
			</section><%--.office_section--%>
			
			<section class="menu_section mainMenu_section">
				<div class="black_bg"></div><%--.black_bg--%>
				<dl>
					<dt>
						메인메뉴
					</dt>
					<dd>
						<form>
							<input type="text" name="main_menu" placeholder="메인메뉴를 추가해주세요."><input type="text" name="main_menu_price" class="input_price" placeholder="가격을 입력해주세요.">원<button class="appendBtn mainMenu" type="button">추가</button>
						</form>
						
						<ul>
							<%--메인메뉴 리스트 뿌려주기--%>
						</ul>
					</dd>
				</dl>
			</section><%--.menu_section--%>
			
			<section class="menu_section subMenu_section">
				<div class="black_bg"></div><%--.black_bg--%>
				<dl>
					<dt>
						선택 사항
					</dt>
					<dd>
						<form>
							<input type="text" placeholder="선택사항을 추가해주세요."><input type="text" placeholder="가격을 입력해주세요.">원<button class="appendBtn subMenu" type="button">추가</button>
						</form>
						<ul>
							<li>없음</li>
							<li>선택 사항 1<span>0원</span></li>
							<li>선택 사항 1<span>500원</span></li>
							<li>선택 사항 1<span>1,000원</span></li>
							<li>선택 사항 1<span>1,000원</span></li>
							<li>선택 사항 1<span>1,000원</span></li>
						</ul>
					</dd>
				</dl>
				<dl>
					<dt>
						추가메뉴
					</dt>
					<dd>
						<form>
							<input type="text" placeholder="추가메뉴를 추가해주세요."><input type="text" placeholder="가격을 입력해주세요.">원<button class="appendBtn addMenu" type="button">추가</button>
						</form>
						<ul>
							<li>없음</li>
							<li>추가 메뉴 1<span>1,000원</span></li>
							<li>추가 메뉴 2<span>1,000원</span></li>
							<li>추가 메뉴 3<span>1,000원</span></li>
							<li>추가 메뉴 3<span>1,000원</span></li>
							<li>추가 메뉴 4<span>1,000원</span></li>
						</ul>
					</dd>
				</dl>
			</section><%--.subMenu_section--%>

			<section class="orderList_section">
				<div class="myOrder">
					<h2>나의 주문내역</h2>
					<div>
						<dl>
							<dt>메인 메뉴</dt>
							<dd>메인 메뉴 1</dd>
						</dl>
						<dl>
							<dt>선택 사항</dt>
							<dd>선택 사항 1</dd>
						</dl>
						<dl>
							<dt>추가 메뉴</dt>
							<dd>없음</dd>
						</dl>
						<span class="price">9,000원</span>
					</div>
				</div><%--.myOrder--%>
				<div class="order_list bokOrderList">
					<h2>
						복부인 주문목록
					</h2>
					<ul>
						<li>
							<h3>이경환</h3>
							<dl>
								<dt>메인 메뉴</dt>
								<dd>메인 메뉴 1</dd>
							</dl>
							<dl>
								<dt>선택 사항</dt>
								<dd>선택 사항 1</dd>
							</dl>
							<dl>
								<dt>추가 메뉴</dt>
								<dd>없음</dd>
							</dl>
							<span class="price">9,000원</span>
						</li>
						<li>
							<h3>이경환</h3>
							<dl>
								<dt>메인 메뉴</dt>
								<dd>메인 메뉴 1</dd>
							</dl>
							<dl>
								<dt>선택 사항</dt>
								<dd>선택 사항 1</dd>
							</dl>
							<dl>
								<dt>추가 메뉴</dt>
								<dd>없음</dd>
							</dl>
							<span class="price">9,000원</span>
						</li>
					</ul>
				</div><%--.bokOrderList--%>
				<div class="order_list theOrderList">
					<h2>더재무 주문목록</h2>
					<ul>
						<li>
							<h3>이경환</h3>
							<dl>
								<dt>메인 메뉴</dt>
								<dd>메인 메뉴 1</dd>
							</dl>
							<dl>
								<dt>선택 사항</dt>
								<dd>선택 사항 1</dd>
							</dl>
							<dl>
								<dt>추가 메뉴</dt>
								<dd>없음</dd>
							</dl>
							<span class="price">9,000원</span>
						</li>
						
					</ul>
				</div><%--.theOrderList--%>
			</section><%--.orderList_section--%>
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
	<script>
    $(document).ready(function(){
      // 사무실 선택시 메뉴 뿌려주기
      $('input[name="office"]').change(function() {
        $("section.mainMenu_section ul").load("./mainMenuList?office="+$(this).val());
      })

      // 가격 input
      $("input.input_price").on("keyup", function() {
        $(this).val(addComma($(this).val().replace(/[^0-9]/g,"")));
      });

      //천단위마다 콤마 생성
      function addComma(data) {
        return data.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }
      
      // 메뉴 추가
	    $("button.appendBtn").click(function (){
        if($('input[name=office]:checked').length == 0){
          // 식당(사무실) 미선택시
          Swal.fire({
            title: "식당(사무실)을 선택해주세요.",
            icon: "warning",//"info,success,warning,error" 중 택1
            confirmButtonText: "확인"
          });
          return false;
        }else if($('input[name=office]:checked').length == 1){
          if($(this).hasClass("mainMenu")){
            alert("메인메뉴");
          }else if($(this).hasClass("subMenu")){
            alert("선택사항");
          }else if($(this).hasClass("addMenu")){
            alert("추가메뉴");
          }
        }
	    });



    });
	</script>
	
	<script>
		function appendMenu(){
  
		}
		
    //식당 선택 버튼 클릭
    function pickingStore(storePicked) {
      let office = $('input[name="office"]:checked').val();
      let StorePickedVO = {
        "storePicked" : storePicked,
        "office" : office
      }
      // alert(JSON.stringify(StorePickedVO));
      if(storePicked!=''){
        $.ajax({
          url:"/api/choice",
          method : "POST",
          data : JSON.stringify(StorePickedVO),
          contentType : "application/json",
          success:function (data) {
            if (data.result == 'success') {
              Swal.fire({
                title: "식당 선택 완료",
                icon: "success",//"info,success,warning,error" 중 택1
                confirmButtonText: "확인"
              }).then((result) => {
                if (result.isConfirmed) {
                  location.reload();
                }
              });
            }else if(data.result == success){
              alert('문자열아이다잉')
            }else {
              alert('식당 선택 error')
            }
          },
          error:function(e){
            alert(e+"\nerror");
          }
        });
      }
    }
	</script>
</body>
</html>
