<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%


String rank=request.getParameter("rank");
List<ProductDTO> productListNew=ProductDAO.getDAO().selectProductRank(1);
List<ProductDTO> productListBest=ProductDAO.getDAO().selectProductRank(2);

DecimalFormat df = new DecimalFormat("###,###");

%>

<h2 class="screen_out">메인 콘텐츠</h2>
<div class="section_banner">
	<div class="slide_banner banner1">
		<div class="inner_slide">
			<strong>네이쳐기어 신규 행사</strong>
			<p>
				런칭 기념<br>
				한 달간 텐트 구매 시 알전구 증정<br>
				2024-07-31 ~ 2024-08-31
			</p>
			<span>※리뷰 작성 필수※</span>
		</div>
	</div>
	<div class="slide_banner banner2">
		<div class="inner_slide">
			<strong>네이쳐기어 회원가입 혜택</strong>
			<p>
				회원가입 쿠폰 증정<br>
				10% 할인 쿠폰 증정<br>
				10만원 이상 구매 시
			</p>
			<span>※첫구매 이후부터 사용가능※</span>
		</div>
	</div>
	<div class="slide_banner banner3">
		<div class="inner_slide">
			<strong>네이쳐기어 특별 이벤트</strong>
	        <p>
	            캠핑 용품 대할인<br>
	            모든 상품 20% 할인<br>
	            2024-08-01 ~ 2024-08-15
	        </p>
	        <span>※선착순 100명 한정※</span>
		</div>
	</div>
</div>
<div class="section_comm section_newly">
	<div class="inner_section">
		<h3 class="tit_section"><span>WEEKLY</span> 신상품</h3>
		<ul class="list_product slick_list">
			<% for(ProductDTO product : productListNew) { %>
			<li>
				<a href="index.jsp?workgroup=item_detail&work=item_detail&num=<%=product.getProductNum()%>" class="link_product">
					<span class="wrap_img">
						<img src="<%=request.getContextPath()%>/img_product/<%=product.getProductMainImg() %>" alt="<%=product.getProductMainImg() %>" class="img_product">
					</span>
					<span class="name_product"><%=product.getProductName() %></span>
				</a>
				<span class="screen_out">가격</span><span class="product_price"><%=df.format(product.getProductPrice()) %>원</span>
			</li>
			<%} %>
			<%--<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27831_main_07.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
				<div class="product_stat">
					<span class="ico_stat ico_new">신상품</span>
					<span class="ico_stat ico_best">베스트</span>
				</div>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27839_main_096.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
				<div class="product_stat">
					<span class="ico_stat ico_best">베스트</span>
				</div>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27876_main_050.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
				<div class="product_stat">
					<span class="ico_stat ico_new">신상품</span>
				</div>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27916_main_040.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
				<div class="product_stat">
					<span class="ico_stat ico_new">신상품</span>
				</div>
			</li> --%>
		</ul>
		<a href="index.jsp?workgroup=product&work=product_list&rank=1&sort=date" class="link_total">더보기 &#62;</a>
	</div>
</div>
<div class="section_comm section_brand">
	<div class="inner_section">
		<h3 class="tit_section"><span>브랜드</span> 스토리</h3>
		<div class="brand_story ">
			<strong class="screen_out">트루버</strong>
			<p class="screen_out">
				감성 캠퍼들을 위한 브랜드<br>
				탄/카키 색상으로 사하라 사막의 감성을 더하다<br>
				작은 디테일의 차이로 자신만의 감성을 완성해 보세요
			</p>
		</div>
	</div>				
</div>
<div class="section_comm section_best">
	<div class="inner_section">
		<h3 class="tit_section"><span>BEST</span> 상품</h3>
		<ul class="list_product">
			<% for(ProductDTO product : productListBest) { %>
			<li>
				<a href="index.jsp?workgroup=item_detail&work=item_detail&num=<%=product.getProductNum()%>" class="link_product">
					<span class="wrap_img">
						<img src="<%=request.getContextPath()%>/img_product/<%=product.getProductMainImg() %>" alt="<%=product.getProductMainImg() %>" class="img_product">
					</span>
					<span class="name_product"><%=product.getProductName() %></span>
				</a>
				<span class="screen_out">가격</span><span class="product_price"><%=df.format(product.getProductPrice()) %>원</span>
			</li>
			<%} %>
			<%--<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27831_main_07.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27839_main_096.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27876_main_050.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27916_main_040.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27916_main_040.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27916_main_040.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27916_main_040.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
			</li>
			<li>
				<a href="#" class="link_product">
					<span class="wrap_img">
						<img src="images/27916_main_040.jpg" alt="집게" class="img_product">
					</span>
					<span class="name_product">아베나키 원버너 플레이트상판 IGT테이블 원버너거치대</span>
				</a>
				<span class="screen_out">가격</span><span class="product_price">60,000원</span>
			</li>
			--%>
		</ul>
		<a href="index.jsp?workgroup=product&work=product_list&rank=2&sort=date" class="link_total">더보기 &#62;</a>
	</div>
</div>