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
curpage=request.QueryString("curpage") '��ȡҳ�������������ҳ���������curpageΪ��
if curpage="" then
	curpage=1
else
	rs.absolutepage=curpage  '��curpageָ��Ϊ��ǰҳ
end if

if rs.recordcount=0 then
	response.write("<tr>��ʱ��û��δͨ��������</tr>")
else %>
<table class="table" >
	<!--��Ҫ��content�ж�ȡȨ��Ϊ0�����£�Ȼ�󵽷�����ж�ȡ��𣬵�username�ж�ȡ��������-->
	<tr><th width="10%">���</th><th width="10%">���±���</th><th width="50%">��������</th>
		<th width="10%">����</th><th width="10%">д��ʱ��</th><th width="10%">���</th>
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
		<td><a href="?action=apply&blog_id=<%=rs("blog_id")%>">ͨ��</a></td>
	</tr>
	<%  rs.movenext '
	next%>
</table>
<ul class="pagination">
   <li><%=rs.pagecount%>��ҳ��</li>
   <li><%=rs.recordcount%>�ܼ�¼��</li>
   <li><%=curpage%>��ǰҳ</li>
<%  if curpage<>1 then%>
	<li><a href="?curpage=<%=curpage-1%>"><</a></li>
<%  end if%>
	
<%  if rs.pagecount>1 then '���ҳ����һҳ�Ļ������ý���ѭ�����1ҳ��
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
