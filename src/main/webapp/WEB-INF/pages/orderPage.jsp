<%--
  User: Cbuc
  Date: 2019/10/12
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>我的订单</title>
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.js"></script>
    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">
    <link rel="stylesheet" href="${APP_PATH}/static/css/orderPage.css">

    <script>
        $(function () {
            //切换状态显示不同列表
            $("a[orderStatus]").click(function () {
                var orderStatus = $(this).attr("orderStatus");
                if ('all' == orderStatus) {
                    $("table[orderStatus]").show();
                } else {
                    $("table[orderStatus]").hide();
                    $("table[orderStatus=" + orderStatus + "]").show();
                }
                $("div.orderType div").removeClass("selectedOrderType");
                $(this).parent("div").addClass("selectedOrderType");
            });
            $(".ask2delivery").click(function () {
                $(this).attr("disabled", "disabled");
                layer.msg("亲，已经帮您催促了哈！", {
                    time: 2000
                    , offset: '200px'
                });
            });
            $("#confirmed").click(function () {
                var orderId = $(this).attr("order_id");
                $("#order_id").val(orderId);
                $.ajax({
                    url: "confirmedDeliver",
                    type: "POST",
                    data: {'orderId':orderId},
                    success: function (result) {
                        layer.msg("<div style='text-align: center;font-size: 20px;font-weight: bold'>确认收货成功！</div>", {
                            time: 20000
                            ,offset: '200px'
                            ,skin: 'demo-class'
                            ,btn:['去评价','关闭']
                            ,btnAlign: 'c'
                            , shade: 0.5
                            ,yes:function () {
                                layer.closeAll();
                                $("#remarkModel").modal('show');
                            },btn2:function () {
                                layer.closeAll();
                                location.reload();
                            }
                        });
                    }
                })
            });

            $("#issue").click(function () {
                $.ajax({
                    url:"issueRemark",
                    type:"POST",
                    data: $("#commentForm").serialize(),
                    success: function () {
                        $("#remarkModel").modal('hide');
                        layer.msg("评论成功");
                        location.reload();
                    }
                })
            });
            $("#remark").click(function () {
                var orderId = $(this).attr("oid");
                $("#remarkModel").modal('show');
                $("#order_id").val(orderId);
            });
        });
    </script>
</head>
<jsp:include page="include/top.jsp"/>
<body>

<%--评价模态框--%>
<div class="modal fade" id="remarkModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel" style="text-align: center;font-size: 24px;font-weight: bold">请输入您的评价内容</h4>
            </div>
            <div class="modal-body">
                <form id="commentForm">
                    <input type="hidden" id="order_id" name="order_id" value="">
                    <div class="form-group">
                        <label for="message-text" class="control-label" style="font-weight: bold;font-size: 14px;color: #ac2925;">Message:</label>
                        <textarea class="form-control" id="message-text" name="msg"></textarea>
                    </div>
                </form>
                <div style="text-align: center">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button id="issue" type="button" class="btn btn-primary">发表</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%--模态框END--%>


