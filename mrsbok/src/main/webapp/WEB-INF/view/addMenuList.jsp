<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
	<c:when test="${addMenuList == []}">
		<div class="non_menu">추가메뉴가 없습니다.</div>
	</c:when>
	<c:otherwise><%-- 여기가 multiple? --%>
		<script>
      $(function(){
        $("section.subMenu_section dl.addMenu_dl dd ul li").on('click', function (){
          $(this).toggleClass('active');
          return false;
        });
      });
		</script>
		<ul>
		<c:forEach items="${addMenuList}" var="addMenu">
			<li>
				<p>${addMenu.addmenu_name}</p>
				<span><fmt:formatNumber value="${addMenu.addmenu_price}" pattern="#,### 원"/></span>
			</li>
		</c:forEach>
		</ul>
	</c:otherwise>
</c:choose>

