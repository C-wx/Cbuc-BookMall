<%--
  Created by IntelliJ IDEA.
  User: 14046
  Date: 2019/11/11
  Time: 23:03
  To change this template use File | Settings | File Templates.
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
<style>
    .row{
        margin-left: 60px;
        margin-top: 50px
    }
    .contentSpan {
        color: #92B8B1;
        cursor: pointer;
        width: 200px;
        height: 22px;
        display: inline-block;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    #navigatepage{
        margin-left: 560px;
        margin-top: 20px;
    }
</style>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-5 col-md-12 col-sm-12 col-xs-12">
            <h2>
                我的消息
                <i class="fa fa-weixin"></i>
            </h2>
            <hr>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <c:forEach items="${pageInfo.list}" var="c">
                    <div class="media" style="margin-top: 30px">
                        <div class="media-body">
                            <p class="media-heading" style="font-size: 18px">
                                <span style="color: #8a6d3b;font-size: 20px">${c.user.user_name}</span>&nbsp;&nbsp;&nbsp;回复了你:&nbsp;&nbsp;
                                <span onclick="showMessage(this)" cid="${c.id}" class="contentSpan">${c.content}</span>
                                <c:if test="${c.status == 'E'}">
                                    <span class="label label-danger">未读</span>
                                </c:if>
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div id="navigatepage" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${not pageInfo.isFirstPage}">
                        <li>
                            <a href="/messagePage?pn=1" aria-label="Previous">
                                <span aria-hidden="true">&lt;&lt;</span>
                            </a>
                        </li>
                        </c:if>
                        <c:if test="${pageInfo.hasPreviousPage }">
                        <li>
                            <a href="/messagePage?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&lt;</span>
                            </a>
                        </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="pn">
                            <c:choose>
                            <c:when test="${pn == pageInfo.pageNum}">
                                <li class="active">
                                    <a href="/messagePage?pn=${pn}">${pn}</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li text="${pn}">
                                    <a href="/messagePage?pn=${pn}">${pn}</a>
                                </li>
                            </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage }">
                        <li>
                            <a href="/messagePage?pn=${pageInfo.pageNum+1}" aria-label="Previous">
                                <span aria-hidden="true">&gt;</span>
                            </a>
                        </li>
                        </c:if>
                        <c:if test="${not pageInfo.isLastPage}">
                        <li>
                            <a href="/messagePage?pn=${pageInfo.pages}" aria-label="Previous">
                                <span aria-hidden="true">&gt;&gt;</span>
                            </a>
                        </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function showMessage(c) {
        $.ajax({
            url: "readReply",
            type: "post",
            data: {'id': $(c).attr("cid")},
            success: function (result) {
                if (result.code == 100) {
                    layer.open({
                        type: 0
                        , offset: 'auto'
                        , id: 'layerDemo' + 1
                        , content: '<div style="padding: 20px;">' + $(c).html() + '</div>'
                        , shade: 0.3
                        , anim: 5
                    });
                    $(c).next().hide();
                    $("#contactTotalItemNumber").text(result.data);
                }
            }
        })
    }
</script>
</html>
