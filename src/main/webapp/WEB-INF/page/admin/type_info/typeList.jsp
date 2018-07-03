<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分类管理</title>

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
					<h2>分类管理</h2>
					
					<!--正文内容-->
					<div class="main">
<!-- 						表格上方的搜索操作
						<div style="text-align:right;margin-bottom:10px;">
							
							<div class="input-group">
								<input type="text" class="text" placeholder="提示信息" />
								<button class="button blue">搜索</button>
							</div>
						</div> -->
						
						<!--表格上方的操作元素，添加、删除等-->
						<div class="operation-wrap">
							<div class="buttons-wrap">
								<button id="add" class="button blue"><span class="icon-plus"></span> 添加</button>
								<button id="delete" class="button red"><span class="icon-minus"></span> 删除</button>
								<button id="save" class="button green"><span class="icon-check2"></span> 保存</button>
							</div>
						</div>
						<table id="table" class="table color2">
							<thead>
								<tr>
									<th class="checkbox"><input type="checkbox" class="fill listen-1" /> <br /> </th>
									<th>显示排序</th>
									<th>名称</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${typeList }" var="entity" varStatus="status">
									<tr>
										<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="${entity.id}" /> </td>
										<td><input type="text" class="text" name="sort" data-type="正整数" error-msg="请输入正整数" value="${entity.sort }" /></td>
										<td><input type="text" class="text" name="name" data-type="必填" placeholder="请输入分类名称" value="${entity.name }"/></td>
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


<script>
	var idArr = new Array();
	var sortArr = new Array();
	var nameArr = new Array();


	//删除分类
	$("#delete").click(function(){
		idArr = [] //清空数组
		$(':checkbox[name="id"]:checked').each(function(){	//遍历所有被勾选的复选框
			var id = $(this).val();	//获取当前的复选框的值
			if(id != ""){	//判断是否为空 , 为空就是添加的 , 不为空就是已有的
				idArr.push(id);	//是已有的 , 放入idArr数组
			}
		});
		
		if(idArr.length == 0){
			//前台无刷新去除
			$(':checkbox[name="id"]:checked').each(function(){
				$(this).parent().parent().parent().remove();	//删除tr
			});
		}else{
			//后台数据库删除
			$.ajax({	//ajax请求发送到后台
				url : "/blog/admin/deleteTypes.json" ,
				type : "POST" ,
				dataType : "json" ,
				traditional : "true" , //开启数组支持
				data : {	//传递到后台的数据
					"idArr" : idArr 
				} , 
				success : function(rtn){	//执行成功的回调函数
					//console.log(rtn);
					if(rtn.code == "000000"){	//判断后台的状态码 , 成功
						javaex.optTip({	//弹窗提示操作成功
							content : rtn.message,
							type : "success"
						});
					
						setTimeout(function(){	//通过定时器刷新页面
							window.location.reload();
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
		
	});
	
	
	//添加分类
	$("#add").click(function(){
		var html = '';
		html += '<tr>';
		html += '<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="${entity.id}" /> </td>';
		html += '<td><input type="text" class="text" name="sort" data-type="正整数" error-msg="请输入正整数" value="${entity.sort }" /></td>';
		html += '<td><input type="text" class="text" name="name" data-type="必填" placeholder="请输入分类名称" value="" /></td>';
		html += '</tr>';
		
		$("#table tbody").append(html);	//在tbody下动态添加
		
		javaex.render();	//重新渲染
	});
	
	
	//保存分类
	$("#save").click(function(){
		
		if (javaexVerify()) {
			
			idArr = [];
			sortArr = [];
			nameArr = [];	//清空数组
			
			
			$(':checkbox[name="id"]').each(function(){	//遍历id的checkbox
				idArr.push($(this).val());	//把checkbox的值放入id数组中
			});
			
			$('input[name="sort"]').each(function(){	
				sortArr.push($(this).val());	
			});
			
			$('input[name="name"]').each(function(){	
				nameArr.push($(this).val());	
			});

			$.ajax({	//ajax请求发送到后台
				url : "/blog/admin/saveTypes.json" ,
				type : "POST" ,
				dataType : "json" ,
				traditional : "true" , //开启数组支持
				data : {	//传递到后台的数据
					"idArr" : idArr , 
					"sortArr" : sortArr ,
					"nameArr" : nameArr ,
				} , 
				success : function(rtn){	//执行成功的回调函数
					//console.log(rtn);
					if(rtn.code == "000000"){	//判断后台的状态码 , 成功
						javaex.optTip({	//弹窗提示操作成功
							content : rtn.message,
							type : "success"
						});
					
						setTimeout(function(){	//通过定时器刷新页面
							window.location.reload();
						} , 2000);
					}else{	//失败
						javaex.optTip({	//弹窗提示操作成功
							content : "操作失败",
							type : "error"
						});
					}

				}
			});
			//alert("验证通过");
		}else{
			alert("输入有误!");
		}

	});
</script>


</html>