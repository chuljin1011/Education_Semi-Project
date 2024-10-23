<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="xyz.itwill.dto.CartDTO"%>
<%@ page import="xyz.itwill.dao.CartDAO"%>
<%@ page import="xyz.itwill.dto.ProductDTO"%>
<%@ page import="xyz.itwill.dao.ProductDAO"%>
<%@ page import="xyz.itwill.dto.ClientDTO"%>

<%
try {
    int cartNum = Integer.parseInt(request.getParameter("cartNum"));
    int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));

    CartDAO cartDAO = CartDAO.getCartDAO();
    CartDTO cart = new CartDTO();
    cart.setCartNum(cartNum);
    cart.setCartCount(newQuantity);
    cartDAO.updateCartQuantity(cartNum, newQuantity);

    ClientDTO loginClient = (ClientDTO) session.getAttribute("loginClient");
    int clientNum = loginClient.getClientNum();

    List<CartDTO> cartList = cartDAO.selectCartClient(clientNum);
    ProductDAO productDAO = ProductDAO.getDAO();

    int totalSum = 0;
    int newPrice = 0;
    for (CartDTO c : cartList) {
        ProductDTO p = productDAO.selectProduct(c.getCartProductNum());
        int itemTotal = c.getCartCount() * p.getProductPrice();
        if (c.getCartNum() == cartNum) {
            newPrice = itemTotal;
        }
        totalSum += itemTotal;
    }

    // JSON 응답 생성
    String jsonResponse = "{";
    jsonResponse += "\"totalSum\":" + totalSum + ",";
    jsonResponse += "\"newPrice\":" + newPrice;
    jsonResponse += "}";

    response.setContentType("application/json");
    PrintWriter jsonOut = response.getWriter();
    jsonOut.print(jsonResponse);
    jsonOut.flush();
} catch (Exception e) {
    e.printStackTrace();
    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    response.getWriter().write("{\"error\":\"An error occurred.\"}");
}
%>
