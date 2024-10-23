<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- 제품정보를 전달받아 PRODUCT 테이블의 행으로 삽입하고 실행결과를
JSON으로 응답하는 JSP 문서  --%>
<%-- <%
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	String productName=Utility.escapeTag(request.getParameter("productName"));
	int productPrice=Integer.parseInt(request.getParameter("productPrice"));
	String productCom=Utility.escapeTag(request.getParameter("productCom"));
	String productBrand=Utility.escapeTag(request.getParameter("productBrand"));
	String productOrigin=Utility.escapeTag(request.getParameter("productOrigin"));
	int productType=Integer.parseInt(request.getParameter("productType"));
	int productStatus=Integer.parseInt(request.getParameter("productStatus"));
	String productMainImg=Utility.escapeTag(request.getParameter("productMainImg"));
	String productSubImg=Utility.escapeTag(request.getParameter("productSubImg"));
	int productRank=Integer.parseInt(request.getParameter("productRank"));

	ProductDTO product=new ProductDTO();
	
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	product.setProductCom(productCom);
	product.setProductBrand(productBrand);
	product.setProductOrigin(productOrigin);
	product.setProductType(productType);
	product.setProductStatus(productStatus);
	product.setProductMainImg(productMainImg);
	product.setProductSubImg(productSubImg);
	product.setProductRank(productRank);
	
	
	int rows=ProductDAO.getDAO().insertProduct(product);
%>
<% if(rows > 0) {//삽입행이 있는 경우 %>
{"code":"success"}
<% } else {//삽입행이 없는 경우 %>
{"code":"error"}
<% } %> --%>

<%
if (request.getMethod().equals("GET")) {
	response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
	return;
}

request.setCharacterEncoding("utf-8");
response.setContentType("application/json; charset=UTF-8");
try {
	String productName = Utility.escapeTag(request.getParameter("productName"));
	
	// 가격 검증
	String priceParam = request.getParameter("productPrice");
	if (priceParam == null || priceParam.trim().isEmpty()) {
		throw new NumberFormatException("가격이 입력되지 않았습니다.");
	}
	int productPrice = Integer.parseInt(priceParam);

	String productCom = Utility.escapeTag(request.getParameter("productCom"));
	String productBrand = Utility.escapeTag(request.getParameter("productBrand"));
	String productOrigin = Utility.escapeTag(request.getParameter("productOrigin"));

	// 타입 검증
	String typeParam = request.getParameter("productType").substring(0, 1);
	if (typeParam == null || typeParam.trim().isEmpty()) {
		throw new NumberFormatException("제품 타입이 입력되지 않았습니다.");
	}
	int productType = Integer.parseInt(typeParam);

	// 상태 검증
	String statusParam = request.getParameter("productStatus").substring(0, 1);
	if (statusParam == null || statusParam.trim().isEmpty()) {
		throw new NumberFormatException("제품 상태가 입력되지 않았습니다.");
	}
	int productStatus = Integer.parseInt(statusParam);

	String productMainImg = Utility.escapeTag(request.getParameter("productMainImg"));
	String productSubImg = Utility.escapeTag(request.getParameter("productSubImg"));

	// 순위 검증
	String rankParam = request.getParameter("productRank").substring(0, 1);
	if (rankParam == null || rankParam.trim().isEmpty()) {
		throw new NumberFormatException("제품 순위가 입력되지 않았습니다.");
	}
	int productRank = Integer.parseInt(rankParam);

	ProductDTO product = new ProductDTO();
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	product.setProductCom(productCom);
	product.setProductBrand(productBrand);
	product.setProductOrigin(productOrigin);
	product.setProductType(productType);
	product.setProductStatus(productStatus);
	product.setProductMainImg(productMainImg);
	product.setProductSubImg(productSubImg);
	product.setProductRank(productRank);

	int rows = ProductDAO.getDAO().insertProduct(product);

	if (rows > 0) {
		out.print("{\"code\":\"success\"}");
	} else {
		out.print("{\"code\":\"error\"}");
	} 

} catch (NumberFormatException e) {
	out.print("{\"code\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
} catch (Exception e) {
	out.print("{\"code\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
}
%>