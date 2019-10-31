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
    <link href="${APP_PATH}/static/css/style.css" rel="stylesheet">
    <style>
        div.aliPayPageDiv{
            text-align: center;
            padding-bottom: 40px;
            max-width: 1013px;
            margin: 10px auto;
        }
        span.confirmMoneyText{
            color: #4D4D4D;
            font-weight: bold;
            font-size: 14px;
        }
        span.confirmMoney{
            display: block;
            color: #FF6600;
            font-weight: bold;
            font-size: 26px;
            font-weight: bold;
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
        div.payedAddressInfo li{
            color: #1b6d85;
            padding-left: 15px;
            padding-top: 5px;
            font-size: 20px;
            text-align: left;
            font-family: '楷体';
        }
        span#total{
            color: #B10000;
            font-weight: bold;
            font-size: 20px;
            font-family: arial;
        }
    </style>
</head>
<jsp:include page="include/top.jsp"/>
<body>
    <%--支付成功模态框--%>
    <div class="modal fade" id="alipayModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;font-size: 25px;color: #393D49;">支付成功</h4>
                </div>
                <div class="modal-footer payedAddressInfo">
                    <ul>
                        <li>收货地址：
                            <span id="addr"></span>
                        </li>
                        <li>收货人：
                            <span id="receiver"></span>
                        </li>
                        <li>联系人电话：
                            <span id="phone"></span>
                        </li>
                        <li>实付款：
                            <span id="total"></span>
                        </li>
                    </ul>
                    <a href="/toOrderPage" class="layui-btn layui-btn-primary layui-btn-radius">查看订单</a>
                    <a href="/home" class="layui-btn layui-btn-primary layui-btn-radius">确认</a>
                </div>
            </div>
        </div>
    </div>

    <div class="aliPayPageDiv">
        <input type="hidden" id="totalPrice" value="${param.total}">
        <input type="hidden" id="orderId" value="${param.order_id}">
        <div>
            <span class="confirmMoneyText">扫一扫付款（元）</span>
            <span class="confirmMoney">
            ￥${param.total}</span>
        </div>
        <div>
            <img class="aliPayImg" src="../../static/imgs/alipay.jpg">
        </div>
        <div>
            <button class="confirmPay" >确认支付</button>
        </div>
    </div>
<script>
    layui.use('layer', function () {
        var $ = layui.jquery, layer = layui.layer;
        //触发事件
        var active = {
             offset: function () {
                layer.open({
                    type: 1
                    , title: false
                    , offset: "auto"
                    , id: 'layerDemo' + "auto"
                    , content: '<div style="padding: 20px 50px 0px;color: #761c19;font-size: 16px">' + "千山万水总是情，给个一分行不行" + '</div>'
                    , btn: ['好的','不行']
                    , btnAlign: 'c'
                    , shade: 0.6
                    , yes: function () {
                       layer.msg("<span style='padding: 10px 10px;color: #fff;font-size:16px'>人间自有真情在</span>", {
                           time: 3000,
                           btn: ['去支付']
                           ,btnAlign: 'c'
                           ,yes:function () {
                               layer.closeAll();
                           }
                       });
                    }
                    , btn2: function () {
                        var orderId = $("#orderId").val();
                        var total = $("#totalPrice").val();
                        $.ajax({
                           url : "/payed",
                           type : "POST",
                           data : {"order_id" : orderId, "total" : total},
                           success : function (result) {
                               $("#addr").text(result.data.addr);
                               $("#receiver").text(result.data.receiver);
                               $("#phone").text(result.data.phone);
                               $("#total").text("￥"+result.data.total);
                               $('#alipayModal').modal("show");
                           }
                        });
                    }
                });
            }
        };
        $('.confirmPay').on('click', function () {
            active["offset"].call(this);
        });

    });
</script>
</body>
</html>
