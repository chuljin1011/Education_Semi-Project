<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dto.DeliveryDTO"%>
<%@page import="xyz.itwill.dao.DeliveryDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	//세션에서 로그인한 클라이언트 정보를 가져와 ClientDTO 객체로 변환
	ClientDTO loginClinet = (ClientDTO) session.getAttribute("loginClient");
	//로그인한 클라이언트의 번호를 가져옴
	Integer clientNum = loginClinet.getClientNum();
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	
	
	DeliveryDAO deliveryDAO = new DeliveryDAO();
	//List<DeliveryDTO> deliveryList = deliveryDAO.getDeliveriesByDateRange(startDate, endDate, clientNum);
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
int totalDeilvery = DeliveryDAO.getDAO().countDeliveryListRecentPaging(startDate, endDate, search, keyword, clientNum); //게시글의 총갯수

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
List<DeliveryDTO> deliveryList = DeliveryDAO.getDAO().getDeliveriesByDateRangePaging(startDate, endDate, clientNum, startRow, endRow, search, keyword);

//게시글에 출력될 일련번호 시작값을 계산하여 저장
// => 게시글의 총갯수가 91개인 경우 => 1Page : 91, 2Page : 81, 3Page : 71, ...\
int displayNum = totalDeilvery - (pageNum - 1) * pageSize;
%>

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
			<% if(deliveryList == null) { %>
				<tr>
					<!-- 배송 내역이 없을 경우 문구 출력 -->
					<td colspan="5">배송내역이 없습니다.</td>
				</tr>
				
			<% } else { %>
				<% for(DeliveryDTO delivery : deliveryList) { %>
		        <tr>
		            <!-- 날짜 / 주문번호 -->
		            <td><%= delivery.getDeliveryCreate() %> 
		            	/<br> CO24UD10RE<%= delivery.getOrderNum() %>
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
