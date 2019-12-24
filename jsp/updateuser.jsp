<%--
  Created by IntelliJ IDEA.
  User: 向莲
  Date: 2019/12/21
  Time: 15:55
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
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: black;color: white">
            修改用户
        </div>

        <div class="panel-body">
            <form action="<%=basePath%>userupdate/${u.id}" method="post">
                <div class="form-group">
                    <label for="pwd">用户名</label>
                    <input type="text" class="form-control" id="pwd" name="username" value="${u.username}">
                </div>
                <div class="form-group">
                    <label for="1">密码</label>
                    <input type="text" class="form-control" id="1" name="password" value="${u.password}">
                </div>
                <div class="form-group">
                    <label for="2">email</label>
                    <input type="text" class="form-control" id="2" name="email" value="${u.email}">
                </div>
                <div class="form-group">
                    <label for="3">电话号码</label>
                    <input type="text" class="form-control" id="3" name="phonenum" value="${u.phoneNum}">
                </div>
                <div class="form-group">
                    <label for="4">积分</label>
                    <input type="text" class="form-control" id="4" name="credit" value="${u.credit}">
                </div>
                <div class="form-group">
                    <label for="5">工作性质</label>
                    <input type="text" class="form-control" id="5" name="workxz" value="${u.workxz}">
                </div>
                <div class="form-group">
                    <label for="6">工作单位</label>
                    <input type="text" class="form-control" id="6" name="workdw" value="${u.workdw}">
                </div>

                <div class="form-group" hidden>
                    <input type="text" class="form-control" id="username" name="id" value="${u.id}">
                </div>
                <input type="submit" class="btn btn-default" id="signup" style="margin-left: 17%">
            </form>
        </div>
    </div>
</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>
<%@ include file="footer.jsp"%>

</body>
</html>