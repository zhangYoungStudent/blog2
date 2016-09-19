<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<link href="css/base.css" rel="stylesheet" />
<link href="css/index.css" rel="stylesheet" />
<link href="css/test.css" rel="stylesheet" />
<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<script src="../common/VeryHuo.Com/lib/jquery.validate.js"></script>
<script src="../common/VeryHuo.Com/lib/jquery.metadata.js"></script>
<script src="../common/VeryHuo.Com/lib/jquery.validate.messages_cn.js"></script>
<script>
//登录验证插件，使用规则
$(document).ready(function(){
   //$.validator.setDefaults({
//	   debug:true
//   });
//   $("#form").validate({
//	   rules:{
//			staffNumber:{required:true,rangelength:[4,6]},
//			psword:{required:true,minlength:6},
//			//confirmpwd:{required:true,minlength:6,equalTo:'#pwd'},
//			//email:{email:true,required:true},
//			//desc:{required:true,rangelength:[4,6]},
//	   },
//	   //下面的代码设定错误消息
//	   messages:{
//		   staffNumber:{required:"请输入用户名",jQuery.validator.format("用户名长度介于{0}到{1}之间的字符串")},
//		   psword:{required:"请输入密码",minlength:jQuery.validator.format("密码不能小于六个字符")},
//		   //email:{required:"请输入正确的邮箱地址",email:请输入正确的邮箱地址xx"},
//	   }
//   );
   
   
   //$("p").css({"background-color":"yellow","font-size":"200%"});
   
   $(".container .row:eq(1) .col-lg-4>div").css({"margin-left":"-15px","margin-right":"-15px"});
   
});

//$(document).ready(function(){
//   $(".container .row:eq(1) .col-lg-4 div").css("margin-left":"-15px","margin-right":"-15px");
//});
</script>
<title>MAXXIS博客首页</title>
</head>
<body>
<!--#include file="common.asp"-->
<% 
datebase="Development"
openconn conn,datebase 
%>
<!--#include file="common/blog_nav.asp"-->
<div class="blog_header">
	<!--#include file="common/header.asp"-->
	<div class="blog_header_carousel container"><!--这里设置轮播大图，记得前两个都是设置了浮动，所以lunbo样式必须设置清除浮动	-->	
		<div data-ride="carousel" class="carousel slide clear" id="carousel-container">
		<!--//图片容器-->
			<div class="carousel-inner container">
				<div class="item" ><img alt="" src="../usermanage/img/002.jpg" alt="maxxis"/></div>
				<div class="item active"><img alt="" src="../usermanage/img/003.jpg" alt="maxxis"/></div>
				<div class="item"><img alt="" src="../usermanage/img/002.jpg" alt="maxxis"/></div>
			</div>
			<!--圆圈指示符-->
			<ol class="carousel-indicators">
				<li data-slide-to="0" data-target="#carousel-container"></li>
				<li data-slide-to="1" data-target="#carousel-container"></li>
				<li data-slide-to="2" data-target="#carousel-container" class="active"></li>
			</ol>
			<!--左右控制按钮-->
			<a data-slide="prev" href="#carousel-container" class="left carousel-control"><span class="glyphicon glyphicon-chevron-left">
			</span></a>
			<a data-slide="next" href="#carousel-container" class="right carousel-control"><span class="glyphicon glyphicon-chevron-right">
			</span></a>
		</div>
	</div>
</div>

