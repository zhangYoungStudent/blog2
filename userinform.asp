<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<link href="css/base.css" rel="stylesheet" />
<link href="css/test.css" rel="stylesheet" />
<link href="css/inform.css" rel="stylesheet" />
<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<script>
$("document").ready(function(){
	$("#userinforma").click(function(){
	  $("#userinforma").addClass("active");
	  $("#userinform").show();
	  $("#modinforma,#modipswa").removeClass("active"); 
	  $("#modinform,#modipsw").hide();
	});
	
	$("#modinforma").click(function(){
	  $("#modinforma").addClass("active");
	  $("#modinform").show();
	  $("#userinforma,#modipswa").removeClass("active"); 
	  $("#userinform,#modipsw").hide();
	});
	
	$("#modipswa").click(function(){
	  $("#modipswa").addClass("active");
	  $("#modipsw").show();
	  $("#userinforma,#modinforma").removeClass("active"); 
	  $("#userinform,#modinform").hide();
	});
		
});
</script>
<title>资料修改</title>
</head>

<body>
<!--#include file="common.asp"-->
<%
if session("user_id")="" then
   response.Redirect "index.asp"
else

datebase="Development"
openconn conn,datebase 

sql="select * from L_zhang_blog_username where user_id='"&session("user_id")&"'"
openrs conn,rs,sql

username=rs("username")
sex=rs("sex")
user_id=rs("user_id")
staff_number=rs("staff_number")
hobby=rs("hobby")
email=rs("email")
qxian=rs("qxian")
'不读取密码
closers rs
%>
<div class="blog_nav">
	<div class="container">
		<div class="logoname">maxxis</div>
		<div class="loginname"><%=username%>您好</div>
		<ul><li><a href="index.asp"><span class="glyphicon glyphicon-home"></span></a></li>
			<li><a href="<%=url%>"><span class="glyphicon glyphicon-cog"></span></a></li>
			<li><a href="userinform.asp"><span class="glyphicon glyphicon-user"></span></a></li>
			<li><a href="logout.asp"><span class="glyphicon glyphicon-off"></span></a></div></li>
		</ul>
	</div>
</div>

<div class="blog_content"><!--页面的主要内容信息,分为主要内容和侧边栏两块-->
	<div class="blog_content_content">
	     <div class="panel-heading">
				<ul class="nav nav-tabs">
					<li class="active" id="userinforma"><a href="#">用户信息</a></li>
					<li id="modinforma"><a href="#">基本信息修改</a></li>
					<li id="modipswa"><a href="#">密码信息修改</a></li>
				</ul>
		 </div>

		<div class="" id="userinform">
		   <h4><% =staff_number %>，用户名为<% =username %>的信息</h4>
		   <dl>
			   <dt>员工编号</dt><dd><% =staff_number %></dd>
			   <dt>权限</dt><dd><% =qxian %></dd>
			   <dt>用户名</dt><dd><% =username %></dd>
			   <dt>性别</dt><dd><%if sex=0 then response.Write("未知")%></dd>
			   <dt>登录邮箱</dt><dd><% =email %></dd>
			   <dt>爱好</dt><dd><% =hobby %></dd>
		   </dl>
		</div>

		<div class="form border_red" id="modinform">
			<!--action中要携带user_id,这代表修改它本人的资料-->
			<form class="form-horizontal" id= "form"action="deal.asp?action=modify&inform=inform&user_id=<%=user_id%>" method="post" enctype="multipart/form-data">
				<legend>---<% =username%>---</legend>		   
				<div class="form-group">
					<label>性别</label>
					<input type="radio" id="sexwman" name="sex" value="0">女
					<input type="radio" id="sexman" name="sex" value="1">男
				</div>
				<div class="form-group">
					<label>爱好</label>
					<input type="checkbox" name="hobby" value="足球"/>足球
					<input type="checkbox" name="hobby" value="吉他"/>吉他
					<input type="checkbox" name="hobby" value="篮球"/>篮球
					<input type="checkbox" name="hobby" value="跑步"/>跑步
				</div>
				<div class="form-group">
					<label>上传头像</label>
				    <input type="file" name="file">
				</div>
				<input type="submit" value="提交资料"  class="btn btn-xs">
			</form>
		</div>

		<div class="form border_red" id="modipsw">
			<form class="form-horizontal" action="deal.asp?action=modify&inform=psword&user_id=<%=user_id%>" method="post">
				<legend>---<% =username%>---</legend>
				<div class="form-group">
					<label>输入旧密码</label>
					<input type="text" id="oldpsword" name="oldpsword" placeholder="输入旧的密码" >
				</div>
				<div class="form-group">
					<label>输入新密码</label>
					<input type="text" id="psword" name="newpsword" placeholder="输入新的密码">
				</div>
				<div class="form-group">
					<label>确认新密码</label>
					<input type="text" id="secondpsword" name="secondpsword" placeholder="确认新密码">
				</div>
				<input type="submit" value="确认修改密码" onclick="" class="btn btn-xs">
			</form>
		</div>		
	</div>
</div>

<!--#include file="common/footer.asp"-->
<%closeconn conn %>
<%end if%>
</body>
</html>