<?xml version="1.0" encoding="utf-8"?>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="xyz.itwill.dao.ClientDAO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	String passwd = Utility.encrypt(request.getParameter("passwd"));
	int num = Integer.parseInt(request.getParameter("num"));
	
	ClientDTO client = new ClientDTO();
    client.setClientPasswd(passwd);
    client.setClientNum(num);
    
	int rows = ClientDAO.getDAO().updatePassword(client);
    
%>

<result>
	<% if(rows == 1) { //업데이트 완료 %>
	<code>complete</code>
	<% } else { //업데이트 실패 %>
	<code>incomplete</code>
	<% } %>	
</result>