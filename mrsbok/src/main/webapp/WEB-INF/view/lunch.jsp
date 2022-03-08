<%--
  Created by IntelliJ IDEA.
  User: Mason
  Date: 2021-12-31
  Time: 오후 10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>식당 선택하기</title>
    <link href="./css/lunch.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>
    
</head><%----%><%----%><%----%><%----%><%----%><%----%><%----%><%----%><%----%><%----%>
<body onload="printClock()"><%----%><%----%><%----%><%----%><%----%><%----%><%----%>
<div class="popup_bg">
    <div class="append_popup append_store">
        <h3>식당 추가</h3>
        <div>
            <form>
                <dl>
                    <dt>식당 이름</dt>
                    <dd><input type="text" name="store" placeholder="식당 이름을 입력해주세요."></dd>
                </dl>
                <dl>
                    <dt>최소주문금액</dt>
                    <dd>
                        <input type="text" name="minimum_price" class="input_price" placeholder="최소주문금액을 입력해주세요.">원
                    </dd>
                </dl>
                <dl>
                    <dt>배달팁</dt>
                    <dd>
                        <input type="text" name="delivery_tip" class="input_price" placeholder="배달팁을 입력해주세요.">원
                    </dd>
                </dl>
                <dl>
                    <dt>배달설명</dt>
                    <dd>
                        <input type="text" name="delivery_detail" placeholder="배달설명을 입력해주세요.">
                    </dd>
                </dl>
            </form>
            <div class="btn_box">
                <button type="button" class="btn_append btn_append_mainMenu">추가</button>
                <button type="button" class="btn_cancel">취소</button>
            </div><%--.btn_box--%>
        </div>
    </div><%--.append_store--%>
</div><%--.popup_bg--%>

<div class="wraper">
    <div class="header">
        <h1 class="logo" onclick="location.reload()">식당 선택</h1>
        <div class="dateAndTime">
            <div id="date"></div>
            <div id="clock"></div>
        </div><%--.dateAndTime--%>
        
        <div class="myBox">
            <c:if test="${!empty choiceStore}">
                <%--<c:if  test="${choiceStore.store_seq eq 1}">--%>
                    <div class="myPick">
                        <dl>
                            <dt>
                                내가 선택한 사무실 :
                            </dt>
                            <dd>
                                <c:if test="${choiceStore.office eq 'OfficeB'}">
                                    사무실B
                                </c:if>
                                <c:if test="${choiceStore.office eq 'OfficeA'}">
                                    사무실A
                                </c:if>
                            </dd>
                        </dl>
                        <dl>
                            <dt>내가 선택한 식당 :</dt>
                            <dd>&nbsp;${choiceStore.storePicked}</dd>
                        </dl>
                    </div><%--.myPick--%>
                <%--</c:if>--%>
            </c:if>
            <button type="button" class="doNotEat" onclick="doNotEat()">식사 X</button>
            <button class="logout" onclick="location.href='/api/logout'">${id}님 로그아웃</button>
        </div><%--.myBox--%>
    </div>

    <div class="container">
        <div class="office">
            <h3>사무실 선택</h3>
            <c:if  test="${empty choiceStore}">
                <input type="radio" name="office" id="OfficeA" value="OfficeA"/><label for="OfficeA">사무실A</label>
                <input type="radio" name="office" id="OfficeB" value="OfficeB"/><label for="OfficeB">사무실B</label>
            </c:if>
            <c:if  test="${!empty choiceStore}">
                <c:if test="${choiceStore.office eq 'OfficeB'}">
                    <input type="radio" name="office" id="OfficeA" value="OfficeA"/><label for="OfficeA">사무실A</label>
                    <input type="radio" name="office" id="OfficeB" value="OfficeB" checked/><label for="OfficeB">사무실B</label>
                </c:if>
                <c:if test="${choiceStore.office eq 'OfficeA'}">
                    <input type="radio" name="office" id="OfficeA" value="OfficeA" checked/><label for="OfficeA">사무실A</label>
                    <input type="radio" name="office" id="OfficeB" value="OfficeB"/><label for="OfficeB">사무실B</label>
                </c:if>
            </c:if>
        </div>

        <div class="menu" id="menu">
            <c:choose>
                <c:when test="${empty storeList}">
                    등록된 식당이 없습니다.
                    새로고침 또는 식당을 DB에 추가해주세요.
                </c:when>
                <c:otherwise>
                    <c:forEach var="store" items="${storeList}">
                        <c:choose>
                            <c:when test="${choiceStore.storePicked eq store.store}">
                                <button class="store active" value="${store.store}">${store.store}</button>
                            </c:when>
                            <c:otherwise>
                                <button class="store" value="${store.store}">${store.store}</button>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <button class="addStore">+</button>
        </div>
    </div><%--.container--%>
    
    <%-- 식당 선택 현황 시작 --%>
    <div class="storePicked">
        <div class="OfficeA">
        
        </div><%--.OfficeA--%>
        <div class="OfficeB">
        
        </div><%--.OfficeB--%>
    </div><%--.storePicked--%>
    
    <%-- 식당 선택 현황 끝 --%>
