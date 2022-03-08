<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h2>${office} 주문내역</h2>

<%--${orderList}--%>
<c:choose>
	<c:when test="${orderList eq null}">
		<ul class="orderList">
			<li>주문내역이 없습니다.</li>
		</ul>
	</c:when>
	<c:otherwise>
		<ul class="orderList">
			<c:forEach var="order" items="${orderList}">
			<li>
				<h5>${order.id}</h5>
				<dl>
					<dt>${order.menu}</dt>
					<c:if test="${!empty order.menu_option}">
						<dd><span>선택사항 : </span><b>${order.menu_option}</b></dd>
					</c:if>
					<c:if test="${!empty order.addmenu}">
						<dd><span>추가메뉴 : </span><b>${order.addmenu}</b></dd>
					</c:if>
				</dl>
			</li>
			</c:forEach>
		</ul>
	</c:otherwise>
</c:choose>

<%--
</jsp:root>--%>
