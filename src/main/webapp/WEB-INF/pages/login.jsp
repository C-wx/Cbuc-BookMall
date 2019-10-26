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

    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.all.js"></script>

    <link rel="stylesheet" href="${APP_PATH}/static/css/login.css">
    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">
</head>
<script>
    $(function () {
        $("#showModal").click(function () {
            $("#modPwdForm")[0].reset();
            $("#modPwdModal").modal("show");
        })
        $("#modPwd").click(function () {
            $.ajax({
                url: "modPwd",
                type: "post",
                data: $("#modPwdForm").serialize(),
                success: function (result) {
                    if (100 == result.code) {
                        layer.msg("修改成功",{icon:6});
                        $("#modPwdModal").modal("hide");
                    }else{
                        layer.msg("用户不存在,请检查用户名是否正确",{icon:5})
                    }
                }
            })

        })
    })
</script>
<body>
<%--修改密码模态框--%>
<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" id="modPwdModal">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div style="font-weight: bold;font-size: 26px;color: #92B8B1;text-align: center">找回密码</div>
            <hr>
            <form action="" id="modPwdForm" style="margin-left: 30px">
                <div class="form-group has-warning">
                    <label class="control-label" style="font-size: 16px;font-weight: bold">请输入用户名:</label>
                    <input type="text" class="form-control" name="user_name" style="width: 200px">
                </div>
                <div class="form-group has-warning">
                    <label class="control-label" style="font-size: 16px;font-weight: bold">你最尊敬的人的是:</label>
                    <input type="text" class="form-control" style="width: 200px" placeholder="测试使用(随意填写)">
                </div>
                <div class="form-group has-warning">
                    <label class="control-label" style="font-size: 16px;font-weight: bold">请输入新密码:</label>
                    <input type="text" class="form-control" name="pwd" style="width: 200px">
                </div>
                <div style="margin:2px 0px 20px 150px">
                    <button type="button" class="btn btn-primary btn-sm" id="modPwd">修改</button>
                    <button type="button" class="btn btn-default btn-sm"  data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="login-area">
    <div class="login_area_box">
        <div class="mainloginbox" id="LOGIN-FORM">
            <div class="logo_login" style="text-align:center;vertical-align:middle;">
                <a style="font-size:34px;color:#1b6d85;font-weight:700;padding-top: 40px;display: inline-block;cursor: pointer"
                   href="/home">小黄书城</a>
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
                                <img id="imgObj" src="" onclick="changeImg()"  />
                            </span>
                        </div>
                    </li>
                    <li class="loginbtn">
                        <input type="button" title="登录" class="btn btn_login" onclick="login()" value=""/>
                        <button formaction="toRegister" class="layui-btn btn_register" type="submit"
                                formmethod="get"></button>
                        <a href="#" class="forgetPwd" id="showModal">忘记密码?点击找回</a>
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
