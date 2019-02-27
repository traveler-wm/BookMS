
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>书店销售管理系统首页</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <script src="js/js.cookie.js"></script>
    <script src="js/VerificationCode.js"></script>
    <style>
        #myCarousel{
            margin-left: 2%;
            width: 60%;
            height: 70%;
            float: left;
            z-index: 999;
            display: inline;
        }
        #login{
            float: left;
           height: 50%;
            width: 23%;
            margin-left: 6%;
            margin-top: 6%;
            display: inline;
            z-index: 999;
        }
        * {
            padding:0;
            margin:0;
        }
    </style>
    <script>
            $(function(){
                $('#myCarousel').carousel({
                    interval: 2000
                })
            });
    </script>
</head>
<body style="background-color: mistyrose">
<div>
<c:if test="${!empty error}">
    <script>
            alert("${error}");
            window.location.href="/login.html";
</script>
</c:if>
<h2 style="text-align: center;font-family: 'Adobe 楷体 Std R';color: palevioletred">书店销售管理系统</h2>
<div style="float:right;" id="github_iframe"></div>
<%--* Copyright (c) 2016 hustcc--%>
<%--* License: MIT--%>
<%--* Version: %%GULP_INJECT_VERSION%%--%>
<%--* GitHub: https://github.com/hustcc/canvas-nest.js--%>
<%--**/--%>
<div id="myCarousel" class="carousel slide">
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <div class="item active">
            <img src="img/105905-106.jpg" alt="第一张">
        </div>
        <div class="item">
            <img src="img/281289-106.jpg" alt="第二张">
        </div>
        <div class="item">
            <img src="img/296494-106.jpg" alt="第三张">
        </div>

</div>
    <a class="carousel-control left" href="#myCarousel"
       data-slide="prev">&lsaquo;
    </a>
    <a class="carousel-control right" href="#myCarousel"
       data-slide="next">&rsaquo;
    </a>
</div>

<div class="panel panel-default" id="login">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">请登录</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="id">用户名</label>
            <input type="text" class="form-control" id="id" placeholder="请输入用户名">
        </div>
        <div class="form-group">
            <label for="passwd" >密码</label>
            <input type="password" class="form-control" id="passwd" placeholder="请输入密码">
        </div>
        <div class="form-group">
            <label for="code" >验证码</label>
        </div>
        <div class="form-horizontal">
        <div class="form-group">
            <div class="col-sm-6">
            <input type="text"  class="form-control" id="code" placeholder="请输入验证码"/>
            </div>
            <div class="col-sm-6">

                <canvas id="canvas" width="150px" height="40"></canvas>

            </div>
        </div>
        </div>
        <div class="checkbox text-left">
            <label>
                <input type="checkbox" id="remember">记住密码
            </label>
            <a style="margin-left: 100px" href="#">忘记密码?</a>
        </div>
        <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
        <button id="loginButton"  class="btn btn-primary  btn-block">登录
        </button>
    </div>
</div>

    <script>
        var code = drawPic();
        $(document).on('click', 'canvas', function () {
            code = drawPic();
        })

        $("#id").keyup(
            function () {
                if(isNaN($("#id").val())){
                    $("#info").text("提示:账号只能为数字");
                }
                else {
                    $("#info").text("");
                }
            }
        )
        // 记住登录信息
        function rememberLogin(username, password, checked) {
            Cookies.set('loginStatus', {
                username: username,
                password: password,
                remember: checked
            }, {expires: 30, path: ''})
        }
        // 若选择记住登录信息，则进入页面时设置登录信息
        function setLoginStatus() {
            var loginStatusText = Cookies.get('loginStatus')
            if (loginStatusText) {
                var loginStatus
                try {
                    loginStatus = JSON.parse(loginStatusText);
                    $('#id').val(loginStatus.username);
                    $('#passwd').val(loginStatus.password);
                    $("#remember").prop('checked',true);
                } catch (__) {}
            }
        }

        // 设置登录信息
        setLoginStatus();
        $("#loginButton").click(function () {
            var id =$("#id").val();
            var passwd=$("#passwd").val();
            var remember=$("#remember").prop('checked');
            var vcode = $("#code").val();
            if( id=='' && passwd==''){
                $("#info").text("提示:账号和密码不能为空");
            }
            else if ( id ==''){
                $("#info").text("提示:账号不能为空");
            }
            else if( passwd ==''){
                $("#info").text("提示:密码不能为空");
            }
            else if( vcode == ''){
                $("#info").text("验证码不能为空");
            }
            else if(vcode != code){
                $("#info").text("验证码不正确");
            }
            else if(isNaN( id )){
                $("#info").text("提示:账号必须为数字");
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "api/loginCheck",
                    data: {
                        id:id ,
                        passwd: passwd
                    },
                    dataType: "json",
                    success: function(data) {
                        if(data.stateCode.trim() == "0") {
                            $("#info").text("提示:账号或密码错误！");
                        } else if(data.stateCode.trim() == "1") {
                            $("#info").text("提示:登陆成功，跳转中...");
                            window.location.href="/admin_main.html";
                        }
                    }
                });
            }
        })

    </script>
</div>

</body>
</html>
