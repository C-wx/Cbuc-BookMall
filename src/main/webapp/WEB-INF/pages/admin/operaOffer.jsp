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
    <script src="${pageContext.request.contextPath}/static/js/jquery/2.0.0/jquery.min.js"></script>
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
<style>
    form label {
        font-size: 19px;
        margin-left: 80px;
    }
</style>
<body>
<div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand" href="/main">小黄书城后台</a>
            <span style="position: relative;left: 1350px;top: 20px;font-size: 16px">
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
                    <c:if test="${param.scop == 'mod'}">
                        <h1 class="page-header">
                            商品修改
                            <small></small>
                        </h1>
                    </c:if>
                    <c:if test="${param.scop == 'add'}">
                        <h1 class="page-header">
                            商品添加
                            <small></small>
                        </h1>
                    </c:if>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form class="form-inline">
                                <input type="hidden" name="id" id="productId" value="${param.id}">
                                <div class="form-group has-success" style="margin: 20px 0px">
                                    <label>商品名称：</label>
                                    <input type="text" class="form-control" id="name" name="name" style="width:200px"
                                           placeholder="请输入商品名称">
                                </div>
                                <hr>
                                <div class="form-group has-success" style="margin: 20px 0px">
                                    <label>商品描述：</label>
                                    <input type="text" class="form-control" id="title" name="title"
                                           placeholder="请输入内容（不超过20个字）" style="width: 350px;">
                                </div>
                                <hr>
                                <div class="form-group" style="margin: 10px 0px 0px">
                                    <label>商品主图:</label>
                                    <div class="layui-input-inline">
                                        <input id="file" type="file" name="files" style="display:none;"
                                               onChange="replace_image(0)"/>
                                        <img id="image" onclick="click_image()" style="cursor:pointer;margin-left: 20px"
                                             src="../../static/imgs/offer_upload.png" height="110px" width="90px"/>
                                        <br>
                                        <div class="layui-form-mid layui-word-aux" style="margin-left: 30px"
                                             id="inputImg">请上传主图
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div class="form-group has-success" style="margin: 0px 0px -10px">
                                    <label style="margin:18px 0px 0px 118px;">价格：</label>
                                    <div class="input-group" style="position: relative;left: 180px;top: -25px;">
                                        <div class="input-group-addon">$</div>
                                        <input type="text" class="form-control" id="price" name="price"
                                               placeholder="Price" style="width: 80px">
                                    </div>
                                </div>
                                <hr>
                                <div class="form-group has-success" style="margin: 0px 0px -10px">
                                    <label style="margin:18px 0px 0px 118px;">库存：</label>
                                    <div class="input-group" style="position: relative;left: 180px;top: -25px;">
                                        <div class="input-group-addon">件</div>
                                        <input type="text" class="form-control" id="stock" name="stock"
                                               placeholder="Count" style="width: 80px">
                                    </div>
                                </div>
                                <hr>
                                <div class="form-group has-success" style="margin: 20px 0px">
                                    <label>商品分类：</label>
                                    <select class="form-control" id="categorySelect" name="category_id">
                                        <option>请选择分类</option>
                                    </select>
                                </div>
                                <hr>
                                <div class="form-group" style="margin: 20px 0px" id="categoryRadio">
                                    <label>是否参加活动：</label>
                                    <input type="radio" name="active" value="1">是</input>
                                    <input type="radio" name="active" value="0">否</radio>
                                </div>
                                <hr>
                                <div style="position: fixed;left: 1200px;top: 600px;">
                                    <a href="#" class="btn btn-primary btn-lg" id="btn_save">提交</a>
                                    <br>
                                    <a href="/offerMana" class="btn btn-warning btn-lg" style="margin-top: 10px">返回</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<c:if test="${param.scop == 'mod'}">
    <script>
        $(function () {
            var productId = $("#productId").val();
            $.ajax({
                url: "getProductInfo",
                type: "GET",
                data: {'id': productId},
                success: function (result) {
                    $.each(result.data.categories, function () {
                        $("<option></option>").append(this.name).attr("value", this.id).appendTo($("#categorySelect"));
                    });
                    $("#name").val(result.data.name);
                    $("#title").val(result.data.title);
                    $("#price").val(result.data.price);
                    $("#stock").val(result.data.stock);
                    $("#image").attr("src", "../../static/upload/image/" + result.data.img);
                    $("#categorySelect").find("option[value=" + result.data.category.id + "]").attr('selected', 'selected');
                    $("#categoryRadio").find("input[value=" + result.data.active + "]").attr('checked', 'checked');
                }
            })
        })
    </script>
    <script>
        $(function () {
            $("#btn_save").click(function () {
                $.ajax({
                    url: "modOffer",
                    type: "POST",
                    data: new FormData($("form")[0]),
                    processData: false,
                    contentType: false,
                    success: function (result) {
                        if (result.code == '100') {
                            layer.msg("修改成功！");
                            setTimeout(function () {
                                location.href = "/offerMana";
                            }, 1000);
                        } else {
                            layer.alert(result.msg);
                        }
                    }
                })
            })
        })
    </script>
</c:if>
<c:if test="${param.scop == 'add'}">
    <script>
        $(function () {
            $.ajax({
                url: "getCategoryInfo",
                type: "GET",
                success: function (result) {
                    $.each(result.data, function () {
                        $("<option></option>").append(this.name).attr("value", this.id).appendTo($("#categorySelect"));
                    });
                }
            })
        })
    </script>
    <script>
        $(function () {
            $("#btn_save").click(function () {
                debugger
                $.ajax({
                    url: "addOffer",
                    type: "POST",
                    data: new FormData($("form")[0]),
                    processData: false,
                    contentType: false,
                    success: function (result) {
                        if (result.code == '100') {
                            layer.msg("添加成功！");
                            setTimeout(function () {
                                location.href = "/offerMana";
                            }, 1000);
                        } else {
                            layer.alert(result.msg);
                        }
                    }
                })
            })
        })
    </script>
</c:if>
<script>
    function click_image() {
        $("#file").click();
    }

    function replace_image() {
        $("#inputImg").hide();
        // 获得图片对象
        var blob_image = $("#file")[0].files[0];
        var url = window.URL.createObjectURL(blob_image);
        console.log(url);
        // 替换image
        $("#image").attr("src", url);
        console.log($("#file").val());
    }
</script>
</html>
