<%--
  Created by IntelliJ IDEA.
  User: Mason
  Date: 2021-12-31
  Time: 오후 2:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>점심</title>
    <link href="./css/index.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>


<div class="loginContainer">
    <div class="loginBox">
        <h1>LUNCH</h1>
        <input type="text" name="id" id="id" placeholder="아이디" onkeydown="if(event.keyCode == 13) doLogin();"/><br>
        <button onclick='doLogin();'>로그인</button>
    </div>
</div>


<script>
    function doLogin() {
        let id = document.getElementById('id').value;

        if( id.length === 0 ){
            alert('아이디를 입력하세요.')
            return false;
        }
        let MemberVO = {
            "id": id
        };
        $.ajax({
            type: 'POST',
            url: '/api/login',
            data: JSON.stringify(MemberVO),
            contentType : 'application/json;  charset=UTF-8',
            async: false,
            success: function(data) {
                if (data != null) {
                    // Do somothing when data is not null
                    if (data.result == 'success') {
                        location.href='/lunch';
                    } else {
                        alert('아이디정보가 없습니다.');
                        return false;
                    }
                }
            },
            error:function (e){
                console.log(e);
            }
        });
    }

</script>

</body>
</html>
