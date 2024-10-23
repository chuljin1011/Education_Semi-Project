<%@page import="java.io.File"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="javax.swing.plaf.multi.MultiMenuItemUI"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	//System.out.println("noticeNum="+request.getParameter("noticeNum"));

	if(request.getMethod().equals("GET")) {//JSP 문서를 GET 방식으로 요청한 경우
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}

	String saveDirectory=request.getServletContext().getRealPath("/notice_images");
	
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	int noticeNum=Integer.parseInt(multipartRequest.getParameter("noticeNum"));
	String pageNum=multipartRequest.getParameter("pageNum");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	
	String noticeTitle=Utility.escapeTag(multipartRequest.getParameter("noticeTitle"));
	
	int noticeStatus=1;//일반글
	if(multipartRequest.getParameter("noticeStatus") != null){//전달값이 있는 경우 - 상단고정글
		noticeStatus=Integer.parseInt(multipartRequest.getParameter("noticeStatus"));
	}
	
	String noticeImage=multipartRequest.getFilesystemName("noticeImage");
	
	NoticeDTO notice=new NoticeDTO();
	notice.setNoticeNum(noticeNum);
	notice.setNoticeTitle(noticeTitle);
	String removeNoticeImage=NoticeDAO.getDAO().selectNoticeByNum(noticeNum).getNoticeImage();
	if(noticeImage != null){//이미지가 있는 경우
		notice.setNoticeImage(noticeImage);
		new File(saveDirectory, removeNoticeImage).delete();//현재 업로드되어 있는 이미지 삭제 처리
	} else {//이미지가 없는 경우
		notice.setNoticeImage(removeNoticeImage);//현재 업로드되어 있는 이미지로 변경
	}
	
	notice.setNoticeStatus(noticeStatus);
	
	NoticeDAO.getDAO().updateNotice(notice);
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=board&work=notice_list"
			+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword);
%>