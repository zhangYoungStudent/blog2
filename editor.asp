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
<title>MAXXIS�������߹���ҳ��</title>
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
		<div class="loginname"><%=username%>����</div>
		<ul><li><a href="index.asp"><span class="glyphicon glyphicon-home"></span></a></li>
			<li><a href="<%=url%>"><span class="glyphicon glyphicon-cog"></span></a></li>
			<li><a href="inform.asp"><span class="glyphicon glyphicon-user"></span></a></li>
			<li><a href="logout.asp"><span class="glyphicon glyphicon-off"></span></a></div></li>
		</ul>
	</div>
</div>
<div class="container">
	<div class="row"><!--ҳ���ͷ����Ϣ-->
	    <div class="col-xs-12 border_red">
			<div class="col-xs-6"><!--�û�����ͷ����logo-->
				<img src="img/LeftLogo.jpg" /><!--ͷ����logo,����ͨ��div,��ӱ���ͼƬ��ʵ�ָù���-->
				<h4>hello,welcome to maxxis world!</h4>
			</div>
		</div>
	</div>

	<div class="row margin_top"><!--ҳ�����Ҫ������Ϣ,��Ϊ��Ҫ���ݺͲ��������-->
		<div class="col-xs-3">
			<div class="panel panel-success border_red clear">
			    <div class="panel-heading">�������ݷ���</div> 
				<div class="list-group ">
					<a  href="#" class="list-group-item">��������</a>
					<a  href="#" class="list-group-item">���¹���</a>
					<a  href="#" class="list-group-item">�鿴����</a>
					<a  href="#" class="list-group-item">����</a>
				</div>
			</div>
		</div>
		<!--��Ҫ��������-->
		<div class="col-xs-9">
		   <!--��������-->
		   <form action="deal.asp?action=publish" method="post">
                     <legend>��������</legend>


		            <input name="user_id" id="user_id"  value="<%=user_id%>" hidden=ture />
				    <label for="blog_title" >���±���</label><input type="text" id="blog_title" name="blog_title"  placehoder="���±���">
					<label for="classify_id">���·���</label>
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
					<label for="blog_content">��������</label><textarea id="blog_content" name="blog_content"></textarea>
					<input type="submit" value="��������">	
	
		    </form>
           <hr>
           <!--�ѷ��������-->
		   <table class="table">
		     <caption>�Ѿ����������</caption>
			 <!--��Ҫ�����۱���ȡ���ݣ��Լ������ݱ���ȡ��Ӧ�����±���-->
		     <tr><th>�������</th><th>���±���</th><th>����ʱ��</th><th>������</th><th>�Ķ���</th><th>���</th><th>ɾ��</th></tr>
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
						<td><%if rs("blog_qxian")=0 then response.Write("�����") else response.Write("��ͨ��")%></td>
						<td><a href="deal.asp?action=del&qxian=1&blog_id="<%=rs("blog_id")%>>ɾ��</a></td>
					</tr>
<%                  rs.movenext '
				  wend
				  rs.close
				  set rs=nothing
			 else%>
				   <tr><td colspan="4">����û�жԱ��˵����·��������<td></tr>	
<%	         end if%>
		 <table>
		<hr>
		   <!--���߶Ա������µ�����-->
		   <table class="table">
		     <caption>��������</caption>
			 <!--��������user_idȥcomment�ж�ȡ����������
			 ��������������blog_idȥcontent�ж�ȡ��Ӧ�����±��⣬�����ߵ�user_id,
			 Ȼ�����user_idȥusername��ȡ���ߵ����֣���һ����û��������-->
		     <tr><th>���±���</th><th>��������</th><th>��������</th><th>��������</th><th>ɾ��</th></tr>
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
						<td><a href="deal.asp?action=del&qxian=1&comment_id="<%=rs("comment_id")%>>ɾ��</a></td>
					</tr>
<%                rs.movenext '
				  wend
				  rs.close
				  set rs=nothing
			 else%>
				   <tr><td colspan="4">����û�жԱ��˵����·��������<td></tr>	
<%	         end if%>
		 <table>	
			
		<!--��Ҫ�����������-->	
		</div>
	</div>	
	<!--ҳ���β��-->
	<div class="row border_red "><div class="">��Ȩ����</div></div>
</div>
<%end if%>
</body>
</html>