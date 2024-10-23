<%@page import="xyz.itwill.dao.ClientDAO"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- REVIEW 테이블에 행(게시글)을 500개 삽입하는 JSP 문서 - 테스트 프로그램 --%>
<%
	ClientDTO client = new ClientDTO();
	String stri = "";
	for(int i=1;i<=500;i++) {
		if(i<10) {
			stri = "000"+i;
		} else if (i<100) {
			stri = "00"+i;
		} else {
			stri = "0"+i;
		}
		
	    client.setClientId("test"+stri);
	    client.setClientPasswd("39df6a17c1670e9bc91dfe1a5c334a98085a6a4ba343a6deb3847bbef74");
	    client.setClientName("사용자"+i);
	    client.setClientEmail("test"+stri+"@itwill.com");
	    client.setClientMobile("010-0000-"+stri);
	    client.setClientZipcode("1"+stri);
	    client.setClientAddress1("강남로 "+stri);
	    client.setClientAddress2("강남아파트 101동 "+stri+"호");
		
	    ClientDAO.getDAO().insertClient(client);
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>500개의 테스트 아이디를 삽입 하였습니다.</h1>
</body>
</html>