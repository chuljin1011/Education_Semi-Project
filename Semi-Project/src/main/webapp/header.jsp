<%@page import="xyz.itwill.dto.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.CartDAO"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	List<CartDTO> cartList=null;
	if(loginClient != null)	{
		cartList=CartDAO.getCartDAO().selectCartClient(loginClient.getClientNum());
	}
	
%>

<script type="text/javascript">

function searchProducts(page) {
    var pageSize = 10; // 기본 페이지 크기
    var searchQuery =""; // 필요한 경우 설정
    var keyword = $("#inpSearch").val() || ""; // 검색어 
    var pageNum = page || 1; // 기본 페이지 번호 설정 (page가 정의되지 않은 경우 기본값 1)

    var myUrl = "<%=request.getContextPath()%>/index.jsp?workgroup=main&work=productSearch" +
                 "&pageSize=" + pageSize + "&search=" + encodeURIComponent(searchQuery) +
                 "&keyword=" + encodeURIComponent(keyword) + "&pageNum=" + pageNum; 
    
    $.ajax({
        type: "GET",
        url: myUrl,
        data: {
            query: searchQuery,
            page: pageNum, // pageNum을 명시적으로 추가
            pageSize: pageSize // pageSize를 명시적으로 추가
        },
        success: function(data) {
            $("#results").html(data);
            window.location.href = myUrl; // 수정된 URL로 이동
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error: " + status + ": " + error);
        }
    });
}

$(document).ready(function() {
    $(".btn_search").click(function(event) {
        event.preventDefault(); // 폼 제출 방지
        searchProducts(1, $("#pageSize").val()); // 첫 페이지로 검색, 현재 페이지 크기 사용
    });

    $("#pageSize").change(function() {
        searchProducts(1, $(this).val()); // 페이지 크기가 변경될 때 첫 페이지로 검색
    });
});
</script>

