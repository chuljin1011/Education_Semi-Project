<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="xyz.itwill.dao.CartDAO"%>
<%@page import="xyz.itwill.dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String cartNumsStr = request.getParameter("cartNums");


List<String> cartNumsList = Arrays.asList(cartNumsStr.split(","));


CartDAO cartDAO = CartDAO.getCartDAO();
boolean deleteSuccess = true;

for (String cartNumStr : cartNumsList) {
    int cartNum = Integer.parseInt(cartNumStr);
    //out.println("Attempting to delete cartNum: " + cartNum);
    int result = cartDAO.deleteCart(cartNum); // deleteCart 메서드 호출
   	//out.println("Delete result for cartNum " + cartNum + ": " + result);
    if (result == 0) {
        deleteSuccess = false;
        break;
    }
}

response.setContentType("application/json");
PrintWriter jsonOut = response.getWriter(); // 변수 이름 변경
if (deleteSuccess) {
    jsonOut.print("{\"code\": \"success\"}");
} else {
    jsonOut.print("{\"code\": \"failure\"}");
}
jsonOut.flush();

%>