<div class="blog_content container">
	<!--主要内容区域-->
	<div class="blog_content_main">
		<!--第一部分，最新文章-->
		<div class="panel panel-success main_blog">
			<div class="panel-heading">最新文章 <div class="float_right"><a href="list.asp?action=newest">more</a></div></div>
			<%
			sql="select top 3 a.*,b.username ,c.classify_name  from L_zhang_blog_content a , L_zhang_blog_username b , L_zhang_blog_classify c where a.user_id = b.user_id and a.classify_id = c.classify_id order by a.publish_time desc"	
			openrs conn,rs,sql
			'blog_id=rs("blog_id")
	'				blog_title=rs("blog_title")
	'				blog_content=rs("blog_content")
	'				username=rs("username")
	'				publish_time=rs("publish_time")
	'				classify_name=rs("classify_name")
	'				read_time=rs("read_time")
								
			while not rs.eof %>
			<div class="media">
				<a class="pull-left" href="#"><img class="media-object" src="img/content1.png" alt="图片不能显示" /></a>
				<div class="media-body" >
					 <h4 class="media-heading"><a href="content.asp?blog_id=<%=rs("blog_id")%>"><%=rs("blog_title")%></a></h4>
					 <div><p><% =Left(rs("blog_content"),70)%>...</p></div>
					 <ul class="list-unstyled list-inline">
					 <li><a href="list.asp?action=writer&writer=<%=rs("username")%>"><%=rs("username")%></a></li>
					 <li><a href="list.asp?action=time&time=<%=rs("publish_time")%>"><%=rs("publish_time")%></a></li>
					 <li>评论(
						 <%sql="select count(comment_id) as count from L_zhang_blog_comment where blog_id='"&rs("blog_id")&"'"	
						   openrs conn,rs1,sql
						   count=rs1("count")
						   closers rs1
						   response.Write(count)
						   %>)
					 </li>
					 <li>分类（<a href="list.asp?action=classify&classify_name=<%=rs("classify_name")%>"><%=rs("classify_name")%></a>）</li>
					 <li>阅读量(<%=rs("read_time")%>)</li>
					 </ul>
				</div>
			</div>	
			<% rs.movenext '
			wend
			closers rs%>	
		</div>
		<!--第二部分，标语-->
		<div class="main_blockquote">
			<blockquote class="pull-right blog_content_aside_blockquote_blockquote">
				<%sql="select top 1 slogan_content,slogan_author from L_zhang_blog_slogan where slogan_qxian ='2'"
				  openrs conn,rs,sql
				  response.Write("<p>"&rs("slogan_content")&"</p>")
				  response.Write("<small>"&rs("slogan_author")&"</small>")
				  closers rs%>
			</blockquote>
		</div>
		<!--第三部分，最热文章-->
		<div class="panel panel-success  clear main_blog">
			<div class="panel-heading">最热文章<div class="float_right"><a href="list.asp?action=hottest">more</a></div></div>
			<% 
			sql="select top 3 a.*,b.username as username,c.classify_name as classify_name from L_zhang_blog_content a , L_zhang_blog_username b , L_zhang_blog_classify c where a.user_id = b.user_id and a.classify_id = c.classify_id order by a.read_time desc "
			openrs conn,rs,sql					
			while not rs.eof %>
				<div class="media">
					<a class="pull-left" href="#"><img class="media-object" src="img/content1.png" alt="图片不能显示" /></a>
					<div class="media-body" >
						 <h4 class="media-heading"><a href="content.asp?blog_id=<%=rs("blog_id")%>"><%=rs("blog_title")%></a></h4>
						 <div><p><% =Left(rs("blog_content"),70)%>...</p></div>
						 <ul class="list-unstyled list-inline">
						 <li><a href="list.asp?action=writer&writer=<%=rs("username")%>"><%=rs("username")%></a></li>
						 <li><a href="list.asp?action=time&time=<%=rs("publish_time")%>"><%=rs("publish_time")%></a></li>
						 <li>评论(
						 <%sql="select count(comment_id) as count from L_zhang_blog_comment where blog_id='"&rs("blog_id")&"'"	
						   openrs conn,rs1,sql
						   count=rs1("count")
						   closers rs1
						   response.Write(count)
						   %>)</li>
						 <li>分类（<a href="list.asp?action=classify&classify_name=<%=rs("classify_name")%>"><%=rs("classify_name")%></a>）</li>
						 <li>阅读量（<%=rs("read_time")%>）</li>
						 </ul>
					</div>
				</div>
		<%     rs.movenext '
			wend
			closers rs%>
		</div>
	
	</div><!--主要内容区域结束-->	
	<!--侧边栏，包含搜索区域-->
	<div class="blog_content_aside">
		<!--侧边栏第一部分，用户搜索内容区域-->
		<div class="aside_search">
			<form action="list.asp?action=search" name="" class="" method="post">
				<select name="identify" class="search_select" >
					 <option value="author">作者</option><option value="title">文章标题</option>
				</select>
				<input type="text" name="searchkeyword" class="search_text" autocomplete="off" placeholder="搜索字段">
				<button class="search_btn"><span class="glyphicon glyphicon-search"></span></button>
			</form>
		</div>
		<!--侧边栏第二部分，无序导航分类-->
		<div class="aside_nav  clear">
			<ul class="list-unstyled list-inline">
				<%sql="select * from L_zhang_blog_nav"    '这里采用的是get提交到classify页面
					openrs conn,rs,sql 
					while not rs.eof %>
						<li><a href="list.asp?action=nav&nav_name=<%=rs("nav_name")%>" ><%=rs("nav_name")%></a></li>
					<%rs.movenext '
					wend
				closers rs%>
			</ul>
		</div>
		<!--侧边栏第三部分，一句话标语-->
		<div class="aside_blockquote">
			 <blockquote>
			<%sql="select top 1 slogan_content,slogan_author from L_zhang_blog_slogan where slogan_qxian ='3'"
			  openrs conn,rs,sql
			  response.Write("<p>"&rs("slogan_content")&"</p>")
			  response.Write("<small>"&rs("slogan_author")&"</small>")
			  closers rs%>
			</blockquote>
		</div>
		<!--侧边栏第四部分，账号登录-->
		<div class="aside_login panel">
			<div class="panel-heading">账号登录<a href="login.asp?" class="float_right">注册</a></div> 
			<div class="login_main">
				<form action="deal.asp?action=denglu" method="post" name="form" id="form" class="form-inline">
					<div class="from-group login_group"><label>登录账号</label>
						<input type="text" id="email" name="email"  placeholder="输入邮箱" autocomplete="off">
						<span id="" name="tishi" class="help-inline"></span>
					</div>
						
					<div class="from-group login_group"><label>登录密码</label>
						<input type="text" id="psword" name="psword"  placeholder="六位密码" autocomplete="off">
						<span id="" name="tishi" class="help-inline"></span>
					</div>						
						<input type="submit" value="登录" class="btn btn-primary login_btn" id="submit">
				</form>
			</div>
		</div>
		<!--侧边栏第五部分，博客文章分类-->
		<div class="panel   aside_classify">
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
		
		<div class="panel aside_classify">
			<div class="panel-heading">站外导航</div> 
			<div class="list-group ">
				<%
				sql="select link_name,link_url from L_zhang_blog_link order by link_time"
				openrs conn,rs,sql
				while not rs.eof %>
					<a href="<%=rs("link_url")%>" class="list-group-item"><%=rs("link_name")%></a>
				<% rs.movenext '
				wend
				closers rs%>
			</div>
		</div>
	</div><!--侧边栏结束-->
</div>
<!--页面的尾部-->
<!--#include file="common/footer.asp"-->

<%closeconn conn %>

</body>
</html>
