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
    <link rel="icon" href="./img/logo.png">
    <title>식당 선택하기</title>
    <link href="./css/lunch.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>
    
</head><%----%><%----%><%----%><%----%><%----%><%----%><%----%><%----%><%----%><%----%>
<body onload="printClock()"><%----%><%----%><%----%><%----%><%----%><%----%><%----%>
<div class="wraper">
    <div class="header">
        <h1 class="logo" onclick="location.reload()">식당 선택</h1>
        <div class="dateAndTime">
            <div id="date"></div>
            <div id="clock"></div>
        </div><%--.dateAndTime--%>
        
        <div class="myBox">
            <c:if  test="${choiceStore.chosen ne 0}">
                <div class="myPick">
                    <dl>
                        <dt>
                            내가 선택한 사무실 :
                        </dt>
                        <dd>
                            &nbsp;
                            <c:if test="${choiceStore.office eq 'the'}">
                                더재무
                            </c:if>
                            <c:if test="${choiceStore.office eq 'bok'}">
                                복부인
                            </c:if>
                        </dd>
                    </dl>
                    <dl>
                        <dt>내가 선택한 식당 :</dt>
                        <dd>&nbsp;${choiceStore.storePicked}</dd>
                    </dl>
                </div><%--.myPick--%>
            </c:if>
            <button type="button" class="doNotEat" onclick="doNotEat()">식사 X</button>
            <button class="logout" onclick="location.href='/api/logout'">${id}님 로그아웃</button>
        </div><%--.myBox--%>
    </div>

    <div class="container">
        <div class="office">
            <h3>사무실 선택</h3>
            <c:if  test="${choiceStore.chosen eq 0}">
                <input type="radio" name="office" id="bok" value="bok"/><label for="bok">복부인</label>
                <input type="radio" name="office" id="the" value="the"/><label for="the">더재무</label>
            </c:if>
            <c:if  test="${choiceStore.chosen eq 1}">
                <c:if test="${choiceStore.office eq 'the'}">
                    <input type="radio" name="office" id="bok" value="bok"/><label for="bok">복부인</label>
                    <input type="radio" name="office" id="the" value="the" checked/><label for="the">더재무</label>
                </c:if>
                <c:if test="${choiceStore.office eq 'bok'}">
                    <input type="radio" name="office" id="bok" value="bok" checked/><label for="bok">복부인</label>
                    <input type="radio" name="office" id="the" value="the"/><label for="the">더재무</label>
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
                            <c:when test="${choiceStore.storePicked eq store}">
                                <button class="store picked" value="${store}" onclick="popUpMenu(this.value)">${store}</button>
                            </c:when>
                            <c:otherwise>
                                <button class="store" value="${store}" onclick="popUpMenu(this.value)">${store}</button>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div>
    </div><%--.container--%>
    
    <%-- 식당 선택 현황 시작 --%>
    <div class="storePicked">
        <div class="officeBok">
        
        </div><%--.officeBok--%>
        <div class="officeThe">
        
        </div><%--.officeThe--%>
    </div><%--.storePicked--%>
    
    <%-- 식당 선택 현황 끝 --%>
</div><%--.wraper--%>


<%-- 팝업 시작 --%>
<div class="layer-popup" id="layer-popup">
    <div class="modal-dialog">
        <div class="modal-content">
            팝업 내용입니다.
        </div>
        <button type="button" class="btn-store-choice" id="btn-store-choice" onclick="pickingStore(this.value)">식당 선택하기</button>
    </div>
</div>
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
                Swal.fire({
                    title: '미식사로 확정!',
                    icon: 'success',
                    confirmButtonText: '확인'
                })
            }
        })
    }

    // 식당 메뉴 팝업
    function popUpMenu(storeName){
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
            $('.modal-content').html('<img src="./img/'+storeName+'.jpg" alt="'+storeName+'대표메뉴사진'+'"/>');
            $('button#btn-store-choice').val(storeName);
        }
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
    
    // 외부영역 클릭 시 팝업 닫기
    $(document).mouseup(function (e){
        let LayerPopup = $(".layer-popup");
        if(LayerPopup.has(e.target).length == 0){
            LayerPopup.removeClass("show");
        }
    });
</script>
<script>
    // 세로줄 사이즈 동적 제어
/*    function verticalResize(){
        let menu = document.getElementById('menu');
        let vertical = document.getElementById('vertical');

        vertical.style.height = menu.innerHeight + 'px';
    }*/
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

<script>
    // 복부인, 더재무 선택된 식당 목록 페이지 로드
    $(function (){
        $("div.officeBok").load("./lunch_officeBok");
        $("div.officeThe").load("./lunch_officeThe");

        setInterval(function (){
            $("div.officeBok").load("./lunch_officeBok");
            $("div.officeThe").load("./lunch_officeThe");
        },5000);
    });
</script>

<script>
    // 파이차트
    let dataset;
    let labels;
    let datasets;
    let config;
    let canvasBok;
    let canvasThe;
    let pieChart;
    let checkStoreListBok;
    let storeResult;
    let choiceCountARR;
    let choiceStoreARR;
    let bgColor;
</script>

</body>
</html>
