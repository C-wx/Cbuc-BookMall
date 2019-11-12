<%--
  Created by IntelliJ IDEA.
  User: Cbuc
  Date: 2019/11/11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>管理端</title>
    <link href="/static/assets/css/bootstrap.css" rel="stylesheet">
    <link href="/static/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="/static/assets/css/custom-styles.css" rel="stylesheet"/>
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
<script>
    $(() => {
        $(".replyBtn").on("click", function () {
            $("#replyContent").val("");
            $("#receivor").val($(this).attr("uid"));
            $("#replyModal").modal("show");
        });
        $("#send").on("click",function () {
            $.ajax({
                url:"reply",
                type:"post",
                data:$("#replyForm").serialize(),
                success:function (result) {
                    if (result.code == 100) {
                        layer.load(2, {offset: '400px',time: 1000});
                        setTimeout(function () {
                            $("#replyModal").modal("hide");
                            layer.msg("回复成功！",{offset:'400px'});
                        }, 888);
                    }
                }
            })
        })
    })
</script>
<body>
<%--回复模态框--%>
<div class="modal fade" id="replyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <label style="margin-top: 10px">请输入回复内容：</label>
                <br>
                <form id="replyForm">
                    <input type="hidden" name="receivor" id="receivor">
                    <textarea name="content" id="replyContent" class="form-control" rows="3"></textarea>
                </form>
                <div style="text-align: center;margin-top: 20px">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" id="send" class="btn btn-primary">发送</button>
                </div>
            </div>
        </div>
    </div>
</div>

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
                    <a href="/main"><i class="fa fa-bar-chart-o"></i> 商城报表</a>
                </li>
                <li>
                    <a href="/categoryMana"><i class="fa fa-bars"></i> 分类管理</a>
                </li>
                <li>
                    <a href="userMana"><i class="fa fa-user"></i> 用户管理</a>
                </li>
                <li>
                    <a href="contactMana" class="active-menu"><i class="fa fa-bell"></i> 消息管理</a>
                </li>
            </ul>
        </div>
    </nav>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-header">
                        消息管理
                        <small></small>
                    </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div>
                                <table class="table table-striped table-bordered table-hover"
                                       id="dataTables-example">
                                    <thead>
                                    <tr>
                                        <th class="col-md-2 text-center">留言者</th>
                                        <th class="col-md-5 text-center">留言内容</th>
                                        <th class="col-md-3 text-center">留言时间</th>
                                        <th class="col-md-2 text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${contacts}" var="c">
                                        <tr cid="${c.id}">
                                            <td class="text-center">${c.user.user_name}</td>
                                            <td class="text-center">${c.content}</td>
                                            <td class="text-center"><fmt:formatDate value="${c.create_time}"
                                                                                    pattern="yyyy-MM-dd hh:mm:ss"/></td>
                                            <td class="text-center">
                                                <button type="button" class="btn btn-primary btn-sm replyBtn"
                                                        cid="${c.id}" uid="${c.contactor}">
                                                    回复
                                                </button>
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
        $('#dataTables-example').dataTable();
    });
    $(function () {
        $("#dataTables-example_length label").hide();
    })
</script>
</body>
</html>