<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
        <div><a orderStatus="WP" href="javascript:;">待付款</a></div>
        <div><a orderStatus="WD" href="javascript:;">待发货</a></div>
        <div><a orderStatus="WC" href="javascript:;">待收货</a></div>
        <div><a orderStatus="WR" href="javascript:;" >待评价</a></div>
        <div><a orderStatus="SS" href="javascript:;" class="noRightborder">已完成订单</a></div>
    </div>
    <div style="clear:both"></div>
    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tr>
                <td>宝贝</td>
                <td width="121px">单价</td>
                <td width="121px">数量</td>
                <td width="141px">实付款</td>
                <td width="121px">交易操作</td>
            </tr>
        </table>
    </div>
    <div class="orderListItem">
        <c:forEach items="${orders}" var="o" varStatus="st">
            <table class="orderListItemTable" orderStatus="${o.status}" oid="${o.id}">
                <tr class="orderListItemFirstTR">
                    <td colspan="5">
                        <b style="margin-right: 25px"><fmt:formatDate value="${o.create_date}" type="DATE" pattern="yyyy-MM-dd HH:ss"/></b>
                        <span>订单号: ${o.order_code}
                    </span>
                    </td>
                    <td class="orderItemDeleteTD">
                        <a class="deleteOrderLink" oid="${o.id}" data-method="offset" style="cursor: pointer;">
                            <span class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>
                    </td>
                </tr>
                <tr class="orderItemProductInfoPartTR">
                    <td class="orderItemProductInfoPartTD" style="width: 150px">
                        <img width="70" height="90" src="../../static/upload/image/${o.product.img}"
                             style="margin-left: 40px">
                    </td>
                    <td class="orderItemProductInfoPartTD" style="width: 300px">
                        <div class="orderListItemProductLinkOutDiv">
                            <a href="/showProduct?product_id=${o.product.id}" class="nameStyle">${o.product.name}</a>
                            <div class="orderListItemProductLinkInnerDiv">
                                <img src="../../static/imgs/creditcard.png" title="支持信用卡支付">
                                <img src="../../static/imgs/7day.png" title="消费者保障服务,承诺7天退货">
                                <img src="../../static/imgs/promise.png" title="消费者保障服务,承诺如实描述">
                            </div>
                        </div>
                    </td>
                    <td class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                        <div class="orderListItemProductPrice">￥${o.product.price}</div>
                    </td>
                    <td rowspan="1" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                        <span class="orderListItemNumber">${o.num}</span>
                    </td>
                    <td rowspan="1" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
                        <div class="orderListItemProductRealPrice">￥${o.price}</div>
                        <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                    </td>
                    <td rowspan="1" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
                        <c:if test="${o.status=='WC' }">
                            <button id="confirmed" class="btn btn-success btn-sm" order_id=${o.id}>确认收货</button>
                        </c:if>
                        <c:if test="${o.status=='WP' }">
                            <a href="/payPage?order_id=${o.id}&total=${o.price}">
                                <button class="btn btn-warning btn-sm">付款</button>
                            </a>
                        </c:if>

                        <c:if test="${o.status=='WD' }">
                            <span style="font-size: 14px">待发货</span>
                            <button class="btn btn-info btn-sm ask2delivery" style="margin-top: 8px">
                                催卖家发货
                            </button>
                        </c:if>
                        <c:if test="${o.status=='WR' }">
                            <button oid="${o.id}" id="remark" class="btn btn-primary btn-sm">评价</button>
                        </c:if>
                        <c:if test="${o.status=='SS' }">
                            <span >订单已完成</span>
                        </c:if>
                    </td>
                </tr>
            </table>
        </c:forEach>
    </div>
</div>
<script>
    layui.use('layer', function () {
        var $ = layui.jquery, layer = layui.layer;

        //触发事件
        var active = {
            confirmTrans: function (othis) {
                layer.msg("<div style='color:#fff9ec;font-size: 20px;font-weight: bold;font-family:楷体'>确定删除此订单吗</div>", {
                    time: 20000
                    , offset: '200px'
                    , anim: 6
                    , btn: ['确定', '取消']
                    , btnAlign: 'c'
                    , shade: 0.5
                    , yes: function () {
                        var deleteOrderid = othis.attr("oid");
                        $.post(
                            "deleteOrder",
                            {"order_id": deleteOrderid},
                            function (result) {
                                if ("100" == result.code) {
                                    $("table.orderListItemTable[oid=" + deleteOrderid + "]").hide();
                                    layer.closeAll();
                                    layer.msg("删除成功！", {
                                        time: 2000
                                        , offset: '200px'
                                    })
                                } else {
                                    location.href = "orderPage";
                                }
                            }
                        );
                    }
                });
            }
        };
        $(".deleteOrderLink").on('click', function () {
            active['confirmTrans'].call(this, $(this));
        });
    });
</script>
</body>
</html>
