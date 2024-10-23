<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/orderComplete.css">

    <div class="contents">
        <div id="locationWrap"><br>홈 > 주문 완료</div>
        <div class="sub_content">
            <div class="content_box">
                    <!-- <h2 class="order_h2">주문 완료</h2> -->
                	<img src="<%=request.getContextPath()%>/images/order.jpg" class="order_image">
                	
                <div class="order_title">
                    <p>고객님의 주문이 성공적으로 완료되었습니다.</p>
                    
                    <a href="<%=request.getContextPath() %>/index.jsp" class="orderHome">메인으로 이동</a>
                </div>
            </div>
        </div>
    </div>
