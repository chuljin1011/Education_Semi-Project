<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/security/login_check.jspf"%>
<%
	//비정상적으로 JSP 문서를 요청한 경우에 대한 응답 처리
	if(request.getMethod().equals("GET")) {//JSP 문서를 GET 방식으로 요청한 경우
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
	String saveDirectory=request.getServletContext().getRealPath("/review_images");

	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값을 반환받아 저장
	int reviewOrderNum=1;
	// int reviewOrderNum=Integer.parseInt(request.getParameter("reviewOrderNum"));
	int reviewLevel=Integer.parseInt(multipartRequest.getParameter("reviewLevel"));
	int reviewProductNum=Integer.parseInt(multipartRequest.getParameter("reviewProductNum"));
	int reviewClientNum=Integer.parseInt(multipartRequest.getParameter("reviewClientNum"));
	String reviewSubject=Utility.escapeTag(multipartRequest.getParameter("reviewSubject"));
	String reviewContent=Utility.escapeTag(multipartRequest.getParameter("reviewContent"));
	String reviewImage=multipartRequest.getFilesystemName("reviewImage");
	
	ReviewDTO review=new ReviewDTO();
	review.setReviewClientNum(reviewClientNum);
	review.setReviewSubject(reviewSubject);
	review.setReviewContent(reviewContent);
	review.setReviewImg(reviewImage);
	review.setReviewProductNum(reviewProductNum);
	review.setReviewOrderNum(reviewOrderNum);
	review.setReviewLevel(reviewLevel);
	
	ReviewDAO.getDAO().insertReview(review);
	// 페이지 이동
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=item_detail&work=item_detail&num="+reviewProductNum);

%>