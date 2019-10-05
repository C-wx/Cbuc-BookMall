<%--
  User: Cbuc
  Date: 2019/9/30
  Time: 20:01
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.all.js"></script>
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.js"></script>
    <link rel="stylesheet" href="/static/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">

    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">
</head>
<body>
<div >
    <nav class="navbar navbar-default" style="margin: 0px 15px 0px">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">小黄书城</span>
                </button>
                <a class="navbar-brand" href="/home" style="font-size: 38px;color: yellowgreen;margin-left: 46px;font-family:SimHei;font-weight: bold" >小黄书城</a>
            </div>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <%--<form class="navbar-form navbar-left" action="/" method="get">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="搜索书籍" name="search">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>--%>
                <ul class="nav navbar-nav navbar-right">
                    <li style="margin-top: 18px;font-size: 16px">
                    <c:if test="${empty sessionScope.user}">
                        <span style="color: #1b6d85;font-family:KaiTi">欢迎来到小黄书城</span>
                        <span style="margin-left: 20px;font-family:KaiTi">
                            <a href="/loginPage">
                                请登录
                                <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
                            </a>
                        </span>
                        <span style="margin-left: 20px;font-family:KaiTi">
                            <a href="/toRegister">
                                免费注册
                                <span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span>
                            </a>
                        </span>
                    </c:if>
                    </li>
                    <li>
                    <c:if test="${not empty sessionScope.user}">
                        <a href="javascript:;" style="margin-top: 3px;font-size: 16px;font-family: Arial">
                            我的购物车
                            <i class="fa fa-shopping-cart"></i>
                        </a>
                    </c:if>
                    </li>
                    <li class="dropdown">
                    <c:if test="${not empty sessionScope.user}">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" id="selfMain"
                           aria-expanded="false" >
                            <img class="img-avatar" src="../../../static/upload/image/${sessionScope.user.img}" style="width: 25px;height: 25px" />
                            <span>${sessionScope.user.user_name}</span>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="/self">个人中心</a></li>
                            <li><a href="/logout">退出登录</a></li>
                        </ul>
                    </c:if>
                    <script>
                        $(function () {
                            $("#selfMain").mouseenter(function () {
                                $(".dropdown-menu").show();
                            });
                            $(".dropdown-menu").mouseleave(function () {
                                $(".dropdown-menu").hide();
                            })
                        })
                    </script>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>

</body>
</html>
