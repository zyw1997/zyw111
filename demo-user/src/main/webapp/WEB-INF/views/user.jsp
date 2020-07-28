<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/7/23
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <style type="text/css">
        .paging_div {
            float: left;
            margin-left: 20px;
            height: 20px;
            width: 20px;
            border: 1px solid
        }

        #add_div {
            display: none;
            position: fixed;
            margin: 0% 0px 20% 45%;
            padding: 20px;
            border: 1px solid
        }
        #update_div {
            display: none;
            position: fixed;
            margin: 0% 0px 20% 45%;
            padding: 20px;
            border: 1px solid
        }

        #btn_div {
            clear: both;
        }

        .paging_ul li {
            margin: 0 auto;
            text-align: center;
            list-style: none;
        }

        .paging_ul div div {
            float: left;
            margin-left: 20px;
            height: 20px;
            width: 20px;
            border: 1px solid
        }
    </style>

    <title>用户界面</title>
</head>
<body>
您好 尊敬的${map.userBean.user_nickname}

<div>请输入用户手机进行查询:<br>
    <input type="text" id="findByTel">
    <br>
    <button onclick="findById()">查询</button>
    <button onclick="findUsers(1)">查询所有</button>
</div>
<div id="add_div">

    请输入手机号码:<br>
    <input type="text" id="add_user_tel">
    <br>
    请输入账号:<br>
    <input type="text" id="add_user_account">
    <br>
    请输入密码:<br>
    <input type="password" id="add_password">
    <br>
    请输入昵称:<br>
    <input type="text" id="add_user_nickname">
    <br><br>
    <button onclick="addUser()">确认新增</button>

</div>

<div id="update_div">

    请输修改后的昵称:<br>
    <input type="text" id="new_nickname">
    <br><br>
    <button onclick="updateUser()">确认修改</button>

</div>
<table border="1" id="users_table">
</table>
<div>
    <ul class="paging_ul">
        <div id="first" class="paging_div">
            <li>&lt;&lt;</li>
        </div>
        <div id="create_paging">
        </div>
        <div id="last" class="paging_div">
            <li>&gt;&gt;</li>
        </div>
    </ul>
</div>
<div id="btn_div">
    <button onclick="show_addUser()" id="on_off_add">新增</button>
    <button onclick="delUser()">删除</button>
    <button onclick="show_update_User()" id="on_off_update">修改昵称</button>
</div>

