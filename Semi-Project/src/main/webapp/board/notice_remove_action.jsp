<%@page import="java.io.File"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호 전달받아 NOTICE 테이블에 저장된 행에서 글상태를 [0]으로 변경하고 
[notice_list.jsp] 문서 요청 --%>
<%@include file="/security/login_check.jspf" %>
<%
	if(request.getParameter("noticeNum")==null){
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}

	int noticeNum=Integer.parseInt(request.getParameter("noticeNum"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	NoticeDTO notice=NoticeDAO.getDAO().selectNoticeByNum(noticeNum);
	
	if(notice == null){
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
	
	if(loginClient.getClientStatus()!=9 ) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
	
	notice.setNoticeStatus(0);
	
	NoticeDAO.getDAO().updateNotice(notice);
	
	if(notice.getNoticeImage()!=null){
		String saveDirectory=request.getServletContext().getRealPath("/notice_images");
		new File(saveDirectory, notice.getNoticeImage()).delete();
	}
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=board&work=notice_list"
			+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword);
%>