<%@page import="xyz.itwill.dao.ReviewDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<link rel="stylesheet" type="text/css"
	href="css/mypage_client_update.css">
<link rel="stylesheet" type="text/css" href="css/join.css">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<%@ include file="/security/login_check.jspf"%>

<%
//세션에서 로그인한 클라이언트 정보를 가져와 ClientDTO 객체로 변환
ClientDTO loginClinet = (ClientDTO) session.getAttribute("loginClient");
//로그인한 클라이언트의 번호를 가져옴
Integer clientNum = loginClient.getClientNum();
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
int totalReivew = ReviewDAO.getDAO().countReviewList(search, keyword, clientNum); //게시글의 총갯수 client_num 기준

//페이지의 총갯수를 계산하여 저장
//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
int totalPage = (int) Math.ceil((double) totalReivew / pageSize);

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
if (endRow > totalReivew) {
	endRow = totalReivew;
}

//페이징 관련 정보(시작행번호, 종료행번호)와 게시글 조회기능 관련 정보(조회대상과 조회단어)를
//전달받아 REVIEW 테이블에 저장된 행에서 조회정보가 포함된 행을 페이징 처리로 검색하여
//List 객체를 반환하는 ReviewDAO 클래스의 메소드 호출
List<ReviewDTO> reviewList = ReviewDAO.getDAO().selectReviewAllbyNumPaging(startRow, endRow, clientNum, search, keyword);

//게시글에 출력될 일련번호 시작값을 계산하여 저장
// => 게시글의 총갯수가 91개인 경우 => 1Page : 91, 2Page : 81, 3Page : 71, ...\
int displayNum = totalReivew - (pageNum - 1) * pageSize;
%>
<style>
#title-text {
	background: white;
	height: 40px;
	margin-bottom: 0;
	display: inline-block;
	width: 50%;
	float: left;
	font-size: 18px;
	vertical-align: middle;
}

#info_text_1 {
	display: inline-block;
	width: 50%;
	float: left;
	font-size: 18px;
	vertical-align: middle;
}

#info_text_2 {
	display: inline-block;
	float: right;
}
</style>

<div class="sub-menu-link">
	<p>홈 > 마이페이지</p>
</div>
<div class="container" style="margin-bottom: 100px;">
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
	<div class="main-content"  style="position: relative; top: -65px">
	
		<div>
			<p id="title-text">나의 리뷰 조회</p>
			<div class="review-table">
				<table>
					<thead>
						<tr>
							<th width="200">리뷰제목</th>
							<th width="100">리뷰내용</th>
							<th width="500">답글</th>
						</tr>
					</thead>
					<tbody>
						
						<% if(totalReivew == 0) { %>
							<tr>
								<td colspan="3">작성한 리뷰가 없습니다.</td>
							</tr>
						<% } else { %>
							<%for (ReviewDTO review : reviewList) { %>
							
							<tr>
								<td><%=review.getReviewSubject()%></td>
								<td><%=review.getReviewLevel()%></td>
								<%if(review.getReviewReplay() != null) { %>
									<td><%=review.getReviewReplay()%>
								<% } else { %>
									<td>답글미작성</td>
								<% } %>
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
							String myUrl=request.getContextPath()+"/index.jsp?workgroup=mypage&work=myreview"
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
</div>

<%-- <script type="text/javascript">
//입력태그(게시글갯수)의 입력값을 변경한 경우 호출되는 이벤트 처리 함수 등록
$("#pageSize").change(function() {	
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=myreview"
		+"&pageNum=<%=pageNum%>&pageSize="+$("#pageSize").val()+"&search=<%=search%>&keyword=<%=keyword%>";
});
</script>
 --%>







































