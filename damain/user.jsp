<%--
  Created by IntelliJ IDEA.
  User: 向莲
  Date: 2019/12/21
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
    <meta charset="UTF-8">
    <link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-3.2.1.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>

</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default"  >
        <div class="panel-heading" style="background-color: black;color: white">
            板块管理
        </div>
            <ul class="list-group" style="width: 100%">
                <li class="list-group-item" >
                    <div style="width: 6%;float: left">用户ID</div>
                    <div style="width:6%;float: left">用户名</div>
                    <div style="width: 7%;float: left">用户密码</div>
                    <div style="width: 12%;float: left">电子邮箱</div>
                    <div style="width: 10%;float: left">电话号码</div>
                    <div style="width: 7%;float: left">创建时间</div>
                    <div style="width: 7%;float: left">更新时间</div>
                    <div style="width: 7%;float: left;text-align: center" >积分</div>
                    <div style="width: 7%;float: left">工作性质</div>
                    <div style="width: 7%;float: left">工作单位</div>
                    <div>&nbsp;</div>
                </li>
                <c:forEach items="${users}" var="u">
                    <li class="list-group-item">
                        <div style="width: 3%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default" >${u.id}</a>
                        </div>
                        <div style="width: 8%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default">${u.username}</a>
                        </div>
                        <div style="width: 7%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default">${u.password}</a>
                        </div>
                        <div style="width: 11%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default">${u.email}</a>
                        </div>
                        <div style="width: 10%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default">${u.phoneNum}</a>
                        </div>
                        <div style="width:9%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default">${u.createTime}</a>
                        </div>
                        <div style="width:8%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default">${u.updateTime}</a>
                        </div>
                        <div style="width: 5%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default">${u.credit}</a>
                        </div>
                        <div style="width: 6%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default">${u.workxz}</a>
                        </div>
                        <div style="width: 6%;float: left;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default">${u.workdw}</a>
                        </div>
                        <div style="width: 3%;float: right;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default" href="<%=basePath%>userhuixian/${u.id}">修改用户</a>
                        </div>
                        <div style="width: 3%;float: right;text-align: center;font-size: 12px;color: black">
                            <a class="button btn-default" href="<%=basePath%>userdelete/${u.id}">删除用户</a>
                        </div>
                    <br><br><br>
                    </li>
                </c:forEach>
            </ul>

        </div>
</div>
        <!-- 引入侧边栏文件 -->
        <%@ include file="side.jsp"%>
<%@ include file="footer.jsp"%>

</body>
</html>