<%@page import="xyz.itwill.dao.ClientDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 로그인 체크를 위한 JSP Include -->
<%@include file="/security/login_check.jspf" %>

<%
	/* //비정상적으로 JSP 문서를 요청한 경우에 대한 응답 처리
	if(request.getMethod().equals("GET")) {//JSP 문서를 GET 방식으로 요청한 경우
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	} */

	/* //전달값을 반환받아 저장
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	
	//로그인 사용자의 비밀번호와 전달받은 비밀번호를 비교하여 같지 않은 경우에 대한 응답 처리
	if(!loginClient.getClientPasswd().equals(passwd)) {
		session.setAttribute("message", "입력하신 비밀번호가 맞지 않습니다. 비밀번호를 정확히 입력해 주세요.");
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=mypage&work=password_confirm&action=delete");
		return;		
	} */
	
	//ClinetDTO 객체 생성
	ClientDTO client = new ClientDTO();
	//로그인한 사용자의 번호를 ClientDTO 객체에 설정 - 타겟 지정
	client.setClientNum(loginClient.getClientNum());
	//사용자 상태번호 0으로 변경 (탈퇴처리)
	client.setClientStatus(0);
	
	//회원정보(MemberDTO 객체)를 전달받아 MEMBER 테이블에 저장된 행의 회원권한을 변경하고 
	//변경행의 갯수를 반환하는 ClientDAO 클래스의 메소드 호출
	ClientDAO.getDAO().updateAuth(client);
	
	//페이지 이동을 위한 URL
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=client&work=client_logout_action");
%>