<div id="wrapHead" class="wrap_head">
	<div class="wrap_top">
		<div class="inner_top">
			<% if(loginClient == null) { %>
			<a href="index.jsp?workgroup=client&work=client_login" class="link_top">로그인</a>
			<a href="index.jsp?workgroup=client&work=client_join_terms" class="link_top">회원가입</a>
			<% } else { %>
			<span><span class="login_name">[<%=loginClient.getClientName() %>]</span>님, 환영합니다.</span>
			<a href="index.jsp?workgroup=client&work=client_logout_action" class="link_top">로그아웃</a>
			<% } %>
			
			<% if(loginClient!=null && loginClient.getClientStatus()==9) { %>
			<a href="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=admin_product" class="link_top type2">관리자 페이지</a>
			<% } %>
		</div>
	</div>
	<div class="inner_head clear_fix">
		<h1>
			<span class="screen_out">네이쳐기어</span>
			<a href="index.jsp" class="link_tit"><img src="images/logo_camp.png" alt="네이쳐기어"></a>
		</h1>
		<div class="wrap_search">
			<h2 class="screen_out">검색</h2>
			<form action="#" method="get" class="form_search">
				<fieldset>
					<legend class="screen_out">통합검색</legend>
					<input type="text" name="inpSearch" id="inpSearch" class="inp_search">
					<button type="submit" class="btn_search"><span>검색</span></button>
				</fieldset>
			</form>
		</div>
		<div class="wrap_menu">
			<ul class="list_menu">
				<li>
					<a href="<%if(loginClient==null){ %>index.jsp?workgroup=client&work=client_login <%}else { %>index.jsp?workgroup=mypage&work=mypage<%} %>" class="link_menu">
						<img src="images/top_mypage.png" alt="마이페이지">
						<span>마이페이지</span>
					</a>
				</li>
				<li>
					<a href="<%if(loginClient==null){ %>index.jsp?workgroup=client&work=client_login <%}else { %>index.jsp?workgroup=cart&work=cart<%} %>" class="link_menu">
						<img src="images/top_cart.png" alt="장바구니">
						<span>장바구니</span>
						<%if(loginClient!=null){ %>
						<span class="screen_out">상품갯수</span><span class="num_product"><%=cartList.size() %></span>
						<% } %>
					</a>
				</li>
			</ul>
		</div>
	</div>
	<div class="wrap_nav">
		<div class="inner_nav clear_fix">
			<div class="wrap_cate">
				<h2 class="all_cate">전체카테고리</h2>
				<ul class="list_cate">
					<li>
						<a href="index.jsp?workgroup=product&work=product_list_type&type=1&sort=date" class="link_cate">텐트</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">쉘터</a></li>
							<li><a href="#" class="link_cate">거실형텐트</a></li>
							<li><a href="#" class="link_cate">티피텐트</a></li>
							<li><a href="#" class="link_cate">팝업텐트</a></li>
							<li><a href="#" class="link_cate">에어텐트</a></li>
							<li><a href="#" class="link_cate">차박텐트</a></li>
							<li><a href="#" class="link_cate">루프탑텐트</a></li>
							<li><a href="#" class="link_cate">텐트소품</a></li>
						</ul>
					</li>
					<li>
						<a href="index.jsp?workgroup=product&work=product_list_type&type=2&sort=date" class="link_cate">랜턴</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					<%-- 
					<li>
						<a href="#" class="link_cate">타프</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
							<li><a href="#" class="link_cate">텐트</a></li>
						</ul>
					</li>
					<li>
						<a href="#" class="link_cate">이블/체어/가구</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					--%>
					<li>
						<a href="index.jsp?workgroup=product&work=product_list_type&type=3&sort=date" class="link_cate">매트/침낭/해먹</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					<li>
						<a href="index.jsp?workgroup=product&work=product_list_type&type=4&sort=date" class="link_cate">화로대/버너</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					<%-- 
					<li>
						<a href="#" class="link_cate">쿨러/식기/물품</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					--%>
					<li>
						<a href="index.jsp?workgroup=product&work=product_list_type&type=5&sort=date" class="link_cate">박스/웨건/가방</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					<%--
					<li>
						<a href="#" class="link_cate">전기용품</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					<li>
						<a href="#" class="link_cate">서큘레이터/에어컨</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					<li>
						<a href="#" class="link_cate">전기요/난로/난방용품</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					<li>
						<a href="#" class="link_cate">레저/자동차</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					<li>
						<a href="#" class="link_cate">의류/잡화/키즈</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					<li>
						<a href="#" class="link_cate">푸드</a>
						<ul class="list_cate_sub">
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
							<li><a href="#" class="link_cate">돔텐트</a></li>
						</ul>
					</li>
					--%>
				</ul>
			</div>
			<div class="wrap_gnb">
				<h2 class="screen_out">서비스 주요 메뉴</h2>
				<ul class="list_gnb">
					<%-- 
					<li><a href="index.jsp?workgroup=product&work=new_product" class="link_gnb">신상품</a></li>
					<li><a href="index.jsp?workgroup=product&work=best_product" class="link_gnb">베스트</a></li>
					<li><a href="index.jsp?workgroup=product&work=sale_product" class="link_gnb">특가혜택</a></li>
					<li><a href="index.jsp?workgroup=product&work=restock_product" class="link_gnb">재입고</a></li>
					<li><a href="index.jsp?workgroup=product&work=refur_product" class="link_gnb">리퍼</a></li>
					--%>
					<li><a href="index.jsp?workgroup=product&work=product_list&rank=1&sort=date" class="link_gnb">신상품</a></li>
					<li><a href="index.jsp?workgroup=product&work=product_list&rank=2&sort=date" class="link_gnb">베스트</a></li>
					<li><a href="index.jsp?workgroup=product&work=product_list&rank=3&sort=date" class="link_gnb">특가혜택</a></li>
					<li><a href="index.jsp?workgroup=product&work=product_list&rank=4&sort=date" class="link_gnb">재입고</a></li>
					<li><a href="index.jsp?workgroup=product&work=product_list&rank=5&sort=date" class="link_gnb">리퍼</a></li>
				</ul>
			</div>	
			<ul class="list_board">
				<li><a href="index.jsp?workgroup=board&work=notice_list" class="link_board">공지사항</a></li>
				<li><a href="index.jsp?workgroup=board&work=qna_list" class="link_board">고객문의</a></li>
			</ul>
		</div>
	</div>
</div>