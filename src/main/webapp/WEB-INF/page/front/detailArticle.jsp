<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详细文章</title>

<!-- 静态包含 -->
<%@ include file="../basejs.jsp"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/editorM/css/editormd.preview.min.css" />
<link rel="stylesheet" href="/blog/static/editorM/css/editormd.css" />
<link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon" />
<script src="/blog/static/editorM/examples/js/jquery.min.js"></script>
<script src="/blog/static/editorM/editormd.min.js"></script> 
<script src="<%=request.getContextPath()%>/static/editorM/lib/marked.min.js"></script>
<script src="<%=request.getContextPath()%>/static/editorM/lib/prettify.min.js"></script>

<style>
.header {
	height: 500px;
	background-image: url(http://cdn.javaex.cn/javaex/pc/images/grey.gif);
	background-position: center center;
	background-size: cover;
	position: relative;
	background-image:-webkit-gradient(linear, left top, left bottom, from(#9c27b0), to(#9c27b0)), -webkit-gradient(linear, left top, left bottom, from(#d2d2d2), to(#d2d2d2));
}

.header-mask {
	background-color: rgba(0, 0, 0, 0.5);
	width: 100%;
	position: absolute;
	height: 100%;
}

#top {
	position: fixed;
	top: 0px;
	width: 100%;
	height: 70px;
	background-color: #fff;
	box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.5);
	z-index: 1003;
}

.container {
	width: 1170px;
	height: 50px;
	line-height: 50px;
	padding: 10px;
	margin: 0 auto;
}

.footer .container a {
	color: #ccc;
}

#logo > a {
	font-size: 18px;
	color: #666;
}

#nav {
	text-align: right;
}

#big-title {
	width: 1170px;
	margin: 0 auto;
	height: 450px;
	line-height: 450px;
	text-align: center;
	font-size: 50px;
	color: #fff;
	position: absolute;
	left: 50%;
	margin-left: -585px;
}

#article-time {
	width: 1170px;
	margin: 60px auto 0;
	text-align: center;
	font-size: 20px;
	color: #fff;
	position: absolute;
	left: 50%;
	margin-left: -585px;
	top: 220px;
}

#content {
	margin: -60px 30px 0;
	-webkit-box-shadow: 0 16px 24px 2px rgba(0, 0, 0, 0.14), 0 6px 30px 5px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
	box-shadow: 0 16px 24px 2px rgba(0, 0, 0, 0.14), 0 6px 30px 5px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
}

.block {
	margin: 0 auto;
	box-shadow: none;
}

.img {
	height: 250px;
	margin: -15px 15px 0;
}

.img img {
	width: 100%;
	height: 100%;
	border-radius: 6px;
}

.nav > li {
	display: inline-block;
}

.nav > li > a {
	font-size: 12px;
	margin: 0 15px;
	display: block;
}

.nav li a:link {
	color: #666;
}

.nav li:hover {
	background: #ededf1;
}

.nav li a:hover, .active > a {
	color: #06999e;
}

.nav > li:hover .classified-nav {
	display: block;
}

.classified-nav {
	position: absolute;
	top: 48px;
	left: -40%;
	z-index: 1000;
	display: none;
	float: left;
	min-width: 140px;
	padding: 5px 0;
	margin: 2px 0 0;
	font-size: 14px;
	text-align: center;
	list-style: none;
	background-color: #fff;
	-webkit-background-clip: padding-box;
	background-clip: padding-box;
	border: 1px solid #ccc;
	border: 1px solid rgba(0,0,0,.15);
	border-radius: 4px;
	-webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);
	box-shadow: 0 6px 12px rgba(0,0,0,.175);
}

input[type="text"] {
	border: none;
}

