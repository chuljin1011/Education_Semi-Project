<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.dao.OrdDAO"%>
<%@page import="xyz.itwill.dto.OrdDTO"%>
<%@page import="xyz.itwill.dao.DeliveryDAO"%>
<%@page import="xyz.itwill.dto.DeliveryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- DataPicker  -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>

<!-- 로그인 체크를 위한 JSP Include -->
<%@ include file="/security/login_check.jspf"%>

<!-- mypage css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/mypage.css">
	
<%-- 선언부 --%>
<%
	//세션에서 로그인한 클라이언트 정보를 가져와 ClientDTO 객체로 변환
	ClientDTO loginClinet = (ClientDTO) session.getAttribute("loginClient");
	//로그인한 클라이언트의 번호를 가져옴
	Integer clientNum = loginClient.getClientNum();
	
	//배달 목록을 조회하기 위해 DeliveryDAO의 메서드를 호출하여 최근 배달 목록을 가져옴
	List<DeliveryDTO> deliveryList = DeliveryDAO.getDAO().getRecentlyDateByNum(clientNum);
	
%>

<%
	//클라이언트 번호를 기반으로 주문 목록을 조회하기 위한 빈 리스트 생성
	List<OrdDTO> ordList = new ArrayList<>();
	//클라이언트 번호가 유효한 경우, 해당 클라이언트의 주문 목록을 데이터베이스에서 조회
	if (clientNum != null) {
		ordList = OrdDAO.getOrdDAO().selectOrdListByClientNum(clientNum);
	}
	//주문 상태 출력을 위한 반복문
	//주문 상태 출력을 위한 변수 초기화
	int ordStatus1 = 0;		//주문 취소
	int ordStatus2 = 0;		//입금 대기
	int ordStatus3 = 0;		//주문 접수 / 결제 완료
	int ordStatus4 = 0;		//상품 준비 중
	int ordStatus5 = 0;		//배송 중
	int ordStatus6 = 0;		//배송 완료
	int ordStatus7 = 0;		//구매 확정
	
	//주문목록이 유효한 경우 주문상태 변수 값 변경
	if (ordList != null && !ordList.isEmpty()) {
		for (OrdDTO ord : ordList) {
			int ordStatus = ord.getOrdStatus();
			switch (ordStatus) {
			case 1:
		ordStatus1++;
		break;
			case 2:
		ordStatus2++;
		break;
			case 3:
		ordStatus3++;
		break;
			case 4:
		ordStatus4++;
		break;
			case 5:
		ordStatus5++;
		break;
			case 6:
		ordStatus6++;
		break;
			case 7:
		ordStatus7++;
		break;
			}
		}
	//주문 목록이 유효하지 않은 경우 문구 출력
	} else {
		
}
%>

<div class="sub-menu-link">
	<p>홈 > 마이페이지</p>
