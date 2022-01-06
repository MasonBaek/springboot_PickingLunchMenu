<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h3>더재무</h3>
<c:choose>
	<c:when test="${checkStoreListThe eq [] || checkStoreListThe eq '[null]'}">
		<div class="nonStore">선택된 식당이 없습니다.</div>
	</c:when>
	<c:otherwise>
		<ul class="chosenStoreList">
			<c:forEach var="chosenStore" items="${checkStoreListThe}">
				<li>
					<dl>
						<dt>이름</dt>
						<dd>${chosenStore.id}</dd>
					</dl>
					<dl>
						<dt>식당</dt>
						<dd>${chosenStore.storePicked}</dd>
					</dl>
				</li>
			</c:forEach>
		</ul>
	</c:otherwise>
</c:choose>