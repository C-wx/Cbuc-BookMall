<%--
  User: Cbuc
  Date: 2019/9/17
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>登录页</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <style>
        html {
            height: 100%
        }

        body {
            margin: 0;
            height: 100%;
            background: #fff;
        }

        canvas {
            display: block;
            width: 100%;
            height: 100%;
        }

        .body_content {
            position: absolute;
            top: 30%;
            left: 20%;
            height: 20%;
            background: palevioletred;
            width: 20%;
        }
    </style>

    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/layui/css/layui.css">
    <script src="${APP_PATH}/static/layui/layui.all.js"></script>

    <link rel="stylesheet" href="${APP_PATH}/static/css/login.css">
    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">

</head>
<body>

<div class="login-area">
    <div class="login_area_box">
        <div class="mainloginbox" id="LOGIN-FORM">
            <div class="logo_login" style="text-align:center;vertical-align:middle;">
                <p style="font-size:24px;color:#FFFFFF;font-weight:700;padding-top: 50px;">用户登录</p>
            </div>
            <form class="login-form" action="" name="form" method="post">
                <ul>
                    <li>
                        <input placeholder="请输入用户名或手机号" type="text" name="LNAME" class="input-style position" id="LNAME"
                               onfocus="clearInfo1()" autocomplete="off"/>
                        <span id="helpBlock1" class="help-block" style="display: none"></span>
                    <li>
                        <input type="password" name="LPW" class="input-style position" placeholder="请输入密码 " id="LPW"
                               onfocus="clearInfo2()"/>
                        <span id="helpBlock2" class="help-block" style="display: none"></span>
                    </li>
                    <li>
                        <div class="form-group">
                            <span class="form-con">
                                <input type="text" id="veryCode" name="veryCode" placeholder="请输入验证码" autocomplete="off"
                                       class="input-style position" maxlength="4"/>
                                <img id="imgObj" src="" onclick="changeImg()"/>
                            </span>
                        </div>
                    </li>
                    <li class="loginbtn">
                        <input type="button" title="登录" class="btn btn_login" onclick="login()" value=""/>
                        <button formaction="toRegister" class="layui-btn layui-btn-warm layui-btn-radius" style="width: 65px;" type="submit" formmethod="get">注册</button>
                    </li>
                </ul>
            </form>
        </div>
        <div class="login_icon">
            <span style="margin-left: -100px">推荐使用浏览器：</span>
            <a href="https://www.google.cn/intl/zh-CN/chrome" target="_blank" class="chrome_icon"
               style="margin-left: -100px;margin-right: 50px">Chrome</a>
            <a href="http://www.firefox.com.cn" target="_blank" class="firefox_icon">Firefox</a>
        </div>
    </div>
</div>

<canvas id="canvas"></canvas>
<script src="${APP_PATH}/static/js/login.js"></script>

<script>
    $(function () {
        changeImg();
    });

    //验证码
    function changeImg() {
        var imgSrc = $("#imgObj");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", chgUrl(src));
    }

    //时间戳
    //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();
        urlurl = url.substring(0, 17);
        if ((url.indexOf("&") >= 0)) {
            urlurl = url + "×tamp=" + timestamp;
        } else {
            urlurl = url + "?timestamp=" + timestamp;
        }

        urlurl = "${APP_PATH}/verycode/getImgCode?timestamp=" + timestamp + "&imgCodeType=NUM";
        return urlurl;
    }
</script>
</body>
</html>
