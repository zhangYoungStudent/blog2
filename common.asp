<%
dim conn,rs,sql,count,datebase


Sub openconn(conn,datebase)
	set conn=server.CreateObject ("adodb.connection")
	conn.ConnectionString = "Provider=sqloledb.1;Server=10.30.1.99;uid=dev;pwd=dev;DATABASE="&datebase
	conn.Open
End Sub
Sub closeconn(conn)
	conn.close
	set conn=nothing
End Sub


Sub openrs(conn,rs,sql)
	 set rs = Server.CreateObject("ADODB.Recordset")
	 rs.open sql,conn,1,1
End Sub
Sub closers(rs)
	 rs.close
	 set rs = nothing
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


'��ҳ����
Sub createpage(actionurl,curpage,rs) %>

		<!--�б��ҳ����-->
		<ul class="pagination">
		<%  if curpage<>1 then%>
			   <li><a href="?<%=actionurl%>&curpage=<%=curpage-1%>"><</a></li> <!--��һҳ-->
		<%  end if%>
			
		<%  '���ҳ����һҳ�Ļ������ý���ѭ�����,ҳ������10ҳ�Ļ������ʡ�ԣ�������Զֻ��ʾ7ҳ�����߸�3ҳ
			if 1<rs.pagecount and rs.pagecount<10 then 
			   for i=1 to rs.pagecount%>
				   <li><a href="?<%=actionurl%>&curpage=<%=i%>"><%=i%></a></li>
		<%     next
			elseif rs.pagecount>10 then
			   dim lastpage,startpage
			   startpage=rs.absolutepage-3
			   lastpage=rs.absolutepage+3
			   if startpage<1 then
				  startpage=1
			   else %>
				   <li><a href="#">...</a></li> 
		<%	   end if %>

		<%	   for i=startpage to lastpage%>
				   <li><a href="?<%=actionurl%>&curpage=<%=i%>"><%=i%></a></li>
		<%     next
			   
			   if lastpage>rs.pagecount then
				  lastpage=rs.pagecount
			   else %>
				  <li><a href="#">...</a></li>
		<%	   end if
		%>

		<% end if
		   
			
		   if rs.pagecount>=curpage+1 then%>
			  <li><a href="?<%=actionurl%>&curpage=<%=curpage+1%>">></a></li><!--��һҳ-->
		<% end if%>
		</ul>
		<div class="article_nav_page">
		   <span><%=rs.pagecount%>��ҳ��</span>
		</div>
		<div class="article_nav_page">
		   <span><%=rs.recordcount%>�ܼ�¼��</span>
		</div>
		<div class="article_nav_page">
		   <span><%=curpage%>��ǰҳ</span>
		</div>
		
<%	
End Sub




%>