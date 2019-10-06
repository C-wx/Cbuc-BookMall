<%--
  User: Cbuc
  Date: 2019/9/26
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>主页</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.all.js"></script>

    <link rel="stylesheet" href="${APP_PATH}/static/css/home.css">
    <link href="${APP_PATH}/static/css/fore/style.css" rel="stylesheet">
</head>
<jsp:include page="include/top.jsp"/>
<jsp:include page="include/search.jsp"/>
<body>
<div class="category-con">
    <div class="workArea">

        <%-- 分类栏 --%>
        <div class="category-tab-content">
            <ul class="normal-nav">
                <c:forEach items="${categories}" var="c">
                    <li class="nav-item" category_id="${c.id}">${c.name}</li>
                    <li style="color: #1aa094;">-------------------------------</li>
                </c:forEach>
            </ul>
            <%@include file="include/categoryList.jsp" %>
        </div>

        <script type="text/javascript">
            function showProductsByCategoryId(category_id) {
                $("div.hot-word-con[category_id=" + category_id + "]").show();
            }

            function hideProductsByCategoryId(category_id) {
                $("div.hot-word-con[category_id=" + category_id + "]").hide();
            }

            $(function () {
                $("li.nav-item").mouseenter(function () {
                    var category_id = $(this).attr("category_id");
                    showProductsByCategoryId(category_id);
                });
                $("li.nav-item").mouseleave(function () {
                    var category_id = $(this).attr("category_id");
                    hideProductsByCategoryId(category_id);
                });
                $("div.hot-word-con").mouseenter(function () {
                    var category_id = $(this).attr("category_id");
                    showProductsByCategoryId(category_id);
                });
                $("div.hot-word-con").mouseleave(function () {
                    var category_id = $(this).attr("category_id");
                    hideProductsByCategoryId(category_id);
                });
            });
        </script>

        <div style="clear: both;"></div>

        <%--轮播图--%>
        <div id="myCarousel" class="carousel slide">
            <!-- 轮播（Carousel）指标 -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <!-- 轮播（Carousel）项目 -->
            <div class="carousel-inner">
                <div class="item active">
                    <img src="../../static/imgs/bg-58.jpg" alt="First slide">
                </div>
                <div class="item">
                    <img src="../../static/imgs/15209.jpg" alt="Second slide">
                </div>
                <div class="item">
                    <img src="../../static/imgs/register-bgc08e.jpg" alt="Third slide">
                </div>
            </div>
            <!-- 轮播（Carousel）导航 -->
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
</div>
<div style="clear: both;"></div>

<div class="new-floor-con">
    <div class="workArea">
        <%--热卖分类--%>
        <div class="floor-line-con" >
            <i class="color-mark" style="background-color: mediumvioletred"></i>
            <div class="floor-name">新书
                <span class="glyphicon glyphicon-fire" aria-hidden="true" style="color: red;"></span>
                热
                <span class="glyphicon glyphicon-fire" aria-hidden="true" style="color: red;"></span>
                卖版</div>
            <br>
            <c:forEach items="${hotBooks}" var="hbs">
                <a class="grid" href="showProduct?product_id=${hbs.id}">
                    <div class="productItem">
                        <img class="floor-item-img" src="../../static/upload/image/${hbs.img}">
                        <div class="floor-item-name">${hbs.name}</div>
                        <div class="floor-item-title">${hbs.title}</div>
                        <div class="floor-price">${hbs.price}</div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <div style="clear: both;"></div>
        <%--活动商品--%>
        <div class="floor-line-con" >
            <i class="color-mark" style="background-color: mediumvioletred"></i>
            <div class="floor-name">活动
                <span class="glyphicon glyphicon-volume-up" aria-hidden="true" style="color: red;margin-right: 6px"></span>精
                <span class="glyphicon glyphicon-volume-up" aria-hidden="true" style="color: red;margin:0px 4px 0px"></span>选</div>

            <br>
            <c:forEach items="${activeBooks}" var="abs">
                <a class="grid" href="showProduct?product_id=${abs.id}">
                    <div class="productItem">
                        <img class="floor-item-img" src="../../static/upload/image/${abs.img}">
                        <div class="floor-item-name">${abs.name}</div>
                        <div class="floor-item-title">${abs.title}</div>
                        <div class="floor-price">${abs.price}</div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <div style="clear: both;"></div>
        <c:forEach items="${categories}" var="c" varStatus="sts">
            <%-- 该分类下有产品才能显示 --%>
            <c:if test="${!empty c.products}">
                <%-- 默认只展示前五个分类的内容，多了页面太长 --%>
                <c:if test="${sts.count<=5}">
                    <div class="floor-line-con">
                        <i class="color-mark"></i>
                        <div class="floor-name">${c.name}</div>
                        <span class="glyphicon glyphicon-book" aria-hidden="true" style="margin-left: 5px"></span>
                        <br>
                        <c:forEach items="${c.products}" var="p" varStatus="st">
                            <c:if test="${st.count<=5}">
                                <a class="grid" href="showProduct?product_id=${p.id}">
                                    <div class="productItem">
                                        <img class="floor-item-img" src="../../static/upload/image/${p.img}">
                                        <div class="floor-item-name">${p.name}</div>
                                        <div class="floor-item-title">${p.title}</div>
                                        <div class="floor-price">${p.price}</div>
                                    </div>
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div style="clear: both;"></div>
                </c:if>
            </c:if>
        </c:forEach>
        <div class="tm-end">
            <img src="../../static/imgs/end.png"/>
        </div>
    </div>
</div>
<div style="clear: both;"></div>
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