.search {
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
	background-image: -webkit-gradient(linear, left top, left bottom, from(#9c27b0), to(#9c27b0)), -webkit-gradient(linear, left top, left bottom, from(#d2d2d2), to(#d2d2d2));
	background-image: -webkit-linear-gradient(#9c27b0, #9c27b0), -webkit-linear-gradient(#d2d2d2, #d2d2d2);
	background-image: linear-gradient(#9c27b0, #9c27b0), linear-gradient(#d2d2d2, #d2d2d2);
	border: 0;
	border-radius: 0;
	background-color: transparent;
	background-repeat: no-repeat;
	background-position: center bottom, center -webkit-calc(100% - 1px);
	background-position: center bottom, center calc(100% - 1px);
	background-size: 0 2px, 100% 1px;
	-webkit-transition: background 0s ease-out;
	transition: background 0s ease-out;
	height: 36px;
	width: 220px;
}

.is-focused .search {
	background-image: -webkit-gradient(linear, left top, left bottom, from(#06999e), to(#06999e)), -webkit-gradient(linear, left top, left bottom, from(#d2d2d2), to(#d2d2d2));
	background-image: -webkit-linear-gradient(#06999e, #06999e), -webkit-linear-gradient(#d2d2d2, #d2d2d2);
	background-image: linear-gradient(#06999e, #06999e), linear-gradient(#d2d2d2, #d2d2d2);
	outline: none;
	background-size: 100% 2px, 100% 1px;
	-webkit-transition-duration: 0.3s;
	transition-duration: 0.3s;
}

.active {
	color: #06999e;
}

.content-header {
	position: relative;
}

.content-header span {
	opacity: 0.8;
	font-size: 16px;
}

.side-bar {
	position: fixed;
	bottom: 12px;
	right: 10px;
	z-index: 999;
	color: #fff;
	min-width: 50px;
}

#goTopBtn {
	display: none;
	width: 50px;
	height: 50px;
	border-radius: 50%;
	cursor: pointer;
	text-align: center;
	background-color: #999;
}

#goTopBtn > span {
	font-size: 20px;
	line-height: 50px;
}

.block2 {
	margin: 50px 0;
	font-size: 18px;
	color: #555;
}

.content-header p {
	position: absolute;
	right: 0;
	top: 0;
	color: rgba(0, 0, 0, 0.1);
	font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
	font-size: 25px;
}


</style>
    
    
</head>
<body>

<!-- 共用头部 -->
<div class="header">
    <div id="top">
        <c:import url="header.jsp"/>
    </div>
    <h1 id="big-title">${article.title}</h1>
    <h4 id="article-time">${article.updateTime}</h4>
</div>


<div id="content">
    <div class="block" style="border-radius: 6px 6px 0 0;">
        <div class="grid-1-2-1">
            <div></div>
            <div id="main-content" style="min-width: 950px;margin-top: 100px;margin-bottom: 40px;">
                <div class="content-header">
                    <span class="icon-home active">
                        <a href="<%=basePath %>"> 主页</a>
                    </span>
                    <span class="divider">/</span>
                    <span class="active">
                       <%--  <a href="<%=basePath %>front/type.blog?typeid=${article.typeid}">${article.typename}</a> --%>
                    </span>
                    <span class="divider">/</span>
                    <span>${article.title}</span>
                    <p>${article.viewCount}</p>
                </div>

                <div class="block block2">
                    <div class="main-0">
                        <div class="content" id="contentHtml">${article.htmlContent}</div>
                    </div>
                </div>
            </div>
            <div></div>
        </div>
    </div>

    <div class="footer" style="background: #323437;">
        <c:import url="footer.jsp"/>
    </div>
</div>

</body>


<script>
	editormd.markdownToHTML("contentHtml");
	
    $(document).ready(function() {
        //$(".header").css("background-image", "upload/${article.cover}");

        // window的高度
        var windowHeight = $(window).height();
        // header的高度
        var headerHeight = $(".header").height();
        // footer的高度
        var footerHeight = $(".footer").height();
        // 内容的高度
        var contentHeight = $("#main-content").height();
        // 差
        var diff = windowHeight - (headerHeight+(contentHeight-60)+footerHeight);
        if (diff>0) {
            $("#main-content").css("margin-bottom", diff-100+"px");
        }

        // 监听元素获得焦点事件
        $('input[type="text"]').focus(function() {
            $("#search").addClass("is-focused");
        });

        // 监听元素失去焦点事件
        $('input[type="text"]').blur(function() {
            $("#search").removeClass("is-focused");
        });
    });
    
    
</script>

</html>