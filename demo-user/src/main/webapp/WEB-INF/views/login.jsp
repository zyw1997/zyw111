<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/7/24
  Time: 9:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>用户管理</title>
</head>
<body>
<input type="text" id="account">
<input type="password" id="password">
<input type="button" onclick="login()" value="登录">

</body>

<script language="JavaScript">
    function httpPost(URL, PARAMS) {
        var temp = document.createElement("form");
        temp.action = URL;
        temp.method = "post";
        temp.style.display = "none";

        for (var x in PARAMS) {
            var opt = document.createElement("textarea");
            opt.name = x;
            opt.value = PARAMS[x];
            temp.appendChild(opt);
        }

        document.body.appendChild(temp);
        temp.submit();

        return temp;
    }
    function login() {
        var account = document.getElementById("account").value;
        var password = document.getElementById("password").value;

        var params = {
            "account": account,
            "password": password
        };

        httpPost("http://localhost:8080/demo-user/user/login", params);

        /*window.location.href = "http://localhost:8080/demo-user/user/login?account=" + account + "&password=" + password;*/
    }
</script>
</html>