</body>
<script language="JavaScript">
    findUsers(1);
    var create_paging = document.getElementById("create_paging");
    for (var i = 1; i <= ${map.pageCount}; i++) {
        create_paging.innerHTML = create_paging.innerHTML + "<div onclick='findUsers(" + i + ")'><li>" + i + "</li></div>";
    }

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


    //第一步，创建XMLHttpRequest对象
    var xmlHttp = new XMLHttpRequest();

    function findById() {
        //第二步，注册回调函数
        xmlHttp.onreadystatechange = callback1;
        //第三步，配置请求信息，open(),get
        //get请求下参数加在url后，.ashx?methodName = GetAllComment&str1=str1&str2=str2
        xmlHttp.open("POST", "http://localhost:8080/demo-user/user/findUserByTel");
        //post请求下需要配置请求头信息
        //xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        //第四步，发送请求,post请求下，要传递的参数放这
        var findByTel = document.getElementById("findByTel").value;
        xmlHttp.send(findByTel);
    }

    function callback1() {
        if (xmlHttp.readyState == 4)
            if (xmlHttp.status == 200) {
                var data = xmlHttp.responseText; //得到后端传来的Json字符串
                var user_json = JSON.parse(data);//将Json字符串转为对象啊
                //json字符串转为json格式
                document.getElementById("users_table").innerHTML = "<tr>\n" +
                    "        <th><input type=\"checkbox\" onclick=\"mainCheck(this)\"/></th>\n" +
                    "        <th>用户账号</th>\n" +
                    "        <th>用户昵称</th>\n" +
                    "        <th>用户电话</th>\n" +
                    "    </tr>";
                document.getElementById("users_table").innerHTML = document.getElementById("users_table").innerHTML + "<tr><td><input name = 'checkbox' type='checkbox'/></td> <td id='account'>" + user_json.user_account + "</td> <td id='nickname'>" + user_json.user_nickname + "</td><td id='tel'>" + user_json.user_tel + "</td></tr>";
            }
    }


    function findUsers(page) {
        var xmlHttp2 = new XMLHttpRequest();
        xmlHttp2.onreadystatechange = function () {
            if (xmlHttp2.readyState == 4) {
                if (xmlHttp2.status == 200) {
                    var date = xmlHttp2.responseText;
                    var users = JSON.parse(date);
                    document.getElementById("users_table").innerHTML = "<tr>\n" +
                        "        <th><input type=\"checkbox\" onclick=\"mainCheck(this)\"/></th>\n" +
                        "        <th>用户账号</th>\n" +
                        "        <th>用户昵称</th>\n" +
                        "        <th>用户电话</th>\n" +
                        "    </tr>";
                    for (var i = 0; i < users.length; i++) {
                        document.getElementById("users_table").innerHTML = document.getElementById("users_table").innerHTML + "<tr><td><input name='checkbox' type='checkbox'/></td> <td id='account'>" + users[i].user_account + "</td> <td id='nickname'>" + users[i].user_nickname + "</td><td id='tel'>" + users[i].user_tel + "</td></tr>";
                    }
                }
            }
        };
        xmlHttp2.open("GET", "http://localhost:8080/demo-user/user/findUsers?page=" + page);
        xmlHttp2.send();
    }


    function show_addUser() {
        var add_div_show = document.getElementById("add_div");
        var on_off = document.getElementById("on_off_add");
        if (add_div_show.style.display == "block") {
            add_div_show.style.display = "none";
            on_off.innerHTML = "新增";
        } else {
            add_div_show.style.display = "block";
            on_off.innerHTML = "取消新增";
        }
    }

    function addUser() {
        var account = document.getElementById("add_user_account").value;
        var tel = document.getElementById("add_user_tel").value;
        var nickname = document.getElementById("add_user_nickname").value;
        var password = document.getElementById("add_password").value;

        if (account != null && tel != null && nickname != null && password != null) {
            var params = {
                "tel": tel,
                "account": account,
                "nickname": nickname,
                "password": password
            };

            httpPost("http://localhost:8080/demo-user/user/addUser", params);
        } else {
            alert("请将信息填完整！");
        }
    }

    function show_update_User() {
        var choosedUsers = new Array();
        var tels = new Array();
        var x = 0;
        choosedUsers = document.getElementsByName("checkbox");
        for (var i = 0; i < choosedUsers.length; i++) {
            if (choosedUsers[i].checked == true) {
                tels[x] = choosedUsers[i].parentNode.parentNode.lastChild.innerHTML;
                x++;
            }
        }
        if (tels.length != 1) {
            alert("一次只能修改一位用户的昵称,请选择一位用户进行操作");
        }else{
            var update_div_show = document.getElementById("update_div");
            var on_off = document.getElementById("on_off_update");
            if (update_div_show.style.display == "block") {
                update_div_show.style.display = "none";
                on_off.innerHTML = "修改";
            } else {
                update_div_show.style.display = "block";
                on_off.innerHTML = "取消修改";
            }
        }
    }
    function updateUser() {
        var choosedUsers = new Array();
        var new_nickname = document.getElementById("new_nickname").value;
        var tel;
        choosedUsers = document.getElementsByName("checkbox");
        for (var i = 0; i < choosedUsers.length; i++) {
            if (choosedUsers[i].checked == true) {
                tel = choosedUsers[i].parentNode.parentNode.lastChild.innerHTML;
            }
        }
        if (new_nickname != null) {
            var info = {
                "tel": tel,
                "new_nickname":new_nickname
            };

            httpPost("http://localhost:8080/demo-user/user/updateUser", info);
        } else {
            alert("请将信息填完整！");
        }


    }

    function delUser() {
        var choosedUsers = new Array();
        var tels = new Array();
        var x = 0;
        choosedUsers = document.getElementsByName("checkbox");
        for (var i = 0; i < choosedUsers.length; i++) {
            if (choosedUsers[i].checked == true) {
                tels[x] = choosedUsers[i].parentNode.parentNode.lastChild.innerHTML;
                x++;
            }
        }
        var param = {
            "tels": tels
        };
        httpPost("http://localhost:8080/demo-user/user/delUsers", param);

    }

    function mainCheck(check) {
        var checkBoxs = new Array();
        var checkBoxs = document.getElementsByName("checkbox");
        if (check.checked == true) {
            for (var i = 0; i < checkBoxs.length; i++) {
                checkBoxs[i].checked = true;
            }
        } else {
            for (var i = 0; i < checkBoxs.length; i++) {
                checkBoxs[i].checked = false;
            }
        }
    }
</script>
</html>
