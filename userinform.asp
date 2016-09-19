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
<title>�����޸�</title>
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
'����ȡ����
closers rs
%>
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

<div class="blog_content"><!--ҳ�����Ҫ������Ϣ,��Ϊ��Ҫ���ݺͲ��������-->
	<div class="blog_content_content">
	     <div class="panel-heading">
				<ul class="nav nav-tabs">
					<li class="active" id="userinforma"><a href="#">�û���Ϣ</a></li>
					<li id="modinforma"><a href="#">������Ϣ�޸�</a></li>
					<li id="modipswa"><a href="#">������Ϣ�޸�</a></li>
				</ul>
		 </div>

		<div class="" id="userinform">
		   <h4><% =staff_number %>���û���Ϊ<% =username %>����Ϣ</h4>
		   <dl>
			   <dt>Ա�����</dt><dd><% =staff_number %></dd>
			   <dt>Ȩ��</dt><dd><% =qxian %></dd>
			   <dt>�û���</dt><dd><% =username %></dd>
			   <dt>�Ա�</dt><dd><%if sex=0 then response.Write("δ֪")%></dd>
			   <dt>��¼����</dt><dd><% =email %></dd>
			   <dt>����</dt><dd><% =hobby %></dd>
		   </dl>
		</div>

		<div class="form border_red" id="modinform">
			<!--action��ҪЯ��user_id,������޸������˵�����-->
			<form class="form-horizontal" id= "form"action="deal.asp?action=modify&inform=inform&user_id=<%=user_id%>" method="post" enctype="multipart/form-data">
				<legend>---<% =username%>---</legend>		   
				<div class="form-group">
					<label>�Ա�</label>
					<input type="radio" id="sexwman" name="sex" value="0">Ů
					<input type="radio" id="sexman" name="sex" value="1">��
				</div>
				<div class="form-group">
					<label>����</label>
					<input type="checkbox" name="hobby" value="����"/>����
					<input type="checkbox" name="hobby" value="����"/>����
					<input type="checkbox" name="hobby" value="����"/>����
					<input type="checkbox" name="hobby" value="�ܲ�"/>�ܲ�
				</div>
				<div class="form-group">
					<label>�ϴ�ͷ��</label>
				    <input type="file" name="file">
				</div>
				<input type="submit" value="�ύ����"  class="btn btn-xs">
			</form>
		</div>

		<div class="form border_red" id="modipsw">
			<form class="form-horizontal" action="deal.asp?action=modify&inform=psword&user_id=<%=user_id%>" method="post">
				<legend>---<% =username%>---</legend>
				<div class="form-group">
					<label>���������</label>
					<input type="text" id="oldpsword" name="oldpsword" placeholder="����ɵ�����" >
				</div>
				<div class="form-group">
					<label>����������</label>
					<input type="text" id="psword" name="newpsword" placeholder="�����µ�����">
				</div>
				<div class="form-group">
					<label>ȷ��������</label>
					<input type="text" id="secondpsword" name="secondpsword" placeholder="ȷ��������">
				</div>
				<input type="submit" value="ȷ���޸�����" onclick="" class="btn btn-xs">
			</form>
		</div>		
	</div>
</div>

<!--#include file="common/footer.asp"-->
<%closeconn conn %>
<%end if%>
</body>
</html>