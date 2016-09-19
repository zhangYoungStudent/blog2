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
	.displaynone {display:none;}
	
	.blog_content{margin-top:10px;clear:both;background:#F6F6F6;overflow:hidden;}
	.blog_content_border_bottom {border-bottom:2px solid #FF7200}
	.blog_content_content {float:left;width:64%;}
	.blog_content_content_user {}
	.blog_content_content_user_content {margin-left:20px;margin-right:20px;}
	.blog_content_content_author_content {margin-left:20px;margin-right:20px;}
	.blog_content_content_articl_content{margin-left:20px;margin-right:20px;}
	
	
	.blog_content_aside {float:left;width:250px;margin-right:20px;margin-left:20px;}
</style>
<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<script>
$("document").ready(function(){
	$("#table11").click(function(){
	  $("#table1").toggle();
	});
	
	$("#table21").click(function(){
	  $("#table2").toggle();
	});
	$("#table31").click(function(){
	  $("#table3").toggle();
	});
	$("#table41").click(function(){
	  $("#table4").toggle();
	});
	$("#table51").click(function(){
	  $("#table5").toggle();
	});
	$("#table61").click(function(){
	  $("#table6").toggle();
	});
	
	$("#blog_set_a").click(function(){
	  $("#blog_set_a").addClass("active");
	  $("#blog_classify_a").removeClass("active"); 
	  $("#blog_set").show();
	  $("#blog_classify").hide();
	});
	
	$("#blog_classify_a").click(function(){
	  $("#blog_classify_a").addClass("active");
	  $("#blog_set_a").removeClass("active"); 
	  $("#blog_classify").show();
	  $("#blog_set").hide();
	});
	
});

</script>
<title>MAXXIS���ͱ༭����Ա����ҳ��</title>
</head>
<!--#include file="common.asp"-->
<% 
if session("user_id")="" then
   response.Redirect "index.asp"
else

dim user,action
dim username,sex,user_id

datebase="Development"
openconn conn,datebase 

sql="select * from L_zhang_blog_username where user_id='"&session("user_id")&"'"
openrs conn,rs,sql

username=rs("username")
sex=rs("sex")
user_id=rs("user_id")

closers rs
%>
<body>
<div class="blog_nav">
	<div class="container">
		<div class="logoname">maxxis</div>
		<div class="loginname"><%=username%>����</div>
		<ul><li><a href="index.asp"><span class="glyphicon glyphicon-home"></span></a></li>
			<li><a href="<%=url%>"><span class="glyphicon glyphicon-cog"></span></a></li>
			<li><a href="userinform.asp"><span class="glyphicon glyphicon-user"></span></a></li>
			<li><a href="logout.asp"><span class="glyphicon glyphicon-off"></span></a></div></li>
		</ul>
	</div>
</div>

<div class="blog_content">
	<div class="blog_content_aside">
		<div class="panel panel-success border_red clear">
			<div class="panel-heading">�������ݷ���</div> 
			<div class="list-group ">
				<a  href="#" class="list-group-item" id="table11">�鿴�ο���Ϣ</a>
				<a  href="#" class="list-group-item" id="table21">�鿴������Ϣ</a>
				<a  href="#" class="list-group-item" id="table31">������¹���</a>
				<a  href="#" class="list-group-item" id="table41">�������ù���</a>
				<a  href="#" class="list-group-item" id="table51">�������</a>
				<a  href="#" class="list-group-item" id="table61">���򵼺�����</a>
				<a  href="#" class="list-group-item" id="table71">��ҳվ�����ӹ���</a>
			</div>
		</div>
	</div>
	<div class="blog_content_content">
		<!--�鿴�ο���Ϣ-->
		<div class="panel panel-success">
			<div class="panel-heading">�鿴�ο���Ϣ</div>
			<div class="displaynone  blog_content_content_author_content" id="table1">
				<iframe src="manage/userinform.asp"  width="840" height="400" frameborder="0"scrolling="no"></iframe>
			</div>
		</div>
		
		<!--�鿴������Ϣ-->
		<div class="panel panel-success">
			<div class="panel-heading" >�鿴������Ϣ</div>
			<iframe src="manage/authorinform.asp"  width="840" height="400" frameborder="0"scrolling="no"class="displaynone blog_content_content_author_content" id="table2">
			</iframe>
		</div>
		
		<!--������¹���-->
		<div class="panel panel-success">
			<div class="panel-heading">������¹���</div>
			<iframe src="manage/essaymanage.asp"  width="840" frameborder="0"scrolling="no"class="displaynone blog_content_content_author_content" id="table3">
			</iframe>
		</div>
		
		<!--���ͷ������---->
		<div class="panel panel-success">
			<div class="panel-heading">�������ù���</div>
			<iframe src="manage/blogsetmanage.asp"  width="840" height="500" frameborder="0"scrolling="no"class="displaynone blog_content_content_author_content" id="table4">
			</iframe>
		</div>
		
		<!--�������-->
		<div class="panel panel-success">
			<div class="panel-heading ">�������</div>
			<iframe src="manage/sloganmanage.asp"  width="840" height="200" frameborder="0"scrolling="no"class="displaynone blog_content_content_author_content" id="table5">
			</iframe>
		</div>
		
		<!--���򵼺�����-->
		<div class="panel panel-success">
			<div class="panel-heading ">���򵼺�����</div>
			<iframe src="manage/disnavmanage.asp"  width="840" height="200" frameborder="0"scrolling="no"class="displaynone blog_content_content_author_content" id="table6">
			</iframe>
		</div>	
			
		<!--��ҳվ�����ӹ���-->
		<div class="panel panel-success">
			<div class="panel-heading ">վ�����ӹ���</div>
			<iframe src="manage/outlinkmanage.asp"  width="840" height="200" frameborder="0"scrolling="no"class="displaynone blog_content_content_author_content" id="table6">
			</iframe>
		</div>	
		
	</div>

</div>
<!--#include file="common/footer.asp"-->
<%end if
closeconn conn %>
</body>
</html>
