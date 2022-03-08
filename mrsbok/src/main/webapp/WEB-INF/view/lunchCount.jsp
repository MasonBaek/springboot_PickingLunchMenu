<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<dl>
	<dt>사무실A</dt>
	<dd>${OfficeACount.size()}명
		<c:if test="${OfficeACount.size() > 0}">
			(<c:forEach items="${OfficeACount}" var="id" varStatus="i"><c:choose><c:when test="${i.last}">${id.id}</c:when><c:otherwise>${id.id}, </c:otherwise></c:choose></c:forEach>)
		</c:if>
	</dd>
</dl>
<dl>
	<dt>사무실B</dt>
	<dd>${OfficeBCount.size()}명
		<c:if test="${OfficeBCount.size() > 0}">
			(<c:forEach items="${OfficeBCount}" var="id" varStatus="i"><c:choose><c:when test="${i.last}">${id.id}</c:when><c:otherwise>${id.id}, </c:otherwise></c:choose></c:forEach>)
		</c:if>
	</dd>
</dl>
<dl>
	<dt>결식</dt>
	<dd>${noLunchCount.size()}명
		<c:if test="${noLunchCount.size() > 0}">
			(<c:forEach items="${noLunchCount}" var="id" varStatus="i"><c:choose><c:when test="${i.last}">${id.id}</c:when><c:otherwise>${id.id}, </c:otherwise></c:choose></c:forEach>)
		</c:if>
	</dd>
</dl>