<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<link href="css/base.css" rel="stylesheet" />
<link href="css/test.css" rel="stylesheet" />
<link href="css/content.css" rel="stylesheet" />
<script src="../common/jquery-1.11.1.min.js"></script>
<script src="../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<title>MAXXIS������������ҳ��</title>
</head>
<!--#include file="common.asp"-->
<body>
<% 
datebase="Development"
openconn conn,datebase 
%>
<!--#include file="common/blog_nav.asp"-->
<div class="blog_header">
	<!--#include file="common/header.asp"-->
	<div class="blog_header_bottom container">
		<div><img alt="" src="../usermanage/img/003.jpg"/></div>
	</div>
</div>
	
<div class="blog_content container"><!--ҳ�����Ҫ������Ϣ,��Ϊ��Ҫ���ݺͲ��������-->
		<div class="blog_content_aside">
			<!--�������һ���֣��û�������������-->
			<div class="aside_search">
				<form action="list.asp?action=search" name="" class="" method="post">
					<select name="identify" class="search_select" >
						 <option value="author">����</option><option value="title">���±���</option>
					</select>
					<input type="text" name="searchkeyword" class="search_text" autocomplete="off">
					<input type="submit" value="sea" class="search_btn">
				</form>
			</div>
			<!--��������Ĳ��֣������������·���-->
			<div class="panel panel-success border_red clear aside_classify">
			    <div class="panel-heading">�������·���</div> 
				<div class="list-group ">
				<%
			    sql="select c.classify_name,count(a.classify_id) as count from L_zhang_blog_classify c left join L_zhang_blog_content a   on a.classify_id=c.classify_id group by c.classify_name"
			    openrs conn,rs,sql
				while not rs.eof %>
				    <a href="list.asp?action=classify&classify_name=<%=rs("classify_name")%>" class="list-group-item">
					<span class="badge"><%=rs("count")%></span><%=rs("classify_name")%>
					</a>
				<% rs.movenext '
					wend
				closers rs
				%>
				</div>
			</div>
        
		</div><!--���������-->
			
		<!--������������-->
		<div class="blog_content_main">
	   <%   dim blog_id
	        blog_id=request.QueryString("blog_id")
	        if blog_id="" then '���Ϊ��˵�����û���ֱ�ӽ������ҳ�棬ֱ����ת������ҳ��
			   response.Redirect("list.asp")
			end if 
			sql="select a.*,b.username,c.classify_name from L_zhang_blog_content a,L_zhang_blog_username b,L_zhang_blog_classify c where a.user_id = b.user_id and a.classify_id=c.classify_id and blog_id='"&blog_id&"'"
			openrs conn,rs,sql
			
			blog_id=rs("blog_id")
			count=rs.recordcount
			dim read_time
			read_time=rs("read_time")
			
'			if request.cookies("blog_id")="" then
'			     read_time=read_time+1   '���Ķ���+1  
'			     response.cookies("blog_id")=true
'			end if
				%>
		   <!--���м����-->
		   <ul class="breadcrumb">
				<li><a href="index.asp">��ҳ</a></li>
				<li><a href="list.asp?action=classify&classify_name=<%=rs("classify_name")%>"><%=rs("classify_name")%></a></li>
				<li><%=rs("blog_title")%></li>
			</ul>		   

		    <div class="panel panel-default border_red main_article"><!--�����������µ���ʽ֮��-->
		         
			<%	if count<>"" then  %>
			        <div class="panel-heading title"><h4><%=rs("blog_title")%></h4></div>
					<div class="panel-body">
					<small><%=rs("publish_time")%></small>
					<small><%=rs("username")%></small>
					<small>�Ķ���(<%=read_time%>)</small>
					
			<%
					dim blog_content,lenght,wordcount,page,curpage,acurpage
					blog_content=rs("blog_content") '��ƪ�������µ�����
					lenght=Len(blog_content)'��ƪ�������µ�����
					  sql="select value from L_zhang_blog_set where name='wordnumber'"
			          openrs conn,rs1,sql
					  wordcount=rs1("value") 'Ԥ��ÿҳ��ʾ������
					  closers rs1
					page=Int(lenght/wordcount) '���м�ҳ����
						
					acurpage=request.QueryString("curpage")
					if acurpage<>"" then
					   curpage=acurpage
					elseif acurpage>page then '����ǰҳ�����ԭ�е�ҳ��ʱ��ֱ����ת����һҳ
					   curpage=1
					else 
					   curpage=1
					end if  %>
					      <p><% =Mid(blog_content,wordcount*(curpage-1)+1,wordcount)%></p>
					</div>
			<%		if page>1 then   '���ҳ����0 ����1������ʾ����ķ�ҳ���Ӱ�ť %>
					   <ul class="pagination">
					   <% for i=1 to page %>
					       <li><a href="?blog_id=<%=blog_id%>&curpage=<%=i%>">��<%=i%>ҳ</a></li>
					   <% next %>
					   </ul>
					<%end if					
			    else
					 response.redirect "list.asp?action=newest"
				end if  %>
	        </div>
			<%
		    closers rs
			
			'�������µ��Ķ�����ֻ������������ʾ�����µ��Ķ������ܸ��³ɹ�	
			sql="update  L_zhang_blog_content set read_time ='"&read_time&"' where blog_id='"&blog_id& "'"
			conn.execute(sql)%>	   
		<!--���������������-->	
		</div>	
	
	<div class="container blog_comment border_red clear">
		<!--������-->
		<%if session("user_id")<>"" then %>
			 <!--�������������ύ��-->
			<form class="form-horizontal border_red" role="form" action="deal.asp?action=comment&blog_id=<%=blog_id%>" method="post">
				 <div class="form-group">
					  <label for="" class="col-sm-2 control-label">��������</label>
					  <div class="col-sm-8">
						 <textarea   class="form-control" name="comment_content"></textarea>
						 <input type="submit" value="��������" class="btn btn-primary  btn-xs " >
					  </div>    
				 </div>	
			</form>
		<%else %> 
			<div ><p>���Ҫ������<a href="login.asp?blog_id=<%=blog_id%>">��¼</a></p></div>
		<%end if%>
			<table class="table">
				 <tr><th>��������</th><th>������</th><th>��������</th></tr>
				 <%
					set rs = Server.CreateObject("ADODB.Recordset")
					sql="select d.*,b.username from L_zhang_blog_comment d,L_zhang_blog_username b where d.user_id = b.user_id and blog_id='"&blog_id&"'"   
					rs.open sql,conn,1,1
					count=rs.recordcount
					if count<>0 then
					while not rs.eof		
				 %>
				 <tr><td><%=rs("comment_time")%></td><td><%=rs("username")%></td><td><%=rs("comment_content")%></td></tr>
				 <% rs.movenext '
					wend
					rs.close
					set rs=nothing
				 else%>
					   <tr><td></td><td></td><td>��ʱ��û�����ۣ��м���ɳ����</td></tr>
				 <%end if%>
			</table>
    </div>
</div>   
<!--ҳ���β����һ���ַ��ð�Ȩ����Ϣ����һ���ַ���һ�仰����-->
<!--#include file="common/footer.asp"-->
<%closeconn conn %>
</body>
</html>
