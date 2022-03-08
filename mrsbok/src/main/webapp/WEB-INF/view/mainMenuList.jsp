<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
	<c:when test="${!empty menuList}">
		<input type="hidden" name="store" value="${menuList[0].store}">
		<ul>
			<c:forEach items="${menuList}" var="menu">
				<li class="${menu.menu_seq}">
					<input type="hidden" name="menu_seq" value="${menu.menu_seq}">
					<p><span class="menu_name">${menu.menu}</span> <%--<span><fmt:formatNumber value="${menu.price}" pattern="#,###원"/></span>--%></p>
					<c:if test="${menu.info != null}">
						<div class="menu_info">${menu.info}</div>
					</c:if>
				</li>
			</c:forEach>
		</ul>
	</c:when>
	<c:otherwise>
		<div class="non_menu">메뉴가 없습니다.</div>
		<input type="hidden" name="store" value="${store}">
	</c:otherwise>
</c:choose>



