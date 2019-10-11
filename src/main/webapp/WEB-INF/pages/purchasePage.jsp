<%--
  User: 14046
  Date: 2019/10/9
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>购买页面</title>
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.all.js"></script>

    <link rel="stylesheet" href="${APP_PATH}/static/css/purchasePage.css">
    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="include/top.jsp"/>
<script>
    $(function () {
        $("span.leaveMessageTextareaSpan").hide();
        $("img.leaveMessageImg").click(function () {
            $(this).hide();
            $("span.leaveMessageTextareaSpan").show();
            $("div.orderItemSumDiv").css("height", "100px");
        });
    });
</script>
<div class="buyPageDiv">
    <form action="createOrder" method="post">
        <input type="hidden" name="num" value="${param.number}"/>
        <input type="hidden" name="product_id" value="${param.product_id}"/>
        <div class="buyFlow">
            <a href="/home">
                <img class="pull-left" src="../../static/imgs/p.jpg" style="width: 240px;height: 130px">
            </a>
            <img class="pull-right" src="../../static/imgs/buyflow.png" style="margin-top: 40px">
            <div style="clear:both"></div>
        </div>
        <div class="address">
            <div class="addressTip">
                输入收货地址 <i class="fa fa-institution"></i>：
            </div>
            <div>
                <table class="addressTable">
                    <tr>
                        <td class="firstColumn">&nbsp;&nbsp;&nbsp;&nbsp;<span class="redStar">*</span>详细地址：</td>
                        <td><textarea name="addr" class="inputText" rows="1" placeholder="收货地址"></textarea></td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;邮政编码：</td>
                        <td><input name="post" class="inputText" placeholder="邮政编码" type="text" maxlength="6"></td>
                    </tr>
                    <tr>
                        <td><span class="redStar">*</span>收货人姓名：</td>
                        <td><input name="receiver" class="inputText" placeholder="收货人姓名" type="text" maxlength="25"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;<span class="redStar">*</span>手机号码：</td>
                        <td><input name="phone" class="inputText" placeholder="手机号码" type="text" maxlength="11"></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="productList">
            <div class="productListTip">
                确认订单信息 <i class="fa fa-file-text"></i>:
            </div>
            <table class="productListTable">
                <thead>
                <tr>
                    <th colspan="2" class="productListTableFirstColumn">
                       订单信息
                    </th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>配送方式</th>
                </tr>
                <tr class="rowborder">
                    <td colspan="2"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </thead>
                <tbody class="productListTableTbody">
                <c:forEach items="${orderLogs}" var="ol" varStatus="st">
                    <input type="hidden" name="orderLogId" value="${ol.id}">
                    <input type="hidden" name="price" id="price">
                    <tr class="orderItemTR">
                        <td class="orderItemFirstTD"><img class="orderItemImg" src="../../static/upload/image/${ol.product.img}">
                        </td>
                        <td class="orderItemProductInfo">
                            <a href="/showProduct?product_id=${ol.product_id}" class="orderItemProductLink">
                                    ${ol.product.name}
                            </a>
                            <img src="../../static/imgs/creditcard.png" title="支持信用卡支付">
                            <img src="../../static/imgs/7day.png" title="消费者保障服务,承诺7天退货">
                            <img src="../../static/imgs/promise.png" title="消费者保障服务,承诺如实描述">
                        </td>
                        <td>
                            <span class="orderItemProductPrice">￥<fmt:formatNumber type="number" value="${ol.product.price}" minFractionDigits="2"/></span>
                        </td>
                        <td>
                            <span class="orderItemProductNumber">${ol.num}</span>
                        </td>
                        <td>
                            <span class="orderItemUnitSum" >￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span>
                        </td>
                        <c:if test="${st.count==1}">
                            <td rowspan="5" class="orderItemLastTD">
                                <label class="orderItemDeliveryLabel">
                                    <input type="radio" value="0" name="postage" checked="checked">
                                    普通配送
                                </label>
                                <label class="orderItemDeliveryLabel">
                                    <input type="radio" value="1" name="postage">
                                    小黄速运
                                </label>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <script>
                $(function () {
                    $("input[name='delivery']").on('click', function () {
                        if ($("input[name='postage']:checked").val() == "1") {
                            $("#totalMoney").text("￥"+(${total}+10));
                            $(".orderItemTotalSumSpan").text("￥"+(${total}+10));
                        }else{
                            $("#totalMoney").text("￥"+${total});
                            $(".orderItemTotalSumSpan").text("￥"+${total});
                        }
                    });
                });
            </script>
            <div class="orderItemSumDiv">
                <div class="pull-left">
                    <span class="leaveMessageText">给卖家留言:</span>
                    <span>
                        <img class="leaveMessageImg" style="" src="../../static/imgs/leaveMessage.png">
                    </span>
                    <span class="leaveMessageTextareaSpan">
					<textarea name="comment" class="leaveMessageTextarea"></textarea>
					<div>
						<span>还可以输入200个字符</span>
					</div>
				    </span>
                </div>
                <span class="pull-right">店铺合计(含运费):￥<span id="totalMoney"><fmt:formatNumber type="number" value="${total}" minFractionDigits="0"/></span> </span>
            </div>
        </div>

        <div class="orderItemTotalSumDiv">
            <div class="pull-right">
                <span>实付款：</span>
                <span class="orderItemTotalSumSpan">￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="0"/></span>
            </div>
        </div>

        <div class="submitOrderDiv">
            <button type="button" onclick="submitForm(this)" class="submitOrderButton">提交订单</button>
        </div>
    </form>
    <script>
        submitForm = function (e) {
            $("#price").val($("#totalMoney").text());
            $.ajax({
                url : $("form").attr("action"),
                type : "POST",
                data : $("form").serialize(),
                success : function (result) {
                    window.location.href = "payPage?order_id=" + result.data.id + "&total=" + $(".orderItemTotalSumSpan").text().split("￥")[1];
                }
            });
        }
    </script>
</div>
</body>
</html>
