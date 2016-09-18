<div class="blog_header_top container">
	<div class="blog_header_logo"><img src="img/LeftLogo.jpg"/></div>
	<div class="blog_header_text">
		<div class="blog_header_name">MAXXIS</div>
		<div class="blog_header_p">hello,welcome to maxxis world!</div>
	</div>
	<div class="blog_header_blockquote"><!--用户放置头部的宣传标语一句话-->
		<blockquote class="pull-right ">
			<%sql="select top 1 slogan_content from L_zhang_blog_slogan where slogan_qxian ='1'"
			  openrs conn,rs,sql
			  response.Write("<p>"&rs("slogan_content")&"</p>")
			  closers rs%>
		</blockquote>
	</div>
</div>