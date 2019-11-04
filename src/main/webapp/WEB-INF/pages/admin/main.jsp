<%--
  User: Cbuc
  Date: 2019/10/16
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>管理端</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="/static/assets/css/bootstrap.css" rel="stylesheet">
    <link href="/static/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="/static/assets/css/custom-styles.css" rel="stylesheet"/>
    <link href="/static/assets/css/main.css" rel="stylesheet"/>
    <link href="/static/css/layui/public.css" rel="stylesheet"/>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'/>
    <link href="/static/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/static/lib/layui-v2.5.4/css/layui.css">

    <script src="/static/assets/js/jquery-1.10.2.js"></script>
    <script src="/static/assets/js/bootstrap.min.js"></script>
    <script src="/static/assets/js/jquery.metisMenu.js"></script>
    <script src="/static/assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="/static/assets/js/dataTables/dataTables.bootstrap.js"></script>
    <script src="/static/lib/layui-v2.5.4/layui.all.js"></script>
</head>
<body>
<div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand" href="/main">小黄书城后台</a>
            <span style="position: relative;left: 1400px;top: 20px;font-size: 16px">
            <a href="#" style="text-decoration: none">
                <img class="img-avatar" src="../../../static/upload/image/${maps.loginUser.img}"
                     style="width: 25px;height: 25px"/>
                <span style="color: #8a6d3b;">${maps.loginUser.user_name}</span>
            </a>
            <a href="/logout" style="margin-left: 20px;text-decoration: none;color: #8a6d3b;">Sign Out</a>
            </span>
        </div>
    </nav>
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <c:if test="${maps.loginUser.type == '超级管理员' }">
                    <li>
                        <a class="active-menu" href="/main"><i class="fa fa-bar-chart-o"></i> 商城报表</a>
                    </li>
                    <li>
                        <a href="/categoryMana"><i class="fa fa-bars"></i> 分类管理</a>
                    </li>
                    <li>
                        <a href="userMana"><i class="fa fa-user"></i> 用户管理</a>
                    </li>
                </c:if>
                <c:if test="${maps.loginUser.type == 'S' }">
                    <li>
                        <a class="active-menu" href="main"><i class="fa fa-list-alt"></i> 销售统计</a>
                    </li>
                    <li>
                        <a href="offerMana"><i class="fa fa-list-alt"></i> 商品管理</a>
                    </li>
                    <li>
                        <a href="orderMana"><i class="fa fa-list-alt"></i> 订单管理</a>
                    </li>
                </c:if>
            </ul>
        </div>

    </nav>
    <c:if test="${maps.loginUser.type == '超级管理员' }">
        <div id="page-wrapper">
            <div id="page-inner">
                <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-header">
                            商城报表
                            <small></small>
                        </h1>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div>
                                        <%--数据统计Start--%>
                                    <div class="layui-card">
                                        <div class="layui-card-header" style="font-size: 16px"><i
                                                class="fa fa-warning icon"></i>数据统计
                                        </div>
                                        <div class="layui-card-body">
                                            <div class="welcome-module">
                                                <div class="layui-row layui-col-space10">
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body"
                                                                 style="background-color: rgb(252,248,227)">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-blue">实时</span>
                                                                    <h3 style="color: #8a6d3b">用户统计：</h3>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins"
                                                                        style="margin-left: 100px">${maps.buyerCount}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number"
                                                             style="background-color: rgb(242,222,222)">
                                                            <div class="panel-body">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-cyan">实时</span>
                                                                    <h3 style="color: #8a6d3b">商户统计：</h3>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins"
                                                                        style="margin-left: 100px">${maps.sellerCount}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body"
                                                                 style="background-color: rgb(217,237,247)">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-orange">实时</span>
                                                                    <h3 style="color: #8a6d3b">商品统计：</h3>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins"
                                                                        style="margin-left: 100px">${maps.productCount}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body" style="background-color: #d0eae4">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-green">实时</span>
                                                                    <h3 style="color: #8a6d3b">订单统计：</h3>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins"
                                                                        style="margin-left: 100px">${maps.orderCount}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                        <%--数据统计End--%>
                                        <%--活动商品统计Start--%>
                                    <div class="layui-card" style="margin-top: 100px">
                                        <div class="layui-card col-xs-6 ">
                                            <div class="layui-card-header" style="font-size: 16px"><i
                                                    class="fa fa-warning icon"></i>活动商品统计
                                            </div>
                                            <div class="row">
                                                <div id="activeBooks" style="width: 500px;height:250px;"></div>
                                            </div>
                                        </div>
                                            <%--TOP5商品统计End--%>
                                        <div class="layui-card col-xs-6">
                                            <div class="layui-card-header" style="font-size: 16px"><i
                                                    class="fa fa-warning icon"></i>Top5商品统计
                                            </div>
                                            <div class="row">
                                                <div id="topBooks" style="width: 500px;height:250px;"></div>
                                            </div>
                                        </div>
                                            <%--TOP5商品统计End--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${maps.loginUser.type == 'S' }">
        <div id="page-wrapper">
            <div id="page-inner">
                <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-header">
                            销售统计
                            <small></small>
                        </h1>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div>
                                        <%--数据统计Start--%>
                                    <div class="layui-card">
                                        <div class="layui-card-header" style="font-size: 16px"><i
                                                class="fa fa-warning icon"></i>数据统计
                                        </div>
                                        <div class="layui-card-body">
                                            <div class="welcome-module">
                                                <div class="layui-row layui-col-space10">
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body"
                                                                 style="background-color: rgb(252,248,227)">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-blue">实时</span>
                                                                    <h3 style="color: #8a6d3b">商品统计：</h3>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins"
                                                                        style="margin-left: 100px">${maps.sptc}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number"
                                                             style="background-color: rgb(242,222,222)">
                                                            <div class="panel-body">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-cyan">实时</span>
                                                                    <h3 style="color: #8a6d3b">订单统计：</h3>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins"
                                                                        style="margin-left: 100px">${maps.sotc}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body"
                                                                 style="background-color: rgb(217,237,247)">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-orange">实时</span>
                                                                    <h3 style="color: #8a6d3b">流水统计：</h3>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins"
                                                                        style="margin-left: 100px">${maps.money}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body" style="background-color: #d0eae4">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-green">实时</span>
                                                                    <h3 style="color: #8a6d3b">热度统计：</h3>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins" style="margin-left: 100px">
                                                                        26%</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                        <%--数据统计End--%>
                                        <%--商品热度Start--%>
                                    <div class="layui-card" style="margin-top: 100px">
                                        <div class="layui-card col-xs-6 ">
                                            <div class="layui-card-header" style="font-size: 16px"><i
                                                    class="fa fa-warning icon"></i>商品销售统计
                                            </div>
                                            <div class="row">
                                                <div id="productStatistic" style="width: 500px;height:250px;"></div>
                                            </div>
                                        </div>
                                            <%--商品库存统计Start--%>
                                        <div class="layui-card col-xs-6">
                                            <div class="layui-card-header" style="font-size: 16px"><i
                                                    class="fa fa-warning icon"></i>商品库存统计
                                            </div>
                                            <div class="row">
                                                <div id="productStocks" style="width: 500px;height:250px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>
