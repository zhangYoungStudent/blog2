<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<link href="css/base.css" rel="stylesheet" />
<link href="css/index.css" rel="stylesheet" />

<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<script src="../common/VeryHuo.Com/lib/jquery.validate.js"></script>
<script src="../common/VeryHuo.Com/lib/jquery.metadata.js"></script>
<script src="../common/VeryHuo.Com/lib/jquery.validate.messages_cn.js"></script>
<script>
//��¼��֤�����ʹ�ù���
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
//	   //����Ĵ����趨������Ϣ
//	   messages:{
//		   staffNumber:{required:"�������û���",jQuery.validator.format("�û������Ƚ���{0}��{1}֮����ַ���")},
//		   psword:{required:"����������",minlength:jQuery.validator.format("���벻��С�������ַ�")},
//		   //email:{required:"��������ȷ�������ַ",email:��������ȷ�������ַxx"},
//	   }
//   );
   
   
   //$("p").css({"background-color":"yellow","font-size":"200%"});
   
   $(".container .row:eq(1) .col-lg-4>div").css({"margin-left":"-15px","margin-right":"-15px"});
   
});

//$(document).ready(function(){
//   $(".container .row:eq(1) .col-lg-4 div").css("margin-left":"-15px","margin-right":"-15px");
//});
</script>
<title>MAXXIS������ҳ</title>
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
	<div class="blog_header_bottom container"><!--���������ֲ���ͼ���ǵ�ǰ�������������˸���������lunbo��ʽ���������������	-->	
		<div data-ride="carousel" class="carousel slide clear" id="carousel-container">
		<!--//ͼƬ����-->
			<div class="carousel-inner container">
				<div class="item" ><img alt="" src="../usermanage/img/002.jpg"/></div>
				<div class="item active"><img alt="" src="../usermanage/img/003.jpg"/></div>
				<div class="item"><img alt="" src="../usermanage/img/002.jpg"/></div>
			</div>
			<!--ԲȦָʾ��-->
			<ol class="carousel-indicators">
				<li data-slide-to="0" data-target="#carousel-container"></li>
				<li data-slide-to="1" data-target="#carousel-container"></li>
				<li data-slide-to="2" data-target="#carousel-container" class="active"></li>
			</ol>
			<!--���ҿ��ư�ť-->
			<a data-slide="prev" href="#carousel-container" class="left carousel-control"><span class="glyphicon glyphicon-chevron-left">
			</span></a>
			<a data-slide="next" href="#carousel-container" class="right carousel-control"><span class="glyphicon glyphicon-chevron-right">
			</span></a>
		</div>
	</div>
</div>

