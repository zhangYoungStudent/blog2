<%
session("user_id")=""
dim logout
logout=request.QueryString("logout")
response.Write(request.QueryString("action"))
select case logout
case "classify" 'ตวยผ
      response.redirect("classify.asp?action="&request.QueryString("action")&"")
case "content"
      response.redirect("content.asp")
case else
      response.redirect("index.asp")
end select
%>