<%--
  User: Cbuc
  Date: 2019/10/4
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
    <title>商品详情页</title>
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.all.js"></script>

    <link rel="stylesheet" href="${APP_PATH}/static/css/detail.css">
    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="include/top.jsp"/>
<script>
    $(function () {
        $("img.smallImg").mouseenter(function () {
            var bigImgURL = $(this).attr("bigImgURL");
            $("img.bigImg").attr("src", bigImgURL);
        });

        var stock = ${product.stock};
        $(".productNumberSetting").keyup(function () {
            var num = $(".productNumberSetting").val();
            num = parseInt(num);
            if (isNaN(num))
                num = 1;
            if (num <= 0)
                num = 1;
            if (num > stock)
                num = stock;
            $(".productNumberSetting").val(num);
        });

        $(".increaseNumber").click(function () {
            var num = $(".productNumberSetting").val();
            num++;
            if (num > stock)
                num = stock;
            $(".productNumberSetting").val(num);
        });
        $(".decreaseNumber").click(function () {
            var num = $(".productNumberSetting").val();
            --num;
            if (num <= 0)
                num = 1;
            $(".productNumberSetting").val(num);
        });

        $("div.productReviewDiv").hide();
        $("a.productDetailTopReviewLink").click(function () {
            $("div.productReviewDiv").show();
            $("div.productDetailDiv").hide();
        });
        $("a.productReviewTopPartSelectedLink").click(function () {
            $("div.productReviewDiv").hide();
            $("div.productDetailDiv").show();
        });

        $(".addCartLink").click(function () {
            var page = "checkLogin";
            $.get(
                page,
                function (result) {
                    if ("success" == result) {
                        var product_id = ${product.id};
                        var num = $(".productNumberSetting").val();
                        var addCartpage = "/addPurchase";
                        $.get(
                            addCartpage,
                            {"product_id": product_id, "num": num},
                            function (result) {
                                if (result.code == "100") {
                                    $("#cartTotalItemNumber").text(result.data);
                                    $(".addCartButton").html("已加入购物车");
                                    $(".addCartButton").attr("disabled", "disabled");
                                    $(".addCartButton").css("background-color", "lightgray");
                                    $(".addCartButton").css("border-color", "lightgray");
                                    $(".addCartButton").css("color", "black");
                                }
                                else {
                                    layer.msg("添加失败");
                                }
                            }
                        );
                    }
                    else {
                        $("#loginForm input").val('');
                        $("#myModal").modal('show');
                    }
                }
            );
            return false;
        });
        $("#saveLogin").click(function () {
            $.ajax({
                type: "post",
                url: "/loginByAjax",
                data: $("#loginForm").serialize(),
                success: function (result) {
                    if (result.code == "100") {
                        $("#myModal").modal('hide');
                        alert("登录成功！");
                        window.location.reload();
                    } else {
                        $("#myModal").modal('hide');
                        alert("用户不存在，请检查用户名密码！");
                    }
                }
            });
        });
    });

</script>

<%--提示登录模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel" style="text-align: center;font-size: 25px">您还未登录,请先登录!</h4>
            </div>
            <form action="/loginIn" class="loginForm" method="post" id="loginForm">
                <div class="field" style="margin-left: 190px;height: 30px;margin-top: 10px">
                        <span class="loginInputIcon">
					        <span class=" glyphicon glyphicon-user"></span>
				        </span>
                    <input id="name" name="user_name" placeholder="手机/会员名/邮箱" type="text" AUTOCOMPLETE="off"
                           style="height: 30px;border: 0px;margin-left: 8px;"/>
                </div>
                <div class="field" style="margin-left: 190px;height: 30px;margin-top: 10px">
                        <span class="loginInputIcon ">
                            <span class=" glyphicon glyphicon-lock"></span>
                        </span>
                    <input id="password" name="pwd" type="password" placeholder="密码" type="text" AUTOCOMPLETE="off"
                           style="height: 30px;border: 0px;margin-left: 8px"/>
                </div>
            </form>
            <div class="modal-footer">
                <a href="/toRegister" class="layui-btn layui-btn-primary layui-btn-radius" id="toRegister">去注册</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveLogin">登录</button>
            </div>
        </div>
    </div>
</div>
<%--END--%>

