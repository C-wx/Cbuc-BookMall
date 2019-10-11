<%--
  User: 14046
  Date: 2019/10/10
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>支付页面</title>
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.all.js"></script>
    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">
    <style>
        div.aliPayPageDiv{
            text-align: center;
            padding-bottom: 40px;
            max-width: 1013px;
            margin: 10px auto;
        }
        span.confirmMoneyText{
            color: #4D4D4D;
        }
        span.confirmMoney{
            display: block;
            color: #FF6600;
            font-weight: bold;
            font-size: 20px;
            margin: 10px;
        }
        button.confirmPay{
            background-color: #00AAEE;
            border: 1px solid #00AAEE;
            text-align: center;
            line-height: 31px;
            font-size: 14px;
            font-weight: 700;
            color: white;
            width: 107px;
            margin-top: 20px;
        }

        img.aliPayImg {
            width: 300px;
        }
    </style>
</head>
<jsp:include page="include/top.jsp"/>
<body>
    <div class="aliPayPageDiv">
        <div>
            <span class="confirmMoneyText">扫一扫付款（元）</span>
            <span class="confirmMoney">
            ￥${param.total}</span>
        </div>
        <div>
            <img class="aliPayImg" src="../../static/imgs/alipay.jpg">
        </div>
        <div>
            <a href="payed?order_id=${param.order_id}&total=${param.total}">
                <button class="confirmPay" data-method="offset" data-type="auto">确认支付</button>
            </a>
        </div>
    </div>
</body>
</html>
