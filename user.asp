<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<link href="css/base.css" rel="stylesheet" />
<style type="text/css">
    .userstatus {background:#000;height:30px;color:#CCCCCC;}
    .border_red {border:1px solid red;}
	.margin_top {margin-top:10px;}
	
	.blog_content{margin-top:10px;clear:both;}
	.blog_content_border_bottom {border-bottom:2px solid #FF7200}
	.blog_content_content {float:left;width:64%;}
	.blog_content_aside {float:left;width:36%;margin-right:20px;}
</style>
<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>

<title>MAXXIS博客游客管理页面</title>
</head>
<body>
<%
if session("user_id")="" then
   response.Redirect "index.asp"
else
dim conn,rs,sql,count,user,action
set conn=server.CreateObject ("adodb.connection")
conn.ConnectionString = "Provider=sqloledb.1;Server=10.30.1.99;uid=dev;pwd=dev;DATABASE=Development;"
conn.Open 

Sub openrs(conn,rs,sql)
	 set rs = Server.CreateObject("ADODB.Recordset")
	 rs.open sql,conn,1,1
End Sub
Sub closers(rs)
	 rs.close
	 set rs = nothing
End Sub
%>
<div class="blog_nav">
	<div class="container">
		<div class="logoname">maxxis</div>
		<div class="loginname"><%=username%>您好</div>
		<ul><li><a href="index.asp"><span class="glyphicon glyphicon-home"></span></a></li>
			<li><a href="<%=url%>"><span class="glyphicon glyphicon-cog"></span></a></li>
			<li><a href="inform.asp"><span class="glyphicon glyphicon-user"></span></a></li>
			<li><a href="logout.asp"><span class="glyphicon glyphicon-off"></span></a></div></li>
		</ul>
	</div>
</div>
<div class="blog_content row">
	<div class="blog_content_aside">
		<div class="panel panel-success border_red clear">
			<div class="panel-heading">管理内容分类</div> 
			<div class="list-group ">
				<a  href="#" class="list-group-item" data-toggle="collapse" data-target="#table">查看评论</a>
				<a  href="user.asp?user=apply" class="list-group-item">申请作者</a>
				<a  href="#" class="list-group-item">其它</a>
			</div>
		</div>
	</div>

	<!--主要内容区域-->
	<div class="container blog_content_border_bottom">
		<table class="table collapse in" id="table">
			<caption>您的文章评论列表</caption>
			<tr><th>文章标题</th><th>文章作者</th><th>评论内容</th><th>评论日期</th><th>删除</th></tr>
			<%sql="select d.*,a.blog_title  from L_zhang_blog_comment d,L_zhang_blog_content a where d.blog_id=a.blog_id and d.user_id ='"&request.QueryString("user_id")&"'order by comment_time desc"
			openrs conn,rs,sql
			count=rs.recordcount
			if count <>0 then
				while not rs.eof %>
				<tr><td><%=rs("blog_title")%></td><td><%=rs("blog_id")%></td><td><%=rs("comment_content")%></td>
					<td><%=rs("comment_time")%></td><td><a href="deal.asp?action=del&qxian=0&comment_id="<%=rs("comment_id")%>>删除</a></td></tr>
				<%   rs.movenext '
				wend
				closers rs
			else%>
			   <tr><td colspan="4">您还没有发表评论<td></tr>	
			<%end if%>
		</table>
	</div><!--主要内容区域结束-->	
	
</div>
<!--页面的尾部-->
<div class="blog_footer"><div class="">版权所有</div></div>	
<%end if%>
</body>
</html>