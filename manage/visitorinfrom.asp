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
openconn conn,datebase%>
<div>
	<table class="table">
		 <tr><th>�û���</th><th>����</th><th>Ա�����</th><th>�Ա�</th><th>ע��ʱ��</th><th>������������</th></tr>
		<%
		 dim curpage
		 sql="select * from L_zhang_blog_username where qxian=0"
		 openrs conn,rs,sql
		 
		 rs.pagesize=10	   
		 curpage=request.QueryString("curpage") '��ȡҳ�������������ҳ���������curpageΪ��
		 if curpage="" then
			curpage=1
		 else
			rs.absolutepage=curpage  '��curpageָ��Ϊ��ǰҳ
		 end if
			 
		for i=1 to rs.pagesize 
		   if rs.eof then 
			  exit for
		   end if %>
		<tr><td><%=rs("username")%></td>
			<td><%=rs("email")%></td>
			<td><%=rs("staff_number")%></td>
			<td><%=rs("sex")%></td>
			<td><%=DateValue(rs("login_time"))%></td>
			<td><%sql="select count(comment_id) as count from L_zhang_blog_comment where user_id='"&rs("user_id")&"'"	
				   openrs conn,rs1,sql
				   count=rs1("count")
				   closers rs1
				   response.Write(count)
				   %>
			</td>
		</tr>
		<%  rs.movenext '
		next%>
	</table>
	<%createpage actionurl,curpage,rs %>
</div>
	<%closers rs
closeconn conn%>
</body>
</html>
