<%--
  Created by IntelliJ IDEA.
  User: Mason
  Date: 2022-01-04
  Time: 오후 2:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>준비중입니다</title>
	<link href="./css/index.css" rel="stylesheet">
</head>
<body onload="moveToIndex()">
<div class="loginContainer">
	<div class="loginBox">
		<h1> 준비중입니다 <br> 운영시간 8:30 ~ 13:00 </h1>
	</div>
</div>
<script>
	function moveToIndex(){
    setTimeout("location.href='./'", 10000);
    setTimeout("moveToIndex()", 10000);
	}
</script>
</body>
</html>
