<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单</title>
</head>
<body>

		<!--logo-->
		<div class="logo">
			<h1>JavaEx前端框架</h1>
		</div>
		
		<!--左侧菜单-->
		<div id="menu" class="menu">
				<ul>
					<li class="menu-item">
						<a href="javascript:;"><span class="icon-home2"></span>主页</a>
					</li>
					<li class="menu-item">
						<!-- 跳转到分类的Jsp页面 -->
						<a href="${pageContext.request.contextPath}/admin/types.action"><span class="icon-bar-chart"></span>分类管理<i class="icon-keyboard_arrow_left"></i></a>
					</li>
					<li class="menu-item">
						<a href="javascript:;"><span class="icon-flask"></span>文章管理<i class="icon-keyboard_arrow_left"></i></a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/admin/articles.action">文章列表</a></li>
							<li><a href="javascript:;">复选框</a></li>
							<li><a href="javascript:;">按钮</a></li>
						</ul>
					</li>
				</ul>
		</div>
	
		
<script>
	javaex.menu({
		id : "menu",	// 菜单id
		isAutoSelected : true
	});
</script>
		
</body>
</html>