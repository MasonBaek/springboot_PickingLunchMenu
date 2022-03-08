<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
	$(document).ready(function (){
    $("button.delete_order").click(function (event){
      Swal.fire({
        title: "해당 주문내역을 삭제하시겠습니까?",
        icon: "info",//"info,success,warning,error" 중 택1
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        confirmButtonText: '네',
        cancelButtonColor: '#d33',
        cancelButtonText: '아니오'
      }).then((result) => {
        if (result.isConfirmed) {
          // 주문 내역 삭제
          $.ajax({
            url:"/api/deleteOrder",
            method : "POST",
            data : JSON.stringify($(event.target).parent().siblings("input")[0].value),
            contentType : "application/json",
            success:function (data) {
              if (data.result == 'success') {
                Swal.fire({
                  title: "주문내역 삭제 완료",
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
    });
	});
</script>

<h2>나의 주문내역</h2>
<%--${myOrderList}--%>
<c:choose>
	<c:when test="${myOrderList eq null}">
		<ul class="myOrderList">
			<li>주문내역이 없습니다.</li>
		</ul>
	</c:when>
	<c:when test="${myOrderList[0].store eq 'noLunch'}">
		<ul class="myOrderList">
			<li class="store">
				오늘의 메뉴
			</li>
			<li>
				<input type="hidden" name="choicemenuseq" value="${myOrderList[0].choicemenuseq}">
				<button class="delete_order"><img src="./img/icon_close.png"></button>
				<dl>
					<dt>결식</dt>
				</dl>
			</li>
		</ul>
	</c:when>
	<c:otherwise>
		<ul class="myOrderList">
			<li class="store">
					${myOrderList[0].store}
			</li>
			<c:set var="totalPrice" value="0"/>
			<c:forEach var="myOrderList" items="${myOrderList}">
			<li>
				<input type="hidden" name="choicemenuseq" value="${myOrderList.choicemenuseq}">
				<button class="delete_order"><img src="./img/icon_close.png"></button>
				<dl>
					<dt>${myOrderList.menu}</dt>
					<c:if test="${!empty myOrderList.menu_option}">
						<dd><span>&#183; 선택사항 :</span><b>${myOrderList.menu_option}</b></dd>
					</c:if>
					<c:if test="${!empty myOrderList.addmenu}">
						<dd><span>&#183; 추가메뉴 :</span><b>${myOrderList.addmenu}</b></dd>
					</c:if>
				</dl>
			</li>
			</c:forEach>
		</ul>
	</c:otherwise>
</c:choose>

<%--
</jsp:root>--%>
