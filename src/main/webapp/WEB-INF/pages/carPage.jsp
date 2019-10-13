<%--
  User: Cbuc
  Date: 2019/10/11
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
    <title>购物车</title>
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.all.js"></script>
    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">
    <link rel="stylesheet" href="${APP_PATH}/static/css/carPage.css">
    <script src="${APP_PATH}/static/js/carPage.js"></script>
</head>
<jsp:include page="include/top.jsp"/>
<body>
<%--删除模态框--%>
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div style="text-align: center;font-weight: bold;font-size: 24px;margin: 10px auto 20px">确认移除此商品吗</div>
                <div style="text-align: center;margin: 10px auto">
                    <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-right: 40px">取消</button>
                    <button type="button" class="btn btn-primary deleteConfirmButton">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="logo">
    <a href="${context}">
        <img src="../../../static/imgs/p.jpg" alt="这是小黄书城的LOGO" id="logoImg">
    </a>
</div>
<div class="cartDiv">
    <div class="cartTitle pull-right">
        <span style="font-size: 15px">已选商品  (不含运费)</span>
        <span class="cartTitlePrice">￥0.00</span>
        <button class="createOrderButton" disabled="disabled">结 算</button>
    </div>
    <div class="cartProductList">
        <table class="cartProductTable">
            <thead>
            <tr>
                <th class="selectAndImage">
                    <img selectit="false" class="selectAllItem" src="../../static/imgs/cartNotSelected.png">
                    全选
                </th>
                <th>商品信息</th>
                <th>单价</th>
                <th>数量</th>
                <th width="120px">金额</th>
                <th class="operation">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${orderLogs}" var="oi">
                <tr orderItemId="${oi.id}" class="cartProductItemTR">
                    <td>
                        <img selectit="false" orderItemId="${oi.id}" class="cartProductItemIfSelected"
                             src="../../static/imgs/cartNotSelected.png">
                        <a style="display:none" href="javascript:;"><img src="../../static/imgs/cartSelected.png"></a>
                        <img class="cartProductImg"
                             src="../../static/upload/image/${oi.product.img}">
                    </td>
                    <td>
                        <div class="cartProductLinkOutDiv">
                            <a href="/showProduct?product_id=${oi.product.id}"
                               class="cartProductLink">${oi.product.name}</a>
                            <div class="cartProductLinkInnerDiv">
                                <img src="../../static/imgs/creditcard.png" title="支持信用卡支付">
                                <img src="../../static/imgs/7day.png" title="消费者保障服务,承诺7天退货">
                                <img src="../../static/imgs/promise.png" title="消费者保障服务,承诺如实描述">
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class="cartProductItemOringalPrice">￥<fmt:formatNumber type="number" value="${oi.product.price}" minFractionDigits="2"/></span>
                        <span class="cartProductItemPromotionPrice">￥<fmt:formatNumber type="number" value="${oi.product.price}" minFractionDigits="2"/></span>
                    </td>
                    <td>
                        <div class="cartProductChangeNumberDiv">
                            <span class="hidden orderItemStock " product_id="${oi.product.id}">${oi.product.stock}</span>
                            <span class="hidden orderItemPromotePrice "
                                  product_id="${oi.product.id}">${oi.product.price}</span>
                            <a product_id="${oi.product.id}" class="numberMinus" href="javascript:;">-</a>
                            <input product_id="${oi.product.id}" orderItemId="${oi.id}" class="orderItemNumberSetting"
                                   autocomplete="off" value="${oi.num}">
                            <a stock="${oi.product.stock}" product_id="${oi.product.id}" class="numberPlus"
                               href="javascript:;">+</a>
                        </div>
                    </td>
                    <td>
                        <span class="cartProductItemSmallSumPrice" orderItemId="${oi.id}" product_id="${oi.product.id}">
                                ￥<fmt:formatNumber type="number" value="${oi.product.price}" minFractionDigits="2"/>
                        </span>
                    </td>
                    <td>
                        <a class="deleteOrderItem btn btn-danger" orderItemId="${oi.id}" href="javascript:;">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="cartFoot">
        <img selectit="false" class="selectAllItem" src="../../static/imgs/cartNotSelected.png">
        <span>全选</span>
        <div class="pull-right">
            <span>已选商品 <span class="cartSumNumber">0</span> 件</span>

            <span>合计 (不含运费): </span>
            <span class="cartSumPrice">￥0.00</span>
            <button class="createOrderButton" disabled="disabled">结 算</button>
        </div>
    </div>
</div>
<jsp:include page="include/foot.jsp"/>
</body>
</html>
