<%--
  User: Cbuc
  Date: 2019/10/5
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.all.js"></script>

    <link rel="stylesheet" href="${APP_PATH}/static/css/detail.css">
    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">
    <style>
        .kefu{
            margin: auto;
            width: 373px;
            height: 500px;
            border: 1px #1b6d85 solid;
        }
        .kefu .kefuNav{
            text-align: center;
            color: #666;;
            font-size: 16px;
        }
        .kefu span{
            font-size: 14px;
        }
        .kefu div #question{
            height: 30px;
            width: 260px;
            font-size: 15px;
        }
    </style>
</head>
<body>
<div class="kefu">
    <div class="kefuNav">人工小黄为你服务...</div>
    <hr>
    <div id="showQuestion">
        <span> &nbsp;您好，请问有什么可以帮助您？</span>
    </div>
    <div style=" top: 200px; left: 40px;position: fixed;">
        <input type="text" id="question" placeholder="请输入问题">
        <button id="launch" type="button" class="layui-btn layui-btn-warm" >发送</button>
    </div>
</div>
<script>
    $(function () {
        $("#launch").click(function () {
            var text = $("#question").val();
            if (text == '') {
                return false;
            }
            var nextQuestion = $("<div style='font-size: 14px;margin-left: 250px'></div>").append(text).append($("<hr>"));
            var answer = $("<div style='font-size: 14px;'></div>").append("您好!我现在还是人工智障听不懂您说什么").append($("<hr>"));
            $("#showQuestion").append(nextQuestion).append(answer);
            $("#question").val('');
        })
    })
</script>
</body>
</html>