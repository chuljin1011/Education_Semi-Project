<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 테이블에 행(게시글)을 삽입하는 JSP 문서 - 테스트 프로그램 --%>

<%
	ProductDTO product = new ProductDTO();
	for(int i=1;i<=10;i++) {
			
		product.setProductName("텐트"+i);
		product.setProductPrice(i*100000);
		product.setProductCom("텐트몰");
		product.setProductBrand("데상트");
		product.setProductOrigin("중국");
		product.setProductType(1);
		product.setProductStatus(1);
		product.setProductMainImg("tent"+i+"_main.jpg");
		product.setProductSubImg("tent"+i+"_sub.jpg");
		if (i <= 2) {
			product.setProductRank(1);
		} else if (i <= 4) {
			product.setProductRank(2);
		} else if (i <= 6) {
			product.setProductRank(3);
		} else if (i <= 8) {
			product.setProductRank(4);
		} else {
			product.setProductRank(5);
		}

	    ProductDAO.getDAO().insertProduct(product);
	}
%>

<%
	/* ProductDTO product = new ProductDTO(); */
	for(int i=1;i<=10;i++) {
			
		product.setProductName("렌턴"+i);
		product.setProductPrice(i*50000);
		product.setProductCom("야전몰");
		product.setProductBrand("프로스펙스");
		product.setProductOrigin("말레이시아");
		product.setProductType(2);
		product.setProductStatus(1);
		product.setProductMainImg("lantern"+i+"_main.jpg");
		product.setProductSubImg("lantern"+i+"_sub.jpg");
		if (i <= 2) {
			product.setProductRank(1);
		} else if (i <= 4) {
			product.setProductRank(2);
		} else if (i <= 6) {
			product.setProductRank(3);
		} else if (i <= 8) {
			product.setProductRank(4);
		} else {
			product.setProductRank(5);
		}

	    ProductDAO.getDAO().insertProduct(product);
	}
%>

<%
	/* ProductDTO product = new ProductDTO(); */
	for(int i=1;i<=10;i++) {
			
		product.setProductName("매트"+i);
		product.setProductPrice(i*200000);
		product.setProductCom("매트24");
		product.setProductBrand("아이티윌");
		product.setProductOrigin("한국");
		product.setProductType(3);
		product.setProductStatus(1);
		product.setProductMainImg("mat"+i+"_main.jpg");
		product.setProductSubImg("mat"+i+"_sub.jpg");
		if (i <= 2) {
			product.setProductRank(1);
		} else if (i <= 4) {
			product.setProductRank(2);
		} else if (i <= 6) {
			product.setProductRank(3);
		} else if (i <= 8) {
			product.setProductRank(4);
		} else {
			product.setProductRank(5);
		}

	    ProductDAO.getDAO().insertProduct(product);
	}
%>


<%
	/* ProductDTO product = new ProductDTO(); */
	for(int i=1;i<=10;i++) {
			
		product.setProductName("버너"+i);
		product.setProductPrice(i*20000);
		product.setProductCom("캠핑몰");
		product.setProductBrand("썬터치");
		product.setProductOrigin("일본");
		product.setProductType(4);
		product.setProductStatus(1);
		product.setProductMainImg("burner"+i+"_main.jpg");
		product.setProductSubImg("burner"+i+"_sub.jpg");
		if (i <= 2) {
			product.setProductRank(1);
		} else if (i <= 4) {
			product.setProductRank(2);
		} else if (i <= 6) {
			product.setProductRank(3);
		} else if (i <= 8) {
			product.setProductRank(4);
		} else {
			product.setProductRank(5);
		}

	    ProductDAO.getDAO().insertProduct(product);
	}
%>


<%
	/* ProductDTO product = new ProductDTO(); */
	for(int i=1;i<=10;i++) {
			
		product.setProductName("박스"+i);
		product.setProductPrice(i*12000);
		product.setProductCom("박스1번지");
		product.setProductBrand("나이키");
		product.setProductOrigin("미국");
		product.setProductType(5);
		product.setProductStatus(1);
		product.setProductMainImg("box"+i+"_main.jpg");
		product.setProductSubImg("box"+i+"_sub.jpg");
		if (i <= 2) {
			product.setProductRank(1);
		} else if (i <= 4) {
			product.setProductRank(2);
		} else if (i <= 6) {
			product.setProductRank(3);
		} else if (i <= 8) {
			product.setProductRank(4);
		} else {
			product.setProductRank(5);
		}

	    ProductDAO.getDAO().insertProduct(product);
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>테스트 프로덕트 삽입 하였습니다.</h1>
</body>
</html>