<%@page import="java.io.File"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	if(request.getMethod().equals("GET")) {//JSP 문서를 GET 방식으로 요청한 경우
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}

	String saveDirectory=request.getServletContext().getRealPath("/qna_images");
	
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	int qnaNum=Integer.parseInt(multipartRequest.getParameter("qnaNum"));
	String pageNum=multipartRequest.getParameter("pageNum");
	
	String qnaSubject=multipartRequest.getParameter("qnaSubject");
	
	int qnaStatus=1;//일반글
	if(multipartRequest.getParameter("qnaStatus") != null){//전달값이 있는 경우 - 비밀글
		qnaStatus=Integer.parseInt(multipartRequest.getParameter("qnaStatus"));
	}
	
	int qnaProductNum=Integer.parseInt(multipartRequest.getParameter("qnaProductNum"));
	String qnaWriter=multipartRequest.getParameter("qnaWriter");
	String qnaTitle=Utility.escapeTag(multipartRequest.getParameter("qnaTitle"));
	String qnaContent=multipartRequest.getParameter("qnaContent");
	String qnaReply=multipartRequest.getParameter("qnaReply");
	String qnaImage=multipartRequest.getFilesystemName("qnaImage");
	String qnaIp=request.getRemoteAddr();
	
	//QnaDTO 객체를 생성하여 변수값(전달값)으로 필드값 변경
	QnaDTO qna=new QnaDTO();
	qna.setQnaNum(qnaNum);
	qna.setQnaSubject(qnaSubject);
	qna.setQnaStatus(qnaStatus);
	qna.setQnaProductNum(qnaProductNum);
	qna.setQnaWriter(qnaWriter);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setQnaReply(qnaReply);
	String removeQnaImage=QnaDAO.getDAO().selectQnaByNum(qnaNum).getQnaImage();
    if (qnaImage != null) { // 새로 등록한 이미지가 있는 경우
        qna.setQnaImage(qnaImage);
        
        // 기존 이미지가 null이 아니고 비어 있지 않을 경우
        if (removeQnaImage != null && !removeQnaImage.trim().isEmpty()) {
            File oldImageFile = new File(saveDirectory, removeQnaImage);
            if (oldImageFile.exists() && oldImageFile.isFile()) {
                // 파일 삭제 시도
                if (!oldImageFile.delete()) {
                    // 파일 삭제 실패 처리
                    out.println("Failed to delete file: " + oldImageFile.getAbsolutePath());
                }
            } else {
                // 파일이 존재하지 않거나 잘못된 경로일 경우 처리
                out.println("File does not exist or is not a file: " + oldImageFile.getAbsolutePath());
            }
        }
    } else { // 새로 등록한 이미지가 없는 경우
        qna.setQnaImage(removeQnaImage);
    }
	
	QnaDAO.getDAO().updateQna(qna);
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=board&work=qna_detail"
			+"&qnaNum="+qnaNum+"&pageNum="+pageNum);
%>