<div class="product">
    <div class="imgAndInfo">
        <div class="imgInimgAndInfo">
            <img class="bigImg" src="../../static/upload/image/${product.img}">
            <div class="smallImageDiv">
                <img class="smallImg" src="../../static/upload/image/${product.img}"
                     bigImgURL="../../static/upload/image/${product.img}">
                <img class="smallImg" src="../../static/upload/image/${product.img}"
                     bigImgURL="../../static/upload/image/${product.img}">
                <img class="smallImg" src="../../static/upload/image/23579654-1_b_2.jpg"
                     bigImgURL="../../static/upload/image/23579654-1_b_2.jpg">
                <img class="smallImg" src="../../static/upload/image/${product.img}"
                     bigImgURL="../../static/upload/image/${product.img}">
                <img class="smallImg" src="../../static/upload/image/${product.img}"
                     bigImgURL="../../static/upload/image/${product.img}">
                <div class="img4load hidden"></div>
            </div>
        </div>

        <div class="infoInimgAndInfo">
            <div class="productTitle">
                ${product.name}
            </div>
            <div class="productSubTitle">
                ${product.title}
            </div>
            <div class="productPrice">
                <div class="productPriceDiv">
                    <div class="gouwujuanDiv"><img src="../../static/imgs/coupon-log.jpg">
                        <span> 全书城商品通用</span>
                    </div>

                    <div class="promotionDiv">
                        <span class="promotionPriceDesc">价格 :</span>
                        <span class="promotionPriceYuan">¥</span>
                        <span class="promotionPrice">${product.price}</span>
                    </div>
                </div>
            </div>

            <div class="productSaleAndReviewNumber">
                <div>销量<span class="redColor boldWord" style="margin-left: 8px;">${product.saled}</span></div>
                <div>累计评价<span class="redColor boldWord" style="margin-left: 8px;">${product.commentCount}</span></div>
            </div>
            <div class="productNumber">
                <span>数量</span>
                <span>
                <span class="productNumberSettingSpan">
                <input type="text" id="number" value="1" class="productNumberSetting">
                </span>
					<span class="arrow">
                    <a class="increaseNumber" href="#nowhere">
                    <span class="updown">
                       <img src="../../static/imgs/increase.png">
                    </span>
					</a>
					<span class="updownMiddle"> </span>
					<a class="decreaseNumber" href="#nowhere">
						<span class="updown">
                        <img src="../../static/imgs/decrease.png">
                    </span>
					</a>
					</span>
					件</span>
                <span>库存${product.stock}件</span>
            </div>
            <div class="serviceCommitment">
                <span class="serviceCommitmentDesc">服务承诺</span>
                <span class="serviceCommitmentLink">
                <a href="#nowhere">正品保证</a>
                <a href="#nowhere">极速退款</a>
                <a href="#nowhere">赠运费险</a>
                <a href="#nowhere">七天无理由退换</a>
            </span>
            </div>
            <script>
                function buyLink() {
                    var page = "checkLogin";
                    $.get(
                        page,
                        function (result) {
                            if ("success" == result) {
                                var productId = ${product.id};
                                debugger
                                window.location = "/buyNow?product_id="+productId+"&number=" + $("#number").val();
                            }
                            else {
                                $("#loginForm input").val('');
                                $("#myModal").modal('show');
                            }
                        }
                    )
                }
            </script>
            <div class="buyDiv">
                <a onclick="javascript:buyLink()" class="buyLink">
                    <button class="buyButton">立即购买</button>
                </a>
                <a class="addCartLink" href="#nowhere">
                    <button class="addCartButton"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button>
                </a>
            </div>
        </div>
        <div style="clear:both"></div>
    </div>
</div>
<div style="clear: both;"></div>
<div class="productDetailDiv" style="display: block;">
    <div class="productDetailTopPart">
        <a class="productDetailTopPartSelectedLink selected" href="#nowhere">商品详情</a>
        <a class="productDetailTopReviewLink" href="#nowhere">累计评价 <span
                class="productDetailTopReviewLinkNumber">${product.commentCount}</span> </a>
    </div>

    <div class="productParamterPart">
        <div class="productParamter">产品参数：</div>
        <div class="productParamterList">
            <c:forEach items="${properties}" var="ps">
                <span>${ps.name}:${ps.value}</span>
            </c:forEach>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="productDetailImagesPart">
        <img src="../../static/upload/image/${product.img}">
    </div>
</div>
<div style="clear:both"></div>
<div class="productReviewDiv" style="display: block;">
    <div class="productReviewTopPart">
        <div class="productReviewTopPart">
            <a class="productReviewTopPartSelectedLink" href="#nowhere">商品详情</a>
            <a class="selected" href="#nowhere">累计评价
                <span class="productReviewTopReviewLinkNumber">${product.commentCount}</span>
            </a>
        </div>
        <div class="productReviewContentPart">
            <c:forEach items="${comments}" var="cs">
                <div class="productReviewItem">
                    <div class="productReviewItemDesc">
                        <div class="productReviewItemContent">
                                ${cs.msg}
                        </div>
                        <div class="productReviewItemDate"><fmt:formatDate value="${cs.create_time}" pattern="yyyy年MM月dd日" /></div>
                        <c:if test="${empty cs.user.user_name}">
                            <span class="userInfoGrayPart">（匿名）</span>
                        </c:if>
                        <span class="userInfoGrayPart">${cs.user.user_name}</span>
                    </div>
                    <div style="clear:both"></div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!--左侧客服栏-->
<div class="leftside">
    <a id="kefu" data-method="setTop" class="way2" title="联系客服"><img src="../../static/imgs/chatLog.png" alt="客服" width="30" height="30" style="margin-right: 8px;margin-top: 10px" /></a>
</div>
<script>
    $(function(){
        $('.leftside a').hover(function(){
            $(this).animate({width:'65px'},300);
        },function(){
            $(this).animate({width:'50px'},300);
        });
    });
    layui.use('layer', function () {
        var $ = layui.jquery, layer = layui.layer;
        var active = {
            setTop: function () {
                layer.open({
                    type: 2
                    , title: '客户服务中心'
                    , area: ['393px', '450px']
                    , shade: 0
                    , offset: [  300 , 100  ]
                    , content: 'kefu'
                    , btn: ['结束']
                    , btn2: function () {
                        layer.closeAll();
                    }
                    , zIndex: layer.zIndex
                    , success: function (layero) {
                        layer.setTop(layero);
                    }
                });
            }
        };

        $('#kefu').on('click', function () {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });

    });
</script>

</body>
</html>
