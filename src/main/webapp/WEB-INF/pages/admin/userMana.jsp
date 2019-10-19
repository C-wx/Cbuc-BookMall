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
<script>
    $(function () {
        $(".modUser").click(function () {
            var uid = $(this).attr("uid");
            $.ajax({
                url: "getUserInfo",
                type: "get",
                data: {'id': uid},
                success: function (result) {
                    $("#modId").val(uid);
                    $("#modName").val(result.data.user_name);
                    $("#modPhone").val(result.data.phone);
                    $("#modSex input[name='sex']").each(function () {
                        if ($(this).val() == result.data.sex) {
                            $(this).attr("checked", "checked");
                        }
                    });
                    $("#modType input[name='type']").each(function () {
                        if ($(this).val() == result.data.type) {
                            $(this).attr("checked", "checked");
                        }
                    });
                    $("#myModal").modal('show');
                }
            })
        });
        $("#modSave_btn").click(function () {
            $.ajax({
                url:"modifyUser",
                type: "POST",
                data:$(".form-horizontal").serialize(),
                success: function (result) {
                    if ("100" == result.code) {
                        $("#myModal").modal('hide');
                        layer.msg("修改成功！", {icon: 6});
                        window.location.reload();
                    }
                }
            })
        });
        $(".disableUser").click(function () {
            var uid = $(this).attr("uid");
            $.ajax({
                url : 'modUserStatus',
                type :"post",
                data: {'id':uid,'status':"D"},
                success: function (result) {
                    if ('100' == result.code) {
                        layer.msg('禁用成功', {icon: 6});
                        window.location.reload();
                    }
                }
            })
        });
        $(".enableUser").click(function () {
            var uid = $(this).attr("uid");
            $.ajax({
                url : 'modUserStatus',
                type :"post",
                data: {'id':uid,'status':"E"},
                success: function (result) {
                    if ('100' == result.code) {
                        layer.msg('启用成功', {icon: 6});
                        window.location.reload();
                    }
                }
            })
        });
        $("#addBtn").click(function () {
            $("#addModal").modal('show');
            $("#layui-form")[0].reset();
        });
        $("#addForm").click(function () {
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
            console.log($("#layui-form").serialize());
            debugger
            $.ajax({
                url: "addUser",
                type: "POST",
                data: $("#layui-form").serialize(),
                success: function (result) {
                    if (result.code == '100') {
                        $("#addModal").modal('hide');
                        layer.msg("添加成功");
                        window.location.reload();
                    }
                }
            })
        })
    })

</script>
<body>
<%--修改模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <form class="form-horizontal">
                    <input type="hidden" name="id" id="modId">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10 validate">
                            <input type="input" name="user_name" class="form-control" id="modName">
                            <span id="helpBlock3" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">号码</label>
                        <div class="col-sm-10 validate">
                            <input type="input" name="phone" class="form-control" id="modPhone">
                            <span id="helpBlock4" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10" id="modSex">
                            <label class="radio-inline">
                                <input type="radio" name="sex" value="1"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">类型</label>
                        <div class="col-sm-10" id="modType">
                            <label class="radio-inline">
                                <input type="radio" name="type" value="B"> 买家
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="type" value="S"> 卖家
                            </label>
                        </div>
                    </div>
                </form>
                <div style="text-align: right">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="modSave_btn">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%--新增模态框--%>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <form class="layui-form" action="" id="layui-form">
                    <input type="hidden" name="status" value="E">
                    <input type="hidden" name="addr" id="addr"/>
                    <input type="hidden" name="pwd" value="123456"/>
                    <div class="layui-form-item">
                        <label class="layui-form-label">用户名:</label>
                        <div class="layui-input-inline">
                            <input type="text" name="user_name" lay-verify="name" placeholder="请输入用户名" autocomplete="off"
                                   class="layui-input">
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
                            <input type="password" placeholder="123456" id="pwd" autocomplete="off"
                                   class="layui-input" disabled >
                        </div>
                        <div class="layui-form-mid layui-word-aux">初始密码:123456,请联系本人自行修改</div>
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
                        <div class="layui-input-block" style="margin-left: 210px">
                            <button class="layui-btn" id="addForm">保存</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </form>
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
                                    <button id="addBtn" type="button" class="btn btn-primary" style="position: relative;top:30px">
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
                                                <button type="button" class="btn btn-warning btn-sm modUser"
                                                        uid="${u.id}">修改
                                                </button>
                                                <c:if test="${u.status == 'E'}">
                                                    <button type="button" class="btn btn-danger btn-sm disableUser"
                                                            uid="${u.id}">
                                                        禁用
                                                    </button>
                                                </c:if>
                                                <c:if test="${u.status == 'D'}">
                                                    <button type="button" class="btn btn-info btn-sm enableUser"
                                                            uid="${u.id}">启用
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
<script>
    layui.use(['form','layer'], function () {
        var form = layui.form
            , layer = layui.layer
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
            , phone: [
                /1((((3[0-3,5-9])|(4[5,7,9])|(5[0-3,5-9])|(66)|(7[1-3,5-8])|(8[0-9])|(9[1,8,9]))\d{8})|((34)[0-8]\d{7}))/
                , '请输入正确的手机号码'
            ]
        });
    });
</script>
</body>
</html>

