<%--
  User: Cbuc
  Date: 2019/9/27
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <title>注册页面</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.js"></script>

</head>

<style>
    .page-top {
        width: 1902px;
        background-color: #92B8B1;
        height: 106px;
        border-bottom: 2px solid #e6e6e6;
        position: relative;
        margin-bottom: 50px;
    }

    .active {
        position: relative;
        margin: 0 auto;
        width: 520px;
        border-bottom: 2px solid #ff4700;
        text-align: center;
    }

    .tsl {
        position: relative;
        left: 28px;
        height: 104px;
        line-height: 106px;
        font-size: 66px;
        font-weight: 700;
        color: #2a6496;
        letter-spacing: 55px;
    }
    body {
        background-color: #fff9ec;
    }
    .layui-form-pane .layui-form-label{
        margin-bottom: 30px;
        width: 125px;
        font-size: 18px;
        font-weight: bold;
        font-family: '楷体';
        letter-spacing: 5px;
    }
</style>

<body style="width: 1000px">
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="page-top">
            <div class="active">
                <div class="tsl">用户注册</div>
            </div>
        </div>
        <form class="layui-form layui-form-pane" action="register" style="position: relative; left: 700px" enctype="multipart/form-data" method="post">
            <input type="hidden" name="status" value="E">
            <input type="hidden" name="addr" id="addr"/>
            <div class="layui-form-item">
                <label class="layui-form-label">用户名:</label>
                <div class="layui-input-inline">
                    <input type="text" name="user_name" lay-verify="name" placeholder="请输入用户名" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">头像:</label>
                <div class="layui-input-inline">
                    <input id="file" type="file" name="files" style="display:none;" onChange="replace_image(0)"/>
                    <img id="image" onclick="click_image()" style="cursor:pointer;margin-left: 20px" class="layui-circle" src="../../static/imgs/upload_hover.png" height="100px" width="100px"/>
                    <div class="layui-form-mid layui-word-aux" style="margin-left: 30px" id="inputImg">请上传头像</div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">手机号:</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="phone" lay-verify="tel|phone" placeholder="请输入手机号" autocomplete="off" id="tel"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">密码:</label>
                <div class="layui-input-inline">
                    <input type="password" name="pwd" lay-verify="pass" placeholder="请输入密码" autocomplete="off" id="pwd"
                           class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">地址:</label>
                <div class="layui-input-inline">
                    <select name="province" id="province">
                        <option value="0">请选择省</option>
                        <option value="福建省" selected="">福建省</option>
                        <option value="浙江省" disabled>浙江省</option>
                        <option value="广东省" disabled>广东省</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="city" id="city">
                        <option value="0">请选择市</option>
                        <option value="莆田">莆田</option>
                        <option value="福州" disabled>福州</option>
                        <option value="泉州" disabled>泉州</option>
                        <option value="厦门" disabled>厦门</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="area" id="area">
                        <option value="0">请选择县/区</option>
                        <option value="仙游县">仙游县</option>
                        <option value="荔城区">荔城区</option>
                        <option value="秀屿市">秀屿市</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">性别:</label>
                <div class="layui-input-block">
                    <input type="radio" name="sex" value="1" title="男" checked="">
                    <input type="radio" name="sex" value="0" title="女">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">类型:</label>
                <div class="layui-input-block">
                    <input type="radio" name="type" value="B" title="买家" checked="">
                    <input type="radio" name="type" value="S" title="卖家">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <input type="checkbox" checked="" name="open" lay-skin="switch" lay-filter="switchTest"
                           lay-text="同意|不同意">
                    <span data-method="notice" id="news" style="color:#A9A9A9;cursor: pointer">我已阅读相关协议</span>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="demo1">立即注册</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    <a href="/loginPage" class="layui-btn layui-btn-primary" style="text-decoration: none">返回</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    layui.use(['form','layer'], function () {
        var form = layui.form
            , layer = layui.layer

        var active = {
            notice: function () {
                layer.open({
                    type: 1
                    , title: false
                    , closeBtn: false
                    , area: '300px;'
                    , shade: 0.5
                    , id: 'LAY_layuipro' //设定一个id，防止重复弹出
                    , btn: '我已了解'
                    , btnAlign: 'c'
                    , content: '<div style="padding: 30px;text-align: center; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">小黄书城用户协议<br><hr>官方说辞<br>xxxx</div>'
                });
            }
        }
        $('#news').on('click', function () {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });

        //自定义验证规则
        form.verify({
            name: function (value) {
                if (value.length < 1) {
                    return '用户名不能为空';
                }
            }, tel: function (value) {
                if (value.length < 1) {
                    return '手机号码不能为空';
                }
            }
            , pass: [
                /^[\S]{6,12}$/
                , '密码必须6到12位，且不能出现空格'
            ]
            , phone: [
                /1((((3[0-3,5-9])|(4[5,7,9])|(5[0-3,5-9])|(66)|(7[1-3,5-8])|(8[0-9])|(9[1,8,9]))\d{8})|((34)[0-8]\d{7}))/
                , '请输入正确的手机号码'
            ]
        });
        //监听指定开关
        form.on('switch(switchTest)', function (data) {
            layer.tips('温馨提示：不同意也可以注册...', data.othis)
        });
        //监听提交
        form.on('submit(demo1)', function (data) {
            var addr = "";
            if ($("#province").val() != 0) {
                addr += $("#province").val();
            }
            if ($("#city").val() != 0) {
                addr += "-" + $("#city").val();
            }
            if ($("#area").val() != 0) {
                addr += "-" + $("#area").val();
            }
            $("#addr").val(addr);
            console.log(addr);
            console.log( $("form").serialize());
            var pattern1 = /1((((3[0-3,5-9])|(4[5,7,9])|(5[0-3,5-9])|(66)|(7[1-3,5-8])|(8[0-9])|(9[1,8,9]))\d{8})|((34)[0-8]\d{7}))/;
            if (!pattern1.test($("#tel").val())) {
               return false;
            }
            var pattern = /^[\S]{6,12}$/;
            if (!pattern.test($("#pwd").val())) {
               return false;
            }
            console.log("开始注册...")
            $.ajax({
                url: "register",
                type: "POST",
                data: new FormData($("form")[0]),
                processData: false,
                contentType: false,
                success: function (result) {
                    if (result.code == 100) {
                        layer.msg('<h3>----注册成功----</h3>', {
                            time: 3000,
                            btn: ['好的', '去登录']
                        }, function () {
                            location.href = "loginPage";
                        });
                    }else{
                        layer.alert(result.msg);
                    }
                }
            })
            return false;
        });
    });
    function click_image(){
        $("#file").click();
    }
    function replace_image(){
        $("#inputImg").hide();
        // 获得图片对象
        var blob_image = $("#file")[0].files[0];
        var url = window.URL.createObjectURL(blob_image);
        console.log(url);
        // 替换image
        $("#image").attr("src",url);
        console.log($("#file").val());
    }
</script>
</body>
</html>
