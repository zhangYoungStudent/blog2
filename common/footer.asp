

<!--ҳ���β��-->
<div class="blog_footer">
    <div class="container">
			<div class="border_red blog_footer_coperight">
			    <ul><li><span class="glyphicon glyphicon-globe"></span>��������</li>
				    <li><span class="glyphicon glyphicon-envelope"></span>755201244@qq.com</li>
				    
				</ul>
				<ul>
				    <li><span class="glyphicon glyphicon-envelope"></span>755201244@qq.com</li>
				    <li><span class="glyphicon glyphicon-phone-alt"></span>0358-5353265</li>
					<li><span class="glyphicon glyphicon-map-marker"></span>�й���ɽ�Ϸ�·</li>
					<li><span class="glyphicon glyphicon-copyright-mark"></span>������</li>
				</ul>
			</div>
			<div class="blog_footer_blockquote">
				<blockquote class="pull-right">
					<%sql="select top 1 slogan_content,slogan_author from L_zhang_blog_slogan where slogan_qxian ='4'"
					  openrs conn,rs,sql
					  response.Write("<p>"&rs("slogan_content")&"</p>")
					  response.Write("<small>"&rs("slogan_author")&"</small>")
					  closers rs%>
				</blockquote>
			</div>
		</div>
	</div>
</div>

