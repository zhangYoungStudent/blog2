<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<link href="css/base.css" rel="stylesheet" />
<link href="css/test.css" rel="stylesheet" />
<link href="css/content.css" rel="stylesheet" />
<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<title>MAXXIS博客文章内容页面</title>
</head>
<!--#include file="common.asp"-->
<body>
<% 
datebase="Development"
openconn conn,datebase 
%>
<!--#include file="common/blog_nav.asp"-->
<div class="blog_header">
	<!--#include file="common/header.asp"-->
	<div class="blog_header_bottom container">
		<div><img alt="" src="../usermanage/img/003.jpg"/></div>
	</div>
</div>
	
<div class="blog_content container"><!--页面的主要内容信息,分为主要内容和侧边栏两块-->
		<div class="blog_content_aside">
			<!--侧边栏第一部分，用户搜索内容区域-->
			<div class="aside_search">
				<form action="list.asp?action=search" name="" class="" method="post">
					<select name="identify" class="search_select" >
						 <option value="author">作者</option><option value="title">文章标题</option>
					</select>
					<input type="text" name="searchkeyword" class="search_text" autocomplete="off">
					<input type="submit" value="sea" class="search_btn">
				</form>
			</div>
			<!--侧边栏第四部分，其它博客文章分类-->
			<div class="panel panel-success border_red clear aside_classify">
			    <div class="panel-heading">博客文章分类</div> 
				<div class="list-group ">
				<%
			    sql="select c.classify_name,count(a.classify_id) as count from L_zhang_blog_classify c left join L_zhang_blog_content a   on a.classify_id=c.classify_id group by c.classify_name"
			    openrs conn,rs,sql
				while not rs.eof %>
				    <a href="list.asp?action=classify&classify_name=<%=rs("classify_name")%>" class="list-group-item">
					<span class="badge"><%=rs("count")%></span><%=rs("classify_name")%>
					</a>
				<% rs.movenext '
					wend
				closers rs
				%>
				</div>
			</div>
        
		</div><!--侧边栏结束-->
			
		<!--文章内容区域-->
		<div class="blog_content_main">
	   <%   dim blog_id
	        blog_id=request.QueryString("blog_id")
	        if blog_id="" then '如果为空说明，用户是直接进入这个页面，直接跳转到分类页面
			   response.Redirect("list.asp")
			end if 
			sql="select a.*,b.username,c.classify_name from L_zhang_blog_content a,L_zhang_blog_username b,L_zhang_blog_classify c where a.user_id = b.user_id and a.classify_id=c.classify_id and blog_id='"&blog_id&"'"
			openrs conn,rs,sql
			
			blog_id=rs("blog_id")
			count=rs.recordcount
			dim read_time
			read_time=rs("read_time")
			
'			if request.cookies("blog_id")="" then
'			     read_time=read_time+1   '让阅读量+1  
'			     response.cookies("blog_id")=true
'			end if
				%>
		   <!--面包屑导航-->
		   <ul class="breadcrumb">
				<li><a href="index.asp">首页</a></li>
				<li><a href="list.asp?action=classify&classify_name=<%=rs("classify_name")%>"><%=rs("classify_name")%></a></li>
				<li><%=rs("blog_title")%></li>
			</ul>		   

		    <div class="panel panel-default border_red main_article"><!--用于设置文章的样式之用-->
		         
			<%	if count<>"" then  %>
			        <div class="panel-heading title"><h4><%=rs("blog_title")%></h4></div>
					<div class="panel-body">
					<small><%=rs("publish_time")%></small>
					<small><%=rs("username")%></small>
					<small>阅读量(<%=read_time%>)</small>
					
			<%
					dim blog_content,lenght,wordcount,page,curpage,acurpage
					blog_content=rs("blog_content") '整篇博客文章的内容
					lenght=Len(blog_content)'整篇博客文章的字数
					  sql="select value from L_zhang_blog_set where name='wordnumber'"
			          openrs conn,rs1,sql
					  wordcount=rs1("value") '预计每页显示的字数
					  closers rs1
					page=Int(lenght/wordcount) '共有几页内容
						
					acurpage=request.QueryString("curpage")
					if acurpage<>"" then
					   curpage=acurpage
					elseif acurpage>page then '当当前页面大于原有的页面时，直接跳转到第一页
					   curpage=1
					else 
					   curpage=1
					end if  %>
					      <p><% =Mid(blog_content,wordcount*(curpage-1)+1,wordcount)%></p>
					</div>
			<%		if page>1 then   '如果页数是0 或者1，则不显示下面的分页链接按钮 %>
					   <ul class="pagination">
					   <% for i=1 to page %>
					       <li><a href="?blog_id=<%=blog_id%>&curpage=<%=i%>">第<%=i%>页</a></li>
					   <% next %>
					   </ul>
					<%end if					
			    else
					 response.redirect "list.asp?action=newest"
				end if  %>
	        </div>
			<%
		    closers rs
			
			'更新文章的阅读量，只有文章正常显示，文章的阅读量才能更新成功	
			sql="update  L_zhang_blog_content set read_time ='"&read_time&"' where blog_id='"&blog_id& "'"
			conn.execute(sql)%>	   
		<!--文章内容区域结束-->	
		</div>	
	
	<div class="container blog_comment border_red clear">
		<!--评论区-->
		<%if session("user_id")<>"" then %>
			 <!--评论区，评论提交表单-->
			<form class="form-horizontal border_red" role="form" action="deal.asp?action=comment&blog_id=<%=blog_id%>" method="post">
				 <div class="form-group">
					  <label for="" class="col-sm-2 control-label">评论内容</label>
					  <div class="col-sm-8">
						 <textarea   class="form-control" name="comment_content"></textarea>
						 <input type="submit" value="发表评论" class="btn btn-primary  btn-xs " >
					  </div>    
				 </div>	
			</form>
		<%else %> 
			<div ><p>如果要评论请<a href="login.asp?blog_id=<%=blog_id%>">登录</a></p></div>
		<%end if%>
			<table class="table">
				 <tr><th>评论日期</th><th>评论人</th><th>评论内容</th></tr>
				 <%
					set rs = Server.CreateObject("ADODB.Recordset")
					sql="select d.*,b.username from L_zhang_blog_comment d,L_zhang_blog_username b where d.user_id = b.user_id and blog_id='"&blog_id&"'"   
					rs.open sql,conn,1,1
					count=rs.recordcount
					if count<>0 then
					while not rs.eof		
				 %>
				 <tr><td><%=rs("comment_time")%></td><td><%=rs("username")%></td><td><%=rs("comment_content")%></td></tr>
				 <% rs.movenext '
					wend
					rs.close
					set rs=nothing
				 else%>
					   <tr><td></td><td></td><td>暂时还没有评论，感激做沙发吧</td></tr>
				 <%end if%>
			</table>
    </div>
</div>   
<!--页面的尾部，一部分放置版权等信息，另一部分放置一句话标语-->
<!--#include file="common/footer.asp"-->
<%closeconn conn %>
</body>
</html>
