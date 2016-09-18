<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../../common/bootstrap-3.3.5/dist/css/bootstrap.css" rel="stylesheet" />
<style>
.displaynone {display:none;}
</style>
<script src="../../common/jquery-1.11.1.min.js"></script>
<script src="../../common/bootstrap-3.3.5/dist/js/bootstrap.js"></script>
<script>
$("document").ready(function(){
	
	$("#blog_set_a").click(function(){
	  $("#blog_set_a").addClass("active");
	  $("#blog_classify_a").removeClass("active"); 
	  $("#blog_set").show();
	  $("#blog_classify").hide();
	});
	
	$("#blog_classify_a").click(function(){
	  $("#blog_classify_a").addClass("active");
	  $("#blog_set_a").removeClass("active"); 
	  $("#blog_classify").show();
	  $("#blog_set").hide();
	});
	
	//控制弹幕的隐藏和显示
	$(".modi").click(function(){
		   $(".modal").removeClass("hide").addClass("show");
		   $(".modal-body input").val(<%=request.QueryString("slogan_id")%>);
		});
		
		$(".btn-default,.close,.btn-primary").click(function(){
		   $(".modal").removeClass("show").addClass("hide");
		});
	
});

</script>
</head>
<!--#include file="../common.asp"-->
<body>
<%datebase="Development"
openconn conn,datebase
action=trim(request.QueryString("action"))
'本页面进行博客文章的分类修改，分类添加，修改博客的名称，修改博客的简介，所以要进行判断
select case action
case "del" 
   sql="delete from L_zhang_blog_classify where classify_id='"& request.QueryString("classify_id") & "'"
   conn.execute(sql)
case "update" 
     classify_name=trim(request.form("classify_name"))
     classify_id=trim(request.form("classify_id"))
     sql="update L_zhang_blog_classify set classify_name='"&classify_name&"' where classify_id='"&classify_id&"'"
	 conn.execute(sql)
case "addclassify"
	 classify_name=trim(request.form("classify_name"))
	 sql="select * from L_zhang_blog_classify where classify_name='"&classify_name&"'"
	 openrs conn,rs,sql
	 if rs.recordcount="" then '条数为0 说明数据库中不存在
		nowtime=Now
		sql="insert into  L_zhang_blog_classify (classify_name,classify_time) values ('"&classify_name&"','"&nowtime&"')"
		conn.execute(sql)
	 end if
case "blogset" 	'设置博客的样式，列表的条数，文章每页的字数
        dim blogset,classify_name,blog_classifynumber,blog_wordnumber
		blogset=request.QueryString("blogset")
		
		if blogset="blog_classifynumber" then
		   blog_classifynumber=trim(request.form("blog_classifynumber"))
		   sql="update L_zhang_blog_classifynumber set blog_classifynumber='"&blog_classifynumber&"'"
		   conn.execute(sql)
		elseif blogset="blog_wordnumber" then
		   blog_wordnumber=trim(request.form("blog_wordnumber"))
		   sql="update L_zhang_blog_wordnumber set blog_wordnumber='"&blog_wordnumber&"'"
		   conn.execute(sql)
		end if
end select
%>
<div>
	<ul class="nav nav-tabs">
		<li class="active" id="blog_classify_a"><a href="#">分类管理</a></li>
		<li id="blog_set_a"><a href="#">博客设置</a></li>
	</ul>

	<div id="blog_classify">
		<table class="table" >
			<tr><td>序列号</td><th>文章类别</th><th>修改</th><th>删除</th></tr>
		<%		     
		 sql="select * from L_zhang_blog_classify" 
		 openrs conn,rs,sql
		 i=1
		 while not rs.eof %>
				<tr>
				    <td><%=(rs.absolutepage-1)*rs.pagesize+i %></td>
				    <td><%=rs("classify_name")%></td>
					<td><a href="?classify_id=<%=(rs.absolutepage-1)*rs.pagesize+i %>&classify_name=<%=rs("classify_name")%>" class="modi">修改</a></td>
					<td><a href="?action=del&classify_id="<%=rs("classify_id")%>>删除</a></td>
				</tr>
		<%   i=i+1            
		    rs.movenext '
		 wend
		 closers rs%>
		</table>
		<form action="?action=addclassify" method="post">
		   <input type="text" name="classify_name" placeholder="不要与已有的重复">
		   <input type="submit" value="添加分类">			
		</form>
	</div>

	<div class="displaynone" id="blog_set">
		<h3>博客设置</h3>
		<form action="?action=blogset&blogset=blog_wordnumber" method="post">
		   <input type="text" name="blog_wordnumber" placeholder="博客每页字数">
		   <input type="submit" value="确认修改">			
		</form>
		
		<form action="?action=blogset&blogset=blog_classifynumber" method="post">
		   <input type="text" name="blog_classifynumber" placeholder="博客列表的条数">
		   <input type="submit" value="确认修改">			
		</form>
    </div>
</div>	
<%closeconn conn%>


<%if  request.QueryString("classify_id")<>"" then
 classify_id=request.QueryString("classify_id")
 classify_name=request.QueryString("classify_name")
%>
<div class="modal show">
		<div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">序列号<%=classify_id%></h4>
		  </div>
		  <div class="modal-body">
			<form action="?action=update"  method="post" name="form">
			      <input name="classify_name" value="<%=classify_name%>"/>
				  <input name="classify_id" value="<%=classify_id%>" hidden/>
		  </div>
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="submit" class="btn btn-primary" for="form">确认修改</button>
		  </div>
		  </form>	
		</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<%end if%>
</body>
</html>
