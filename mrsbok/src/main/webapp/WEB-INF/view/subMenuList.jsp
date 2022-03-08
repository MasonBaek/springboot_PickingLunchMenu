<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
	<c:when test="${subMenuList == null}">
		<div class="non_menu">선택사항이 없습니다.</div>
	</c:when>
	<c:otherwise>
		<c:forEach items="${subMenuList}" var="subMenuList">
			<h3>${subMenuList.submenu}</h3>
			<c:choose>
				<c:when test="${subMenuList.submenu_status == 'single'}">
					<script>
						$(function(){
              $("section.subMenu_section dl.subMenu_dl dd ul.ul_single li").on('click', function (){
                $(this).addClass('active').siblings().removeClass('active');
                return false;
              });
						});
					</script>
					<ul class="ul_single">
						<c:forEach items="${subMenuList.submenu_optionVO}" var="option">
							<li><p>${option.option_name}</p><span><fmt:formatNumber value="${option.option_price}" pattern="#,### 원"/></span></li>
						</c:forEach>
					</ul>
				</c:when>
				<c:otherwise><%-- 여기가 multiple? --%>
					<script>
            $(function(){
              $("section.subMenu_section dl.subMenu_dl dd ul.ul_multiple li").on('click', function (){
                $(this).toggleClass('active');
                return false;
              });
            });
					</script>
					
					<ul class="ul_multiple">
						<c:forEach items="${subMenuList.submenu_optionVO}" var="option">
							<li><p>${option.option_name}</p><span><fmt:formatNumber value="${option.option_price}" pattern="#,### 원"/></span></li>
						</c:forEach>
					</ul>
				</c:otherwise>
			</c:choose>
		
		</c:forEach>
	</c:otherwise>
</c:choose>