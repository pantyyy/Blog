<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<div class="grid-1-3 container">
    <div id="logo">
        <a href="<%=basePath %>/front/index.action">Neo's blog</a>
    </div>
    <div id="nav">
        <ul class="nav">
            <li><a href="<%=basePath %>/front/index.action">首页</a></li>
            <li style="position: relative;">
                <a href="javascript:;">文章分类</a>
                <ul id="typeList" class="classified-nav">

                </ul>
            </li>
            <li><a href="<%=basePath %>front/aboutMe.action">关于我</a></li>
            <li><a href="javascript:;" onClick="openSearch()"><span class="icon-search" style="font-size: 14px;"></span></a></li>
            <li><a href="javascript:;" onClick="back()" >返回</a></li>
        </ul>
        
        <div id="search" class="hide">
						<span class="search-field-wrapper form-group">
							<input type="text" class="search" id="keyWord" placeholder="搜索…" value="" onkeydown="if(event.keyCode==13){search(this.value)};"/>
							<button class="button navy"  onclick="search2();">搜索</button>
						</span>
            <span id="close-search" class="icon-close" style="font-size: 16px;"></span>
        </div>
        
    </div>
</div>


<script>

var typeList = new Array();
//页面加载-读取分类列表
$(function () {
	//console.log(1);
     $.ajax({
        url : "<%=basePath %>front/selectAllType.json",
        type : "POST",
        dataType : "json",
        data : {},
        success : function(data) {
        	console.log(data);
            var typeList = data.data.types;
            var html = '';
            for (var i = 0;i<typeList.length;i++){
                html+='<li><a href="<%=basePath %>front/index.action?typeId='+typeList[i].id+'&typeName='+typeList[i].name+'&indexSta=2">'+typeList[i].name+'</a></li>';
            }
            $("#typeList").append(html);
        }
    });
})

//搜索
function search(keyWord) {
	if(keyWord == ""){
        window.location.href = "<%=basePath %>front/index.action?title="+keyWord+"&indexSta=3";
	}
}

function search2(){
	var keyWord = $("#keyWord").val();
	window.location.href = "<%=basePath %>front/index.action?title="+keyWord+"&indexSta=3";	
}

<%-- $("#search").click(function(){
	var keyWord = $("#keyWord").val();
	window.location.href = "<%=basePath %>front/index.action?title="+keyWord;
}); --%>


//打开搜索框
function openSearch() {
    $(".nav").hide();
    $("#search").show();
}

//关闭搜索框
$("#close-search").click(function() {
    $("#search").hide();
    $(".nav").show();
});

//返回上一级
function back(){
	self.location = document.referrer;	
}


</script>