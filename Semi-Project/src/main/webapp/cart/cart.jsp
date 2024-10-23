
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="xyz.itwill.dto.ClientDTO"%>
<%@ page import="xyz.itwill.dao.ClientDAO"%>
<%@ page import="xyz.itwill.dto.CartDTO"%>
<%@ page import="xyz.itwill.dao.CartDAO"%>
<%@ page import="xyz.itwill.dto.ProductDTO"%>
<%@ page import="xyz.itwill.dao.ProductDAO"%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/cart.css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%
    // 세션에서 clientNum 가져오기
    ClientDTO loginClient = (ClientDTO) session.getAttribute("loginClient");
    int cartNum = loginClient.getClientNum();

    List<CartDTO> cartList = CartDAO.getCartDAO().selectCartClient(cartNum);
    ProductDAO productDAO = ProductDAO.getDAO();
    
    
    
    int totalSum = 0;
    int delivery = 3000;
    int itemTotal = 0;
%>

<div class="contents">
    <div id="locationWrap"><br>홈 > 장바구니</div>
    <div class="sub_content">
        <div class="content_box">
            <div class="order_tit">
                <br>
               <!-- <h2>장바구니</h2> -->
                <ol>
                    <li class="page_on"><span>03</span> 주문완료</li>
                   
                    <li>
                    	<img alt="화살표" src="<%=request.getContextPath()%>/images/step_on.png" class="step_images" style="color: #d1d1d1;">
                    </li>
                    
                    <li class="page_on"><span>02</span>주문서작성/결제</li>
                    
                    <li>
                    	<img alt="화살표" src="<%=request.getContextPath()%>/images/step_on.png" class="step_images">
                    </li>
                    
                    <li><span>01 장바구니</span></li>
                </ol>
            </div>
        </div>
        <div class="cart_cont order_table_type">
            <form id="orderForm" action="order.jsp" method="post">
                <table>
                    <thead >
                        <tr class="cart_tr">
                            <th><input type="checkbox" id="selectAll"></th>
                            
                            <th>상품/옵션정보</th>
                            <th>가격</th>
                            <th>수량</th>
                            <th>상품합계</th>
                            <th>배송비</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (cartList != null && !cartList.isEmpty()) { 
                            for (CartDTO cart : cartList) {
                                ProductDTO product = productDAO.selectProduct(cart.getCartProductNum());
                                if (product == null) {
                                    out.println("<tr><td colspan='5'>상품 정보를 가져오는데 실패했습니다.</td></tr>");
                                    continue;
                                }
                                int productPrice = product.getProductPrice();
                                itemTotal = cart.getCartCount() * productPrice;
                                totalSum += itemTotal;
                        %>
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
                          	<td class="number_up"><input type="number" min="1" max="99" value="<%= cart.getCartCount() %>"  onchange="updateCartQuantity(<%= cart.getCartNum() %>, this.value)"></td>
                            <td class="productPrice"><strong><%= itemTotal %>원</strong></td>
                            <td class="td_delivery">기본 - 금액별 배송비 <br> <%=delivery%>원 <br>(택배선결제)</td>
                            </tr>
                        <% } } else { %>
                        <tr><td colspan='6'>장바구니에 담겨있는 상품이 없습니다.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </form>
        </div>
        <div class="btn_left_box"><a href="<%=request.getContextPath() %>/index.jsp" class="shop_go_link">◁&nbsp;쇼핑 계속하기</a></div>
    </div>
    <div class="price_sum">
    <div class="price_sum_cont">
        <div class="price_sum_list">
            <dl class="sum_list">
                <dt>총 <%= cartList.size() %> 개의 상품금액</dt>
                <dd id="priceSum"><%= totalSum %> 원</dd>
            </dl>
            <span><img src="<%=request.getContextPath() %>/images/order_price_plus.png" ></span>
            <dl>
                <dt>배송비</dt>
                <dd>3000원</dd>
            </dl>
            <span><img src="<%=request.getContextPath() %>/images/order_price_total.png"></span>
            <dl class="sum_list">
                <dt>합계</dt>
                <dd id="orderTotal"><%= totalSum + delivery %> 원</dd>
            </dl>
        </div>
    </div>
</div>
    <div class="btn_order_box">
        <span class="btn_left_box">
            <button type="button" class="btn_order_choice_del" onclick="deleteSelectedItems()">선택 상품 삭제</button>
        </span>
        <span class="btn_right_box">
            <button type="button" class="btn_order_choice_buy" onclick="submitSelectedOrder()">선택 상품 주문</button>
            <button type="button" class="btn_order_whole_buy" onclick="submitWholeOrder()"> 전체 상품 주문</button>
        </span>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
document.getElementById('selectAll').addEventListener('click', function(event) {
    var checkboxes = document.querySelectorAll('input[name="selectedCart"]');
    for (var checkbox of checkboxes) {
        checkbox.checked = event.target.checked;
    }
});

// 선택 상품 주문
function submitSelectedOrder() {
    var selected = document.querySelectorAll('input[name="selectedCart"]:checked');
    if (selected.length > 0) {
        var orderForm = document.getElementById('orderForm');
        
        // 기존에 생성된 hidden input 제거
        var existingInputs = document.querySelectorAll('input[name="selectedCartNums"]');
        existingInputs.forEach(function(input) {
            input.remove();
        });

        // 선택된 상품들을 hidden input으로 추가
        selected.forEach(function(checkbox) {
            var hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'selectedCartNums';
            hiddenInput.value = checkbox.value;
            orderForm.appendChild(hiddenInput);
        });

       <%--  orderForm.action = "<%=request.getContextPath()%>/cart/order.jsp"; --%>
       <%--orderForm.action =request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=cart&work=/order.jsp");--%>
       document.getElementById('orderForm').action = "<%=request.getContextPath()%>/index.jsp?workgroup=cart&work=order";
        orderForm.submit();
    } else {
        alert("주문할 상품을 선택해 주세요.");
    }
}

// 전체 상품 주문
function submitWholeOrder() {
    var checkboxes = document.querySelectorAll('input[name="selectedCart"]');
    if (checkboxes.length > 0) {
        var orderForm = document.getElementById('orderForm');

        // 기존에 생성된 hidden input 제거
        var existingInputs = document.querySelectorAll('input[name="selectedCartNums"]');
        existingInputs.forEach(function(input) {
            input.remove();
        });

        // 모든 상품들을 hidden input으로 추가
        checkboxes.forEach(function(checkbox) {
            var hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'selectedCartNums';
            hiddenInput.value = checkbox.value;
            orderForm.appendChild(hiddenInput);
            checkbox.checked = true; // 모든 상품을 선택 상태로 변경
        });

        <%-- orderForm.action = "<%=request.getContextPath()%>/cart/order.jsp"; --%>
        document.getElementById('orderForm').action = "<%=request.getContextPath()%>/index.jsp?workgroup=cart&work=order";
        orderForm.submit();
    } else {
        alert("장바구니에 상품이 없습니다.");
    }
}

function updateCartQuantity(cartNum, newQuantity) {
    $.ajax({
        type: "POST",
     	//요청을 보낼 URL을 설정합니다. 여기서는 cart_action.jsp
        url: "<%=request.getContextPath()%>/cart/cart_action.jsp", 
        data: {"cartNum": cartNum, "newQuantity": newQuantity   }, 
     	//서버로 보낼 데이터를 객체 형태로 설정합니다. cartNum과 newQuantity 값을 포함합니다
        dataType: "json",  
        //서버 응답을 JSON 형식으로 기대합니다
        success: function(response) {//요청이 성공적으로 완료되었을 때 실행됩니다:
            if (response.error) {
                alert(response.error);//서버에서 오류가 발생한 경우 경고 창을 표시합니다:
            } else {
            	//해당 카트 항목의 새로운 가격을 업데이트합니다.
                $('tr[data-cart-num="' + cartNum + '"] .productPrice').text(response.newPrice + " 원");
				//전체 총합을 업데이트합니다.
                $('#totalSum').text(response.totalSum + " 원");
				//가격 요약을 업데이트합니다.
                $('#priceSum').text(response.totalSum + " 원");
				//배송비를 포함한 총합을 업데이트합니다
                $('#orderTotal').text(response.totalSum + 3000 + " 원"); // 배송비 포함 합계
            }
        },
        error: function(xhr) {
            alert("에러코드 = " + xhr.status);
        }
    });
}

function deleteSelectedItems() {
    var selected = document.querySelectorAll('input[name="selectedCart"]:checked');
    if (selected.length > 0) {
        var selectedCartNums = [];
        selected.forEach(function(checkbox) {
            selectedCartNums.push(checkbox.value);
        });

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "<%=request.getContextPath()%>/cart/cart_delete.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = JSON.parse(xhr.responseText); 
                if (response.code === "success") {
                    alert("삭제 성공");
                    location.reload();
                } else {
                    alert("삭제 실패");
                }
            }
        };
        xhr.send("cartNums=" + selectedCartNums.join(","));
    } else {
        alert("삭제할 상품을 선택해 주세요.");
    }
}

</script>
