<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑文章</title>

<!-- 静态包含 -->
<%@ include file="../basejs.jsp"%>

<link rel="stylesheet" href="/blog/static/editorM/examples/css/style.css" />
<link rel="stylesheet" href="/blog/static/editorM/css/editormd.css" />
<link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon" />
<script src="/blog/static/editorM/examples/js/jquery.min.js"></script>
<script src="/blog/static/editorM/editormd.min.js"></script>

</head>
<body>


            <!-- 表单 -->
			<form id="form" action="" method="" >
			<!-- 文章的id -->
			<input type="hidden" name="id" value="${article.id}" />
			
			<!-- 文章列表 -->
			<div id="content">
			    <div class="block" style="border-radius: 6px 6px 0 0;">
					<div class="editormd" id="test-editormd">
					  <textarea id="srcContent" class="editormd-markdown-textarea" name="srcContent">
					  ${article.srcContent}
					  </textarea>
					  <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
					  <textarea id="htmlContent" class="editormd-html-textarea" name="htmlContent">
					  </textarea>
					  
					</div>
			    </div>
			 
 				<!--保存按钮-->
				<div style="text-align: center;">
					<input type="button" id="save" class="button yes" value="保存" />
				</div>
			</div>

			</form>
	
</body>

<script>

//markdown编辑器
 $(function() {
    editormd("test-editormd", {
        width   : "90%",
        height  : 640,
        syncScrolling : "single",
        //你的lib目录的路径，我这边用JSP做测试的
        path    : "/blog/static/editorM/lib/",
        //这个配置在simple.html中并没有，但是为了能够提交表单，使用这个配置可以让构造出来的HTML代码直接在第二个隐藏的textarea域中，方便post提交表单。
        saveHTMLToTextarea : true
    });
}); 


//保存文章
$("#save").click(function(){	
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
					//window.location.href = "${pageContext.request.contextPath}/admin/articles.action";
					//history.go(-1);
					self.location = document.referrer;
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

//返回
$("#return").click(function(){
	window.history.back(-1);
});

javaex.select({
	id : "type_id",
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