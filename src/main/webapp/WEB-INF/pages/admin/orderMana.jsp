<%--
  User: Cbuc
  Date: 2019/10/19
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
    <link href="${pageContext.request.contextPath}/static/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/assets/css/custom-styles.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/assets/css/main.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/css/layui/public.css" rel="stylesheet"/>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'/>
    <link href="${pageContext.request.contextPath}/static/assets/js/dataTables/dataTables.bootstrap.css"
          rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/lib/layui-v2.5.4/css/layui.css">

    <script src="${pageContext.request.contextPath}/static/assets/js/jquery-1.10.2.js"></script>
    <script src="${pageContext.request.contextPath}/static/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/assets/js/jquery.metisMenu.js"></script>
    <script src="${pageContext.request.contextPath}/static/assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="${pageContext.request.contextPath}/static/assets/js/dataTables/dataTables.bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui-v2.5.4/layui.all.js"></script>
</head>
<body>
<div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand" href="/main">小黄书城后台</a>
            <span style="position: relative;left: 1400px;top: 20px;font-size: 16px">
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
                <li>
                    <a href="main"><i class="fa fa-list-alt"></i> 销售统计</a>
                </li>
                <li>
                    <a href="offerMana"><i class="fa fa-list-alt"></i> 商品管理</a>
                </li>
                <li>
                    <a class="active-menu" href="orderMana"><i class="fa fa-list-alt"></i> 订单管理</a>
                </li>
            </ul>
        </div>

    </nav>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-header">
                        订单管理
                        <small></small>
                    </h1>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div>
                                <table class="table table-striped table-bordered table-hover" id="dataTables-order">
                                    <thead>
                                    <tr>
                                        <th class="text-center">订单号</th>
                                        <th class="text-center">商品名称</th>
                                        <th class="text-center">商品数量</th>
                                        <th class="text-center">订单金额</th>
                                        <th class="text-center">收货人名称</th>
                                        <th class="text-center">收货人电话</th>
                                        <th class="text-center">收货人地址</th>
                                        <th class="text-center">状态</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${orders}" var="o">
                                        <tr>
                                            <td class="text-center" style="vertical-align: middle">${o.orderCode}</td>
                                            <td class="text-center"
                                                style="vertical-align: middle">${o.product.name}</td>
                                            <td class="text-center" style="vertical-align: middle">${o.num}</td>
                                            <td class="text-center" style="vertical-align: middle">${o.price}</td>
                                            <td class="text-center" style="vertical-align: middle">${o.receiver}</td>
                                            <td class="text-center" style="vertical-align: middle">${o.phone}</td>
                                            <td class="text-center" style="vertical-align: middle">${o.addr}</td>
                                            <td class="text-center" style="vertical-align: middle">
                                                <c:if test="${o.status == 'WC'}">
                                                    <span>
                                                        待收货
                                                    </span>
                                                </c:if>
                                                <c:if test="${o.status == 'WR'}">
                                                    <span>
                                                        待评价
                                                    </span>
                                                </c:if>
                                                <c:if test="${o.status == 'WD'}">
                                                    <span>
                                                        待发货
                                                    </span>
                                                </c:if>
                                                <c:if test="${o.status == 'WP'}">
                                                    <span>
                                                        待付款
                                                    </span>
                                                </c:if>
                                            </td>
                                            <td class="text-center" style="vertical-align: middle">
                                                <c:if test="${o.status == 'WD'}">
                                                    <button type="button" class="btn btn-danger btn-sm delivery"
                                                            oid="${o.id}">
                                                        发货
                                                    </button>
                                                </c:if>
                                                <c:if test="${o.status == 'WR'}">
                                                    <button type="button" class="btn btn-primary btn-sm remark"
                                                            oid="${o.id}">
                                                        催评价
                                                    </button>
                                                </c:if>
                                                <c:if test="${o.status == 'WC'}">
                                                    <span >
                                                        等待买家收货
                                                    </span>
                                                </c:if>
                                                <c:if test="${o.status == 'WP'}">
                                                    <button type="button" class="btn btn-warning btn-sm pay"
                                                            oid="${o.id}">
                                                        催付款
                                                    </button>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#dataTables-order').dataTable();
    });
    $(function () {
        $("#dataTables-order_length label").hide();
        $("#dataTables-order_info").hide();
        $(".remark").click(function () {
            layer.msg("已经催促买家评价，请耐心等待！",{skin:'demo-class',icon:6,offset:'400px'});
        });
        $(".pay").click(function () {
            layer.msg("已经给买家洗脑，请耐心等待！",{skin:'demo-class',icon:6,offset:'400px'});
        });
        $(".delivery").click(function () {
            var oid = $(this).attr("oid");
            $.ajax({
                url: "delivery",
                type: "POST",
                data:{'id':oid,status:'WC'},
                success: function (result) {
                    if (100 == result.code) {
                        layer.load(3, {time: 1000,offset:'400px'});
                        setTimeout(function () {
                            layer.msg("发货成功，耐心等待买家收货！",{skin:'demo-class',icon:6,offset:'400px'});
                        },1000);
                        setTimeout(function () {
                            location.reload()
                        },3000);
                    }
                }
            })
        })
    })
</script>
<script src="${pageContext.request.contextPath}/static/assets/js/custom-scripts.js"></script>
</body>
</html>
