<%@page import="xyz.itwill.dao.DeliveryDAO"%>
<%@page import="xyz.itwill.dto.DeliveryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="xyz.itwill.dto.ClientDTO"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="xyz.itwill.dto.OrdDTO"%>
<%@ page import="xyz.itwill.dao.OrdDAO"%>
<%@ page import="xyz.itwill.dto.CartDTO"%>
<%@ page import="xyz.itwill.dao.CartDAO"%>
<%@ page import="xyz.itwill.dto.ProductDTO"%>
<%@ page import="xyz.itwill.dao.ProductDAO"%>

<%
request.setCharacterEncoding("UTF-8");

ClientDTO loginClient = (ClientDTO) session.getAttribute("loginClient");
int clientNum = loginClient.getClientNum();

//order 주문 번호 가져오기 위한 조회
List<OrdDTO> orderList = OrdDAO.getOrdDAO().selectOrdListByClientNum(clientNum);

String ordererName = request.getParameter("orderer_name");
String ordererPhone = request.getParameter("orderer_phone");
String ordererEmail = request.getParameter("orderer_email") + "@" + request.getParameter("email_domain");

String recipientName = request.getParameter("recipient_name");
String recipientPhone = request.getParameter("recipient_phone");  
String postcode = request.getParameter("postcode");
String address = request.getParameter("address");
String detailAddress = request.getParameter("detailAddress");

// 선택된 장바구니 항목 가져오기
String[] selectedCartNums = request.getParameterValues("selectedCartNums");
List<CartDTO> cartList = new ArrayList<>();
if (selectedCartNums != null) {
    for (String cartNum : selectedCartNums) {
        cartList.add(CartDAO.getCartDAO().selectCart(Integer.parseInt(cartNum)));
    }
}

// 현재 시간과 날짜를 포맷팅
Date now = new Date();
SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
String nowTime = timeFormat.format(now);
String nowDate = dateFormat.format(now);

boolean orderSuccess = true;

int orderNum = OrdDAO.getOrdDAO().selectLatestOrdNum();
if (orderNum != -1) {
    out.println("최신 주문 번호: " + orderNum);
} else {
    out.println("주문이 없습니다.");
}


for (CartDTO cart : cartList) {
    try {
        OrdDTO order = new OrdDTO();
        order.setOrdclientNum(clientNum);
        order.setOrdReceiver(recipientName);
        order.setOrdZipcode(postcode);
        order.setOrdAddress1(address);
        order.setOrdAddress2(detailAddress);
        order.setOrdMobile(recipientPhone);
        order.setOrdCount(String.valueOf(cart.getCartCount()));
        order.setOrdproductNum(cart.getCartProductNum());
        order.setOrdTime(nowTime);
        order.setOrdDate(nowDate);
        order.setOrdStatus(3); // 주문 상태를 1로 설정
        order.setOrdPaySum(cart.getCartCount() * ProductDAO.getDAO().selectProduct(cart.getCartProductNum()).getProductPrice());
        order.setOrdEmail(ordererEmail); // 여기서 이메일 값을 설정합니다.

        OrdDAO orderDAO = OrdDAO.getOrdDAO();
        orderDAO.insertOrder(order);
        
		// 가장 최신의 주문번호 +1 값 가져오기
		DeliveryDTO delivery = new DeliveryDTO();
		delivery.setOrderNum(orderNum);
		
		// 배송 정보 삽입 DAO 호출
		DeliveryDAO.getDAO().insertDeliveryList(delivery);
		
        
    } catch (Exception e) {
        orderSuccess = false;
        e.printStackTrace();
    }
}

 if (orderSuccess && orderNum > 0) {
   // 주문 성공 시 선택된 항목들만 장바구니에서 삭제
    for (CartDTO cart : cartList) {
        CartDAO.getCartDAO().deleteCart(cart.getCartNum());
    }
	
    //response.sendRedirect("orderComplete.jsp"); 
   response.sendRedirect(request.getContextPath() + "/index.jsp?workgroup=cart&work=orderComplete");
    
	/*  cartDAO.clearCartClient(clientNum);
    response.sendRedirect(request.getContextPath() + "/index.jsp?workgroup=cart&work=orderComplete");  */
    
	
	} else {
		
	}


%>
