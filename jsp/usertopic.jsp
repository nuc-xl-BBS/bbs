<%--
  Created by IntelliJ IDEA.
  User: 向莲
  Date: 2019/12/19
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
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
    <meta name="Content-Type"  content="text/html;charset=utf-8">
    <meta name="keywords" content="Genesis,论坛,社区,程序员">

    <link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-3.2.1.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
    <style>
        li {list-style-type:none;}
        html, body {
            height: 100%;
            font-size: 14px;
            color: #525252;
            font-family: NotoSansHans-Regular,AvenirNext-Regular,arial,Hiragino Sans GB,"Microsoft Yahei","Hiragino Sans GB","WenQuanYi Micro Hei",sans-serif;
            background: #f0f2f5;
        }
        .footer {
            background-color: #fff;
            margin-top: 22px;
            margin-bottom: 22px;
            width: 100%;
            padding-top: 22px;
            color: #8A8A8A;
            display: block;
            height: 200px;
            border: 1px ;
            clear:both
        }

        .container {
            margin-right: 5%;
            margin-left: 5%;
            padding-left: 15px;
            padding-right: 15px;
            width: 40%;
            float: left;
        }
        .info {
            margin-right: 5%;
            width: 10%;
            float: left;
        }
        a{
            color: #8A8A8A;
            cursor: pointer;
        }
    </style>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div class="panel panel-default" style="width: 16%;margin:1% 0% 2% 2%;float: left;">
    <ul class="list-group" style="width: 100%">
        <li class="list-group-item" style="background-color: black;color: white"><a href="<%=basePath%>">MYBBS</a></li>
        <c:forEach items="${tabs}" var="t">
            <li class="list-group-item"><a href="<%=basePath%>tab/${t.tabNameEn}">${t.tabName}</a></li>
        </c:forEach>
        <li class="list-group-item" ><a href="<%=basePath%>look/jinghua">精华</a></li>
        <li class="list-group-item" style="background-color: black;color: white"><a>【赞助本站】</a></li>
        <li><img style="width: 100%;height: 230px" alt="xixi" src="<%=basePath%>img/1.jpg"></li>
        <li><img style="width: 100%;height: 230px" alt="xixi" src="<%=basePath%>img/2.jpg"></li>
    </ul>
</div>
<div class="panel panel-default" id="main" style="width: 55%;margin:1% 2% 1% 2%;float: left;">
    <div class="panel-heading" style="background-color: black;color: white">
        <a href="<%=basePath%>member/${username}"><span ><strong>${username}</strong></span></a>的帖子
    </div>
    <ul class="list-group" style="width: 100%">
        <li class="list-group-item" >
            <div style="width: 10%;float: left">标题</div>
            <div style="width: 10%;float: right">回复数</div>
            <div style="width: 8%;float: right">作者</div>

            <div>&nbsp;</div>
        </li>
        <c:forEach items="${topics}" var="topic">
            <li class="list-group-item">
                <c:if test="${topic.zhiding=='1'}"><a href="" style="text-decoration: none;color: red">【置顶】</a> </c:if>
                        <a href="<%=basePath%>t/${topic.id}">${topic.title}</a>

                <c:if test="${currentID==topic.userId}">
                    <div style="width: 5%;float: right;text-align: center;font-size: 12px;color: black">
                        <a href="<%=basePath%>delete/${topic.id}">删除</a>
                    </div>
                    <div style="width: 5%;float: right;text-align: center;font-size: 12px;color: black">
                        <a href="<%=basePath%>get/${topic.id}">修改</a>
                    </div>
                    <div style="width: 5%;float: right;text-align: center;font-size: 12px;color: black">
                        <a href="<%=basePath%>zhiding/${topic.id}">置顶</a>
                    </div>
                    <div style="width: 7%;float: right;text-align: center;font-size: 12px;color: black">
                        <a href="<%=basePath%>quxiaozhiding/${topic.id}">取消置顶</a>
                    </div>
                </c:if>
                <br>
                            <div>
                                <a><span class="label label-default" >${topic.tab.tabName}</span></a>&nbsp;&nbsp;&nbsp;
                                <small class="text-muted">${topic.localCreateTime}</small>
                                <div style="width: 10%;float: right;text-align: center">
                                    <span class="badge">${topic.countReplies}</span>
                                </div>
                                <div style="width: 10%;float: right;text-align: center">
                                    <a href="<%=basePath%>look/${topic.userId}"><span ><strong>${topic.user.username}</strong></span></a>
                                </div>
                            </div>



            </li>
        </c:forEach>

    </ul>

</div>
<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>
<%@ include file="footer.jsp"%>

</body>
</html>