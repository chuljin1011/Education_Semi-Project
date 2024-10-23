<%@page import="java.nio.channels.ClosedByInterruptException"%>
<%@page import="xyz.itwill.dao.OrdDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="xyz.itwill.dto.OrdDTO"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.Clinit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="xyz.itwill.dto.ClientDTO"%>
<%@ page import="xyz.itwill.dao.ClientDAO"%>
<%@ page import="xyz.itwill.dto.CartDTO"%>
<%@ page import="xyz.itwill.dao.CartDAO"%>
<%@ page import="xyz.itwill.dto.ProductDTO"%>
<%@ page import="xyz.itwill.dao.ProductDAO"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/order.css">
<script src="<%=request.getContextPath()%>/js/order.js"></script>

<%
    // 세션에서 clientNum 가져오기
    ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
    int clientNum = loginClient.getClientNum();

    // 선택된 장바구니 항목 가져오기
    String[] selectedCartNums = request.getParameterValues("selectedCartNums");
    List<CartDTO> cartList = new ArrayList<>();
    if (selectedCartNums != null) {
        for (String cartNum : selectedCartNums) {
            cartList.add(CartDAO.getCartDAO().selectCart(Integer.parseInt(cartNum)));
        }
    }

    ProductDAO productDAO = ProductDAO.getDAO();

    int totalSum = 0;
    int delivery = 3000;
    int itemTotal = 0;
%>



