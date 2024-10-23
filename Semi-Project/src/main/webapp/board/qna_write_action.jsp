<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
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

	String saveDirectory=request.getServletContext().getRealPath("/qna_images");
	
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	//DefaultFileRenamePolicy() : 파일 업로드 시 발생할 수 있는 파일 이름 충돌 문제를 쉽게 해결
	//파일 이름 충돌 시 새로운 이름을 생성하여 충돌 방지
	//System.out.println("Save Directory: " + saveDirectory);
	
	String pageNum=multipartRequest.getParameter("pageNum");
	
	String qnaSubject=multipartRequest.getParameter("qnaSubject");
	
	int qnaStatus=1;
	if(multipartRequest.getParameter("qnaStatus") != null) {
		qnaStatus=Integer.parseInt(multipartRequest.getParameter("qnaStatus"));
	}
	
	String qnaWriter=multipartRequest.getParameter("qnaWriter");
	
	int qnaProductNum=Integer.parseInt(multipartRequest.getParameter("qnaProductNum"));
	
	String qnaTitle=Utility.escapeTag(multipartRequest.getParameter("qnaTitle"));
	
	String qnaContent=multipartRequest.getParameter("qnaContent");
	
	String qnaImage=multipartRequest.getFilesystemName("qnaImage");
	
	String qnaIp=request.getRemoteAddr();
	

	int nextNum=QnaDAO.getDAO().selectQnaNextNum();
	
	QnaDTO qna=new QnaDTO();
	qna.setQnaNum(nextNum);
	qna.setQnaClientNum(loginClient.getClientNum());
	qna.setQnaSubject(qnaSubject);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setQnaImage(qnaImage);
	qna.setQnaIp(qnaIp);
	qna.setQnaProductNum(qnaProductNum);
	qna.setQnaStatus(qnaStatus);
	qna.setQnaWriter(qnaWriter);
	
	
	QnaDAO.getDAO().insertQna(qna);
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=board&work=qna_list"
			+"&pageNum="+pageNum);
%>
