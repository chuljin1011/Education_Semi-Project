<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
    int clientNum = (Integer) session.getAttribute("clientNum");

    CartDAO cartDAO = CartDAO.getCratDAO();
    List<CartDTO> cartList = cartDAO.selectCartClient(clientNum);

    if (cartList.isEmpty()) {
        out.println("장바구니가 비어있습니다");
    } else {
        int totalSum = 0;
        for (CartDTO cart : cartList) {
            totalSum += cart.getCartSum();
        }
--%>

<link rel="stylesheet" type="text/css" href="css/styles.css">

<div class="contents">
    <div id="locationWrap">
        <br>홈 > 주문서작성/결제
    </div>
    <div class="sub_content">
        <div class="content_box">
            <div class="order_title">
                <h2>주문서작성/결제</h2>
                <ol class="order_steps">
                    <li class="step_completed">03 주문완료</li>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <li class="step_current">02 주문서작성/결제</li>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <li class="step_pending">01 장바구니</li>
                </ol>
            </div>
            <div class="cart_content_list">
                <div class="order_cart_title">
                    <h3>주문상세내역</h3>
                </div>
                <div class="order_table">
                    <table>
                        <colgroup>
                            <col>
                            <col style="width: 5%;">
                            <col style="width: 10%;">
                            <col style="width: 13%;">
                            <col style="width: 10%;">
                        </colgroup>
                        <thead class="form_element">
                            <tr>
                                <th>상품/옵션 정보</th>
                                <th>수량</th>
                                <th>상품금액</th>
                                <th>합계금액</th>
                                <th>배송비</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- for (CartDTO cart : cartList) { --%>
                            <tr class="order_goods">
                                <td class="td_left"><%--= cart.getCartProductNum() --%></td>
                                <td class="td_order_amount">
                                    <div class="order_goods_num">
                                        <strong><%--= cart.getCartCount() --%> 개</strong>
                                    </div>
                                </td>
                                <td><strong class="order_sum_txt price"><%--= cart.getCartSum() --%> 원</strong></td>
                                <td><strong class="order_sum_txt"><%--= cart.getCartSum() --%> 원</strong></td>
                                <td class="td_delivery">기본 - 금액별 배송비 <br> 원 <br>(택배선결제)</td>
                            </tr>
                            <%-- } --%>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="btn_left_box">
                <a href="https://www.naver.com" class="shop_go_link">&lt;장바구니가기</a>
            </div>
            <%-- } --%>
        </div>
        <div class="price_summary">
            <div class="price_summary_content">
                <div class="price_summary_list">
                    <dl>
                        <dt>총 <%--= cartList.size() --%> 개의 상품금액</dt>
                        <dd><%--= totalSum --%> 원</dd>
                    </dl>
                    <span> <img src="<%=request.getContextPath()%>/images/order_price_plus.png">
                    </span>
                    <dl>
                        <dt>배송비</dt>
                        <dd>원</dd>
                    </dl>
                    <span> <img src="<%=request.getContextPath()%>/images/order_price_total.png">
                    </span>
                    <dl>
                        <dt>합계</dt>
                        <dd><%--= totalSum --%> 원</dd>
                    </dl>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="payment_final_total">
    <dl>
        <dd>
            <span> <strong><%--= totalSum --%> 원</strong>
            </span>
            <dt>최종 결제 금액</dt>
        </dd>
    </dl>
</div>
<div class="btn_center_box">
    <button class="btn_order_buy" type="button">
        <em>결제하기</em>
    </button>
</div>