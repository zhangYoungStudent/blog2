<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%Option Explicit%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
</head>
<body>
<%
dim conn,rs,sql,count 'conn,rs,sqlΪ�������ݿ⣬connΪ���ݿ�����Ӧ���ݵ�����
dim id,qxian,action 'id���ݿ��е�Ψһ��ʾ,qxian��ʾȨ�ޣ�0Ϊ��ͨԱ��,actionΪ����ҳ���ύ�����ı�ʾ����ʾҪִ��ʲô���Ĳ���
dim blog_title,classify_id,blog_content,blog_id,user_id,nowtime 'contetent��
dim email,username,psword,staff_number 'emailΪ��¼����,pswordΪ����,username�û��ǳ�,staff_numberԱ�����

dim inform
dim comment_id  'comment��
dim remail,rpsword,rusername,rstaff_number'���������������

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
	response.Write "&nbsp;��&nbsp;"&RecordCount&"&nbsp;����¼&nbsp;&nbsp;��&nbsp;"&PageCount&"&nbsp;ҳ&nbsp;"
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
	response.write "<a href='?T_Page=1"&url&"'>��ǰҳ</a>"
	for ipage=NowStart to NowEnd
		if cstr(ipage)=cstr(CreatePageNumber_Page) then
			response.write "&nbsp;<span style='color:#FF0000'>" & ipage &"</span>&nbsp;"
		else
			response.write "[<a href='?T_Page="&ipage&url&"'>" & ipage &"</a>]"
		end if
	next
	response.write "<a href='?T_Page="&PageCount&url&"'>���ҳ</a>"
End Sub

'�����жϺ���
Function RegExpTest(patrn, strng)
  Dim regEx,result 'Match, Matches      ' ����������
  Set regEx = New RegExp         ' ����������ʽ��
  regEx.Pattern = patrn         ' ����ģʽ��
  regEx.IgnoreCase = True         ' �����Ƿ����ִ�Сд��
  regEx.Global = True         ' ����ȫ�̿����ԡ�
  'Set Matches = regEx.Execute(strng)   ' ִ��������
  'For Each Match in Matches      ' ���� Matches ���ϡ�
    'RetStr = RetStr & "ƥ�� " & I & " λ�� "
    'RetStr = RetStr & Match.FirstIndex & "��ƥ��ĳ���Ϊ"
    'RetStr = RetStr & Match.Length 
    'RetStr = RetStr & "���ַ���" & vbCRLF
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
case "denglu" '��¼
        blog_id=request.QueryString("blog_id")
		'replace(trim(request("username")),"'","")

		email=replace(trim(Request("email")),"'","")
        psword=replace(trim(Request("psword")),"'","")

        remail=RegExpTest("^\w{1,20}@\w{1,5}.\w{1,5}$", email)
		rpsword=RegExpTest("^[0-9a-zA-Z_]{6}$", psword)
		if remail=0 or rpsword=0 then 
			response.write "�û������������"
            response.write "<a href='javascript:onclick=history.go(-1)'>����</a>" 
		else
		    sql="select * from L_zhang_blog_username where email='"&email&"'"
		    openrs conn,rs,sql		
			count=rs.recordcount	
			if count=1 then
				if rs("psword")=psword then
					session("user_id")=rs("user_id")
					'�û���¼��ʱ�򣬿�����ֱ��������̨��Ҳ�������뷢�����۲ŵ�½��
					if blog_id<>"" then'��Ϊ��˵���û��Ǵ�ĳһҳ���������ע���
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
					Response.Write("<script language='javascript'>alert('��������,�����µ�¼!');location.href='index.asp';</script>")
				end if
			else
				Response.Write("<script language='javascript'>alert('�û�������,�����µ�¼!');location.href='index.asp';</script>")
			end if
			closers rs
		end if
