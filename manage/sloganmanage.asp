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
dim slogan_content,slogan_author,slogan_quote,slogan_qxian,slogan_id
select case action
case "del" 
   sql="delete from L_zhang_blog_slogan where slogan_id='"& request.QueryString("slogan_id") & "'"
   conn.execute(sql)
case "addslogan"
	slogan_content=trim(request.form("slogan_content"))
	slogan_author=trim(request.form("slogan_author"))
	slogan_quote=trim(request.form("slogan_quote"))
	slogan_qxian=trim(request.form("slogan_qxian"))
	sql="insert into  L_zhang_blog_slogan (slogan_content,slogan_author,slogan_quote,slogan_qxian) values ('"&slogan_content&"','"&slogan_author&"','"&slogan_quote&"','"&slogan_qxian&"')"
	conn.execute(sql)
case "update" 
     slogan_content=trim(request.form("slogan_content"))
     slogan_id=trim(request.form("slogan_id"))
     sql="update L_zhang_blog_slogan set slogan_content='"&slogan_content&"' where slogan_id='"&slogan_id&"'"
	 conn.execute(sql)
end select
%>



<div>
    <ul class="nav nav-tabs">
		<li class="active" id="slogan_set_a"><a href="#">标语管理</a></li>
		<li id="slogan_add_a"><a href="#">添加标语</a></li>
	</ul>
	<div id="slogan_set" style="border:1px solid red">
		<table class="table" >
			<tr><th width="3%">序号</th><th width="10%">标语内容</th><th width="10%">标语作者</th>
			    <th width="10%">标语出处</th><th width="5%">标语权限</th><th width="10%">修改内容</th><th width="5%">删除</th>
			</tr>
				<%sql="select * from L_zhang_blog_slogan" 
				 openrs conn,rs,sql
				 i=1
				 while not rs.eof %>
			<tr><td align="center"><%=(rs.absolutepage-1)*rs.pagesize+i %></td>
			    <td><%=rs("slogan_content")%></td>
				<td><%=rs("slogan_author")%></td>
				<td><%=rs("slogan_quote")%></td>
				<td><%=rs("slogan_qxian")%></td>
				<td><a href="?slogan_id=<%=rs("slogan_id")%>&slogan_content=<%=rs("slogan_content")%>" class="modi">修改</a></td>
				<td><a href="?action=del&slogan_id=<%=rs("slogan_id")%>">删除</a></td>
			</tr>
		<%         i=i+1
		          rs.movenext '
				 wend
				 closers rs%>
		</table>
	</div>
	<div id="slogan_add">
		<form action="?action=addslogan" method="post">
		   <textarea name="slogan_content" placeholder="标语内容"></textarea>
		   <input type="text" name="slogan_author" placeholder="标语作者">
		   <input type="text" name="slogan_quote" placeholder="标语出处">
		   <select name="slogan_qxian" id="select"><option value="0">0</option><option value="1">1</option></select>
		   <input type="submit" value="添加标语">			
		</form>
	</div>
	
<%closeconn conn%>

</div>


<%if  request.QueryString("slogan_id")<>"" then
 slogan_id=request.QueryString("slogan_id")
 slogan_content=request.QueryString("slogan_content")

%>
<div class="modal show">
		<div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Modal title<%=slogan_id%></h4>
		  </div>
		  <div class="modal-body">
			<form action="?action=update"  method="post" name="form">
			      <input name="slogan_content" value="<%=slogan_content%>"/>
				  <input name="slogan_id" value="<%=slogan_id%>" hidden/>
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
