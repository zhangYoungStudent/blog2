<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<style type="text/css">
    .center {width:400px;height:300px;margin:100px auto;background:#F6F6F6;}
	.label1 {margin-left: 78px;margin-top:5px;}
	.input {margin-left: 20px;height:20px;padding:4px;}
	.login_btn {height: 24px;
    width: 90px;
    margin-left: 155px;
    font-size: 14px;
    padding-left: 13px;
    /* text-align: center; */
    padding-top: 1px;}
	
	
	.padding_top {padding-top:10px;}
    .border_red {border:1px solid red;}
	.diaplaynone {display:none;}
</style>
<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<script>
$("document").ready(function(){
	$("#logina").click(function(){
	  $("#logina").addClass("active");
	  $("#denglua").removeClass("active"); 
	  $("#login").show();
	  $("#denglu").hide();
	});
	
	$("#denglua").click(function(){
	  $("#denglua").addClass("active");
	  $("#logina").removeClass("active"); 
	  $("#denglu").show();
	  $("#login").hide();
	});
	//ajax
	$("#email").keyup(function(){
	  $.get("deal.asp",
	       {action:"ajax",email:$("#email").val()},
			function (data,textstatus){$("#emailtishi").html(data);}
	  );
	});
	
});




</script>
<title>MAXXIS博客账号注册页面</title>
</head>
<body>

<div class="center border_red">
<% dim blog_id,k
   blog_id=request.QueryString("blog_id")
   if blog_id<>"" then
	  k="blog_id="&blog_id
   end if
%>
<div class="panel-heading">
	<ul class="nav nav-tabs">
		<li class="active" id="logina"><a href="#">注册</a></li>
		<li id="denglua"><a href="#">登录</a></li>
	</ul>
</div> 
<div class="login border_red padding_top " id="login"><!--注册样式-->
	<form action="deal.asp?action=login&<%if blog_id<>"" then response.write k%>" method="post">
	    <div class="from-group login_group label1">
			<label for="select" style="margin-left:27px;">身份</label>
			<select name="qxian" id="select" style="margin-left:18px;"><option value="0">游客</option><option value="1">作者</option></select>
		</div>
		<div class="from-group login_group label1">
			<label for="email" >注册邮箱</label><input type="text" id="email" name="email"  placehoder="登录邮箱" class="input" autocomplete="off">
		</div><span id="emailtishi " style="margin-left: 155px;font-size: 12px;"></span>
		<div class="from-group login_group label1">
			<label for="email" >员工编号</label><input type="text" id="staff_number" name="staff_number"  placehoder="登录邮箱" class="input">
		</div>
		<div class="from-group login_group label1">
		    <label for="username" >用户昵称</label><input type="text" id="username" name="username" placehoder="用户昵称" class="input">
		</div>
		<div class="from-group login_group label1">
		    <label for="psword">登录密码</label><input type="text" id="psword" name="psword" placehoder="登录密码" class="input">
		</div>
		<input type="submit" value="提交注册" class="login_btn">			
	</form>
</div> 
<div class="login border_red  padding_top diaplaynone" id="denglu"><!--登录样式-->
	<form action="deal.asp?action=denglu&<%if blog_id<>"" then response.write k%>" method="post">
	<div class="from-group login_group label1">
		<label for="email" >登录邮箱</label><input type="text" id="demail" name="email"  placehoder="登录邮箱" class="input">
	</div>
	<div class="from-group login_group label1">
		<label for="psword">登录密码</label><input type="text" id="dpsword" name="psword" placehoder="登录密码" class="input">
	</div>
	<input type="submit" value="提交登录" class="login_btn">			
	</form>
</div>	

</body>
</html>
	