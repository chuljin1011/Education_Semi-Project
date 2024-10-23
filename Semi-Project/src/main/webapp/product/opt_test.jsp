<%@page import="xyz.itwill.dao.OptionDAO"%>
<%@page import="xyz.itwill.dto.OptionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 테이블에 행(게시글)을 삽입하는 JSP 문서 - 테스트 프로그램 --%>

<%
	OptionDTO option = new OptionDTO();
	for(int i=1;i<=50;i++) {
		option.setProductNum(i);
		for(int j=1;j<=4;j++) {			
			switch (j) {
			case 1:
				option.setOption("블랙");
				break;
			case 2:
				option.setOption("화이트");
				break;
			case 3:
				option.setOption("베이지");
				break;
			default:
				option.setOption("그레이");
				break;	
			}
		    OptionDAO.getDAO().insertOption(option);
		}
	}
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>테스트 옵션 삽입 하였습니다.</h1>
</body>
</html>