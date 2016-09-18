<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%Option Explicit%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
</head>
<body>
<%
dim conn,rs,sql,count 'conn,rs,sql为连接数据库，conn为数据库中相应数据的条数
dim id,qxian,action 'id数据库中的唯一标示,qxian表示权限，0为普通员工,action为其他页面提交过来的标示，表示要执行什么样的操作
dim blog_title,classify_id,blog_content,blog_id,user_id,nowtime 'contetent表
dim email,username,psword,staff_number 'email为登录邮箱,psword为密码,username用户昵称,staff_number员工编号

dim inform
dim comment_id  'comment表
dim remail,rpsword,rusername,rstaff_number'定义正则变量量，

Sub openrs(conn,rs,sql)
	 set rs = Server.CreateObject("ADODB.Recordset")
	 rs.open sql,conn,1,1
End Sub
Sub closers(rs)
	 rs.close
	 set rs = nothing
End Sub

Sub CreatePageNumber(rs,CreatePageNumber_Page,url)
	RecordCount=rs.recordcount
	PageCount=rs.pagecount
	response.Write "&nbsp;总&nbsp;"&RecordCount&"&nbsp;条记录&nbsp;&nbsp;共&nbsp;"&PageCount&"&nbsp;页&nbsp;"
	NowStart=CreatePageNumber_Page-3
	if NowStart<1 then
		NowStart=1
	end if
	NowEnd=CreatePageNumber_Page+3
	if NowEnd>PageCount then
		NowEnd=PageCount
	end if
	if trim(url)<>"" then
		url="&"&url
	end if
	response.write "<a href='?T_Page=1"&url&"'>最前页</a>"
	for ipage=NowStart to NowEnd
		if cstr(ipage)=cstr(CreatePageNumber_Page) then
			response.write "&nbsp;<span style='color:#FF0000'>" & ipage &"</span>&nbsp;"
		else
			response.write "[<a href='?T_Page="&ipage&url&"'>" & ipage &"</a>]"
		end if
	next
	response.write "<a href='?T_Page="&PageCount&url&"'>最后页</a>"
End Sub

'正则判断函数
Function RegExpTest(patrn, strng)
  Dim regEx,result 'Match, Matches      ' 建立变量。
  Set regEx = New RegExp         ' 建立正则表达式。
  regEx.Pattern = patrn         ' 设置模式。
  regEx.IgnoreCase = True         ' 设置是否区分大小写。
  regEx.Global = True         ' 设置全程可用性。
  'Set Matches = regEx.Execute(strng)   ' 执行搜索。
  'For Each Match in Matches      ' 遍历 Matches 集合。
    'RetStr = RetStr & "匹配 " & I & " 位于 "
    'RetStr = RetStr & Match.FirstIndex & "。匹配的长度为"
    'RetStr = RetStr & Match.Length 
    'RetStr = RetStr & "个字符。" & vbCRLF
  'Next
  'RegExpTest = RetStr
   RegExpTest=regEx.Test(strng) 
End Function
'dim a
'a=RegExpTest("^\w{1,20}@\w{1,5}.\w{1,5}$", email)
'response.Write(a)
'response.Write(request.QueryString("action"))
action=trim(request.QueryString("action"))
set conn=server.CreateObject ("adodb.connection")
conn.ConnectionString = "Provider=sqloledb.1;Server=10.30.1.99;uid=dev;pwd=dev;DATABASE=Development;"
conn.Open 

