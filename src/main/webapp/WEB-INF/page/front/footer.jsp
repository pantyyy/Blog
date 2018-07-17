<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="grid-1-3 container">
    <div style="text-align: left;">
        <ul class="equal-4">
            <li><a href="#">联系我</a></li>
            <li><a href="#">友情链接</a></li>
            <li><a href="<%=basePath %>admin/index.action" target="_blank">后台管理</a></li>
        </ul>
    </div>
    <div style="text-align: right;color: #ccc;">我要涨工资 ©2018　Neo's blog</div>
</div>