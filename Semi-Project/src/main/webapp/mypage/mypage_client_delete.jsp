<%@page import="xyz.itwill.dao.DeliveryDAO"%>
<%@page import="xyz.itwill.dto.DeliveryDTO"%>
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


<style>
#deleteContainer {
	display: flex;
	width: 900px;
	height: 550px;
	position: relative;
	justify-content: center;
	top: 7px;
	border: 1px solid #ccc;
	position: relative;
	justify-content: center;
}

#deleteBox {
	max-width: 600px; /* 최대 폭 600px */
	margin: 20px auto; /* 중앙 정렬 */
	padding: 20px; /* 내부 여백 */
	border: 2px solid #ccc; /* 테두리 색상 */
	border-radius: 5px; /* 모서리 둥글게 */
	background-color: #f9f9f9; /* 배경색 */
	text-align: center; /* 텍스트 중앙 정렬 */
	align-content: center;
}

#deleteButton {
	padding: 10px 20px; /* 내부 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 5px; /* 모서리 둥글게 */
	background-color: #ccc; /* 버튼 배경색 */
	color: white; /* 글자색 */
	font-size: 16px; /* 글자 크기 */
	cursor: pointer; /* 커서 모양 변경 */
}

/* 버튼 호버 효과 */
#deleteButton:hover {
	background-color: #7fffd4; /* 호버 시 배경색 변경 */
}
/* h1 스타일 추가 */
#deleteContainer h1 {
	margin-top: 100px;
	margin-bottom: 20px; /* 제목과 박스 간의 여백 */
}

p {
	line-height: 24px; /* 줄 간격을 24픽셀로 설정 */
}
</style>

<!-- 로그인 체크를 위한 JSP Include -->
<%@ include file="/security/login_check.jspf"%>

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
	
	<form id="join"
		action="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=mypage_client_delete_action"
		method="post">
		<!-- 로그인한 사용자의 번호(클라이언트넘버)를 히든처리하여 전달 -->
		<input type="hidden" name="num"
			value="<%=loginClient.getClientNum()%>">
		<div id="deleteContainer">
			<div style="text-align: center;">
				<h1>회원 탈퇴</h1>
				<div id="deleteBox">
					<p>회원 탈퇴 안내 회원님의 소중한 계정을 탈퇴하시기 전에 아래 사항을 반드시 확인해 주시기 바랍니다. 회원
						탈퇴를 진행하시면, 계정에 저장된 모든 정보와 데이터가 영구적으로 삭제됩니다. 이 작업은 복구할 수 없으므로 신중히
						결정해 주세요. 탈퇴 후에는 해당 계정으로 서비스에 접근할 수 없으며, 모든 서비스 이용이 제한됩니다. 탈퇴를 원하실
						경우, 아래 "회원 탈퇴하기" 버튼을 클릭해 주세요. 이후에는 재가입이 가능하지만, 이전의 데이터는 복구되지 않습니다.
						추가적인 문의 사항이 있으시면 고객센터로 연락해 주시기 바랍니다. 회원 탈퇴를 원하시면 아래 버튼을 클릭하세요.</p>
				</div>
				<button type="submit" id="deleteButton">회원 탈퇴하기</button>
			</div>
		</div>
	</form>

</div>



