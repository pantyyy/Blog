<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>管理员后台</title>

<%@ include file="basejs.jsp"%>


</head>

<body>


	<!--左侧菜单-->
	<div class="admin-left">
		<c:import url="menu.jsp"></c:import>
	</div>
		
		<!--右侧内容-->
	<div class="admin-right">
		<!--顶部-->
		<c:import url="admin-header.jsp"></c:import>
		<!-- 内容 -->
		<c:import url="content.jsp"></c:import>
	</div>	
	



</body>

</html>