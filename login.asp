<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<link href="css/base.css" rel="stylesheet" />
<link href="css/test.css" rel="stylesheet" />
<style type="text/css">
	.blog_header {height:60px;background:#F6F6F6;width:100%;} 
	.blog_header_text {float:left;width:300px;margin-left:30px;}
	.blog_header_name {float:left;font-size:50px;font-weight:bold;line-height:40px;padding-bottom:0px;padding-top: 2px;}
	.blog_header_text .blog_header_name a{color:#333;}
	.blog_header_name a:hover {color:#FF7200;}
	.blog_header_p {float:left;font-size:16px;line-height:20px;margin-top:0px;padding-top:0;padding-left:2px;}
	 
    .blog_content {}
	.blog_content .main{width:400px;height:300px;margin:100px auto;background:#F6F6F6;}
	.blog_content .panel-heading{float: left;}
	.blog_content .panel-heading li {width: 100px;margin-left: 8px;}
	.blog_content .panel-heading li a {padding-left: 32px;}
	.blog_content .shouye {float: right;margin-right: 20px;margin-top: 23px;}
    .blog_content .login {clear:both;}
	.blog_content .login .login_btn {height: 24px; width: 90px;margin-left: 155px;font-size: 14px;padding-left: 13px;padding-top: 1px;}
	.blog_content .login .input {margin-left: 20px;height:20px;padding:4px;}
	.blog_content .login .label1 {margin-left: 78px;margin-top:5px;}

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
<title>MAXXIS�����˺�ע��ҳ��</title>
</head>
<body>
<!--#include file="common.asp"-->
<% 
datebase="Development"
openconn conn,datebase 

   dim blog_id,k
   blog_id=request.QueryString("blog_id")
   if blog_id<>"" then
	  k="blog_id="&blog_id
   end if
%>
<div class="blog_header">
	<div class="container">
		<div class="blog_header_text">
			<div class="blog_header_name"><a href="index.asp">MAXXIS</a></div>
			<div class="blog_header_p">hello,welcome to maxxis world!</div>
		</div>
	</div>
</div>

<div class="blog_content">
	<div class="container">
	    <div class="main">
			<div class="panel-heading">
				<ul class="nav nav-tabs">
					<li class="active" id="logina"><a href="#">ע��</a></li>
					<li id="denglua"><a href="#">��¼</a></li>
				</ul>
			</div>
			<div class="shouye"><a href="index.asp"><span class="glyphicon glyphicon-home"></span>������ҳ</a></div> 
			<div class="login border_red padding_top " id="login"><!--ע����ʽ-->
				<form action="deal.asp?action=login&<%if blog_id<>"" then response.write k%>" method="post">
					<div class="from-group login_group label1">
						<label for="select" style="margin-left:27px;">���</label>
						<select name="qxian" id="select" style="margin-left:18px;"><option value="0">�ο�</option><option value="1">����</option></select>
					</div>
					<div class="from-group login_group label1">
						<label for="email" >ע������</label><input type="text" id="email" name="email"  placehoder="��¼����" class="input" autocomplete="off">
					</div><span id="emailtishi " style="margin-left: 155px;font-size: 12px;"></span>
					<div class="from-group login_group label1">
						<label for="email" >Ա�����</label><input type="text" id="staff_number" name="staff_number"  placehoder="��¼����" class="input">
					</div>
					<div class="from-group login_group label1">
						<label for="username" >�û��ǳ�</label><input type="text" id="username" name="username" placehoder="�û��ǳ�" class="input">
					</div>
					<div class="from-group login_group label1">
						<label for="psword">��¼����</label><input type="text" id="psword" name="psword" placehoder="��¼����" class="input">
					</div>
					<input type="submit" value="�ύע��" class="login_btn">			
				</form>
			</div> 
			<div class="login border_red  padding_top diaplaynone" id="denglu"><!--��¼��ʽ-->
				<form action="deal.asp?action=denglu&<%if blog_id<>"" then response.write k%>" method="post">
				<div class="from-group login_group label1">
					<label for="email" >��¼����</label><input type="text" id="demail" name="email"  placehoder="��¼����" class="input">
				</div>
				<div class="from-group login_group label1">
					<label for="psword">��¼����</label><input type="text" id="dpsword" name="psword" placehoder="��¼����" class="input">
				</div>
				<input type="submit" value="�ύ��¼" class="login_btn">			
				</form>
			</div>
		</div>
	</div>
</div>	
<!--#include file="common/footer.asp"-->
<%closeconn conn %>
</body>
</html>
	