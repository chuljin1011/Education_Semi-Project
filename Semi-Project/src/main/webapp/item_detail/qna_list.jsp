<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 상품 넘버 받아야함 수정중
	
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	List<QnaDTO> qnaList=QnaDAO.getDAO().selectQnaAll(productNum);  
	
%>
<% if(qnaList.isEmpty()){ %>
{
	"code":"empty", 
	"message":"등록된 상품문의가 없습니다."
}
<% } else {%>
{
	"code":"success",
	"data":[
	<%for(int i=0;i<qnaList.size();i++){ %>
		<%if(i>0){ %>,<% } %>	
		{"qnanum": <%=qnaList.size()-i %>
			,"title":"<%=qnaList.get(i).getQnaTitle() %>"
			,"content":"<%=qnaList.get(i).getQnaContent() %>"
			,"name":<%=qnaList.get(i).getQnaClientNum() %>
			,"id":"<%=qnaList.get(i).getClientId() %>"
			,"redate":"<%=qnaList.get(i).getQnaDate() %>"
			,"reply": "<%=qnaList.get(i).getQnaReply() %>"
			,"writer":"<%=qnaList.get(i).getQnaWriter() %>"
			,"qnaimg":"<%=qnaList.get(i).getQnaImage() %>"
			,"status":<%=qnaList.get(i).getQnaStatus() %>}
	<% } %>
	]

}
<% } %>