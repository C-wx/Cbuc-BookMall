<%--
  User: Cbuc
  Date: 2019/10/16
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Title</title>
    <script src="${APP_PATH}/static/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${APP_PATH}/static/assets/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/lib/layui-v2.5.4/css/layui.css">
    <script src="${APP_PATH}/static/lib/layui-v2.5.4/layui.all.js"></script>

    <link rel="stylesheet" href="${APP_PATH}/static/css/searchResult.css">
    <link href="${APP_PATH}/static/css/style.css" rel="stylesheet">
</head>
<jsp:include page="include/top.jsp"/>

<body>
<div class="header">
    <div class="headerLayout workArea" style="position: relative;left: 20px">
        <%-- 图片logo --%>
        <div class="logo">
            <a href="${context}">
                <img src="../../../static/imgs/p.jpg" alt="这是小黄书城的LOGO" style="font-size: 40px;color: red;">
            </a>
        </div>

        <%-- 搜索框 --%>
        <form class="mallSearch-input" action="/searchProduct">
            <input name="keyword" type="text" placeholder="新中国70年70部长篇小说典藏">
            <button type="submit" class="searchButton"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
            <ul class="hot-query">
                <li>
                    热搜：
                </li>
                <li>
                    <a href="searchProduct?keyword=我在未来等你">我在未来等你</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=人类探险史">人类探险史</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=中间民间故事">中间民间故事</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=正面管教">正面管教</a>
                </li>
            </ul>
        </form>
    </div>
</div>
<div class="workArea">
    <div class="searchProducts">
        <c:forEach items="${products}" var="p">
            <div class="product">
                <div class="product-iWrap">
                    <div class="productImg-wrap">
                        <a class="productImg" href="/showProduct?product_id=${p.id}">
                            <img src="../../static/upload/image/${p.img}" width="200px" height="300px">
                        </a>
                    </div>
                    <div style="clear: both;"></div>
                    <p class="productPrice">
                        <em title="${p.price}">
                            <b>￥</b>${p.price}
                        </em>
                    </p>
                    <div style="clear: both;"></div>
                    <p class="productTitle">
                        <a href="/showProduct?product_id=${p.id}">${p.name}</a>
                    </p>
                    <p class="productStatus">
                        <span>销量<em>${p.saled}</em></span>
                        <span>评价<a href="#nowhere">${p.commentCount}</a></span>
                        <span class="ww-light"><a></a></span>
                    </p>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty products}">
            <div class="nrt">
                <p>
                    没找到与
                    <em style="font-weight: bold;font-size: 16px">" ${param.keyword} "</em>
                    相关的商品哦。
                </p>
            </div>
        </c:if>
        <div style="clear:both"></div>
    </div>
</div>
</body>
</html>
