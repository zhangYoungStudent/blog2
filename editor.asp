<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<style type="text/css">
    .userstatus {background:#000;height:30px;color:#CCCCCC;}
    .border_red {border:1px solid red;}
	.margin_top {margin-top:10px;}
</style>
<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<title>MAXXIS博客作者管理页面</title>
</head>
<body>
<%
if session("user_id")="" then
   response.Redirect "index.asp"
else

dim conn,rs,sql,count,user,action
dim username,sex,user_id
set conn=server.CreateObject ("adodb.connection")
conn.ConnectionString = "Provider=sqloledb.1;Server=10.30.1.99;uid=dev;pwd=dev;DATABASE=Development;"
conn.Open 

set rs = Server.CreateObject("ADODB.Recordset")
sql="select * from L_zhang_blog_username where user_id='"&session("user_id")&"'"
rs.open sql,conn,1,1

username=rs("username")
sex=rs("sex")
user_id=rs("user_id")

rs.close
set rs=nothing
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
<div class="container">
	<div class="row"><!--页面的头部信息-->
	    <div class="col-xs-12 border_red">
			<div class="col-xs-6"><!--用户放置头部的logo-->
				<img src="img/LeftLogo.jpg" /><!--头部的logo,或者通过div,添加背景图片来实现该功能-->
				<h4>hello,welcome to maxxis world!</h4>
			</div>
		</div>
	</div>

	<div class="row margin_top"><!--页面的主要内容信息,分为主要内容和侧边栏两块-->
		<div class="col-xs-3">
			<div class="panel panel-success border_red clear">
			    <div class="panel-heading">管理内容分类</div> 
				<div class="list-group ">
					<a  href="#" class="list-group-item">发表文章</a>
					<a  href="#" class="list-group-item">文章管理</a>
					<a  href="#" class="list-group-item">查看评论</a>
					<a  href="#" class="list-group-item">其它</a>
				</div>
			</div>
		</div>
		<!--主要内容区域-->
		<div class="col-xs-9">
		   <!--发表文章-->
		   <form action="deal.asp?action=publish" method="post">
                     <legend>发表文章</legend>


		            <input name="user_id" id="user_id"  value="<%=user_id%>" hidden=ture />
				    <label for="blog_title" >文章标题</label><input type="text" id="blog_title" name="blog_title"  placehoder="文章标题">
					<label for="classify_id">文章分类</label>
					<select name="classify_id" id="select">
	<%					 set rs = Server.CreateObject("ADODB.Recordset")
						 sql="select classify_name,classify_id from L_zhang_blog_classify"
						 rs.open sql,conn,1,1
						 while not rs.eof %>
						  <option value="<%=rs("classify_id")%>"><%=rs("classify_name")%></option>
	<%                   rs.movenext '
						 wend
						 rs.close
						 set rs=nothing	%>
					</select>
					<label for="blog_content">文章内容</label><textarea id="blog_content" name="blog_content"></textarea>
					<input type="submit" value="发表文章">	
	
		    </form>
           <hr>
           <!--已发表的文章-->
		   <table class="table">
		     <caption>已经发表的文章</caption>
			 <!--需要到评论表中取数据，以及到内容表中取对应的文章标题-->
		     <tr><th>文章类别</th><th>文章标题</th><th>发表时间</th><th>评论量</th><th>阅读量</th><th>审核</th><th>删除</th></tr>
<%		     set rs = Server.CreateObject("ADODB.Recordset")
		     sql="select a.*,c.classify_name from L_zhang_blog_content a,L_zhang_blog_classify c where a.classify_id = c.classify_id and a.user_id='"&user_id&"' order by a.publish_time"
			 rs.open sql,conn,1,1
			 if not(rs.eof and rs.bof) then
				  while not rs.eof %>
                    <tr><td><%=rs("classify_name")%></td>
					    <td><%=rs("blog_title")%></td>
						<td><%=rs("publish_time")%></td>
				        <td></td>
						<td><%=rs("read_time")%></td>
						<td><%if rs("blog_qxian")=0 then response.Write("待审核") else response.Write("已通过")%></td>
						<td><a href="deal.asp?action=del&qxian=1&blog_id="<%=rs("blog_id")%>>删除</a></td>
					</tr>
<%                  rs.movenext '
				  wend
				  rs.close
				  set rs=nothing
			 else%>
				   <tr><td colspan="4">您还没有对别人的文章发表过评论<td></tr>	
<%	         end if%>
		 <table>
		<hr>
		   <!--作者对别人文章的评论-->
		   <table class="table">
		     <caption>您的评论</caption>
			 <!--根据作者user_id去comment中读取评论数量，
			 根据评论数量的blog_id去content中读取对应的文章标题，和作者的user_id,
			 然后根据user_id去username读取作者的名字（这一步还没有做到）-->
		     <tr><th>文章标题</th><th>文章作者</th><th>评论内容</th><th>评论日期</th><th>删除</th></tr>
<%		     set rs = Server.CreateObject("ADODB.Recordset")
		     sql="select d.*,a.blog_title,a.blog_title  from L_zhang_blog_comment d,L_zhang_blog_content a where d.blog_id=a.blog_id and d.user_id ='"&user_id&"'order by comment_time desc"
			 rs.open sql,conn,1,1
			 count=rs.recordcount
			 if count <>0 then
				  while not rs.eof %>
                    <tr><td><%=rs("blog_title")%></td>
					    <td><%=rs("blog_id")%></td>
					    <td><%=rs("comment_content")%></td>
				        <td><%=rs("comment_time")%></td>
						<td><a href="deal.asp?action=del&qxian=1&comment_id="<%=rs("comment_id")%>>删除</a></td>
					</tr>
<%                rs.movenext '
				  wend
				  rs.close
				  set rs=nothing
			 else%>
				   <tr><td colspan="4">您还没有对别人的文章发表过评论<td></tr>	
<%	         end if%>
		 <table>	
			
		<!--主要内容区域结束-->	
		</div>
	</div>	
	<!--页面的尾部-->
	<div class="row border_red "><div class="">版权所有</div></div>
</div>
<%end if%>
</body>
</html>