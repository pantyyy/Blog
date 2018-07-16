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
					
					<!--  -->
					<!-- 检索 -->
					<div style="text-align:right;margin-bottom:10px;">
						<!-- 标题检索 -->
						<input type="text" id="titleSearch" class="text" placeholder="根据文章标题检索" value="${mapQuery.title }" />
						
						<!-- 分类检索 -->
						<select id="type_id" name="typeId">
							<option value="">--请选择--</option>
							<c:forEach items="${typeList}" var="typeInfo" varStatus="status">
								<option value="${typeInfo.id}" <c:if test="${mapQuery.typeId eq typeInfo.id}">selected</c:if> >${typeInfo.name}</option>
							</c:forEach>
						</select>
						
						<!-- 日期检索 -->
						<input type="text" id="date2" class="date" style="width: 220px;" value="" readonly/>
						<!-- 执行查询按钮 -->
						<button class="button blue" style="margin-top:-5px;" onclick="search();"><span class="icon-search"></span></button>					
					</div>

					
						<!--表格上方的操作元素，添加、删除等-->
						<div class="operation-wrap">
							<div class="buttons-wrap">
								<!-- 跳转到添加文章的Jsp -->
								<a href="editArticle.action">
									<button id="add" class="button blue"><span class="icon-plus"></span> 添加</button>
								</a>
								
								<button id="delete" onclick="deleteArticle();" class="button red"><span class="icon-minus"></span> 删除</button>
								<button id="save" class="button green"><span class="icon-check2"></span> 保存</button>
								
							</div>
						</div>
						<table id="table" class="table color2">
							<thead>
								<tr>
									<th class="checkbox"><input type="checkbox" class="fill listen-1" /> <br /> </th>
									<th>文章标题</th>
									<th>分类</th>
									<th>上次修改日期</th>
									<th>阅读量</th>
									<th>编辑</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pageInfo.list }" var="entity" varStatus="status">
									<tr>
										<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="${entity.id}" /> </td>
										<td>${entity.title }</td>
										<td>${entity.typeName}</td>
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
						
						<!-- 文章的分页 -->
						<div class="page">
							<ul id="page" class="pagination"></ul>
						</div>
						
						<!--批量操作-->
						<div class="block no-shadow" >
							<!--修饰块元素名称-->
							<div class="banner">
								<p class="tab fixed">批量操作</p>
							</div>
						
							<!--正文内容-->
							<div class="main" style="margin-bottom:200px;">
							
								
								<label zoom="1.2"><input type="radio" id="boxRemove" class="fill" name="radio" value="remove" />批量移动到分类</label>
								<!-- <input type="radio" class="fill" name="radio" />单选框未选中 -->
								<select id="type_id_action" class="no-shadow">
									<option value="0">--请选择--</option>
									<c:forEach items="${typeList}" var="typeInfo" varStatus="status">
										<option value="${typeInfo.id}">${typeInfo.name}</option>
									</c:forEach>
								</select>
								
								<br/>
								
								<label zoom="1.2"><input type="radio" id="boxRecycle" class="fill" name="radio" value="recycle" />批量移动回收站</label>
															
								<br/>
								
								<button class="button green" onclick="submit();" style="margin-top:20px">提交</button>
							</div>
						</div>
				
					</div>
				</div>

			</div>
		</div>
	</div>	

</body>

<script>
var currentPage = "${pageInfo.pageNum}";	//当前页
var pageCount = "${pageInfo.pages}";		//总页数
var startDate = ""	//开始日期
var endDate = ""	//结束日期
var	selectList = new Array;	//用户选择的数据
var selectType = 0;

function submit(){
	selectList = []; //清空数组
	
	//选中的数据
	$("tbody input:checkbox:checked").each(function(i){
		var value = $(this).val();
		selectList[i] = value;
	});
	
	if(selectList.length == 0){
		javaex.optTip({
			content : "请至少选择一条记录" ,
			type : "error"
		})
		return 
	}
	
	//判断选中的是哪一个单选框
	var opt = $(':radio[name="radio"]:checked').val();
	
	if(opt == "remove"){
		removeArticle();
	}else if(opt == "recycle"){
		recycleArticle();
	}
}

//批量移动到回收站
function recycleArticle(){
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/deleteArticle.json" , 
		type : "POST" ,
		dataType : "json" , 
		data : {"selectList" : selectList , "sta" : 0} , 
		traditional : true , 
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
}

//批量转移文章
function removeArticle(){

	
	if(selectType == 0){
		alert("请选择类型!");
	}else{
		$.ajax({
		url : "${pageContext.request.contextPath}/admin/removeArticle.json" , 
		type : "POST" ,
		dataType : "json" , 
		data : {"selectList" : selectList , "selectType" : selectType} , 
		traditional : true , 
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
	}
	
}
//删除企业文章
function deleteArticle(){
	selectList = []; //清空数组
	//获取用户选中的数据
	$("tbody input:checkbox:checked").each(function(i){
		var value = $(this).val();
		selectList[i] = value;
	});
	
	//提交到后台删除数据
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/deleteArticle.json" , 
		type : "POST" , 
		dataType : "json" ,
		data : {"selectList" : selectList} , 
		traditional: true,	//数组提交需要这样设置
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
	
	
	//console.log(selectList);
}


	//批量操作的下拉选择框
	javaex.select({
		id : "type_id_action",
		isSearch : true,
		// 选择后的回调函数
		callback: function (rtn) {
			selectType = rtn.selectValue;
/* 			console.log("selectValue:" + rtn.selectValue);
			console.log("selectName:" + rtn.selectName); */
		}
	});
	
	//分页
	javaex.page({
		id : "page",
		pageCount : pageCount,	// 总页数
		currentPage : currentPage,// 默认选中第几页
		position : "right",
		// 返回当前选中的页数
		callback:function(rtn) {
			//alert("当前选中的页数：" + rtn.pageNum);
			window.location.href = "articles.action?pageNum="+rtn.pageNum;
		}
	});
	
	//搜索的下拉框
	javaex.select({
		id : "type_id",
		isSearch : true,
		// 选择后的回调函数
		callback: function (rtn) {
			console.log("selectValue:" + rtn.selectValue);
			console.log("selectName:" + rtn.selectName);
		}
	});
	
	//日期
	javaex.date({
		id : "date2",		// 承载日期组件的id
		monthNum : 2,		// 2代表选择范围日期
		startDate : "${mapQuery.startDate}",	// 开始日期(一开始默认查询所有的数据 , 所以默认为空)
		endDate : "${mapQuery.endDate}",		// 结束日期
		// 重新选择日期之后返回一个时间对象
		callback : function(rtn) {
			//用户选择日期赋值
			startDate = rtn.startDate;
			endDate = rtn.endDate;
			//alert(rtn.startDate + " - " + rtn.endDate);
		}
	});
	
	//搜索
	function search(){
		//文章分类
		var typeId = $("#type_id").val();
		//标题检索
		var title = $("#titleSearch").val();
		
		window.location.href = "articles.action?pageNum="+currentPage+"&typeId="+typeId+"&title="+title+"&startDate="+startDate+"&endDate="+endDate;
		
	}
	
</script>

	
</html>