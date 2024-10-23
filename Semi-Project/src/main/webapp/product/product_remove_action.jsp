<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 제품번호를 전달받아 PRODUCT 테이블에 저장된 행을 삭제하고 [product_list.jsp] 문서를 요청할 
수 있는 URL 주소로 응답하는 JSP 문서 --%>      
<%
	//비정상적인 요청에 대한 응답 처리
	try{
		if(request.getParameter("num") == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		//전달값을 반환받아 저장
		int num=Integer.parseInt(request.getParameter("num").trim());
		
		int rows=ProductDAO.getDAO().deleteProduct(num);
		
		if(rows > 0) {//삭제행이 있는 경우
			response.sendRedirect(request.getContextPath()+"/index.jsp?workgroup=admin&work=admin_product");
		} else {//삭제행이 있는 경우 - 비정상적인 요청에 대한 응답 처리
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		}
	} catch(NumberFormatException e) {
        // 전달된 num이 유효한 정수로 변환되지 않는 경우
        response.sendError(HttpServletResponse.SC_BAD_REQUEST);
    }
	
%>
