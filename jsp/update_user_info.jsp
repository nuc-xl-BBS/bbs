<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String socketPath = request.getServerName()+":"+request.getServerPort()+path+"/";
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
            更新个人信息
        </div>

        <div class="panel-body">
            <c:if test="${!empty userInfo}">
                <form action="<%=basePath%>user/updateinfo" method="post">
                    <div class="form-group">
                        <label for="username">用户名</label>
                        <input type="text" class="form-control" id="username" name="name" value="${userInfo.username}">
                    </div>

                    <div class="form-group">
                        <label for="pwd">密码</label>
                        <input type="text" class="form-control" id="pwd" name="password" value="${userInfo.password}" >
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="text" class="form-control" id="email" name="email" value="${userInfo.email}" >
                    </div>
                    <div class="form-group">
                        <label for="workxz">工作性质</label>
                        <input type="text" class="form-control" id="workxz" name="workxz" value="${userInfo.workxz}" >
                    </div>
                    <div class="form-group">
                        <label for="workdw">工作单位</label>
                        <input type="text" class="form-control" id="workdw" name="workdw" value="${userInfo.workdw}" >
                    </div>

                    <input type="text"  name="id" value="${userInfo.id}" hidden>
                <input type="submit" class="btn btn-default" id="signup" style="margin-left: 17%">
            </form>
            </c:if>
            <c:if test="${!empty errorInfo}">
                会员未找到!
            </c:if>
        </div>
    </div>
</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>
<%@ include file="footer.jsp"%>

</body>
</html>