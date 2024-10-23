<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalDate"%>
<%@page import="xyz.itwill.dao.OrdDAO"%>
<%@page import="xyz.itwill.dto.OrdDTO"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="xyz.itwill.dao.DeliveryDAO"%>
<%@page import="xyz.itwill.dto.DeliveryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- DataPicker  -->
<!--  jQuery UI의 기본 테마 스타일 시트를 가져옴 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<!-- DatePicker 구현을 위한 jQuery UI 라이브러리를 가져옴  -->
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>

<!-- mypage css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/mypage_order_list.css">
<%-- 선언부 --%>
<!-- 로그인 체크를 위한 JSP Include -->
<%@ include file="/security/login_check.jspf"%>
<%
//세션에서 로그인한 클라이언트 정보를 가져와 ClientDTO 객체로 변환
ClientDTO loginClinet = (ClientDTO) session.getAttribute("loginClient");
//로그인한 클라이언트의 번호를 가져옴
Integer clientNum = loginClinet.getClientNum();

//배달 목록을 조회하기 위해 DeliveryDAO의 메서드를 호출하여 최근 배달 목록을 가져옴
//List<DeliveryDTO> deliveryList = DeliveryDAO.getDAO().selectDeliveryListByNum(clientNum);
%>

<%
//page_list 출력 유무를 결정하는 변수 = 0 출력X
int displayStatus = 1;
//게시글 조회기능에 필요한 전달값(조회대상과 조회단어)을 반환받아 저장
String search = request.getParameter("search");//조회대상
if (search == null) {//전달값이 없는 경우 - 조회기능을 사용하지 않은 경우
	search = "";
}

String keyword = request.getParameter("keyword");//조회단어
if (keyword == null) {
	keyword = "";
}

//페이징 처리에 필요한 전달값(페이지번호와 게시글갯수)을 반환받아 저장
int pageNum = 1;//페이지번호 - 전달값이 없는 경우 사용할 기본값 저장
if (request.getParameter("pageNum") != null) {//전달값이 있는 경우
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}

int pageSize = 5;//게시글갯수 - 전달값이 없는 경우 사용할 기본값 저장
if (request.getParameter("pageSize") != null) {//전달값이 있는 경우
	pageSize = Integer.parseInt(request.getParameter("pageSize"));
}

//조회정보(조회대상과 조회단어)를 전달받아 DELIVERY 테이블에 저장된 행에서 조회정보가 포함된 
//행의 갯수를 검색하여 반환하는 DeliveryDAO 클래스의 메소드 호출
int totalDeilvery = DeliveryDAO.getDAO().countDeliveryList(search, keyword, clientNum); //게시글의 총갯수

//페이지의 총갯수를 계산하여 저장
//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
int totalPage = (int) Math.ceil((double) totalDeilvery / pageSize);

//전달받은 페이지번호가 비상적인 경우 첫번째 페이지를 요청할 수 있는 기본값 저장
if (pageNum <= 0 || pageNum > totalPage) {
	pageNum = 1;
}

//페이지번호에 대한 게시글의 시작 행번호를 계산하여 저장
//ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
int startRow = (pageNum - 1) * pageSize + 1;

//페이지번호에 대한 게시글의 종료 행번호를 계산하여 저장
//ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
int endRow = pageNum * pageSize;

//마지막 페이지의 게시글의 종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행변호 변경
if (endRow > totalDeilvery) {
	endRow = totalDeilvery;
}

//페이징 관련 정보(시작행번호, 종료행번호)와 게시글 조회기능 관련 정보(조회대상과 조회단어)를
//전달받아 REVIEW 테이블에 저장된 행에서 조회정보가 포함된 행을 페이징 처리로 검색하여
//List 객체를 반환하는 ReviewDAO 클래스의 메소드 호출
List<DeliveryDTO> deliveryList = DeliveryDAO.getDAO().getDeliveryListPaging(startRow, endRow, clientNum, search, keyword);

//게시글에 출력될 일련번호 시작값을 계산하여 저장
// => 게시글의 총갯수가 91개인 경우 => 1Page : 91, 2Page : 81, 3Page : 71, ...\
int displayNum = totalDeilvery - (pageNum - 1) * pageSize;
%>

<!--datepicker script-->
<script>
	/*datepicker에 출력내용을 한글로 변경*/
	$(function() {
		$("#datepickerStart,#datepickerEnd").datepicker(
				{	
					showMonthAfterYear: true,		//연도 월 순서로 표시
					changeYear: true,				//연도 선택 가능
					changeMonth: true,				//월 선택 가능
					closeText : "닫기",				
					currentText : "오늘",
					prevText : '이전 달',
					nextText : '다음 달',
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
					dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
					weekHeader : "주",
					yearSuffix : '년',
					dateFormat : "yy-mm-dd"			//연도-월-일 로 날짜 형식 변경
					
				});
	});
