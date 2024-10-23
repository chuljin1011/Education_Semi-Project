<?xml version="1.0" encoding="utf-8"?>
<%@page import="xyz.itwill.dao.OrdDAO"%>
<%@page import="xyz.itwill.dao.DeliveryDAO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}
	
	request.setCharacterEncoding("utf-8");

	int order_num = Integer.parseInt(request.getParameter("order_num"));
	int delivery_status = Integer.parseInt(request.getParameter("delivery_status"));
	

    
	int rows_delivery = DeliveryDAO.getDAO().updateDate(order_num);
	int rows_ord = OrdDAO.getOrdDAO().updateStatus(order_num, delivery_status);
    
%>

<result>
	<% if(rows_delivery >= 1 && rows_ord >= 1) { //업데이트 완료 %>
	<code>complete</code>
	<% } else { //업데이트 실패 %>
	<code>incomplete</code>
	<% } %>	
</result>