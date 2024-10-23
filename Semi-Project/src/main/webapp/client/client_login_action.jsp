<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dao.ClientDAO"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if(request.getMethod().equals("GET")) {
	    response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
	    return;
	}

	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	String url=request.getParameter("url");
	if(url == null) {
		url="";
	}
	
	ClientDTO client=ClientDAO.getDAO().selectClientById(id);
	
	//검색된 회원정보가 없거나 검색된 회원정보의 비밀번호가 전달받은 비밀번호와 같지 않거나
	if(client == null || !client.getClientPasswd().equals(passwd)) {
		session.setAttribute("message", "아이디 또는 비밀번호를 잘못 입력하셨습니다.");
		session.setAttribute("id", id);
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=client&work=client_login");
		return;
	}
	
	//검색된 회원정보이 탈퇴회원인 경우 인증 실패 처리 
	else if(client.getClientStatus() == 0) {
		session.setAttribute("message", "회원탈퇴 혹은 이용이 정지 된 회원입니다.");
		session.setAttribute("id", id);
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=client&work=client_login");
		return;
	}

	//인증 성공 - 권한 관련 정보가 저장된 객체를 session 내장객체의 속성값으로 저장
	session.setAttribute("loginClient", client);
	
	//최근 로그인 일자 업데이트
	ClientDAO.getDAO().updateLastLogin(client.getClientNum());

	//페이지 이동 처리
	if(url.equals("")) {//전달받은 URL 주소가 없는 경우 - 메인 페이지로 이동
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp");
	} else {//전달받은 URL 주소가 있는 경우 - URL 주소의 페이지로 이동
		request.setAttribute("returnUrl", url);
	}
%>