</div><%--.wraper--%>


<%-- 팝업 시작 --%>
<%--<div class="layer-popup" id="layer-popup">--%>
<%--    <div class="modal-dialog">--%>
<%--        <div class="modal-content">--%>
<%--            팝업 내용입니다.--%>
<%--        </div>--%>
<%--        <button type="button" class="btn-store-choice" id="btn-store-choice" onclick="pickingStore(this.value)">식당 선택하기</button>--%>
<%--    </div>--%>
<%--</div>--%>
<%-- 팝업 끝 --%>

<script>
    // 식사 안함
    function doNotEat(){
        Swal.fire({
            title: '정말 식사를 하지 않으시겠습니까?',
            text: "낙 장 불 입",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            confirmButtonText: '네',
            cancelButtonColor: '#d33',
            cancelButtonText: '아니오'
        }).then((result) => {
            // 식사 진짜로 안함 확정
            if (result.isConfirmed) {
               
                $.ajax({
                    url:"/api/noLunchToday",
                    method : "POST",
                    success:function (data) {
                        if (data.result == 'success') {
                            Swal.fire({
                                title: '식사 X ',
                                icon: 'success',
                                confirmButtonText: '확인'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    location.reload();
                                }
                            });
                        }else {
                            alert('식사 X error')
                        }
                    },
                    error:function(e){
                        alert(e+"\nerror");
                    }
                });
            }
        })
    }

    // 식당 메뉴 팝업
    function popUpMenu(store){
        /*let target = $('').attr("href");*/
        let office_inputs = document.querySelector("input[name=office]:checked");
        
        if(!office_inputs){
            // 사무실 미선택
            Swal.fire({
                title: "사무실을 선택하셨나요?",
                text: "사무실을 선택하세요!",
                icon: "warning",//"info,success,warning,error" 중 택1
                confirmButtonText: "확인"
            });
        }else{
            // 사무실 선택
            $('.layer-popup').addClass("show");
            $('.modal-content').html('<img src="./img/'+store+'.jpg" alt="'+store+'대표메뉴사진'+'"/>');
            $('button#btn-store-choice').val(store);
        }
    }
    
    // 외부영역 클릭 시 팝업 닫기
    $(document).mouseup(function (e){
        let LayerPopup = $(".layer-popup");
        if(LayerPopup.has(e.target).length == 0){
            LayerPopup.removeClass("show");
        }
    });
</script>
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
        
        // 10시 20분에 돌림판 돌리고
        // /menu로 넘기기 돌리기
        if(currentMinute == 20){
            if(currentHours == 10){
                Swal.fire({
                    title: ' 메뉴선택 페이지로 이동합니다 ',
                    icon: 'success',
                    confirmButtonText: '확인'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.href='./menu';
                    }
                });
            }
        }
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