</div>
<div class="container">
	<div class="left-sidebar">

		<hr>
		<h2>마이페이지</h2>
		<hr>

		<ul class="left-sidebar-menu">
			<li>
				<hr>
				<h3>쇼핑정보</h3>
				<ul class="left-sidebar-menu-child">
					<li><a
						href="index.jsp?workgroup=mypage&work=mypage_order_list"> -
							주문목록/배송조회</a></li>
					<li><a href="">- 취소/반품/교환 내역</a></li>
					<li><a href="">- 환불/입금 내역</a></li>
				</ul>
			</li>
			<li>
				<hr>
				<h3>고객센터</h3>
				<ul class="left-sidebar-menu-child">
					<li><a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_write">- 1:1 문의</a></li>
				</ul>
			</li>
			<li>
				<hr>
				<h3>회원정보</h3>
				<ul class="left-sidebar-menu-child">
					<li><a
						href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=password_confirm&action=update">-
							회원정보 변경</a></li>
					<li><a
						href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=password_confirm&action=delete">-
							회원 탈퇴</a></li>
				</ul>
			</li>
			<li>
				<hr>
				<h3>나의 상품문의</h3>
				<ul class="left-sidebar-menu-child">
					<!-- QnA 페이지로 이동 후 내가 작성한 글만 조회-->
					<li><a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_list&myNotice=true">- 나의 상품문의</a></li>
				</ul>
			</li>
			<li>
				<hr>
				<h3>나의 상품후기</h3>
				<ul class="left-sidebar-menu-child">
					<li><a href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=myreview">- 나의 상품후기</a></li>
				</ul>
			</li>
		</ul>
	</div>
	
	<div class="main-content">

		<div class="mypage-dashboard">
			<div class="mypage-dashboard-left">
				<p><%=loginClient.getClientName()%>님의 정보입니다.	<!-- 로그인한 클라이언트의 이름을 가져와 출력 -->
				</p>	

			</div>
			<div class="mypage-dashboard-center">
				<img src="<%=request.getContextPath()%>/images/icon_coupon.png">
				<h3>쿠폰</h3>
				<h2>0장</h2>
			</div>
			<div class="mypage-dashboard-right">
				<img src="<%=request.getContextPath()%>/images/icon_mileage.png">
				<h3>마일리지</h3>
				<h2>0원</h2>
			</div>
		</div>

		<div class="order-title">
			<h3 style="display: inline;">진행 중인 주문</h3>
			<span style="margin-left: 10px;">최근 30일 내 진행 중인 내역입니다.</span>
		</div>

		<div class="order-status-border">
			<div class="order-status-left">
				<div class="status-item">
					<span> <!-- 2번 상태 -->
						<h4>입금대기</h4>
					</span>
					<div class="status-icon"><%=ordStatus2%></div>
				</div>
				<div class="next_bg">
					<img
						src="<%=request.getContextPath()%>/images/mypgae_ing_next_bg.png">
				</div>
				<div class="status-item">
					<span> <!-- 3번 상태 -->
						<h4>결제완료</h4>
					</span>
					<div class="status-icon"><%=ordStatus3%></div>
				</div>
				<div class="next_bg">
					<img
						src="<%=request.getContextPath()%>/images/mypgae_ing_next_bg.png">
				</div>
				<div class="status-item">
					<span> <!-- 4번 상태 -->
						<h4>상품준비중</h4>
					</span>
					<div class="status-icon"><%=ordStatus4%></div>
				</div>
				<div class="next_bg">
					<img
						src="<%=request.getContextPath()%>/images/mypgae_ing_next_bg.png">
				</div>
				<div class="status-item">
					<span> <!-- 5번 상태 -->
						<h4>배송중</h4>
					</span>
					<div class="status-icon"><%=ordStatus5%></div>
				</div>
				<div class="next_bg">
					<img
						src="<%=request.getContextPath()%>/images/mypgae_ing_next_bg.png">
				</div>
				<div class="status-item">
					<span> <!-- 6번 상태 -->
						<h4>배송완료</h4>
					</span>
					<div class="status-icon"><%=ordStatus6%></div>
				</div>
				<div class="next_bg">
					<img
						src="<%=request.getContextPath()%>/images/mypgae_ing_next_bg.png">
				</div>
				<div class="status-item">
					<span> <!-- 7번 상태 -->
						<h4>구매확정</h4>
					</span>
					<div class="status-icon"><%=ordStatus7%></div>
				</div>
			</div>
			<div class="order-status-right">
				<ul>
					<li><b style="margin-right: 30px;">• 취소</b> <span><%=ordStatus1%>건</span>
						<hr></li>
					<li><b style="margin-right: 30px;">• 교환</b> <span>0건</span>
						<hr></li>
					<li><b style="margin-right: 30px;">• 반품</b> <span>0건</span>
						<hr></li>
				</ul>	

			</div>
		</div>


		<div class="recent-order">
			<!-- 최근 주문 정보 출력부분 -->
			<div class="order-title">
				<h3 style="display: inline;">최근 주문 정보</h3>
				<span style="margin-left: 10px text-align: left: ;">최근 내역 중 10건의 주문하신 내역입니다.</span> 
				<span style="margin-left: 450px; text-align: right;">
				<a href="index.jsp?workgroup=mypage&work=mypage_order_list">+ 더보기</a></span>	<!-- 나의 주문목록으로 이동 -->
			</div>
			<table class="recent-table">
				<thead>
					<tr>
						<th width="100">주문날짜/주문번호</th>
						<th width="500">상품명/옵션</th>
						<th width="100">상품금액</th>
						<th width="100">구매수량</th>
						<th width="100">주문상태</th>
					</tr>
				</thead>

				<tbody id="delievryTableBody">
					<!-- 배송 목록이 유효성 확인 -->
					<%-- <%
					if (deliveryList != null && !deliveryList.isEmpty()) {
						//유효한 경우 deliveryList를 순회하여 DeliveryDTO 객체를 값을 참조
						for (DeliveryDTO delivery : deliveryList) {
					%>
					<!-- 각 delivery 객체의 속성을 통해 값을 출력 -->
					<tr>
						<!-- 날짜 / 주문번호  -->
						<td><%=delivery.getDeliveryCreate()%> / 
						<br>CO24UD10RE<%=delivery.getOrderNum()%></td>
						<!-- 상품명 -->
						<td><%=delivery.getProductName()%></td>	
						<!-- 상품금액 -->
						<td><%=delivery.getPaySum()%></td>
						<!-- 수량 -->
						<td><%=delivery.getOrdCount()%></td>
						<%
						String statusMessage;
						//주문 상태에 따라 출력하는 값 변경
						switch (delivery.getOrdStatus()) {
						    case 1:
						        statusMessage = "주문취소";
						        break;
						    case 2:
						        statusMessage = "입금 대기";
						        break;
						    case 3:
						        statusMessage = "주문접수";
						        break;
						    case 4:
						        statusMessage = "상품준비중";
						        break;
						    case 5:
						        statusMessage = "배송중";
						        break;
						    case 6:
						        statusMessage = "배송완료";
						        break;
						    case 7:
						        statusMessage = "구매확정";
						        break;
						    default:
						        statusMessage = "알 수 없는 상태";
						}
						%>
						<!-- 주문 상태 -->
						<td><%=statusMessage%></td>
					</tr>
					<%
					}
					} else {	//유효하지 않을 경우 출력
					%>
					<tr>
						<td colspan="5">배송 정보가 없습니다.</td>
					</tr>
					<%
					}
					%> --%>
					<%
					if (deliveryList != null && !deliveryList.isEmpty()) {
					    // deliveryList의 크기와 10 중 작은 값으로 반복 횟수 설정
					    int loopCount = Math.min(deliveryList.size(), 10);
					    for (int i = 0; i < loopCount; i++) {
					        DeliveryDTO delivery = deliveryList.get(i); // 인덱스를 사용하여 객체를 참조
					%>
					        <!-- 각 delivery 객체의 속성을 통해 값을 출력 -->
					        <tr>
					            <!-- 날짜 / 주문번호  -->
					            <td><%=delivery.getDeliveryCreate()%> / 
					            <br>CO24UD10RE<%=delivery.getOrderNum()%></td>
					            <!-- 상품명 -->
					            <td><%=delivery.getProductName()%></td>    
					            <!-- 상품금액 -->
					            <td><%=delivery.getPaySum()%></td>
					            <!-- 수량 -->
					            <td><%=delivery.getOrdCount()%></td>
					            <%
					            String statusMessage;
					            // 주문 상태에 따라 출력하는 값 변경
					            switch (delivery.getOrdStatus()) {
					                case 1:
					                    statusMessage = "주문취소";
					                    break;
					                case 2:
					                    statusMessage = "입금 대기";
					                    break;
					                case 3:
					                    statusMessage = "주문접수";
					                    break;
					                case 4:
					                    statusMessage = "상품준비중";
					                    break;
					                case 5:
					                    statusMessage = "배송중";
					                    break;
					                case 6:
					                    statusMessage = "배송완료";
					                    break;
					                case 7:
					                    statusMessage = "구매확정";
					                    break;
					                default:
					                    statusMessage = "알 수 없는 상태";
					            }
					            %>
					            <!-- 주문 상태 -->
					            <td><%=statusMessage%></td>
					        </tr>
					<%
					    }
					} else {    // 유효하지 않을 경우 출력
					%>
					    <tr>
					        <td colspan="5">배송 정보가 없습니다.</td>
					    </tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>