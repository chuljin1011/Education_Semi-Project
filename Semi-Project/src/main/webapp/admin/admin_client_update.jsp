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
	
	String name = request.getParameter("name");
	String mobile = request.getParameter("mobile");
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	int status = Integer.parseInt(request.getParameter("status"));
	int num = Integer.parseInt(request.getParameter("num")); /* 찾는 조건 */
	
	ClientDTO client = new ClientDTO();
    client.setClientName(name);
    client.setClientMobile(mobile);
    client.setClientZipcode(zipcode);
    client.setClientAddress1(address1);
    client.setClientAddress2(address2);
    client.setClientStatus(status);
    client.setClientNum(num);

    
	int rows = ClientDAO.getDAO().updateClientAdmin(client);
    
%>

<result>
	<% if(rows == 1) { //업데이트 완료 %>
	<code>complete</code>
	<% } else { //업데이트 실패 %>
	<code>incomplete</code>
	<% } %>	
</result>