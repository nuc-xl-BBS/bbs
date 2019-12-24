<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    a{text-decoration: none;}
</style>

<c:if test="${empty userId}">
    <!-- 未登录 -->
    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item" style="background-color: black;color: white">【请登录】</li>
            <li class="list-group-item">
                <a  href="<%=basePath%>signin" class="btn btn-default btn-block">登录</a>
                <a  href="<%=basePath%>signup" class="btn btn-default btn-block">注册</a>
            </li>
        </ul>
    </div>
</c:if>

<c:if test="${!empty userId}">
    <!-- 已登录 -->
    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <c:if test="${user.type=='0'}">
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item" style="background-color: black;color: white">你好&nbsp;【${user.username}】</li>
            <li class="list-group-item"><a href="<%=basePath%>member/${user.username}">查看我的信息</a></li>
            <li class="list-group-item"><a href="<%=basePath%>new">创作新的帖子</a></li>
            <li class="list-group-item"><a href="<%=basePath%>user/update/${user.username}">修改个人信息</a></li>
            <li class="list-group-item"><a href="<%=basePath%>look/${user.id}">查看我的贴子</a> </li>
            <li class="list-group-item"><a href="">积分:${user.credit}</a></li>
        </ul>
        </c:if>
        <c:if test="${user.type=='1'}">
            <ul class="list-group" style="width: 100%">
                <li class="list-group-item" style="background-color: black;color: white">你好&nbsp;【${user.username}】</li>
                <li class="list-group-item"><a href="<%=basePath%>member/${user.username}">查看我的信息</a></li>
                <li class="list-group-item"><a href="<%=basePath%>user/update/${user.username}">修改个人信息</a></li>
                <li class="list-group-item"><a href="<%=basePath%>taball">论坛板块管理</a></li>
                <li class="list-group-item"><a href="<%=basePath%>userall">论坛用户管理</a></li>
            </ul>
        </c:if>
    </div>
</c:if>

<div class="panel panel-default" id="sidebar1" style="width: 20%;margin:1% 2% 1% 0%;float: right">
    <ul class="list-group" style="width: 100%">
        <li class="list-group-item" style="background-color: black;color: white">【关于】</li>
        <li class="list-group-item">QQ：1234456789</li>
        <li class="list-group-item">enen：enenene</li>
        <li class="list-group-item">heng：hengheng？</li>
        <li class="list-group-item">email:kefu@csdn.n</li>
        <li class="list-group-item">tel:400-4444-4444</li>
        <li class="list-group-item">会员数: ${usersNum}</li>
        <li class="list-group-item">话题数: ${topicsNum}</li>
        <li class="list-group-item">京ICP备19004658号&nbsp;&nbsp;经营性网站备案信息&nbsp;&nbsp;
            公安备案号&nbsp;&nbsp;11010502030143<br>
            ©1999-2019&nbsp;&nbsp;北京创新乐知网络技术有限公司 </li>
        <li class="list-group-item">design by ours</li>
    </ul>
</div>


