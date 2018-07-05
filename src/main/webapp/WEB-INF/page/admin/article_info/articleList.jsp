<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>所有文章</title>

<%@ include file="../basejs.jsp"%>

</head>
<body>
	<!--左侧菜单-->
	<div class="admin-left">
		<c:import url="../menu.jsp"></c:import>
	</div>
	
	<div class="admin-right">
		<!--顶部-->
		<c:import url="../admin-header.jsp"></c:import>
		<!-- 内容 -->
		<div class="admin-content">
			<!--主体内容-->
			<div class="list-content">
				<!--块元素-->
				<div class="block">
					<!--页面有多个表格时，可以用于标识表格-->
					<h2>文章列表</h2>
					
					
					<!--正文内容-->
					<div class="main">
						<!--表格上方的操作元素，添加、删除等-->
						<div class="operation-wrap">
							<div class="buttons-wrap">
								<!-- 跳转到添加文章的Jsp -->
								<a href="editArticle.action">
									<button id="add" class="button blue"><span class="icon-plus"></span> 添加</button>
								</a>
								
								<button id="delete" class="button red"><span class="icon-minus"></span> 删除</button>
								<button id="save" class="button green"><span class="icon-check2"></span> 保存</button>
							</div>
						</div>
						<table id="table" class="table color2">
							<thead>
								<tr>
									<th class="checkbox"><input type="checkbox" class="fill listen-1" /> <br /> </th>
									<th>序号</th>
									<th>分类</th>
									<th>文章标题</th>
									<th>撰写日期</th>
									<th>阅读量</th>
									<th>编辑</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${articleList }" var="entity" varStatus="status">
									<tr>
										<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="${entity.id}" /> </td>
										<td>${entity.id }</td>
										<td>${entity.typeName}</td>
										<td>${entity.title }</td>
										<td>${entity.updateTime }</td>
										<td>${entity.viewCount }</td>
										<td>
											<a href="editArticle.action?articleId=${entity.id}" >
												<botton class="button wathet"><span class="icon-mode_edit"></span>编辑</botton>
											</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				
					
					
				</div>
			</div>
		</div>
	</div>	

</body>

</html>