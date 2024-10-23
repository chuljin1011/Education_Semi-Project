<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="javax.swing.plaf.multi.MultiMenuItemUI"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}

	String saveDirectory=request.getServletContext().getRealPath("/notice_images");
	
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	//DefaultFileRenamePolicy() : 파일 업로드 시 발생할 수 있는 파일 이름 충돌 문제를 쉽게 해결
	//파일 이름 충돌 시 새로운 이름을 생성하여 충돌 방지
	
	String pageNum=multipartRequest.getParameter("pageNum");
	String pageSize=multipartRequest.getParameter("pageSize");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	
	String noticeTitle=Utility.escapeTag(multipartRequest.getParameter("noticeTitle"));
	
	int noticeStatus=1;//일반글
	if(multipartRequest.getParameter("noticeStatus") != null) {//2 : 상단고정글
		noticeStatus=Integer.parseInt(multipartRequest.getParameter("noticeStatus"));
	}
	
	String noticeImage=multipartRequest.getFilesystemName("noticeImage");
	
	int nextNum=NoticeDAO.getDAO().selectNoticeNextNum();
	
	NoticeDTO notice=new NoticeDTO();
	notice.setNoticeNum(nextNum);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeImage(noticeImage);
	notice.setNoticeClientNum(loginClient.getClientNum());
	notice.setNoticeStatus(noticeStatus);
	
	NoticeDAO.getDAO().insertNotice(notice);
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=board&work=notice_list"
			+"&pageNum="+pageNum+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword);
%>
