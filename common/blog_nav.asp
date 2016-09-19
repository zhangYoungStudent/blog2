<%
'如果session不为空说明，它之前进入过后台，这是需要读取账号的信息，并显示在账号信息导航栏目中
if session("user_id")<>"" then
   sql="select username,qxian from L_zhang_blog_username where user_id='"&session("user_id")&"'"
   openrs conn,rs,sql
   dim username,sex,url
   username=rs("username")
   qxian=rs("qxian")
   closers rs
   if qxian=0 then 
	   url="user.asp" 
   elseif qxian=1 then 
	   url="editor.asp" 
   else 
       url="manage.asp" 
   end if
%>
<div class="blog_nav">
     <div class="container">
		<div class="logoname">maxxis</div>
		<div class="loginname"><%=username%>您好</div>
		<ul><li><a href="index.asp"><span class="glyphicon glyphicon-home"></span></a></li>
			<li><a href="<%=url%>"><span class="glyphicon glyphicon-cog"></span></a></li>
			<li><a href="inform.asp"><span class="glyphicon glyphicon-user"></span></a></li>
			<li><a href="logout.asp"><span class="glyphicon glyphicon-off"></span></a></li>
		</ul>
	 </div>
</div>
<%
end if
%>