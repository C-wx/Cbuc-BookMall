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
            <span style="position: relative;left: 1200px;top: 20px;font-size: 16px">
            <a href="#" style="text-decoration: none">
                <img class="img-avatar" src="../../../static/upload/image/${loginUser.img}"
                     style="width: 25px;height: 25px"/>
                <span style="color: #8a6d3b;">${loginUser.user_name}</span>
            </a>
            <a href="/logout" style="margin-left: 20px;text-decoration: none;color: #8a6d3b;">Sign Out</a>
            </span>
        </div>
    </nav>
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <c:if test="${loginUser.type == '超级管理员' }">
                    <li>
                        <a class="active-menu" href="/main"><i class="fa fa-bars"></i> 商城报表</a>
                    </li>
                    <li>
                        <a href="/categoryMana"><i class="fa fa-bars"></i> 分类管理</a>
                    </li>
                    <li>
                        <a href="userMana"><i class="fa fa-user"></i> 用户管理</a>
                    </li>
                </c:if>
                <c:if test="${loginUser.type == 'S' }">
                    <li>
                        <a href="listOrder"><i class="fa fa-list-alt"></i> 销售统计</a>
                    </li>
                    <li>
                        <a href="listOrder"><i class="fa fa-list-alt"></i> 商品管理</a>
                    </li>
                    <li>
                        <a href="listOrder"><i class="fa fa-list-alt"></i> 订单管理</a>
                    </li>
                </c:if>
            </ul>
        </div>

    </nav>
    <c:if test="${loginUser.type == '超级管理员' }">
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
                                        <div class="layui-card-header"><i class="fa fa-warning icon"></i>数据统计</div>
                                        <div class="layui-card-body">
                                            <div class="welcome-module">
                                                <div class="layui-row layui-col-space10">
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-blue">实时</span>
                                                                    <h5>用户统计</h5>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins">${buyerCount}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-cyan">实时</span>
                                                                    <h5>商户统计</h5>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins">${sellerCount}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-orange">实时</span>
                                                                    <h5>商品统计</h5>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins">${productCount}</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="panel layui-bg-number">
                                                            <div class="panel-body">
                                                                <div class="panel-title">
                                                                    <span class="label pull-right layui-bg-green">实时</span>
                                                                    <h5>订单统计</h5>
                                                                </div>
                                                                <div class="panel-content">
                                                                    <h1 class="no-margins">${orderCount}</h1>
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
                                    <div class="col-xs-6">
                                        <!--module-title s-->
                                        <div class="module-title">
                                            <h4>近一个月交易情况</h4>
                                        </div>
                                        <!--module-title e-->
                                        <!--chart s-->
                                        <div class="row">
                                            <div id="main" style="width: 500px;height:220px;"></div>
                                        </div>
                                        <!--chart e-->
                                    </div>
                                        <%--活动商品统计End--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${loginUser.type == 'S' }">
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
                            <div class="panel-heading">
                                销售统计
                            </div>
                            <div class="panel-body">
                                统计内容
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
<script type="text/javascript">
    function queryActiveSaled(activeBooks){
        $.ajax({
            async: false,
            url:"queryActiveSaled",
            type:"get",
            dataType:"json",
            success:function(result){
                for(var i =0;i < result.data.length;i++){
                    offerData.push(result.data[i]);
                }
            }
        })
    }
    function queryTop(classifyData){
        $.ajax({
            async: false,
            url:"queryTop",
            type:"get",
            dataType:"json",
            success:function(result){
                for(var i =0;i < result.data.length;i++){
                    classifyData.push(result.data[i]);
                }
            }
        })
    }
    $(function () {
        var activeBooks = [];
        var topBooks = [];
        queryActiveSaled(activeBooks);
        // queryClassifyData(topBooks);
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('offer'), 'light');
        // 指定图表的配置项和数据
        var option = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            series: [{
                type: 'pie',
                name:'活动商品',
                minAngle: 10,
                radius: '80%',
                center: ['50%', '49%'],
                selectedMode: 'single',
                data: activeBooks,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        // 基于准备好的dom，初始化echarts实例
        myChart = echarts.init(document.getElementById('classify'), 'light');
        // 指定图表的配置项和数据
        option = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            series: [{
                type: 'pie',
                name:'权益分类占比',
                minAngle: 10,
                radius: '80%',
                center: ['50%', '49%'],
                selectedMode: 'single',
                data: topBooks,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    });
</script>
</body>
</html>
