<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


		<div class="admin-header">
			<ul class="header-right">
				<li>
					<a class="pull-left avatar" href="#"><img src="http://doc.javaex.cn/javaex/javaex/pc/images/user.jpg" alt=""></a>
					<p class="pull-left margin-left-10">欢迎您，<span>管理员</span></p>
					<label class="margin-left-10 margin-right-10">|</label>
					<a href="${pageContext.request.contextPath}/admin/login_out.action">退出</a>
				</li>
				<li>
					<a href="#">
						<span class="icon-commenting-o" style="font-size: 20px;position: relative;top:2px;">
							<i style=""><span>31</span></i>
						</span>
					</a>
				</li>
				<li>
					<a href="#">用户中心</a>
				</li>
			</ul>
		</div>
		
		
</body>
</html>