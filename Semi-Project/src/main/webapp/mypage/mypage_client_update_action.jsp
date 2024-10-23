<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dao.ClientDAO"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 로그인 체크를 위한 JSP Include -->

<%@include file="/security/login_check.jspf" %>
<%

	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	String passwd=request.getParameter("passwd");
	if(passwd != null && !passwd.equals("")) {//전달값(비밀번호)이 있는 경우
		passwd=Utility.encrypt(passwd);
	}
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String mobileinput = request.getParameter("mobile");
    int mlength = mobileinput.length();
    String mobile1 = mobileinput.substring(0, mlength - 8);
    String mobile2 = mobileinput.substring(mlength - 8, mlength - 4);
    String mobile3 = mobileinput.substring(mlength - 4);
    String mobile = mobile1 + "-" + mobile2 + "-" + mobile3;
	String zipcode=request.getParameter("zipcode");
	String address1=request.getParameter("address1");
	String address2=request.getParameter("address2");

	//ClientDTO 객체를 생성하여 전달값으로 필드값 변경
	ClientDTO client=new ClientDTO();
	client.setClientNum(num);
	client.setClientPasswd(passwd);
	client.setClientName(name);
	client.setClientEmail(email);
	client.setClientMobile(mobile);
	client.setClientZipcode(zipcode);
	client.setClientAddress1(address1);
	client.setClientAddress2(address2);
	
	//회원정보(ClientDAO 객체)를 전달받아 CLIENT 테이블에 저장된 행을 변경하고 변경행의 갯수를 
	//반환하는 ClientDAO 클래스의 메소드 호출
	ClientDAO.getDAO().updateClient(client);
	
	if(passwd != null && !passwd.equals("")) {//전달값(비밀번호)이 있는 경우
		//회원정보(MemberDTO 객체)를 전달받아 MEMBER 테이블에 저장된 행의 비밀번호를 변경하고 
		//변경행의 갯수를 반환하는 MemberDAO 클래스의 메소드 호출
		ClientDAO.getDAO().updatePassword(client);
	}
	
	// 세션에 저장된 로그인 관련 정보가 저장된 속성값 변경
	// => 회원번호를 전달받아 CLIENT 테이블에 저장된 하나의 행을 검색하여 ClientDTO 객체로
	// 반환하는 ClientDAO 클래스의 메소드 호출하여 속성값 변경
	session.setAttribute("loginClient", ClientDAO.getDAO().selectClientByNum(num));
	
	// request 내장객체의 속성값으로 URL 주소를 저장하여 요청 JSP 문서(index.jsp)에게 제공
	// => 요청 JSP 문서(index.jsp)에서 URL 주소를 반환받아 리다이렉트 이동 
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=mypage&work=mypage");
%>