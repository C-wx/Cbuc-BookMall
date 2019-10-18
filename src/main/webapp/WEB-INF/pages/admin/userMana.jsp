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
    <title>Title</title>
    <link href="/static/assets/css/bootstrap.css" rel="stylesheet">
    <link href="/static/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="/static/assets/css/custom-styles.css" rel="stylesheet"/>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'/>
    <link href="/static/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/static/lib/layui-v2.5.4/css/layui.css">
    <script src="/static/lib/layui-v2.5.4/layui.all.js"></script>
    <script src="/static/assets/js/jquery-1.10.2.js"></script>
    <script src="/static/assets/js/bootstrap.min.js"></script>
    <script src="/static/assets/js/jquery.metisMenu.js"></script>
    <script src="/static/assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="/static/assets/js/dataTables/dataTables.bootstrap.js"></script>
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
                <li>
                    <a href="/main"><i class="fa fa-bars"></i> 商城报表</a>
                </li>
                <li>
                    <a href="/categoryMana"><i class="fa fa-bars"></i> 分类管理</a>
                </li>
                <li>
                    <a class="active-menu" href="userMana"><i class="fa fa-user"></i> 用户管理</a>
                </li>
            </ul>
        </div>

    </nav>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-header">
                        用户管理
                        <small></small>
                    </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div>
                                <table class="table table-striped table-bordered table-hover" id="dataTables-user">
                                    <thead>
                                    <button type="button" class="btn btn-primary" style="position: relative;top:30px">
                                        新增
                                    </button>
                                    <tr>
                                        <th class="col-md-2 text-center">id</th>
                                        <th class="col-md-3 text-center">名称</th>
                                        <th class="col-md-2 text-center">号码</th>
                                        <th class="col-md-1 text-center">性别</th>
                                        <th class="col-md-2 text-center">类型</th>
                                        <th class="col-md-2 text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${users}" var="u">
                                        <tr>
                                            <td class="text-center">${u.id}</td>
                                            <td class="text-center">${u.user_name}</td>
                                            <td class="text-center">${u.phone}</td>
                                            <td class="text-center">${u.sex eq '1'?'男':'女'}</td>
                                            <td class="text-center">${u.type eq 'B'?'买家':'卖家'}</td>
                                            <td class="text-center">
                                                <button type="button" class="btn btn-warning btn-sm" uid="${u.id}">修改
                                                </button>
                                                <c:if test="${u.status == 'E'}">
                                                    <button type="button" class="btn btn-danger btn-sm" uid="${u.id}">
                                                        禁用
                                                    </button>
                                                </c:if>
                                                <c:if test="${u.status == 'D'}">
                                                    <button type="button" class="btn btn-info btn-sm" uid="${u.id}">启用
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
        $('#dataTables-user').dataTable();
    });
    $(function () {
        $("#dataTables-user_length label").hide();
    })
</script>
<script src="/static/assets/js/custom-scripts.js"></script>
</body>
</html>