</script>

<script type="text/javascript">
$(function() {
    // Datepicker 초기화 : 시작날짜와 종료날짜 설정
    $("#datepickerStart").datepicker();
    $("#datepickerEnd").datepicker();

    // 버튼 클릭 이벤트 핸들러
    
    //1일 버튼을 클릭 할 경우
    $("#btn-1-day").click(function() {
        var startDate = new Date(new Date() -(1 * 24 * 60 * 60 * 1000) ); //1일 전
        var endDate = new Date();
        
        $("#datepickerStart").datepicker("setDate", startDate);
        $("#datepickerEnd").datepicker("setDate", endDate);
    });
    
    //7일 버튼을 클릭 할 경우
    $("#btn-1-week").click(function() {
        var startDate = new Date(new Date() - (7 * 24 * 60 * 60 * 1000)); // 1주일 전
        var endDate = new Date();
        
        $("#datepickerStart").datepicker("setDate", startDate);
        $("#datepickerEnd").datepicker("setDate", endDate);
    });
    
    //15일 버튼을 클릭 할 경우
    $("#btn-2-week").click(function() {
        var startDate = new Date(new Date() - (15 * 24 * 60 * 60 * 1000)); // 15일 전
        var endDate = new Date();
        
        $("#datepickerStart").datepicker("setDate", startDate);
        $("#datepickerEnd").datepicker("setDate", endDate);
    });
	
    //1개월 버튼을 클릭 할 경우
    $("#btn-1-month").click(function() {
        var startDate = new Date(new Date().getFullYear(), new Date().getMonth() - 1, new Date().getDate()); // 1달 전
    	var endDate = new Date();
        
        $("#datepickerStart").datepicker("setDate", startDate);
        $("#datepickerEnd").datepicker("setDate", endDate);
    });
	
    //3개월 버튼을 클릭 할 경우
    $("#btn-3-month").click(function() {
        var startDate = new Date(new Date().getFullYear(), new Date().getMonth() - 3, new Date().getDate()); // 3달 전
    	var endDate = new Date();
        
        $("#datepickerStart").datepicker("setDate", startDate);
        $("#datepickerEnd").datepicker("setDate", endDate);
    });
    
    //1년 버튼을 클릭 할 경우 
    $("#btn-1-year").click(function() {
        var startDate = new Date(new Date().getFullYear() - 1, new Date().getMonth(), new Date().getDate()); // 1년 전
        var endDate = new Date();
        
        $("#datepickerStart").datepicker("setDate", startDate);
        $("#datepickerEnd").datepicker("setDate", endDate);
    });
});

</script>

<script>
	//페이지가 완전히 로드되었을 경우 실행되는 jQuery 함수
	$(document).ready(function() {
		//ID가 datepickerStart, datepickerEnd 인 HTML 요소에 datepicker 기능을 적용
		$("#datepickerStart, #datepickerEnd").datepicker();
	});
</script>

<script type="text/javascript">
$(document).ready(function() {
	//ID 가 dateSelectBtn 버튼을 클릭 할 경우 실행되는 함수
    $("#dateSelectBtn").click(function() {        
		//datepicker 에서 선택한 날짜를 startDate와 endDate에 저장
        var startDate = $("#datepickerStart").val();
        var endDate = $("#datepickerEnd").val();
        
        //ajax 요청
        $.ajax({
            type: "GET",	//GET 방식으로 요청
            url: "<%=request.getContextPath()%>/mypage/selectDeliveryDate.jsp",	//요청 URL
            data: {
                startDate: startDate,	//startDate를 데이터로 전달
                endDate: endDate,		//endDate를 데티어로 전달
            },
            success: function(data) {	//요청이 성공하였을 경우 
            	 $(".recent-order").html(data);		//서버로부터 전달받은 데이터를 recent-order 클래스에 삽입
            },
            error: function(xhr, status, error) {	//요청이 실패하였을 경우 
                console.error("AJAX Error: " + status + ": " + error);	//오류메세지 전달
                alert("서버 요청 중 오류가 발생했습니다.");
            }
        });
	});
});
</script>

