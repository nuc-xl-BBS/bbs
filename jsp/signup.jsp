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

<div class="panel panel-default" id="login" style="width: 55%;margin-left: 20%;margin-top: 5%;margin-bottom: 5%">
    <div class="panel-heading" style="background-color: black;color: white">
    注册
</div>
    <div class="panel-body">
        <form action="<%=basePath%>user/add/do" method="post" id="signupForm" class="form-horizontal" role="form" style="margin-left: 5%">
            <div class="form-group" >
                <label class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="text" class="form-control" id="username" name="username" required="required">
                    <p class="form-control-static">请使用半角的 a-z 或数字 0-9</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密码</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="password" class="form-control" id="password" name="password" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">电子邮件</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="email" class="form-control" id="email" name="email" required="required">
                </div>
            </div>



            <div class="form-group">
                <label class="col-sm-2 control-label">手机号</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="tel" class="form-control" id="tel" name="tel" required="required">
                </div>
            </div>


            <div class="form-group">
                <label class="col-sm-2 control-label">工作性质</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="text" class="form-control" id="workxz" name="workxz" required="required">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">工作单位</label>
                <div class="col-sm-10" style="width: 40%;">
                    <input type="text" class="form-control" id="workdw" name="workdw" required="required">
                </div>
            </div>
            <div class="form-group">
            <label class="col-sm-2 control-label" hidden>国际电话区号</label>
            <div class="col-sm-10" style="width: 40%;" hidden>
                <select class="form-control" id="areaCode" name="areaCode" hidden>
                    <option value="86" selected>+86</option>
                    <option value="85">+85</option>
                    <option value="84">+84</option>
                </select>
            </div>
        </div>
            <input type="submit" class="btn btn-default" id="signup" style="margin-left: 17%">
        </form>
    </div>
</div>


<script>
    function submitValidate(flag){
        return flag;
    }
    $("#signupForm").submit(function () {
        if($("#username").val()==''||$("#password").val()==''||$("#email").val()==''||$("#tel").val()==''){
            alert("请将注册信息填写完整！");
            return submitValidate(false);
        }else {

        }
    })
</script>
<%@ include file="footer.jsp"%>
</body>
</html>