select case action
case "denglu" '登录
        blog_id=request.QueryString("blog_id")
		'replace(trim(request("username")),"'","")

		email=replace(trim(Request("email")),"'","")
        psword=replace(trim(Request("psword")),"'","")

        remail=RegExpTest("^\w{1,20}@\w{1,5}.\w{1,5}$", email)
		rpsword=RegExpTest("^[0-9a-zA-Z_]{6}$", psword)
		if remail=0 or rpsword=0 then 
			response.write "用户名或密码错误"
            response.write "<a href='javascript:onclick=history.go(-1)'>返回</a>" 
		else
		    sql="select * from L_zhang_blog_username where email='"&email&"'"
		    openrs conn,rs,sql		
			count=rs.recordcount	
			if count=1 then
				if rs("psword")=psword then
					session("user_id")=rs("user_id")
					'用户登录的时候，可能是直接想进入后台，也可能是想发表评论才登陆的
					if blog_id<>"" then'不为空说明用户是从某一页点进来进行注册的
					      response.redirect "content.asp?blog_id="&blog_id
					end if
					
					if rs("qxian")=0 then				
						response.redirect "user.asp"
					elseif rs("qxian")=1 then 
						response.redirect "editor.asp"
					elseif rs("qxian")=2 then 
						response.redirect "manage.asp"
					end if
				else
					Response.Write("<script language='javascript'>alert('密码有误,请重新登录!');location.href='index.asp';</script>")
				end if
			else
				Response.Write("<script language='javascript'>alert('用户名有误,请重新登录!');location.href='index.asp';</script>")
			end if
			closers rs
		end if
case "login" '注册账号
        email=trim(request.form("email"))
		username=trim(request.form("username"))
		psword=trim(request.form("psword"))
		staff_number=trim(request.form("staff_number"))
		qxian=request.form("qxian")
		nowtime=Now
		'正则判断
		remail=RegExpTest("^\w{1,20}@\w{1,5}.\w{1,5}$", email)
		rusername=RegExpTest("^[\u4e00-\u9fa5]{1,6}$", username)
		rpsword=RegExpTest("^[0-9a-zA-Z_!@#$%^&*()+]{6,18}$", psword)
		rstaff_number=RegExpTest("^[0-9a-zA-Z_]{6}$", staff_number)

		if remail=0 or rusername=0 or rpsword=0 or rstaff_number=0 then 
			Response.Write("<script language='javascript'>alert('信息填写有误!');location.href='login.asp';</script>") 
		else

			sql="select * from L_zhang_blog_username where email='"&email&"'"
            openrs conn,rs,sql
			count=rs.recordcount
			closers rs
			if count<>"" then
				sql="insert into  L_zhang_blog_username (email,username,psword,qxian,staff_number,login_time) values ('"&email&"','"&username&"','"&psword&"','"&qxian&"','"&staff_number&"','"&nowtime&"')"
				conn.execute(sql)
				
				sql="select user_id from L_zhang_blog_username where email='"&email&"'"
				openrs conn,rs,sql
				user_id=rs("user_id")
				closers rs
				session("user_id")=user_id
				if qxian=0 then	
					Response.Write("<script language='javascript'>alert('注册成功!');location.href='user.asp';</script>")			
				elseif qxian=1 then
					Response.Write("<script language='javascript'>alert('注册成功!');location.href='editor.asp';</script>") 
				end if
			else
			    Response.Write("<script language='javascript'>alert('该注册邮箱已经存在，请重新注册!');location.href='login.asp';</script>")    
			end if
		end if		
case "apply" '申请修改权限
		'user_id 为普通用户申请成为作者权限，无需管理员通过,怎么才能做到让他申请之后直接跳转到作者的页面呢？？
		'blog_id为管理员批准审核通过的权限
		user_id=trim(request.QueryString("user_id"))
		blog_id=trim(request.QueryString("blog_id"))
		if user_id<>"" then
			sql="update L_zhang_blog_username set qxian='1' where user_id='"&user_id&"'"
			conn.execute(sql)
			Response.Write("<script language='javascript'>alert('申请成功!');location.href='index.asp';</script>")
		'elseif blog_id<>"" then
'			sql="update L_zhang_blog_content set blog_qxian='1' where blog_id='"&blog_id&"'"
'			conn.execute(sql)
'			Response.redirect "manage.asp"
		end if
case "publish" '作者发表文章
        blog_title=trim(request.form("blog_title"))
		classify_id=trim(request.form("classify_id"))
		blog_content=trim(request.form("blog_content"))
		nowtime=Now
		user_id=trim(request.form("user_id"))
	    sql="insert into  L_zhang_blog_content (user_id,classify_id,blog_title,blog_content,publish_time) values ('"&user_id&"','"&classify_id&"','"&blog_title&"','"&blog_content&"','"&nowtime&"')"
        conn.execute(sql)
        Response.Write("<script language='javascript'>alert('添加成功!');location.href='editor.asp';</script>")

