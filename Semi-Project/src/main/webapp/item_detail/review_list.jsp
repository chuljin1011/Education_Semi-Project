<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 상품 넘버 받아야함 수정중
	
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	List<ReviewDTO> reviewList=ReviewDAO.getDAO().selectReviewAll(productNum); 
	
%>
<%  if (reviewList.isEmpty()) { %>
{
	"code":"empty",
	"message":" 등록된 상품후기가 없습니다."
}
<% } else { %>
{
	"code":"success",
	"data":[
	<% for(int i=0;i<reviewList.size();i++){ %>
		<% if(i > 0 ) { %>,<% } %>
		{"level": <%=reviewList.get(i).getReviewLevel() %>
			,"subject":"<%=reviewList.get(i).getReviewSubject() %>"
			,"name":"<%=reviewList.get(i).getClientId() %>"
			,"content":"<%=reviewList.get(i).getReviewContent() %>"
			,"reviewimg":"<%=reviewList.get(i).getReviewImg() %>"
			,"regdate": "<%=reviewList.get(i).getReviewRegisterTime() %>"}
		
	<% } %>
	]
}
<% } %>