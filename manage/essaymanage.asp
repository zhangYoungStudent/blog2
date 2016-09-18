<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<script src="../../common/jquery-1.11.1.min.js"></script>
<script src="../../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
</head>
<!--#include file="../common.asp"-->
<body>
<%datebase="Development"
openconn conn,datebase

if request.QueryString("action")="apply" then
   sql="update L_zhang_blog_content set blog_qxian='1' where blog_id='"&request.QueryString("blog_id")&"'"
   conn.execute(sql)
end if
%>
<div>
<%
sql="select a.*,c.classify_name,b.username from L_zhang_blog_content a,L_zhang_blog_classify c,L_zhang_blog_username b where a.classify_id = c.classify_id and a.user_id = b.user_id and a.blog_qxian='0' order by a.publish_time"
openrs conn,rs,sql
rs.pagesize=10	   
curpage=request.QueryString("curpage") '获取页数，如果是其它页面过来的则curpage为空
if curpage="" then
	curpage=1
else
	rs.absolutepage=curpage  '将curpage指定为当前页
end if

if rs.recordcount=0 then
	response.write("<tr>暂时还没有未通过的文章</tr>")
else %>
<table class="table" >
	<!--需要到content中读取权限为0的文章，然后到分类表中读取类别，到username中读取作者名称-->
	<tr><th width="10%">类别</th><th width="10%">文章标题</th><th width="50%">文章内容</th>
		<th width="10%">作者</th><th width="10%">写作时间</th><th width="10%">审核</th>
	</tr>
	<%
	for i=1 to rs.pagesize 
		if rs.eof then 
			exit for
		end if %>
	<tr><td><%=rs("classify_name")%></td>
		<td><%=rs("blog_title")%></td>
		<td><% =Left(rs("blog_content"),50)%>...</td>
		<td><%=rs("username")%></td>
		<td><%=DateValue(rs("publish_time"))%></td>
		<td><a href="?action=apply&blog_id=<%=rs("blog_id")%>">通过</a></td>
	</tr>
	<%  rs.movenext '
	next%>
</table>
<ul class="pagination">
   <li><%=rs.pagecount%>总页数</li>
   <li><%=rs.recordcount%>总记录数</li>
   <li><%=curpage%>当前页</li>
<%  if curpage<>1 then%>
	<li><a href="?curpage=<%=curpage-1%>"><</a></li>
<%  end if%>
	
<%  if rs.pagecount>1 then '如果页数就一页的话，不用进行循环输出1页了
	 for i=1 to rs.pagecount%>
		<li><a href="?curpage=<%=i%>"><%=i%></a></li>
<%    next
   end if
   
	
   if rs.pagecount>=curpage+1 then%>
	<li><a href="classify.asp?curpage=<%=curpage+1%>">></a></li>
<%  end if%>
</ul>
<%
end if 
closers rs%>
</div>
<%closeconn conn%>
</body>
</html>
