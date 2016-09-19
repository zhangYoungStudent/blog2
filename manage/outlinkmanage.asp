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
	
	$("#slogan_set_a").click(function(){
	  $("#slogan_set_a").addClass("active");
	  $("#slogan_add_a").removeClass("active"); 
	  $("#slogan_set").show();
	  $("#slogan_add").hide();
	});
	
	$("#slogan_add_a").click(function(){
	  $("#slogan_add_a").addClass("active");
	  $("#slogan_set_a").removeClass("active"); 
	  $("#slogan_add").show();
	  $("#slogan_set").hide();
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

'本页面进行标语的添加，修改，删除的操作，所以要进行判断
action=trim(request.QueryString("action"))
dim link_name,link_qxian,link_id,link_url,link_time
select case action
case "del" 
   sql="delete from L_zhang_blog_link where link_id='"& request.QueryString("link_id") & "'"
   conn.execute(sql)
case "add"
	link_name=trim(request.form("link_name"))
	link_qxian=trim(request.form("link_qxian"))
	link_url=trim(request.form("link_url"))
	link_time=trim(request.form("link_time"))
	sql="insert into  L_zhang_blog_link (link_name,link_url,link_time,link_qxian) values ('"&link_name&"','"&link_url&"'','"&link_time&"','"&link_qxian&"')"
	conn.execute(sql)
case "update" 
     link_name=trim(request.form("link_name"))
     link_id=trim(request.form("link_id"))
	 link_qxian=trim(request.form("link_qxian"))
     sql="update L_zhang_blog_link set link_name='"&link_name&"',link_qxian='"&link_qxian&"' where link_id='"&link_id&"'"
	 conn.execute(sql)
end select
%>



<div>
    <ul class="nav nav-tabs">
		<li class="active" id="slogan_set_a"><a href="#">管理</a></li>
		<li id="slogan_add_a"><a href="#">添加</a></li>
	</ul>
	<div id="slogan_set" style="border:1px solid red">
		<table class="table" >
			<tr><th width="3%">序号</th><th width="10%">连接名称</th><th width="5%">连接url</th><th width="10%">权限</th><th width="10%">修改</th><th width="5%">删除</th>
			</tr>
				<%sql="select * from L_zhang_blog_link" 
				 openrs conn,rs,sql
				 i=1
				 while not rs.eof %>
			<tr><td align="center"><%=(rs.absolutepage-1)*rs.pagesize+i %></td>
			    <td><%=rs("link_name")%></td>
				<td><%=rs("link_url")%></td>
				<td><%=rs("link_qxian")%></td>
				<td><a href="?link_id=<%=rs("link_id")%>&link_name=<%=rs("link_name")%>&link_url=<%=rs("link_url")%>&link_qxian=<%=rs("link_qxian")%>" class="modi">修改</a></td>
				<td><a href="?action=del&link_id=<%=rs("link_id")%>">删除</a></td>
			</tr>
		<%         i=i+1
		          rs.movenext '
				 wend
				 closers rs%>
		</table>
	</div>
	<div id="slogan_add">
		<form action="?action=add" method="post">
		   <textarea name="link_name" placeholder="名称"></textarea>
		   <textarea name="link_url" placeholder="http://www.xxx.com"></textarea>
		   <select name="link_qxian"><option value="0">0</option><option value="1">1</option></select>
		   <input type="submit" value="添加">			
		</form>
	</div>
	
<%closeconn conn%>

</div>


<%if  request.QueryString("link_id")<>"" then
 link_id=request.QueryString("link_id")
 link_name=request.QueryString("link_name")
 link_url=request.QueryString("link_url")
 link_qxian=request.QueryString("link_qxian")
%>
<div class="modal show">
		<div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Modal title<%=link_id%></h4>
		  </div>
		  <div class="modal-body">
			<form action="?action=update"  method="post" name="form">
			      <input name="link_name" value="<%=link_name%>"/>
				  <input name="link_url" value="<%=link_url%>"/>
				  <select name="link_qxian"><option value="0">0</option><option value="1">1</option></select>
				  <input name="link_id" value="<%=link_id%>" hidden/>
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
