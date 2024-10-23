<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%-- AJAX_COMMENT 테이블에 저장된 모든 행을 검색하여 JSON으로 응답하는 JSP 문서 --%>    
<%
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductAll();
%>

{
	"code":"success",
	"data":[
	<% for(int i=0;i<productList.size();i++) { %>
		<% if(i > 0 ) { %>,<% } %>
		{"productNum":<%=productList.get(i).getProductNum() %>
			, "productName":"<%=Utility.toJSON(productList.get(i).getProductName()) %>"
			, "productPrice":"<%=productList.get(i).getProductPrice() %>"
			, "productCom":"<%=Utility.toJSON(productList.get(i).getProductCom())%>"
			, "productBrand":"<%=Utility.toJSON(productList.get(i).getProductBrand()) %>"
			, "productOrigin":"<%=Utility.toJSON(productList.get(i).getProductOrigin()) %>"
			, "productType":"<%=productList.get(i).getProductType() %>"
			, "productReg":"<%=productList.get(i).getProductReg() %>"
			, "productStatus":"<%=productList.get(i).getProductStatus() %>"
			, "productMainImg":"<%=Utility.toJSON(productList.get(i).getProductMainImg()) %>"
			, "productSubImg":"<%=Utility.toJSON(productList.get(i).getProductSubImg()) %>"
			, "productRank":"<%=productList.get(i).getProductRank() %>"
		}
	<% } %>	
	]
}