<body>
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
					<div>
						<p><%=loginClinet.getClientName()%>님의 정보입니다.	<!-- 로그인한 클라이언트의 이름을 가져와 출력 --> 
						</p>
					</div>
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
				<h2 style="display: inline;">주문목록/배송조회</h2>
			</div>
			<div class="order-date-picker-container">

				<h3 style="margin-bottom: 2px;">조회기간</h3>
				<div class="datepicker-btn">
					<!-- 날짜 범위 선택 버튼 -->
					<button type="button" id="btn-1-day">1일</button>
					<button type="button" id="btn-1-week">7일</button>
					<button type="button" id="btn-2-week">15일</button>
					<button type="button" id="btn-1-month">1개월</button>
					<button type="button" id="btn-3-month">3개월</button>
					<button type="button" id="btn-1-year">1년</button>
				</div>

				<div>
					<!-- 시작날짜 입력을 위한 필드 datepicker만 사용하게 readonly 설정 -->
					<input type="text" id="datepickerStart" readonly="readonly">
				</div>
				<h2>~</h2>
				<div>
					<!-- 종료날짜 입력을 위한 필드 datepicker만 사용하게 readonly 설정 -->
					<input type="text" id="datepickerEnd" readonly="readonly">
				</div>

				<div>
					<!-- 선택한 날짜 값을 통해 동작하는 조회 버튼  -->
					<button id="dateSelectBtn" type="button" style="width: 50px;">조회</button>
				</div>
			</div>

			<div class="recent-order">
				<div class="order-title">
					<h3 style="color: #bbb;">주문목록 / 배송조회 내역</h3>
				</div>
				<table class="recent-table">
					<thead>
						<tr>
							<th width="200">주문날짜/주문번호</th>
							<th width="500">상품명/옵션</th>
							<th width="100">상품금액</th>
							<th width="100">구매수량</th>
							<th width="100">주문상태</th>
						</tr>
					</thead>
					<tbody id="delievryTableBody">
						<% if(totalDeilvery == 0) { %>
							<tr>
								<!-- 배송 내역이 없을 경우 문구 출력 -->
								<td colspan="5">배송내역이 없습니다.</td>
							</tr>
							
						<% } else { %>
							<% for(DeliveryDTO delivery : deliveryList) { %>
					        <tr>
					            <!-- 날짜 / 주문번호 -->
					            <td><%= delivery.getDeliveryCreate() %> 
					            	/ CO24UD10RE<%= delivery.getOrderNum() %>
					            </td>
					            <!-- 상품명 -->
					            <td><%= delivery.getProductName() %></td>
					            <!-- 상품금액 -->
					            <td><%= delivery.getPaySum() %> 원</td>
					            <!-- 수량 -->
					            <td><%= delivery.getOrdCount() %> 개</td>
					            <!-- 주문상태 -->
								<%
								String statusMessage;
		
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
								<td><%=statusMessage%></td>
					        </tr>
					    	<% } %>
						<% } %>
						<%-- 페이지 번호 출력 --%>
						<%
							//하나의 페이지블럭에 출력될 페이지번호의 갯수 설정
							int blockSize=5;
						
							//페이지블럭에 출력될 시작 페이지번호를 계산하여 저장
							//ex) 1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
							int startPage=(pageNum-1)/blockSize*blockSize+1; 
					
							//페이지블럭에 출력될 종료 페이지번호를 계산하여 저장
							//ex) 1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
							int endPage=startPage+blockSize-1;
							
							//종료 페이지번호가 페이지 총갯수보다 큰 경우 종료 페이지번호 변경
							if(endPage > totalPage) {
								endPage=totalPage;
							}
						%>
						<%
							//pageSize, search, keyword 값을 추가한 요청 URL을 생성
							String myUrl=request.getContextPath()+"/index.jsp?workgroup=mypage&work=mypage_order_list"
								+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword;
						%>						
					</tbody>
				</table>
				
			    <div id="page_list" style="text-align: center;">
			        <%-- 이전 블럭을 출력할 수 있는 링크 제공 --%>
			        <% if(startPage > blockSize) { %>
			            <a href="<%=myUrl%>&pageNum=<%=startPage-blockSize%>">[이전]</a>
			        <% } else { %>
			            [이전]
			        <% } %>
			        
			        <% for(int i = startPage ; i <= endPage ; i++) { %>
			            <%-- 현재 처리중인 페이지 번호와 출력된 페이지 번호가 같지 않은 경우 링크 제공 --%>
			            <% if(pageNum != i) { %>
			                <a href="<%=myUrl%>&pageNum=<%=i%>">[<%=i %>]</a>
			            <% } else { %>
			                [<%=i %>]
			            <% } %>
			        <% } %>
			        
			        <%-- 다음 블럭을 출력할 수 있는 링크 제공 --%>
			        <% if(endPage != totalPage) { %>
			            <a href="<%=myUrl%>&pageNum=<%=startPage+blockSize%>">[다음]</a>
			        <% } else { %>
			            [다음]
			        <% } %>
			    </div>
		
			</div>
		</div>
	</div>
	
	
<%-- <script type="text/javascript">
//입력태그(게시글갯수)의 입력값을 변경한 경우 호출되는 이벤트 처리 함수 등록
$("#pageSize").change(function() {	
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=mypage_order_list"
		+"&pageNum=<%=pageNum%>&pageSize="+$("#pageSize").val()+"&search=<%=search%>&keyword=<%=keyword%>";
});
</script> --%>