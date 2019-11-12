<%--
  User: Cbuc
  Date: 2019/10/17
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
                    <a class="active-menu" href="offerMana"><i class="fa fa-list-alt"></i> 商品管理</a>
                </li>
                <li>
                    <a href="orderMana"><i class="fa fa-list-alt"></i> 订单管理</a>
                </li>
            </ul>
        </div>
    </nav>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-header">
                        商品管理
                        <small></small>
                    </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div>
                                <table class="table table-striped table-bordered table-hover" id="dataTables-offer">
                                    <thead>
                                    <a id="addBtn" href="/operaOffer?scop=add" class="btn btn-primary"
                                            style="position: relative;top:30px">
                                        新增
                                    </a>
                                    <tr>
                                        <th class="text-center">商品类别</th>
                                        <th class="text-center">商品图片</th>
                                        <th class="text-center">商品名称</th>
                                        <th class="text-center">商品描述</th>
                                        <th class="text-center">商品价格</th>
                                        <th class="text-center">商品库存</th>
                                        <th class="text-center">活动商品</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${products}" var="p">
                                        <tr>
                                            <td class="text-center" style="vertical-align: middle">${p.category.name}</td>
                                            <td class="text-center" style="vertical-align: middle">
                                                <img width="65px" height="90px" class="smallImg"
                                                     src="../../static/upload/image/${p.img}">
                                            </td>
                                            <td class="text-center" style="vertical-align: middle">${p.name}</td>
                                            <td class="text-center" style="vertical-align: middle">${p.title}</td>
                                            <td class="text-center" style="vertical-align: middle">${p.price}</td>
                                            <td class="text-center" style="vertical-align: middle">${p.stock}</td>
                                            <td class="text-center" style="vertical-align: middle">${p.active eq '1'?'是':'否'}</td>
                                            <td class="text-center" style="vertical-align: middle">
                                                <a type="button" class="btn btn-warning btn-sm modBook" href="/operaOffer?id=${p.id}&scop=mod">修改
                                                </a>
                                                <c:if test="${p.status == 'E'}">
                                                    <button type="button" class="btn btn-danger btn-sm disableBook"
                                                            pid="${p.id}">
                                                        下架
                                                    </button>
                                                </c:if>
                                                <c:if test="${p.status == 'D'}">
                                                    <button type="button" class="btn btn-info btn-sm enableBook"
                                                            pid="${p.id}">上架
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
        $('#dataTables-offer').dataTable();
    });
    $(function () {
        $("#dataTables-offer_length label").hide();
        $("#dataTables-offer_info").hide();
        $(".enableBook").click(function () {
            const productId = $(this).attr("pid");
            var pthis = $(this);
            $.ajax({
                url: "changeStatus",
                type: "POST",
                data: {'id':productId,'status':"E"},
                success: function (result) {
                    if (result.code == 100) {
                        layer.msg("上架成功");
                        $("button[pid="+productId+"]").text("下架");
                        $("button[pid="+productId+"]").removeClass("btn-info");
                        $("button[pid="+productId+"]").addClass("btn-danger");
                    }
                }
            })
        });
        $(".disableBook").click(function () {
            const pid = $(this).attr("pid");
            $.ajax({
                url: "changeStatus",
                type: "POST",
                data: {'id':pid,'status':"D"},
                success: function (result) {
                    if (result.code == 100) {
                        layer.msg("下架成功");
                        $("button[pid="+pid+"]").text("上架");
                        $("button[pid="+pid+"]").removeClass("btn-danger");
                        $("button[pid="+pid+"]").addClass("btn-info");
                    }
                }
            })
        })
    })
</script>
<script src="${pageContext.request.contextPath}/static/assets/js/custom-scripts.js"></script>
</body>
</html>