<div class="blog_content">
    <div class="container">
		<!--��Ҫ��������-->
		<div class="blog_content_content">
			<!--��һ���֣���������-->
			<div class="panel panel-success  clear blog_content_content_blog">
				<div class="panel-heading">�������� <div class="float_right"><a href="classify.asp?action=newest">more</a></div></div>
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
					<a class="pull-left" href="#"><img class="media-object" src="img/content1.png" alt="ͼƬ������ʾ" /></a>
					<div class="media-body" >
						 <h4 class="media-heading"><a href="content.asp?blog_id=<%=rs("blog_id")%>"><%=rs("blog_title")%></a></h4>
						 <div><p><% =Left(rs("blog_content"),70)%>...</p></div>
						 <ul class="list-unstyled list-inline">
						 <li><a href="classify.asp?action=writer&writer=<%=rs("username")%>"><%=rs("username")%></a></li>
						 <li><a href="classify.asp?action=time&time=<%=rs("publish_time")%>"><%=rs("publish_time")%></a></li>
						 <li>����(
							 <%sql="select count(comment_id) as count from L_zhang_blog_comment where blog_id='"&rs("blog_id")&"'"	
							   openrs conn,rs1,sql
							   count=rs1("count")
							   closers rs1
							   response.Write(count)
							   %>)
						 </li>
						 <li>���ࣨ<a href="classify.asp?action=classify&classify_name=<%=rs("classify_name")%>"><%=rs("classify_name")%></a>��</li>
						 <li>�Ķ���(<%=rs("read_time")%>)</li>
						 </ul>
					</div>
				</div>	
				<% rs.movenext '
				wend
				closers rs%>	
			</div>
			<!--�ڶ����֣�����-->
			<div class="blog_content_content_blockquote">
				<blockquote class="pull-right blog_content_aside_blockquote_blockquote">
					<%sql="select top 1 slogan_content,slogan_author from L_zhang_blog_slogan where slogan_qxian ='2'"
					  openrs conn,rs,sql
					  response.Write("<p>"&rs("slogan_content")&"</p>")
					  response.Write("<small>"&rs("slogan_author")&"</small>")
					  closers rs%>
				</blockquote>
			</div>
			<!--�������֣���������-->
			<div class="panel panel-success  clear blog_content_content_blog">
				<div class="panel-heading">��������<div class="float_right"><a href="classify.asp?action=hottest">more</a></div></div>
				<% 
				sql="select top 3 a.*,b.username as username,c.classify_name as classify_name from L_zhang_blog_content a , L_zhang_blog_username b , L_zhang_blog_classify c where a.user_id = b.user_id and a.classify_id = c.classify_id order by a.read_time desc "
				openrs conn,rs,sql					
				while not rs.eof %>
					<div class="media">
						<a class="pull-left" href="#"><img class="media-object" src="img/content1.png" alt="ͼƬ������ʾ" /></a>
						<div class="media-body" >
							 <h4 class="media-heading"><a href="content.asp?blog_id=<%=rs("blog_id")%>"><%=rs("blog_title")%></a></h4>
							 <div><p><% =Left(rs("blog_content"),70)%>...</p></div>
							 <ul class="list-unstyled list-inline">
							 <li><a href="classify.asp?action=writer&writer=<%=rs("username")%>"><%=rs("username")%></a></li>
							 <li><a href="classify.asp?action=time&time=<%=rs("publish_time")%>"><%=rs("publish_time")%></a></li>
							 <li>����(
							 <%sql="select count(comment_id) as count from L_zhang_blog_comment where blog_id='"&rs("blog_id")&"'"	
							   openrs conn,rs1,sql
							   count=rs1("count")
							   closers rs1
							   response.Write(count)
							   %>)</li>
							 <li>���ࣨ<a href="classify.asp?action=classify&classify_name=<%=rs("classify_name")%>"><%=rs("classify_name")%></a>��</li>
							 <li>�Ķ�����<%=rs("read_time")%>��</li>
							 </ul>
						</div>
					</div>
			<%     rs.movenext '
				wend
				closers rs%>
			</div>
		
		</div><!--��Ҫ�����������-->	
		<!--�������������������-->
		<div class="blog_content_aside">
			<!--�������һ���֣��û�������������-->
			<div class="blog_content_aside_search">
				<form action="classify.asp?action=search" name="" class="" method="post">
					<select name="identify" class="blog_content_aside_search_select" >
						 <option value="author">����</option><option value="title">���±���</option>
					</select>
					<input type="text" name="searchkeyword" class="blog_content_aside_search_text" autocomplete="off">
					<button class="blog_content_aside_search_btn"><span class="glyphicon glyphicon-search"></span></button>
				</form>
			</div>
			<!--������ڶ����֣����򵼺�����-->
			<div class="blog_content_aside_nav  clear">
				<ul class="list-unstyled list-inline">
					<%sql="select * from L_zhang_blog_nav"    '������õ���get�ύ��classifyҳ��
						openrs conn,rs,sql 
						while not rs.eof %>
							<li><a href="classify.asp?action=search&searchkeyword=<%=rs("nav_name")%>" ><%=rs("nav_name")%></a></li>
						<%rs.movenext '
						wend
					closers rs%>
				</ul>
			</div>
			<!--������������֣�һ�仰����-->
			<div class="blog_content_aside_blockquote">
				 <blockquote>
				<%sql="select top 1 slogan_content,slogan_author from L_zhang_blog_slogan where slogan_qxian ='3'"
				  openrs conn,rs,sql
				  response.Write("<p>"&rs("slogan_content")&"</p>")
				  response.Write("<small>"&rs("slogan_author")&"</small>")
				  closers rs%>
				</blockquote>
			</div>
			<!--��������Ĳ��֣��˺ŵ�¼-->
			<div class="login panel">
				<div class="panel-heading">�˺ŵ�¼<a href="login.asp?" class="float_right">ע��</a></div> 
				<div class="login_main">
					<form action="deal.asp?action=denglu" method="post" name="form" id="form" class="form-inline">
						<div class="from-group login_group"><label>��¼�˺�</label>
							<input type="text" id="email" name="email"  placeholder="��������" autocomplete="off">
							<span id="" name="tishi" class="help-inline"></span>
						</div>
							
						<div class="from-group login_group"><label>��¼����</label>
							<input type="text" id="psword" name="psword"  placeholder="��λ����" autocomplete="off">
							<span id="" name="tishi" class="help-inline"></span>
						</div>						
							<input type="submit" value="��¼" class="btn btn-primary login_btn" id="submit">
					</form>
				</div>
			</div>
			<!--��������岿�֣��������·���-->
			<div class="panel panel-success  blog_classify">
				<div class="panel-heading">�������·���</div> 
				<div class="list-group ">
					<%
					sql="select c.classify_name,count(a.classify_id) as count from L_zhang_blog_classify c left join L_zhang_blog_content a   on a.classify_id=c.classify_id group by c.classify_name"
					openrs conn,rs,sql
					while not rs.eof %>
						<a href="classify.asp?action=classify&classify_name=<%=rs("classify_name")%>" class="list-group-item">
						<span class="badge"><%=rs("count")%></span><%=rs("classify_name")%>
						</a>
					<% rs.movenext '
					wend
					closers rs%>
				</div>
			</div>
		</div><!--���������-->
	</div>
</div>
<!--ҳ���β��-->
<!--#include file="common/footer.asp"-->

<%closeconn conn %>

</body>
</html>