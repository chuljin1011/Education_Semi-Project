<?xml version="1.0" encoding="utf-8"?>
<%@page import="xyz.itwill.dao.ClientDAO"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ClientDTO client = null;
	
	String id=request.getParameter("id");
	String email=request.getParameter("email");

	
	if((id == null || id.equals(""))&&(email == null || email.equals(""))) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
	
	
	if(id != null && !id.equals("")) {
		client = ClientDAO.getDAO().selectClientById(id);
	} else if(email != null && !email.equals("")) {
		client = ClientDAO.getDAO().selectClientByEmail(email);
	}
%>



<result>
	<% if(client != null) {//아이디로 검색된 회원정보가 있는 경우 - 아이디 중복(아이디 사용 불가능) %>
	<code>impossible</code>
	<% } else {//아이디로 검색된 회원정보가 없는 경우 - 아이디 미중복(아이디 사용 가능) %>
	<code>possible</code>
	<% } %>	
</result>