<script>
    // 사무실A, 사무실B 선택된 식당 목록 페이지 로드
    $(function (){
        $("div.OfficeA").load("./lunch_officeA");
        $("div.OfficeB").load("./lunch_officeB");

        setInterval(function (){
            $("div.OfficeA").load("./lunch_officeA");
            $("div.OfficeB").load("./lunch_officeB");
        },5000);
    });
</script>

<script>
    // 파이차트
    let dataset;
    let labels;
    let datasets;
    let config;
    let canvasOfficeA;
    let canvasOfficeB;
    let pieChart;
    let checkStoreListOfficeA;
    let storeResult;
    let choiceCountARR;
    let choiceStoreARR;
    let bgColor;
</script>

<script>
    $(document).ready(function (){
        // 식당 선택시
       $("div.menu button.store").click(function (){
           if($("div.office input:checked").length == 0){
               // 사무실 미선택
               Swal.fire({
                   title: "사무실을 선택하셨나요?",
                   text: "사무실을 선택하세요!",
                   icon: "warning",//"info,success,warning,error" 중 택1
                   confirmButtonText: "확인"
               });
           }else{
               $(this).siblings('button').removeClass('active');
               $(this).addClass('active');
    
               Swal.fire({
                   title: $(this).val(),
                   text: "선택하시겠습니까?",
                   icon: "info",//"info,success,warning,error" 중 택1
                   showCancelButton: true,
                   confirmButtonColor: '#3085d6',
                   confirmButtonText: '네',
                   cancelButtonColor: '#d33',
                   cancelButtonText: '아니오'
               }).then((result) => {
                   if (result.isConfirmed) {
                       // 식당 선택 동의
                       let StorePickedVO = {
                           "storePicked" : $(this).val(),
                           "office" : $("div.office input:checked").val()
                       }
                       
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
                               }else {
                                   alert('식당 선택 error')
                               }
                           },
                           error:function(e){
                               alert(e+"\nerror");
                               console.log(e);
                           }
                       });
                   }else{
                       // 식당 선택 거절
                       $("div.menu button.store").removeClass('active');
                   }
               });
           }
       });
       
       // 식당 추가 팝업 띄우기
       $("button.addStore").click(function (){
           $("div.popup_bg").css("display","flex");
           $("div.append_store").css("display","block");
       });
    
        // 팝업 닫기
        $("button.btn_cancel").click(function(){
            $("div.append_popup").css("display","none");
            $("div.append_popup form")[0].reset();
            $("div.popup_bg").css("display","none");
        });
    
        // 가격 input
        $("input.input_price").on("keyup", function() {
            $(this).val(addComma($(this).val().replace(/[^0-9]/g,"")));
        });
    
        //천단위마다 콤마 생성
        function addComma(data) {
            return data.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        
        // 찐 식당 추가 클릭시
        $("button.btn_append").click(function(){
            let store = $("input[name=store]").val();
            if(!store){
                Swal.fire({
                    text: "식당 이름을 입력해주세요.",
                    icon: "warning",//"info,success,warning,error" 중 택1
                    confirmButtonText: "확인"
                });
                return false;
            }else{
                let minimum_price = $("input[name=minimum_price]").val();
                let delivery_tip = $("input[name=delivery_tip]").val();
                let delivery_detail = $("input[name=delivery_detail]").val();
                
                let VO = {
                    "store" : store,
                    "minimum_price" : minimum_price,
                    "delivery_tip" : delivery_tip,
                    "delivery_detail" : delivery_detail,
                }
    
                // ajax 통신하기
                $.ajax({
                    url:"/api/insertNewStore",
                    method : "POST",
                    data : JSON.stringify(VO),
                    contentType : "application/json",
                    success:function (data) {
                        Swal.fire({
                            title: "식당을 추가하였습니다.",
                            icon: "success",//"info,success,warning,error" 중 택1
                            confirmButtonText: "확인"
                        }).then((result) => {
                            location.reload();
                        });
                    },
                    error:function(e){
                        alert(e+"\nerror");
                    }
                });
            }
        });
    });
</script>

</body>
</html>
