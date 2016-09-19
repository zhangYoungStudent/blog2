<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<link href="css/base.css" rel="stylesheet" />
<link href="css/classify.css" rel="stylesheet" />
<link href="css/test.css" rel="stylesheet" />
<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<title>MAXXIS博客分类页面</title>
</head>
<!--#include file="common.asp"-->
<body>
<% 
datebase="Development"
openconn conn,datebase 
%>
<!--#include file="common/blog_nav.asp"-->
<div class="blog_header">
	<div class="blog_header_top container">
		<div class="blog_header_logo"><img src="img/LeftLogo.jpg"/></div>
		<div class="blog_header_text">
			<div class="blog_header_name">MAXXIS</div>
			<div class="blog_header_p">hello,welcome to maxxis world!</div>
		</div>
		<div class="blog_header_blockquote"><!--用户放置头部的宣传标语一句话-->
			<blockquote class="pull-right ">
				<%sql="select top 1 slogan_content from L_zhang_blog_slogan where slogan_qxian ='1'"
				  openrs conn,rs,sql
				  response.Write("<p>"&rs("slogan_content")&"</p>")
				  closers rs%>
			</blockquote>
		</div>
	</div>
	<div class="blog_header_bottom container">
		<div><img alt="" src="../usermanage/img/003.jpg"/></div>
	</div>
</div>

<div class="blog_content container"><!--页面的主要内容信息,分为主要内容和侧边栏两块-->
	    <!--侧边栏，包含搜索区域-->
		<div class="blog_content_aside">
			<div class="aside_search">
				<form action="list.asp?action=search" name="" class="" method="post">
					<select name="identify" class="search_select" >
						 <option value="author">作者</option><option value="title">文章标题</option>
					</select>
					<input type="text" name="searchkeyword" class="search_text" autocomplete="off">
					<button class="search_btn"><span class="glyphicon glyphicon-search"></span></button>
				</form>
			</div>
			<div class="panel panel-success  aside_classify">
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
					closers rs%>
				</div>
			</div>
		</div>
		<!--文章列表区域-->
		<div class="blog_content_main">
		   <!--面包屑导航-->
		   <ul class="breadcrumb">
		       <li><a href="index.asp">首页</a></li>
		       <li><% action=request.QueryString("action")
			          'response.Write session("action")
				      select case action
		              case "time" 
					        response.Write request.QueryString("time")
				      case "classify"
				            response.Write request.QueryString("classify_name")
				      case "writer" 
				            response.Write request.QueryString("writer")
				      case "hottest" %>
				            热度排序 
				   <% case "hottest" %>
				            时间排序
				   <% case "search" %> 
				            搜索结果
				   <% case else %>
				            暂无查询结果
				   <% end select%>
			   </li>
		   </ul>
<%         '根据不同的条件输入不同的查询语句
			dim publish_time,writer,classify_name
		   select case request.QueryString("action")
           case "time"
		         publish_time=request.QueryString("time")
				 sql="select a.blog_id,a.blog_title,a.publish_time,a.read_time,b.username from L_zhang_blog_content a,L_zhang_blog_username b where a.user_id=b.user_id and a.publish_time='"&publish_time&"'"
				 actionurl="action="&request.QueryString("action")&"&time="&request.QueryString("time")		 			 
		   case "writer"
		         writer=request.QueryString("writer")
				 sql="select a.blog_id,a.blog_title,a.publish_time,a.read_time,b.username from L_zhang_blog_content a,L_zhang_blog_username b where a.user_id=b.user_id and b.username='"&writer&"'order by a.publish_time desc"
				 actionurl="action="&request.QueryString("action")&"&writer="&request.QueryString("writer")
		   case "classify"
				 classify_name=request.QueryString("classify_name")
				 sql="select a.blog_id,a.blog_title,a.publish_time,a.read_time,b.username from L_zhang_blog_content a,L_zhang_blog_username b,L_zhang_blog_classify c where a.user_id=b.user_id and a.classify_id=c.classify_id and c.classify_name='"&classify_name&"'order by a.publish_time desc"
				 actionurl="action="&request.QueryString("action")&"&classify_name="&request.QueryString("classify_name")
		   case "newest"
				 sql="select a.blog_id,a.blog_title,a.publish_time,a.read_time,b.username from L_zhang_blog_content a,L_zhang_blog_username b where a.user_id=b.user_id order by a.publish_time desc"
				 actionurl="action="&request.QueryString("action")        
		   case "hottest"
				 sql="select a.blog_id,a.blog_title,a.publish_time,a.read_time,b.username from L_zhang_blog_content a,L_zhang_blog_username b where a.user_id=b.user_id order by a.read_time desc"
				 actionurl="action="&request.QueryString("action")
		          
		   case "search"
		         dim tiaojian,tiaojian1,tiaojian2
				 '查询条件从首页搜索框提交过来的时候是post,从首页无序导航链接过来的时候get，从本页面的其它页数相互之间跳转时也是使用get
		         if request("identify")="author" then
				      tiaojian1="b.username"
				 elseif request("identify")="title" then	  
					  tiaojian1="a.blog_title"
				 end if
				 tiaojian2=request("searchkeyword")
				 
				 'tiaojian=tiaojian1&" like '%"&tiaojian2&"%'"
				 tiaojian=tiaojian1&" = '"&tiaojian2&"'"
				 sql="select a.blog_id,a.blog_title,a.publish_time,a.read_time,b.username from L_zhang_blog_content a,L_zhang_blog_username b where "&tiaojian&" and b.user_id=a.user_id  order by a.read_time desc"	         	 
		         actionurl="action="&request.QueryString("action")&"&identify="&request("identify")&"&searchkeyword="&request("searchkeyword")
           end select
		   
		   if request.QueryString("action")="" then
		      response.write("<p>暂无查询信息</p>")
		   else
			   '连接数据库，查询数据 
			   openrs conn,rs,sql
			   count=rs.recordcount 
			   
			   if count<>0 then%>
			   <!--显示文章的信息-->
			   <div class="main_article">
					<div class="article_content">   
						<table class="table">
							<tr><th class="thcenter">序号</th><th>文章标题</th><th>作者</th><th>发表时间</th><th>阅读量</th></tr>
							<%	
							  sql="select value from L_zhang_blog_set where name='colnumber'"
							  openrs conn,rs1,sql
							  'rs.pagesize=rs1("value") 
							  closers rs1	   
							rs.pagesize=1 '每页显示10条
							curpage=request.QueryString("curpage") '获取页数，如果是其它页面过来的则curpage为空
							if curpage="" then
							   curpage=1
							'elseif curpage > rs.pagecount then
'							   curpage=1
							else
							   rs.absolutepage=curpage  '将curpage指定为当前页
							end if
											   
							for i=1 to rs.pagesize 
								if rs.eof then 
								   exit for
								end if %>
							   <tr>
							       <td align="center"><%=(rs.absolutepage-1)*rs.pagesize+i %></td>
								   <td><a href="content.asp?blog_id=<%=rs("blog_id")%>"><%=rs("blog_title")%></a></td>
								   <td><%=rs("username")%></td>
								   <td><%=DateValue(rs("publish_time"))%></td>
								   <td><%=rs("read_time")%></td>
							   </tr>
							<% rs.movenext
							next  	  
							%>
						</table>
					</div>
					<div class="article_nav"> 
						<%createpage actionurl,curpage,rs %>
					</div>
			   </div>		   
			<%  end if%>
			<%	closers rs
		   end if %> 
	    </div>	
</div>
<!--#include file="common/footer.asp"-->
<%closeconn conn %>
</body>
</html>
