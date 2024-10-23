<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	session.invalidate();

	String url=request.getParameter("url");
	if(url == null) {
		url="";
	}

	if(url.equals("")) {//전달받은 URL 주소가 없는 경우 - 메인 페이지로 이동
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp");
	} else {//전달받은 URL 주소가 있는 경우 - URL 주소의 페이지로 이동
		request.setAttribute("returnUrl", url);
	}
%>

	