case "modify"        
		user_id=trim(request.QueryString("user_id")) '使用get获取要修改的id
		inform=trim(request.QueryString("inform"))'inform为inform时执行资料修改，为psword时执行密码修改
			
		if inform="inform" then
           'sex,hobby,psword为修改资料提交过来的三个字段
		   sql="update L_zhang_blog_username set sex='"&request.form("sex")&"',hobby='"&request.form("hobby")&"'where user_id='"&user_id& "'"
		   conn.execute(sql)
		   Response.Write("<script language='javascript'>location.href='inform.asp';</script>")
		elseif  inform="psword" then '首先验证旧密码是否正确，然后验证两次输入的新密码是否一致
		   dim oldpsword,newpsword,secondpsword
		   oldpsword=trim(request.form("oldpsword"))
		   newpsword=trim(request.form("newpsword"))
		   secondpsword=trim(request.form("secondpsword"))
		   
		   sql="select * from L_zhang_blog_username where user_id='"&user_id&"'"
		   openrs conn,rs,sql
		   if rs("psword")=oldpsword then
		      if newpsword=secondpsword then
			     sql="update L_zhang_blog_username set psword='"&newpsword&"' where user_id='"&user_id& "'"
		         conn.execute(sql)
				 Response.Write("<script language='javascript'>location.href='inform.asp';</script>")
			  else
			     Response.Write("<script language='javascript'>alert('输入的两遍新密码不正确');location.href='inform.asp';</script>")
			  end if
		   else
		      Response.Write("<script language='javascript'>alert('输入的旧密码不正确');location.href='inform.asp';</script>")
		   end if    
		end if
case "comment" 	'添加评论
         dim comment_content	 
		 blog_id=request.QueryString("blog_id")
		 user_id=session("user_id")
		 comment_content=trim(request.form("comment_content"))
		 nowtime=Now
		 sql="insert into  L_zhang_blog_comment (blog_id,user_id,comment_content,comment_time) values ('"&blog_id&"','"&user_id&"','"&comment_content&"','"&nowtime&"')"
		 conn.execute(sql)
		 response.redirect "content.asp?blog_id="&blog_id
	
case "del"
		comment_id=trim(request.QueryString("comment_id"))
		qxian=trim(request.QueryString("qxian"))'
		blog_id=trim(request.QueryString("blog_id"))
		if comment_id<>"" then	
			sql="delete from L_zhang_blog_comment where comment_id='"& comment_id & "'"
			conn.execute(sql)
			'删除数据的可能是游客页面，也可能是作者页面怎么回到具体的页面呢
			if qxian=0 then				
					response.redirect "user.asp"
			elseif qxian=1 then 
					response.redirect "editor.asp"
			end if
		elseif blog_id <>"" then
			 sql="delete from L_zhang_blog_content where blog_id='"& blog_id & "'"
			 conn.execute(sql)
			'删除数据的可能是作者页面,也可能是编辑，这里为编辑留了一个后台，实际上不制作编辑删除按钮
			if qxian=1 then				
					response.redirect "editor.asp"
			elseif qxian=2 then 
					response.redirect "manage.asp"
			end if
		end if
case "ajax"
	  email=request.QueryString("email")
	  remail=RegExpTest("^\w{1,20}@\w{1,5}.\w{1,5}$", email)
	  if remail=-1 then
	  sql="select * from L_zhang_blog_username where email='"&email&"'"
		  openrs conn,rs,sql
		  count=rs.recordcount
		  if count>0 then
			 response.write("该邮箱已经存在,请选择其他邮箱")
		  else
			 response.write("该邮箱可以使用")
		  end if
		  closers rs
	  elseif remail=0 then
	      response.write("格式不正确")
	  end if
case else
    response.Write("数据有误，请联系管理员")
end select
conn.close
set conn=nothing
%>
</body>
</html>
