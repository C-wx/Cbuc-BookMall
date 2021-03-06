<%--
  User: 14046
  Date: 2019/10/3
  Time: 10:29
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
</head>
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

<div style="clear: both;"/>

<%-- 分类信息栏 --%>
<div class="main-nav">
    <div class="workArea">
            <span class="category-type">
                <span class="category-type-text" style="margin-left: 28px">图书分类</span>
                <span class="glyphicon glyphicon-hand-down category-type-icon" ></span>
            </span>
        <span id="links">
            <a href="searchProduct?keyword=图书">
                <span>图书</span>
            </a>
            <a href="searchProduct?keyword=电子书">
                <span>电子书</span>
            </a>
            <a href="searchProduct?keyword=网络文学">
                <span>网络文学</span>
            </a>
            <a href="searchProduct?keyword=服装">
                <span>服装</span>
            </a>
            <a href="searchProduct?keyword=运动户外">
                <span>运动户外</span>
            </a>
            <a href="searchProduct?keyword=孕婴童">
                <span>孕婴童</span>
            </a>
            <a href="searchProduct?keyword=教育">
                <span>教育</span>
            </a>
            <a href="searchProduct?keyword=文艺">
                <span>文艺</span>
            </a>
            <a href="searchProduct?keyword=励志">
                <span>励志</span>
            </a>
        </span>
    </div>
</div>
</body>
</html>