<script>
    $(document).ready(function () {
        $('#dataTables-example').dataTable();
    });
    $(function () {
        $("#dataTables-example_length label").hide();
    })
</script>
<script src="/static/assets/js/custom-scripts.js"></script>
<script src="/static/js/echarts.common.min.js" charset="utf-8"></script>
<c:if test="${maps.loginUser.type == '超级管理员' }">
    <script type="text/javascript">
        function queryActiveSaled(activeData) {
            $.ajax({
                async: false,
                url: "queryActiveSaled",
                type: "get",
                dataType: "json",
                success: function (result) {
                    debugger
                    for (var i = 0; i < result.data.length; i++) {
                        activeData.push(result.data[i]);
                    }
                }
            })
        }

        function queryTopBooks(topData) {
            $.ajax({
                async: false,
                url: "queryTopBooks",
                type: "get",
                dataType: "json",
                success: function (result) {
                    debugger
                    for (var i = 0; i < result.data.length; i++) {
                        topData.push(result.data[i]);
                    }
                }
            })
        }

        window.onload = function () {
            var activeData = [];
            var topData = [];
            queryActiveSaled(activeData);
            queryTopBooks(topData);
            var myChart = echarts.init(document.getElementById('activeBooks'), 'light');
            var option = {
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b}: {c} ({d}%)"
                },
                series: [{
                    type: 'pie',
                    name: '活动商品统计',
                    minAngle: 10,
                    radius: ['15%', '75%'],
                    center: ['50%', '49%'],
                    selectedMode: 'single',
                    data: activeData,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }]
            };
            myChart.setOption(option);
            myChart = echarts.init(document.getElementById('topBooks'), 'light');
            option = {
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b}: {c} ({d}%)"
                },
                series: [{
                    type: 'pie',
                    name: 'Top5商品统计',
                    minAngle: 10,
                    radius: ['15%', '75%'],
                    center: ['50%', '49%'],
                    selectedMode: 'single',
                    data: topData,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }]
            };
            myChart.setOption(option);
        }
    </script>
</c:if>
<c:if test="${maps.loginUser.type == 'S' }">
    <script type="text/javascript">
        function querySaledStatistic(saledStatistic) {
            $.ajax({
                async: false,
                url: "querySaledStatistic",
                type: "get",
                dataType: "json",
                success: function (result) {
                    debugger
                    for (var i = 0; i < result.data.length; i++) {
                        saledStatistic.push(result.data[i]);
                    }
                }
            })
        }

        function queryStocks(stocks) {
            $.ajax({
                async: false,
                url: "queryStocks",
                type: "get",
                dataType: "json",
                success: function (result) {
                    debugger
                    for (var i = 0; i < result.data.length; i++) {
                        stocks.push(result.data[i]);
                    }
                }
            })
        }

        window.onload = function () {
            var saledStatistic = [];
            var stocks = [];
            querySaledStatistic(saledStatistic);
            queryStocks(stocks);
            var myChart = echarts.init(document.getElementById('productStatistic'), 'light');
            var option = {
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b}: {c} ({d}%)"
                },
                series: [{
                    type: 'pie',
                    name: '商品销售统计',
                    minAngle: 10,
                    radius: ['15%', '75%'],
                    center: ['50%', '49%'],
                    selectedMode: 'single',
                    data: saledStatistic,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }]
            };
            myChart.setOption(option);
            myChart = echarts.init(document.getElementById('productStocks'), 'light');
            option = {
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b}: {c} ({d}%)"
                },
                series: [{
                    type: 'pie',
                    name: '商品库存统计',
                    minAngle: 10,
                    radius: ['15%', '75%'],
                    center: ['50%', '49%'],
                    selectedMode: 'single',
                    data: stocks,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }]
            };
            myChart.setOption(option);
        }
    </script>
</c:if>
</body>
</html>