case "login" 'ע���˺�
        email=trim(request.form("email"))
		username=trim(request.form("username"))
		psword=trim(request.form("psword"))
		staff_number=trim(request.form("staff_number"))
		qxian=request.form("qxian")
		nowtime=Now
		'�����ж�
		remail=RegExpTest("^\w{1,20}@\w{1,5}.\w{1,5}$", email)
		rusername=RegExpTest("^[\u4e00-\u9fa5]{1,6}$", username)
		rpsword=RegExpTest("^[0-9a-zA-Z_!@#$%^&*()+]{6,18}$", psword)
		rstaff_number=RegExpTest("^[0-9a-zA-Z_]{6}$", staff_number)

		if remail=0 or rusername=0 or rpsword=0 or rstaff_number=0 then 
			Response.Write("<script language='javascript'>alert('��Ϣ��д����!');location.href='login.asp';</script>") 
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
					Response.Write("<script language='javascript'>alert('ע��ɹ�!');location.href='user.asp';</script>")			
				elseif qxian=1 then
					Response.Write("<script language='javascript'>alert('ע��ɹ�!');location.href='editor.asp';</script>") 
				end if
			else
			    Response.Write("<script language='javascript'>alert('��ע�������Ѿ����ڣ�������ע��!');location.href='login.asp';</script>")    
			end if
		end if		
case "apply" '�����޸�Ȩ��
		'user_id Ϊ��ͨ�û������Ϊ����Ȩ�ޣ��������Աͨ��,��ô����������������֮��ֱ����ת�����ߵ�ҳ���أ���
		'blog_idΪ����Ա��׼���ͨ����Ȩ��
		user_id=trim(request.QueryString("user_id"))
		blog_id=trim(request.QueryString("blog_id"))
		if user_id<>"" then
			sql="update L_zhang_blog_username set qxian='1' where user_id='"&user_id&"'"
			conn.execute(sql)
			Response.Write("<script language='javascript'>alert('����ɹ�!');location.href='index.asp';</script>")
		'elseif blog_id<>"" then
'			sql="update L_zhang_blog_content set blog_qxian='1' where blog_id='"&blog_id&"'"
'			conn.execute(sql)
'			Response.redirect "manage.asp"
		end if
case "publish" '���߷�������
        blog_title=trim(request.form("blog_title"))
		classify_id=trim(request.form("classify_id"))
		blog_content=trim(request.form("blog_content"))
		nowtime=Now
		user_id=trim(request.form("user_id"))
	    sql="insert into  L_zhang_blog_content (user_id,classify_id,blog_title,blog_content,publish_time) values ('"&user_id&"','"&classify_id&"','"&blog_title&"','"&blog_content&"','"&nowtime&"')"
        conn.execute(sql)
        Response.Write("<script language='javascript'>alert('��ӳɹ�!');location.href='editor.asp';</script>")

case "modify"        
		user_id=trim(request.QueryString("user_id")) 'ʹ��get��ȡҪ�޸ĵ�id
		inform=trim(request.QueryString("inform"))'informΪinformʱִ�������޸ģ�Ϊpswordʱִ�������޸�
			
		if inform="inform" then
           'sex,hobby,pswordΪ�޸������ύ�����������ֶ�
		   sql="update L_zhang_blog_username set sex='"&request.form("sex")&"',hobby='"&request.form("hobby")&"'where user_id='"&user_id& "'"
		   conn.execute(sql)
		   Response.Write("<script language='javascript'>location.href='inform.asp';</script>")
		elseif  inform="psword" then '������֤�������Ƿ���ȷ��Ȼ����֤����������������Ƿ�һ��
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
			     Response.Write("<script language='javascript'>alert('��������������벻��ȷ');location.href='inform.asp';</script>")
			  end if
		   else
		      Response.Write("<script language='javascript'>alert('����ľ����벻��ȷ');location.href='inform.asp';</script>")
		   end if    
		end if
case "comment" 	'�������
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
			'ɾ�����ݵĿ������ο�ҳ�棬Ҳ����������ҳ����ô�ص������ҳ����
			if qxian=0 then				
					response.redirect "user.asp"
			elseif qxian=1 then 
					response.redirect "editor.asp"
			end if
		elseif blog_id <>"" then
			 sql="delete from L_zhang_blog_content where blog_id='"& blog_id & "'"
			 conn.execute(sql)
			'ɾ�����ݵĿ���������ҳ��,Ҳ�����Ǳ༭������Ϊ�༭����һ����̨��ʵ���ϲ������༭ɾ����ť
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
			 response.write("�������Ѿ�����,��ѡ����������")
		  else
			 response.write("���������ʹ��")
		  end if
		  closers rs
	  elseif remail=0 then
	      response.write("��ʽ����ȷ")
	  end if
case else
    response.Write("������������ϵ����Ա")
end select
conn.close
set conn=nothing
%>
</body>
</html>
