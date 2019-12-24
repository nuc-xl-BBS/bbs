<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    a{text-decoration: none;}
</style>
<header >
    <nav class="navbar navbar-default" role="navigation" style="background-color: black;color: white">
        <div class="container-fluid" style="margin-left: 20%;">
            <div class="navbar-header">
                <a class="navbar-brand" href="<%=basePath%>">MyBBS</a>
            </div>
                <c:if test="${empty userId}">
                <!--未登陆-->
                 <ul class="nav navbar-nav navbar-right">
                       <li>
                           <a class="navbar-brand"href="<%=basePath%>signin">登录</a>
                       </li>
                       <li>
                               <a class="navbar-brand" href="<%=basePath%>signup">注册</a>
                       </li>
                 </ul>
                </c:if>
            <c:if test="${!empty userId}">
                   <!--已登陆-->
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <p class="navbar-text"><a href="<%=basePath%>>">首页</a></p>
                    </li>
                    <li>
                        <p class="navbar-text"><a href="<%=basePath%>member/${sessionScope.id}">${sessionScope.username}</a></p>
                    </li>
                    <li>
                        <p class="navbar-text"><a href="javascript:signout_confirm();">登出</a></p>
                    </li>
                </ul>
            </c:if>
        </div>
    </nav>
</header>
<script>
    function signout_confirm()
    {
        var r=confirm("确定退出?")
        if (r==true)
        {
            window.location.href="<%=basePath%>signout";
        }
        else
        {

        }
    }
</script>