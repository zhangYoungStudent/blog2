<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<style>
.blog_content_content .article_nav {height: 38px;background:#F6F6F6;}
.blog_content_content .article .pagination {margin: 3px 0 0 10px;}
.blog_content_content .article .article_nav_page {float:left;border: 1px solid #ddd;height:33px;border-radius: 4px;background-color: #fff;margin:3px 0 0 10px;padding:0 4px;}
.blog_content_content .article .article_nav_page span{float:left;margin-top:6px;padding:0 3px;}
</style>
<script src="../../common/jquery-1.11.1.min.js"></script>
<script src="../../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
</head>
<!--#include file="../common.asp"-->
<body>
<%datebase="Development"
openconn conn,datebase%>
<div>
	<table class="table" >
	 <caption>查看作者信息</caption>
	 <!--只需到username中读取1权限的用户,然后根据user_id去comment表中统计发表的数量，去content中统计发表文章的数量-->
	 <tr><th>作者昵称</th><th>邮箱</th><th>员工编号</th><th>性别</th><th>注册时间</th><th>发表评论数量</th><th>发表文章数量</th></tr>
	<%		     
	 sql="select * from L_zhang_blog_username where qxian=1"
	 openrs conn,rs,sql
	 rs.pagesize=10	   
		 curpage=request.QueryString("curpage") '获取页数，如果是其它页面过来的则curpage为空
		 if curpage="" then
			curpage=1
		 else
			rs.absolutepage=curpage  '将curpage指定为当前页
		 end if
		 
		for i=1 to rs.pagesize 
			   if rs.eof then 
				  exit for
			   end if %>
			<tr><td><%=rs("username")%></td>
				<td><%=rs("email")%></td>
				<td><%=rs("staff_number")%></td>
				<td><%=rs("sex")%></td>
				<td><%=rs("login_time")%></td>
				<td><%sql="select count(comment_id) as count from L_zhang_blog_comment where user_id='"&rs("user_id")&"'"	
					   openrs conn,rs1,sql
					   count=rs1("count")
					   closers rs1
					   response.Write(count)
					   %>
				</td>
				<td><%sql="select count(blog_id) as count from L_zhang_blog_content where user_id='"&rs("user_id")&"'"	
					   openrs conn,rs1,sql
					   count=rs1("count")
					   closers rs1
					   response.Write(count)
					   %>
				</td>
			</tr>
	<%                  rs.movenext '
		  next%>
	</table>
	<%createpage actionurl,curpage,rs %>
</div>
	<%closers rs
closeconn conn%>
</body>
</html>
