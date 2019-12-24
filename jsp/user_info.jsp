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
            查看我的信息
        </div>

        <div class="panel-body">
            <c:if test="${!empty userInfo}">

                <div class="form-group">
                    <label class="col-sm-2 control-label">uid</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.id}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.username}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.email}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">工作性质</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.workxz}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">工作单位</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.workdw}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">注册时间</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.localCreateTime}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">积分</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${userInfo.credit}</p>
                    </div>
                </div>
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