<div class="contents">
    <div id="locationWrap">
        <br>홈 > 주문서작성/결제
    </div>
    <div class="sub_content">
        <div class="content_box">
            <div class="order_title">
            <br>
              <!--   <h2>주문서작성/결제</h2> -->
               <ol>
                    <li class="page_on"><span>03</span> 주문완료</li>
                   
                    <li>
                    	<img alt="화살표" src="<%=request.getContextPath()%>/images/step_on.png" class="step_images" style="color: #d1d1d1;">
                    </li>
                    
                    <li ><span>02</span>주문서작성/결제</li>
                    
                    <li>
                    	<img alt="화살표" src="<%=request.getContextPath()%>/images/step_on.png" class="step_images">
                    </li>
                    
                    <li><span class="page_on">01 장바구니</span></li>
                </ol>
            </div>
            
            
            <div class="cart_content_list">
                <div class="order_cart_title">
                    <h3>주문상세내역</h3>
                </div>
                <div class="order_table order_table_type">
                    <table>
                        <!-- <colgroup>
                            <col>
                            <col style="width: 26%;">
                            <col style="width: 10%;">
                            <col style="width: 13%;">
                            <col style="width: 10%;">
                            <col style="width: 8%;">
                        </colgroup>
                        <thead class="form_element">
                            <tr>
                                <th></th>
                                <th>상품/옵션 정보</th>
                                <th>수량</th>
                                <th>가격</th>
                                <th>상품합계</th>
                                <th>택배비</th>
                            </tr>
                        </thead> -->
                        
                         <thead >
                        <tr class="cart_tr ">
                            <th><input type="checkbox" id="selectAll"></th>
                            
                            <th>상품/옵션정보</th>
                            <th>가격</th>
                            <th>수량</th>
                            <th>상품합계</th>
                            <th>배송비</th>
                        </tr>
                    </thead>
                        <tbody>
                            <%
                            if (cartList != null && !cartList.isEmpty()) { 
                                for (CartDTO cart : cartList) {
                                    ProductDTO product = productDAO.selectProduct(cart.getCartProductNum());
                                    if (product == null) {
                                        out.println("<tr><td colspan='4'>상품 정보를 가져오는데 실패했습니다.</td></tr>");
                                        continue;
                                    }
                                    int productPrice = product.getProductPrice();
                                    itemTotal = cart.getCartCount() * productPrice;
                                    totalSum += itemTotal;
                            %>
                            <%-- <tr class="order_goods">
                                <td><img src="<%=request.getContextPath()%>/images/nestout.jpg" class="img_product" style="width:60px"></td>
                                <td><%= product.getProductName() %><br><span>&nbsp;옵션&nbsp;:&nbsp;&nbsp;<%=cart.getCartOpt() %></span></td>
                                <td class="td_left"><%=product.getProductName()%></td>
                                <td class="td_order_amount">
                                    <div class="order_goods_num">
                                        <strong><%=cart.getCartCount()%> 개</strong>
                                    </div>
                                </td>
                                <td><strong class="order_sum_txt price"><%=productPrice%> 원</strong></td>
                                <td><strong class="order_sum_txt"><%=itemTotal%> 원</strong></td>
                                <td class="td_delivery">기본 - 금액별 배송비 <br> <%=delivery%>원 <br>(택배선결제)</td>
                            </tr>
                            <% } } else { %>
                            <tr><td colspan='6'>장바구니에 담긴 상품이 없습니다.</td></tr>
                            <% } %> --%>
                             <tr data-cart-num="<%= cart.getCartNum() %>">
                       		<td><input type="checkbox" name="selectedCart" value="<%= cart.getCartNum() %>"></td>
                        	
                       		<td>
                       			<img src="<%=request.getContextPath()%>/img_product/<%=product.getProductMainImg() %>" class="img_product" style="width:50px">
                       			<span class="name_opt">
                       				<span class="name_product"><%= product.getProductName() %></span>
                       				<span class="opt_product">&nbsp;옵션&nbsp;:&nbsp;&nbsp;<%=cart.getCartOpt() %></span>
                       			</span>
                       		</td>
                       		<td class="order_sum_price "><strong><%=productPrice%> 원</strong></td>
                          	<td class="number_up">
                          	
                          	<%-- <input type="text"  value="<%= cart.getCartCount() %>"  onchange="updateCartQuantity(<%= cart.getCartNum() %>, this.value)"> --%>
                          	
    						<strong><span id="cartCount_<%= cart.getCartNum() %>" data-count="<%= cart.getCartCount() %>"><%= cart.getCartCount() %></span></strong>

                          	</td>
                            <td class="productPrice"><strong><%= itemTotal %>원</strong></td>
                            <td class="td_delivery">기본 - 금액별 배송비 <br> <%=delivery%>원 <br>(택배선결제)</td>
                            </tr>
                        <% } } else { %>
                        <tr><td colspan='6'>장바구니에 담겨있는 상품이 없습니다.</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="btn_left_box">
                <a href="<%=request.getContextPath() %>/index.jsp?workgroup=cart&work=cart" class="shop_go_link">◁&nbsp;장바구니 가기</a>
            </div>
        </div>
        <div class="price_summary">
            <div class="price_summary_content">
                <div class="price_summary_list">
                    <dl>
                        <dt>총 <%=cartList.size()%> 개의 상품금액</dt>
                        <dd><%=totalSum%> 원</dd>
                    </dl>
                    <span><img src="<%=request.getContextPath()%>/images/order_price_plus.png"></span>
                    <dl>
                        <dt>배송비</dt>
                        <dd><%=delivery%> 원</dd>
                    </dl>
                    <span><img src="<%=request.getContextPath()%>/images/order_price_total.png"></span>
                    <dl>
                        <dt>합계</dt>
                        <dd><%=totalSum + delivery%> 원</dd>
                    </dl>
                </div>
            </div>
        </div>
        <form action="<%=request.getContextPath()%>/cart/processOrder.jsp" method="post">
        	<%
    			for (String cartNum : selectedCartNums) {
        		out.println("<input type='hidden' name='selectedCartNums' value='" + cartNum + "'>");
   				 }
   			 %>
            <div class="order_information">
                <div class="order_zone_title">
                    <h4>주문자 정보</h4>
                </div>
                <div class="order_table">
                    <table class="table_left">
                        <colgroup>
                            <col style="width: 15%;">
                            <col style="width: 80%;">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th><span class="important">주문하시는분</span></th>
                                <td><input type="text" name="orderer_name" value="<%=loginClient.getClientName()%>"></td>
                            </tr>
                            <tr>
                                <th><span class="important">전화번호</span></th>
                                <td><input type="text" name="orderer_phone" value="<%=loginClient.getClientMobile()%>"></td>
                            </tr>
                            <tr>
                                <th><span class="important">이메일</span></th>
                                <td><input type="text" name="orderer_email" value="<%=loginClient.getClientEmail()%>">
                                    <select name="email_domain">
                                        <option value="text">직접입력</option>
                                        <option value="naver.com">@naver.com</option>
                                        <option value="daum.net">@daum.net</option>
                                        <option value="gmail.com">@gmail.com</option>
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="delivery_information">
                <div class="order_zone_title">
                    <h4>배송 정보</h4>
                </div>
                <div class="order_table">
                    <table class="table_left">
                        <colgroup>
                            <col style="width: 15%;">
                            <col style="width: 80%;">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th><span class="important">배송지 확인</span></th>
                                <td>
                                    <div class="form_element">
                                        <ul>
                                            <li>
                                                <input type="radio" id="default" name="delivery" value="default" checked onclick="toggleAddress(true)">
                                                <label class="choice_s" for="default">기본배송지</label>
                                            </li>
                                            <li>
                                                <input type="radio" id="new" name="delivery" value="new" onclick="toggleAddress(false)">
                                                <label class="choice_s" for="new">배송지 등록</label>
                                            </li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="important">받으실분</span></th>
                                <td><input type="text" id="recipient_name" name="recipient_name"></td>
                            </tr>
                            <tr>
                                <th><span class="important">받으실곳</span></th>
                                <td class="member_address">
                                    <div class="address_postcode">
                                        <input type="text" id="postcode" name="postcode">
                                        <button type="button" id="btn_post_search" class="btn_post_search" onclick="openPostcode()">우편번호검색</button>
                                    </div>
                                    <div class="address_input">
                                        <input type="text" id="address" name="address" width="200">
                                        <input type="text" id="detailAddress" name="detailAddress" width="150">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="important">전화번호</span></th>
                                <td><input type="text" id="recipient_phone" name="recipient_phone"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="payment_method">
                <div class="order_zone_title">
                    <h4>결제수단 선택/결제</h4>
                </div>
                <div class="order_table">
                    <table class="table_left">
                        <colgroup>
                            <col style="width: 15%;">
                            <col style="width: 80%;">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th><span class="important">일반 결제</span></th>
                                <td class="radio_main">
                                  <!--   <input type="radio" name="payment_method" value="bank_transfer">계좌이체
                                    <input type="radio" name="payment_method" value="kakao_pay">카카오페이
                                    <input type="radio" name="payment_method" value="credit_card">신용카드
                                    <input type="radio" name="payment_method" value="mobile_payment">휴대폰결제 -->
                                    <input type="radio" id="bank_transfer" name="payment_method" value="bank_transfer">
									<label for="bank_transfer">계좌이체</label>
									&nbsp;&nbsp;
									<input type="radio" id="kakao_pay" name="payment_method" value="kakao_pay">
									<label for="kakao_pay">카카오페이</label>
									&nbsp;&nbsp;
									<input type="radio" id="credit_card" name="payment_method" value="credit_card">
									<label for="credit_card">신용카드</label>
									&nbsp;&nbsp;
									<input type="radio" id="mobile_payment" name="payment_method" value="mobile_payment">
									<label for="mobile_payment">휴대폰결제</label>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="important">현금영수증/계산서 발행</span></th>
                                <td>
                                    <input type="radio" id="none" name="receipt" value="none">
									<label for="none">신청안함</label>
									&nbsp;&nbsp;
									<input type="radio" id="cash_receipt" name="receipt" value="cash_receipt">
									<label for="cash_receipt">현금영수증</label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="payment_final_total">
                <dl>
                    <dd><span><%=totalSum + delivery%>원</span></dd>
                    <dt>최종 결제 금액</dt>
                </dl>
            </div>
            <div class="btn_center_box">
                <button class="btn_order_buy" type="submit">
                    <em>결제하기</em>
                </button>
            </div>
        </form>
    </div>
</div>

<script>
function toggleAddress(useDefault) {
    if (useDefault) {
        document.getElementById('recipient_name').value = "<%=loginClient.getClientName()%>";
        document.getElementById('postcode').value = "<%=loginClient.getClientZipcode()%>";
        document.getElementById('address').value = "<%=loginClient.getClientAddress1()%>";
        document.getElementById('detailAddress').value = "<%=loginClient.getClientAddress2()%>";
        document.getElementById('recipient_phone').value = "<%=loginClient.getClientMobile()%>";

        document.getElementById('recipient_name').readOnly = true;
        document.getElementById('postcode').readOnly = true;
        document.getElementById('address').readOnly = true;
        document.getElementById('detailAddress').readOnly = true;
        document.getElementById('recipient_phone').readOnly = true;
    } else {
        document.getElementById('recipient_name').value = "";
        document.getElementById('postcode').value = "";
        document.getElementById('address').value = "";    
        document.getElementById('detailAddress').value = "";
        document.getElementById('recipient_phone').value = "";
        document.getElementById('recipient_name').readOnly = false;
        document.getElementById('postcode').readOnly = false;
        document.getElementById('address').readOnly = false;
        document.getElementById('detailAddress').readOnly = false;
        document.getElementById('recipient_phone').readOnly = false;
    }
}
window.onload = function() {
    toggleAddress(true);
};
</script>
