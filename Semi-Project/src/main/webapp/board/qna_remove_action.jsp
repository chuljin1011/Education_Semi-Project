<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호 전달받아 QNA 테이블에 저장된 행을 삭제(delete) 하고 [qna_list] 문서 요청--%>
<%@include file="/security/login_check.jspf" %>
<%
	if(request.getParameter("qnaNum")==null){
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
		
	int qnaNum=Integer.parseInt(request.getParameter("qnaNum"));
	String pageNum=request.getParameter("pageNum");
	
	QnaDTO qna=QnaDAO.getDAO().selectQnaByNum(qnaNum);
	
	if(qna == null){
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
	
	
	if(loginClient.getClientNum() != qna.getQnaClientNum() && loginClient.getClientStatus()!=9 ) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
	
	//글상태를 [0]으로 변경하는 것이 아닌 아예 행을 삭제하는 방법
	QnaDAO.getDAO().deleteQna(qnaNum);
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=board&work=qna_list"
			+"&pageNum="+pageNum);
%>