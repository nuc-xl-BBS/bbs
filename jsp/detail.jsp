<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
    <meta charset="UTF-8">
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath %>js/jquery-3.2.1.js"></script>
    <script src="<%=basePath %>js/bootstrap.min.js"></script>
    <title>${topic.title} - Genesis </title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>
<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
<div class="panel panel-default" id="main" style="">
    <div class="panel-heading" style="background-color: white">
        <div>
            <div class="panel-heading" style="background-color: black;color: white">
                帖子详情
            </div>
            <h3>${topic.title}</h3><br/>
            <div>
                <a href="<%=basePath%>look/${topic.userId}"><span ><strong>${topic.user.username}</strong></span></a>&nbsp;&nbsp;
                <small class="text-muted">${topic.localCreateTime}&nbsp;&nbsp;&nbsp;+08:00</small>&nbsp;&nbsp;
                <small class="text-muted">${topic.click}次点击</small>
            </div>
        </div>


    </div>

    <ul class="list-group" style="width: 100%">
            <li class="list-group-item">
                ${topic.content}
            </li>
    </ul>
</div>

<c:if test="${!empty replies}">
<div class="panel panel-default" id="main" style="">
    <div class="panel-heading" style="background-color: white">
        <span>
                ${fn:length(replies)} 回复  |  直到 <c:forEach items="${replies}" var="reply" varStatus="status">

<c:if test="${status.last}">
    ${reply.localCreateTime}
    </c:if>

    </c:forEach>
    </span>
    </div>

    <ul class="list-group" style="width: 100%">
        <!-- 遍历评论 -->
        <c:forEach items="${replies}" var="reply">
        <li class="list-group-item">
                    <a href="<%=basePath%>look/${reply.replyUserId}"><strong>${reply.user.username}</strong></a>&nbsp;&nbsp;
                    <small class="text-muted">${reply.localCreateTime}</small>
                    <br/>
                    <div>
                        <p style="width: 90%">${reply.content}
                            <c:if test="${topic.tabId=='6'}">
                            <a style="width: 5%;float: right;text-align: center;font-size: 15px;text-decoration: none" href="<%=basePath%>topic/dashang/${reply.replyUserId}&${user.id}&${topic.id}">打赏</a>
                        </c:if></p>
                    </div>




        </li>
        </c:forEach>

    </ul>
</div>
</c:if>

<c:if test="${!empty user}">

<div class="panel panel-default" id="main" style="">
    <div class="panel-heading" style="background-color: white">
        添加一条新回复
    </div>
    <div class="panel-body">
        <div class="form-group">
            <form action="<%=basePath%>reply/add" method="post">
                <input type="hidden" name="topicId" value="${topic.id}">
                <input type="hidden" name="replyUserId" value="${user.id}">
                <textarea class="form-control" rows="3" name="content" required="required"></textarea><br/>
            <input type="submit" class="btn btn-default btn-sm" value="回复">
            </form>
        </div>

    </div>
</div>
</c:if>

</div>


<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>
<%@ include file="footer.jsp"%>


</body>
</html>