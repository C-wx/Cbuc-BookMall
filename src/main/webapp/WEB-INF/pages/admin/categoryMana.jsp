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
    $(function () {
        $("#addCg").click(function () {
            $("#addCgModal").modal('show');
            $("#name").val('');
            $("#scop").val("add");
        });
        $("#save").click(function () {
            if ('add' == $("#scop").val()) {
                var name = $("#name").val();
                $.ajax({
                    url: "addCategory",
                    type: "POST",
                    data: {'name': name},
                    success: function (result) {
                        if ('100' == result.code) {
                            $("#addCgModal").modal('hide');
                            $("#name").val('')
                            layer.msg("添加成功");
                            location.reload();
                        } else {
                            layer.msg("服务端异常,请重新尝试");
                        }
                    }
                })
            } else if ('modify' == $("#scop").val()) {
                var id = $("#id").val();
                var name = $("#name").val();
                $.ajax({
                    url: "modifyCategory",
                    type: "POST",
                    data: {'id': id, 'name': name},
                    success: function (result) {
                        if ('100' == result.code) {
                            $("#addCgModal").modal('hide');
                            layer.msg("修改成功");
                            location.reload();
                        } else {
                            layer.msg("服务端异常,请重新尝试");
                        }
                    }
                })
            }
        });
        $(".modifyCg").click(function () {
            var cname = $(this).attr('cname');
            var cid = $(this).attr('cid');
            $("#id").val(cid);
            $("#name").val(cname);
            $("#scop").val("modify");
            $("#addCgModal").modal('show');
        })
    })
</script>
<body>
<%--新增/修改模态框--%>
<div class="modal fade" id="addCgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <label style="margin-top: 10px">请输入分类名称：</label>
                <br>
                <input type="text" name="name" class="form-control" id="name">
                <input type="hidden" name="id" id="id">
                <input type="hidden" id="scop">
                <div style="text-align: center;margin-top: 20px">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" id="save" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>

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
                    <a href="/main"><i class="fa fa-bar-chart-o"></i> 商城报表</a>
                </li>
                <li>
                    <a class="active-menu" href="/categoryMana"><i class="fa fa-bars"></i> 分类管理</a>
                </li>
                <li>
                    <a href="userMana"><i class="fa fa-user"></i> 用户管理</a>
                </li>
            </ul>
        </div>
    </nav>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-header">
                        分类管理
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
                                    <button type="button" class="btn btn-primary"
                                            style="position: relative;top:30px" id="addCg">新增
                                    </button>
                                    <tr>
                                        <th class="col-md-3 text-center">分类id</th>
                                        <th class="col-md-4 text-center">分类名称</th>
                                        <th class="col-md-5 text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${categories}" var="c">
                                        <tr cid="${c.id}">
                                            <td class="text-center">${c.id}</td>
                                            <td class="text-center">${c.name}</td>
                                            <td class="text-center">
                                                <button type="button" class="btn btn-warning btn-sm modifyCg"
                                                        cid="${c.id}" cname="${c.name}">修改
                                                </button>
                                                <button type="button" class="btn btn-danger btn-sm delCg" cid="${c.id}"
                                                        cname="${c.name}">删除
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
<script src="/static/assets/js/custom-scripts.js"></script>
<script>
    layui.use('layer', function () {
        var $ = layui.jquery, layer = layui.layer;
        var active = {
            offset: function (othis) {
                var categoryId = othis.attr('cid');
                layer.open({
                    title: false
                    ,
                    type: 1
                    ,
                    offset: '300px'
                    ,
                    content: '<div style="padding: 20px 50px;">' + "确定删除" + '<span style="font-size: 16px;color: #ac2925;font-weight: bold;padding: 0px 5px">' + othis.attr('cname') + '</span>' + "?" + '</div>'
                    ,
                    btn: ['确定', '取消']
                    ,
                    btnAlign: 'c'
                    ,
                    shade: 0.5
                    ,
                    shadeClose: true
                    ,
                    anim: 6
                    ,
                    closeBtn: 0
                    ,
                    yes: function () {
                        $.ajax({
                            url: "delCg",
                            type: "POST",
                            data: {'id': categoryId},
                            success: function (result) {
                                if (result.code == '100') {
                                    layer.closeAll();
                                    layer.msg("删除成功");
                                    $("tr[cid=" + categoryId + "]").hide();
                                } else {
                                    layer.msg("服务端异常,请重新尝试!");
                                }

                            }
                        })
                    }
                    ,
                    btn2: function () {
                        layer.closeAll();
                    }
                });
            }
        };
        $(".delCg").on('click', function () {
            const othis = $(this);
            active['offset'].call(this, othis);
        });
    });
</script>
</body>
</html>
