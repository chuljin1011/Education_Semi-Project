<?xml version="1.0" encoding="utf-8"?>
<%@page import="xyz.itwill.dao.ClientDAO"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 이름과 이메일을 전달받아 AJAX_MEMBER 테이블에 저장된 회원정보의 아이디를 검색해 XML로 응답하는 JSP 문서 --%>    
<%
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	//POST 방식으로 요청하여 전달된 값을 읽기 위한 문자형태 변경
	request.setCharacterEncoding("utf-8");
	
	//전달값을 반환받아 저장
	String find=request.getParameter("find");
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String id=request.getParameter("id");
	
%>

<result>

<%	if(find.equals("id")) { //아이디 찾기로 실행 된 경우 %>
<%		ClientDTO client = ClientDAO.getDAO().selectClientByEmail(email); %>
		
<%		if(client == null) { //입력 이메일이 존재하지 않는경우 %>
			<message>가입되지 않은 이메일입니다.</message>
<%		} else { %>
	
<%			String findid = client.getClientId();
			String nameCheck = client.getClientName();
			int status = client.getClientStatus();
	
			if(status == 0) { //탈퇴한 회원의 경우 %>
				<message>삭제되었거나 이용이 정지 된 ID 입니다.</message>
			
<%			} else if(nameCheck.equals(name)) {	//이름 매칭으로 본인검증 %>
				<message><%=name%> 님의 ID는 [ <%=findid%> ] 입니다.</message>
			
<%			} else { //이메일과 사용자 이름이 일치하지 않는 경우 %>
				<message>입력하신 정보가 올바르지 않습니다.</message>
<%			}
			
		}

	} else if(find.equals("pw")) { //아이디 찾기로 실행 된 경우 %>
<%		ClientDTO client = ClientDAO.getDAO().selectClientById(id); %>
		
<%		if(client == null) { //입력 아이디가 존재하지 않는경우 %>
			<message>가입되지 않은 아이디입니다.</message>
<%		} else { %>
	
<%			String nameCheck = client.getClientName();
			String emailCheck = client.getClientEmail();
			int status = client.getClientStatus();
			int clientNum = client.getClientNum();
	
			if(status == 0) { //탈퇴한 회원의 경우 %>
				<message>삭제되었거나 이용이 정지 된 ID 입니다.</message>
			
<%			} else if(nameCheck.equals(name) && emailCheck.equals(email)) {	//이름, 아이디 매칭으로 본인검증 %>
				<message>complete</message>
				<code><%=clientNum%></code>
			
<%			} else { //이메일과 사용자 이름이 일치하지 않는 경우 %>
				<message>입력하신 정보가 올바르지 않습니다.</message>
<%			}
			
		}

} %>

</result>