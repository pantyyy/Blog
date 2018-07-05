<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑文章</title>

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
					<h2>编辑文章</h2>
					
					<!--正文内容-->
					<div class="main">	
						<!-- 表单 -->
						<form id="form" action="" method="" >
									<!-- 隐藏域数据 -->
									<!-- 文章的id -->
									<input type="hidden" name="id" value="${article.id}" />
															
									<!--文章标题-->
									<div class="unit">
										<div class="left"><span class="required">*</span><p class="subtitle">文章标题</p></div>
										<div class="right">
											<input type="text" class="text"  name="title" data-type="必填" placeholder="请输入文章标题" value="${article.title }">
										</div>
										<!--清浮动-->
										<span class="clearfix"></span>
									</div>
									

									<!--下拉选择框 , 选择文章分类-->
									<div class="unit">
										<div class="left"><p class="subtitle">所属分类</p></div>
										<div class="right">
											<select id="type_id" name="typeId">
												<c:forEach items="${typeList}" var="typeInfo" varStatus="status">
													<option value="${typeInfo.id}" <c:if test="${article.typeId eq typeInfo.id}">selected</c:if>> ${typeInfo.name} 
													</option>
												</c:forEach>
											</select>
										</div>
										<!--清浮动-->
										<span class="clearfix"></span>
									</div>
									
									<!--日期选择框-->
<!-- 									<div class="unit" >
										<div class="left"><p class="subtitle">注册时间</p></div>
										<div class="right">
											<input type="text" id="date" class="date" style="width: 200px;" value="" readonly/>
										</div>
										<span class="clearfix"></span>
									</div> -->
									
									<!-- 文章封面 -->
									<div class="unit">
										<div class="left"><p class="subtitle">文章封面</p></div>
										<!-- 图片承载容器 -->
										<label id="container" for="upload" style="display: inline-block; width:132px;height:74px;">
											<img src="${pageContext.request.contextPath}/static/javaex/pc/images/default.png" width="100%" height="100%" />
<%-- 											<c:choose>
												<!-- 判断数据库中是否有图片 -->
												<c:when test="${empty article.cover}">
													<!-- 数据库中的图片 -->
													<img src="${pageContext.request.contextPath}/upload/${article.cover}" width="100%" height="100%" />
												</c:when>
												<c:otherwise>
													<!-- 默认图片 -->
													<img src="${pageContext.request.contextPath}/static/javaex/pc/images/default.png" width="100%" height="100%" />		
												</c:otherwise>
											</c:choose> --%>
											
										</label>
										<!-- 上传按钮 -->
										<input type="file" class="hide" id="upload" accept="image/gif, image/jpeg, image/jpg, image/png" />
										<!-- 图片的url地址 -->
										<input type="hidden" id="cover" name="cover" value="" />
									</div>

									<!--文本域-->
									<div class="unit">
										<div class="left"><p class="subtitle">内容</p></div>
										<div class="right">
										
											<div class="right">
												<textarea name="content" class="desc" placeholder="请填写简介" value="${article.content}"></textarea>
												<!--提示说明-->
												<p class="hint">请填写个人简介。简介中不得包含令人反感的信息，且长度应在10到255个字符之间。</p>
											</div>
<!-- 											富文本编辑器
											<div id="edit" class="edit-container">
	
											</div> -->
											<!-- 文章的简介 -->
											<input type="hidden" name="contentText" value="" />
										</div>
										<!--清浮动-->
										<span class="clearfix"></span>
									</div>
									
									<!--提交按钮-->
									<div class="unit" style="width: 800px;">
										<div style="text-align: center;">
											<!--表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数-->
											<input type="button" id="return" class="button no" value="返回" />
											<input type="button" id="save" class="button yes" value="保存" />
										</div>
									</div>
						
						</form>
						
					</div>
				</div>
				
			</div>
		</div>
	</div>
	
	
</body>

<script>

//图片上传
javaex.upload({
	type : "image",
	url : "${pageContext.request.contextPath}/admin/upload.json",	// 请求路径
	id : "upload",	// <input type="file" />的id
	param : "file",			// 参数名称，SSM中与MultipartFile的参数名保持一致
	dataType : "url",		// 返回的数据类型：base64 或 url
	callback : function (rtn) {
		// 后台返回的数据
		console.log(rtn);
		
		if (rtn.code=="000000") {
			var imgUrl = rtn.data.imgUrl;
			$("#container img").attr("src", "/upload/" + imgUrl);
			$("#cover").val(imgUrl);	//对隐藏域中的图片路径赋值
		} else {
			javaex.optTip({
				content : rtn.message,
				type : "error"
			});
		}

	}
});

//保存文章
$("#save").click(function(){
	
	//提交文件之前 , 截取文章的内容 , 作为文章的简介
	
	
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/saveArticle.json" , 
		type : "POST" ,
		dataType : "json" , 
		data : $("#form").serialize() , 
		success : function(rtn){
			if(rtn.code == "000000"){	//判断后台的状态码 , 成功
				javaex.optTip({	//弹窗提示操作成功
					content : rtn.message,
					type : "success"
				});
			
				setTimeout(function(){	//通过定时器刷新页面
					//跳转页面
					window.location.href = "${pageContext.request.contextPath}/admin/articles.action";
				} , 2000);
			}else{	//失败
				javaex.optTip({	//弹窗提示操作成功
					content : "操作失败",
					type : "error"
				});
			}
		}
	});
});



javaex.select({
	id : "select",
	isSearch : true,
	// 选择后的回调函数
	callback: function (rtn) {
		console.log("selectValue:" + rtn.selectValue);
		console.log("selectName:" + rtn.selectName);
	}
});


javaex.edit({
	id : "edit",
	image : {
		url : "${pageContext.request.contextPath}/admin/upload.json",	// 请求路径
		param : "file",		// 参数名称，SSM中与MultipartFile的参数名保持一致
		dataType : "url",	// 返回的数据类型：base64 或 url
		rtn : "rtnData",	// 后台返回的数据对象，在前面页面用该名字存储
		imgUrl : "data.imgUrl",	// 根据返回的数据对象，获取图片地址。  例如后台返回的数据为：{code: "000000", message: "操作成功！", data: {imgUrl: "1.jpg"}}
		prefix : "/upload/"	// 图片地址的前缀，根据实际情况决定是否需要填写
	},
	content : '我是来测试的',	// 这里必须是单引号，因为html代码中都是双引号，会产生冲突
	callback : function(rtn) {
		$("#articleContent").val(rtn.html);
		$("#articleContentText").val(rtn.text);
	}
});
</script>


</html> 