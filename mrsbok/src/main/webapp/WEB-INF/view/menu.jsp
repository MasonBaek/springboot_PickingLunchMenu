<%--
  Created by IntelliJ IDEA.
  User: Mason
  Date: 2022-01-04
  Time: 오후 3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<meta name="viewport" content="user-scalable=0, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, width=device-width" />
	<link href="./css/lunch.css" rel="stylesheet">
	<title>메뉴선택하기</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body onload="printClock()">
	<div id="menu">
		<div class="popup_bg">
			<div class="append_popup append_mainMenu">
				<h3>메인 메뉴 추가<span>?</span><img src="./img/mainMenuExplain.png"></h3>
				<div>
					<form>
						<dl>
							<dt>메인 메뉴 이름</dt>
							<dd><input type="text" name="mainMenu_name" placeholder="메인메뉴 이름을 입력해주세요."></dd>
						</dl>
						<dl>
							<dt>메인 메뉴 가격</dt>
							<dd>
								<input type="text" name="mainMenu_price" class="input_price" placeholder="메인메뉴 가격을 입력해주세요.">원
							</dd>
						</dl>
						<dl>
							<dt>메인 메뉴 설명</dt>
							<dd>
								<input type="text" name="mainMenu_amount" placeholder="메인메뉴 설명을 입력해주세요. (적으면 좋고, 없으면 안적어도 됨)">
							</dd>
						</dl>

					</form>
					<div class="btn_box">
						<button type="button" class="btn_append btn_append_mainMenu">추가</button>
						<button type="button" class="btn_cancel">취소</button>
					</div><%--.btn_box--%>
				</div>
			</div><%--.append_mainMenu--%>
			<div class="append_popup append_subMenu">
				<h3>선택 사항 추가</h3>
				<div>
					<form>
						<dl>
							<dt>선택 사항 제목</dt>
							<dd><input type="text" name="subMenu_title" placeholder="선택사항 제목을 입력해주세요."></dd>
						</dl>
						<dl>
							<dt>선택 사항 종류</dt>
							<dd class="dd_type">
								<div><input type="radio" name="subMenu_type" value="single" id="single"><label for="single">단일 선택</label></div>
								<div><input type="radio" name="subMenu_type" value="multiple" id="multiple"><label for="multiple">다중 선택</label></div>
							</dd>
						</dl>
						<dl>
							<dt>선택 항목 추가<button type="button" class="add_option"><img src="../../img/icon_plus.png"></button></dt>
							<dd>
								<ul>
									<li><input type="text" name="subMenu_name[]" placeholder="이름을 입력해주세요."><input type="text" name="subMenu_option_price[]" class="input_price" placeholder="가격을 입력해주세요.">원</li>
									<li><input type="text" name="subMenu_name[]" placeholder="이름을 입력해주세요."><input type="text" name="subMenu_option_price[]" class="input_price" placeholder="가격을 입력해주세요.">원<button class="btn_remove">ㅡ</button></li>
								</ul>
							</dd>
						</dl>
					</form>
					<div class="btn_box">
						<button type="button" class="btn_append btn_append_subMenu">추가</button>
						<button type="button" class="btn_cancel">취소</button>
					</div><%--.btn_box--%>
				</div>
			</div><%--.append_subMenu--%>
			<div class="append_popup append_addMenu">
				<h3>추가 메뉴 추가</h3>
				<div>
					<form>
						<dl>
							<dt>추가메뉴 이름</dt>
							<dd><input type="text" name="addMenu_name" placeholder="추가메뉴 이름을 입력해주세요."></dd>
						</dl>
						<dl>
							<dt>추가 메뉴 가격</dt>
							<dd>
								<input type="text" name="addMenu_price" class="input_price" placeholder="추가메뉴 가격을 입력해주세요.">원
							</dd>
						</dl>
					
					</form>
					<div class="btn_box">
						<button type="button" class="btn_append btn_append_addMenu">추가</button>
						<button type="button" class="btn_cancel">취소</button>
					</div><%--.btn_box--%>
				</div>
			</div><%--.append_mainMenu--%>
		</div><%--.popup_bg--%>
		
		<div class="dateAndTime">
			<div id="date"></div>
			<div id="clock"></div>
			<div class="lunchCountBox">
				<button>
					식사 인원 현황
				</button>
				<div>

				</div>
			</div><%--.lunchCountBox--%>
		</div><%--.dateAndTime--%>
		
		<div class="menu_container">
			<section class="office_section">
				<input type="radio" name="office" id="사무실A" value="OfficeA"><label for="사무실A" class="office">사무실A<span class="${OfficeAStore}"><input type="hidden" value="">${OfficeAStore}</span></label>
				<input type="radio" name="office" id="사무실B" value="OfficeB"><label for="사무실B" class="office">사무실B<span class="${OfficeBStore}"><input type="hidden" value="">${OfficeBStore}</span></label>
			</section><%--.office_section--%>
			
			<section class="menu_section mainMenu_section">
				<div class="black_bg"></div><%--.black_bg--%>
				<dl>
					<dt>
						메인메뉴
						<button class="appendBtn mainMenu" type="button">추가</button>
					</dt>
					<dd>
						<div>
							<div class="non_menu">메뉴가 없습니다.</div>
							<%--메인메뉴 리스트 뿌려주기--%>
						</div>
					</dd>
				</dl>
			</section><%--.menu_section--%>
			
			<section class="menu_section subMenu_section">
				<div>
					<dl class="subMenu_dl">
						<dt>
							선택 사항
							<span>선택사항을 입력해주세요.</span>
						</dt>
						<dd>
							<textarea name="options"></textarea>
						</dd>
					</dl>
					<dl class="addMenu_dl">
						<dt>
							추가메뉴
							<span>추가메뉴를 입력해주세요.</span>
						</dt>
						<dd>
							<textarea name="addMenu"></textarea>
						</dd>
					</dl>
				</div>
				
				<div class="btn_box">
					<button type="button" class="btn_order">주문</button>
				</div>
			</section><%--.subMenu_section--%>

			<section class="myOrder_section">
			
			</section>
			
			<section class="orderList_section">
				<h2>주문내역</h2>
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
      $("div.menu_container section.myOrder_section").load("./myOrderList?");
      
	    // 사무실 선택시 메뉴 뿌려주기
	    $.fn.subMenuLoad = function (){
        $("section.mainMenu_section ul li").on('click', function (){
          $(this).addClass('active').siblings().removeClass('active');
        });
	    }

      $('input[name="office"]').change(function() {
        $("section.mainMenu_section dd div").load("./mainMenuList?office="+$(this).val(), function (){
          // 메인메뉴 선택시
          $.fn.subMenuLoad();
          return false;
        });
        $("section.orderList_section").load("./orderList?office="+$(this).val());
      });

      // 가격 input
      $("input.input_price").on("keyup", function() {
        $(this).val(addComma($(this).val().replace(/[^0-9]/g,"")));
      });

      //천단위마다 콤마 생성
      function addComma(data) {
        return data.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }
      
      // 메뉴 추가 팝업 띄우기
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
          let popup_bg = $("div.popup_bg");
          let mainMenu_popup = $("div.append_mainMenu");
          let subMenu_popup = $("div.append_subMenu");
          let append_addMenu = $("div.append_addMenu");

          popup_bg.css("display", "flex");
          
          if($(this).hasClass("mainMenu")){
            mainMenu_popup.css("display", "block");
          }else if($(this).hasClass("subMenu")){
            subMenu_popup.css("display", "block");
          }else if($(this).hasClass("addMenu")){
            append_addMenu.css("display", "block");
          }
        }
	    });
      
      // 팝업 닫기
      $("button.btn_cancel").click(function(){
        $("div.append_popup").css("display","none");
        $("div.append_popup form")[0].reset();
        $("div.popup_bg").css("display","none");
      });

	    // 메뉴 추가하기
	    $("button.btn_append").click(function(){
        let VO;
        let url;
        let swal;
		    
        // 메인 메뉴 추가할때
        let mainMenuName = $('input[name="mainMenu_name"]').val();
        let mainMenuPrice = $('input[name="mainMenu_price"]').val().replace(",","");
        let mainMenuAmount = $('input[name=mainMenu_amount]').val();
        let store = $('input[name=store]').val();
        if(!mainMenuName){
          Swal.fire({
            text: "메인 메뉴 이름을 입력해주세요.",
            icon: "warning",//"info,success,warning,error" 중 택1
            confirmButtonText: "확인"
          });
          return false;
        }
        if(!mainMenuPrice){
          Swal.fire({
            text: "메인 메뉴 가격을 입력해주세요.",
            icon: "warning",//"info,success,warning,error" 중 택1
            confirmButtonText: "확인"
          });
          return false;
        }
				
        url = "/api/insertMainMenu";
        VO = {
          "store" : store,
          "menu" : mainMenuName,
          "price" : mainMenuPrice,
          "info" : mainMenuAmount
        }
        
        console.log(VO);
        
        office = $("section.office_section input:checked").val();
        swal = function (seq){
          Swal.fire({
            title: "메인 메뉴 추가 완료",
            icon: "success",//"info,success,warning,error" 중 택1
            confirmButtonText: "확인"
          }).then((result) => {
            if (result.isConfirmed) {
              $("#menu div.popup_bg").css("display","none");
              $("div.append_mainMenu").css("display","none");
              $("section.mainMenu_section dd div").load("./mainMenuList?office="+$("section.office_section input[name=office]:checked").val(), function (){
                $("section.mainMenu_section ul li").click( function (){
									// 사무실 선택시 메뉴 뿌려주기
                  $('input[name="office"]').change(function() {
                    $("section.mainMenu_section dd div").load("./mainMenuList?office="+$(this).val(), function (){
                      // 메인메뉴 선택시
                      $.fn.subMenuLoad = function (){
                        $("section.mainMenu_section ul li").on('click', function (){
                          $("section.subMenu_section dl.subMenu_dl dd").load("./subMenuList?menu_seq="+$(this).prop('class'));
                          $("section.subMenu_section dl.addMenu_dl dd").load("./addMenuList?menu_seq="+$(this).prop('class'));
                          $(this).addClass('active').siblings().removeClass('active');
                        });
                      }

                      $.fn.subMenuLoad();
                      return false;
                    });
                  });
                });
                
                $("section.mainMenu_section ul li." + seq).addClass('active');
                $("section.mainMenu_section ul").animate({
                  scrollTop: $("section.mainMenu_section ul").prop('scrollHeight')
                },500);
              });
            }
          });
        }

        // ajax 통신하기
        $.ajax({
          url:url,
          method : "POST",
          data : JSON.stringify(VO),
          contentType : "application/json",
          success:function (data) {
            if(Number(data.result) > 0 ){
              swal(Number(data.result));
            }
            // if (data.result == 'success') {
            //   swal();
            // }else if(data.result == success){
            //   alert('문자열아이다잉')
            // }else {
            //   alert('식당 선택 error')
            // }
          },
          error:function(e){
            alert(e+"\nerror");
          }
        });
	    });
      
      $("div.append_mainMenu h3 span").on("mouseover", function (){
        $("div.append_mainMenu h3 img").css("display","block");
      });
      $("div.append_mainMenu h3 span").on("mouseout", function (){
        $("div.append_mainMenu h3 img").css("display","none");
      });
      
      
      
      // 주문하기 클릭시
      $("button.btn_order").click(function (){
        if($('input[name=office]:checked').length == 0){
          // 식당(사무실) 미선택시
          Swal.fire({
            title: "식당(사무실)을 선택해주세요.",
            icon: "warning",//"info,success,warning,error" 중 택1
            confirmButtonText: "확인"
          });
          return false;
        }else if($('input[name=office]:checked').length == 1){
          // 식당(사무실) 선택시
	        if($("section.mainMenu_section ul li.active").length == 0){
            // 메인메뉴 미선택시
            Swal.fire({
              title: "메인메뉴를 선택해주세요.",
              icon: "warning",//"info,success,warning,error" 중 택1
              confirmButtonText: "확인"
            });
            return false;
	        }
        }
        
        let date = new Date();
        let menu_seq = $("section.mainMenu_section ul li.active input").val();
        let office = $("section.office_section input:checked").val();
        let store = $("section.office_section input:checked").next().children("span").attr("class");
        let menu_name = $("section.mainMenu_section ul li.active span.menu_name").text();
        let options = $("textarea[name=options]").val();
        let addMenu = $("textarea[name=addMenu]").val();
				let price = $("")
        let url = "/api/insertChoiceMenu";
        let VO = {
          "menu_seq" : menu_seq,
	        "office" : office,
          "id" : 	"${id}",
	        "store" : store,
          "menu" : menu_name,
          "menu_option" : options,
          "addmenu" : addMenu,
        }
	      
        console.log(VO);
        
        // ajax 통신하기
        $.ajax({
          url:url,
          method : "POST",
          data : JSON.stringify(VO),
          contentType : "application/json",
          success:function (data) {

              if(data.result == 'success'){
                Swal.fire({
                  title: "주문을 완료하였습니다.",
                  icon: "success",//"info,success,warning,error" 중 택1
                  confirmButtonText: "확인"
                }).then((result) => {
                  $("section.myOrder_section").load("./myOrderList");
                  $("section.orderList_section").load("./orderList?office="+office);
                  $("textarea[name=options]").val('');
                  $("textarea[name=addMenu]").val('');
                  $("#menu .menu_container > section.menu_section dl dd ul li.active").removeClass("active");
                });
              }
              
              
              

            // if (data.result == 'success') {
            //   swal();
            // }else if(data.result == success){
            //   alert('문자열아이다잉')
            // }else {
            //   alert('식당 선택 error')
            // }
          },
          error:function(e){
            alert(e+"\nerror");
          }
        });
        
      });
      
      // 식사 현황 가져오기
	    $("div.lunchCountBox button").click(function (){
        $("div.lunchCountBox div").toggle(function (){
          $("div.lunchCountBox div").load("./lunchCount");
        });
	    });
    });
    
	</script>
</body>
</html>
