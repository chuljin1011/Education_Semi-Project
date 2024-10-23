<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.CartDAO"%>
<%@page import="xyz.itwill.dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   if(request.getMethod().equals("GET")) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
      return;
   }
   
   request.setCharacterEncoding("utf-8");
   
   String[] options = request.getParameterValues("options");
    String[] quantities = request.getParameterValues("quantities");
    int clientNum = Integer.parseInt(request.getParameter("clientNum"));
    int productNum = Integer.parseInt(request.getParameter("productNum"));
    
    List<Integer> cartNumList = new ArrayList<>();
    
    int cartNum = 0;
    CartDAO.getCartDAO().selectCartNextNum();
   
    int rows=0;
    for (int i = 0; i < options.length; i++) {
        String optionName = options[i];
        int quantity = Integer.parseInt(quantities[i]);

        cartNum = CartDAO.getCartDAO().selectCartNextNum(); 
        cartNumList.add(cartNum);
        
        CartDTO cart = new CartDTO();
      
        cart.setCartNum(cartNum);
        cart.setCartClientNum(clientNum);
        cart.setCartProductNum(productNum); 
        cart.setCartOpt(optionName);
        cart.setCartCount(quantity);

        rows += CartDAO.getCartDAO().insertCartSeq(cart);
    }
   
%>
<% if(rows > 0) {//삽입행이 있는 경우 %>
{"code":"success", "cartNumList":<%=cartNumList%>}
<% } else {//삽입행이 없는 경우 %>
{"code":"error"}
<% } %>

