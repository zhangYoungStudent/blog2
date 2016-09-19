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


'分页函数
Sub createpage(actionurl,curpage,rs) %>

		<!--列表分页导航-->
		<ul class="pagination">
		<%  if curpage<>1 then%>
			   <li><a href="?<%=actionurl%>&curpage=<%=curpage-1%>"><</a></li> <!--上一页-->
		<%  end if%>
			
		<%  '如果页数就一页的话，不用进行循环输出,页数大于10页的话多余的省略，并且永远只显示7页，两边各3页
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
			  <li><a href="?<%=actionurl%>&curpage=<%=curpage+1%>">></a></li><!--下一页-->
		<% end if%>
		</ul>
		<div class="article_nav_page">
		   <span><%=rs.pagecount%>总页数</span>
		</div>
		<div class="article_nav_page">
		   <span><%=rs.recordcount%>总记录数</span>
		</div>
		<div class="article_nav_page">
		   <span><%=curpage%>当前页</span>
		</div>
		
<%	
End Sub




%>