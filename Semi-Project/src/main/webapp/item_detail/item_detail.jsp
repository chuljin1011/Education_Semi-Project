<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="xyz.itwill.dao.OptionDAO"%>
<%@page import="xyz.itwill.dto.OptionDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int productNum=Integer.parseInt(request.getParameter("num"));
	ProductDTO product=ProductDAO.getDAO().selectProduct(productNum);
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
	if (loginClient == null) {
	    loginClient = new xyz.itwill.dto.ClientDTO();
	    loginClient.setClientNum(-1);    
	}
	
	List<OptionDTO> optionList=OptionDAO.getDAO().selectOption(productNum);
	/* if(loginClient==null){
		int reviewClientNum=9;
	}else{
		int reviewClientNum=loginClient.getClientNum();
	} */
%>

<link rel="stylesheet" href="css/item_detail.css">

<!-- 상세정보 -->
<div id="mAticle" class="cont_article_sub">
	<div class="sub_cont_article">	
		<div class="location_wrap">
			<div class="location_home"><a href="#">홈</a></div>
			<span>&nbsp;&#62;&nbsp;&nbsp;</span>
			<div class="location_select">
				<div><a href="#">전기용품</a></div>
				<div class="location_img"></div>
				<ul class="location_select_name">
					<li><a href="#" class="location_select_list">텐트</a></li>
					<li><a href="#" class="location_select_list">랜턴</a></li>
					<li><a href="#" class="location_select_list">매트/침낭/해먹</a></li>
					<li><a href="#" class="location_select_list">화로대/버너</a></li>
					<li><a href="#" class="location_select_list">박스/웨건/가방</a></li>
				</ul>
			</div>
		</div>

		<div class="item_info_sec">
			<!-- 상품 이미지 -->
			<div class="item_view_box">
				<div class="item_view_photo">
					<img src="<%=request.getContextPath()%>/img_product/<%=product.getProductMainImg()%>">
					<div class="icon_zoom"></div>
				</div>
				<div class="item_view_slice">
					<div></div>
					<div class="item_view_slice_img">
						<div><img src="<%=request.getContextPath()%>/img_product/<%=product.getProductMainImg()%>"></div>
						<div></div>
						<div></div>
						<div></div>
						<div></div>
					</div>
					<div></div>
				</div>
			</div>
			<!-- 상품 가격정보 -->
			<div class="item_info_box">
				<div class="item_detail_title"><%=product.getProductName()%></div>
				<div class="item_detail_list">
					<ul>
						<li>판매가</li>
						<li><strong><%=product.getProductPrice()%>원</strong></li>
					</ul>
					<ul>
						<li>구매제한</li>
						<li>옵션당 최소1개</li>
					</ul>
					<ul>
						<li>배송비</li>
						<ul>
							<li>4000원 / 주문시결제(선결제)</li>
							<li>택배</li>
						</ul>
					</ul>
					<ul>
						<li>상품코드</li>
						<li><%=product.getProductNum() %></li>
					</ul> 
					<ul>
						<li>브랜드</li>
						<li><%=product.getProductBrand()%></li>
					</ul>
					<ul>
						<li>제조사</li>
						<li><%=product.getProductCom()%></li>
					</ul>
					<ul>
						<li>원산지</li>
						<li><%=product.getProductOrigin() %></li>
					</ul>
					<div class="item_add_option">
						<div>선택</div>
						<select class="chosen_select">
							<option value="" disabled selected >=옵션:가격=</option>
							<% for(OptionDTO option : optionList) { %>
							<option value="<%=option.getOption()%>"><%=option.getOption()%></option>
							<% } %>
						</select>
					</div>
				</div>
				<div class="chosen_total_list">
					<div class="chosen_select_price" >
						<div>총 합계금액</div>
						<div class="total_price"></div>
					</div>
				</div>
				<div class="item_detail_btn">
					<div class="btn_add_cart"></div>
					<div class="btn_add_order">바로 구매</div>
				</div>
			</div>
		</div>

		<div class="item_goods_sec">
			<div id="goods_detail">
				<div class="goods_detail_tab">
					<ul class="goods_detail_tab_name">
						<li class="tab_name_on"><a href="#goods_detail">상품상세정보</a></li>
						<li><a href="#goods_delivery">배송안내</a></li>
						<li><a href="#goods_exchange">교환 및 반품안내</a></li>
						<li><a href="#goods_reviews">상품후기</a></li>
						<li><a href="#relation">상품문의</a></li>	
					</ul>
				</div>
				<div class="goods_detail_cnts_title">상품상세정보</div>
				<div class="goods_detail_cnts">
					<div><img src=" <%=request.getContextPath()%>/img_product/<%=product.getProductSubImg()%>"></div>
				</div>
				<div class="goods_detail_cnts_plus">상세정보 더보기</div>
			</div>
			<div id="goods_delivery">
				<div class="goods_detail_tab">
					<ul class="goods_detail_tab_name">
						<li><a href="#goods_detail">상품상세정보</a></li>
						<li class="tab_name_on"><a href="#goods_delivery">배송안내</a></li>
						<li><a href="#goods_exchange">교환 및 반품안내</a></li>
						<li><a href="#goods_reviews">상품후기</a></li>
						<li><a href="#relation">상품문의</a></li>
					</ul>
				</div>
				<div class="goods_delivery_cnts">
					<div class="goods_delivery_cnts_title">배송안내</div>
					<div class="goods_delivery_cnts_sec">
						<ul>
							<li>&#40;1&#41;배송안내</li>
							<li>배송기간은 주문일(무통장,가상계좌 입금은 결제 완료일)로부터 2일~5일(토요일/공휴일 제외)이 소요될 수 있습니다.</li>
							<li>배송은 각 공급사에서 직배송되며, 공급사별로 배송비가 별도 부과됩니다.(묶음배송 및 조건부무료배송은 공급사별 가능상품만 가능합니다.)</li>
							<li>직접수령은 불가합니다. 온라인 주문/배송만 가능합니다.</li>
							<li>제품불량 및 배송실수, 업무착오로 인한 반품 배송비용은 초캠몰 또는 해당 공급사에서 부담합니다.</li>
							<li>단, 수취거부, 주문정보 오류 및 변심 등의 고객님 사정으로 반송되는 경우 반송시 반송 택배비(상품 발송 택배비를 포함한 왕복택배비)를 고객님이 부담하셔야 합니다.</li>
							<br>
							<li>&#40;2&#41;식품류 배송안내</li>
							<li>수령 가능한 연락처(휴대전화,일반전화 포함)는 정확히 적어주세요. 연락이 안 될 경우 손상된 상품을 받으실 수 있습니다.</li>
							<li>연락처 불기재 및 잘못된 연락처 기재로 인해 연락이 안되어 택배사고(미수령 및 회수 등) 발생 시 교환, 환불 등의 보상이 안 됩니다.</li>
							<li>식품류는 단순 변심에 의한 반품이나 환불은 안 됩니다.</li>
							<li>단, 상품 자체의 결함으로 인한 반품, 환불은 제외됩니다.</li>
							<li>상품하자가 있는 경우 수령한 후 24시간 이내에 하자 이유를 전달해 주시고 수령일 포함 3일 이내에 반송해 주셔야 합니다.</li>
							<li>상품자체의 문제가 있을 땐 미리 사진을 찍고 고객센터로 연락을 주세요.</li>
						</ul>
					</div>
				</div>
			</div>
			<div id="goods_exchange">
				
				<div class="goods_detail_tab">
					<ul class="goods_detail_tab_name">
						<li><a href="#goods_detail">상품상세정보</a></li>
						<li><a href="#goods_delivery">배송안내</a></li>
						<li class="tab_name_on"><a href="#goods_exchange">교환 및 반품안내</a></li>
						<li><a href="#goods_reviews">상품후기</a></li>
						<li><a href="#relation">상품문의</a></li>
					</ul>
				</div>
				<div class="goods_exchange_cnts">
					<div class="goods_exchange_cnts_title">교환 및 반품안내</div>
					<div class="goods_exchange_cnts_sec">
						<ul>
							<li class="goods_exchange_cnts_size">&#40;1&#41;교환 및 반품이 가능한경우</li>
							<li>공급받으시는 상품의 내용이 표시, 광고 내용과 다르거나 상품이 파손/손상되었거나 불량 제품일 경우에는 공급받는 날로부터 7일 이내에 본사와 상담후 교환 및 반품이 </li>
							<li>가능하며 수거 및 재발송 비용은 본사가 부담합니다.</li>
							<li>단 고객님의 단순 변심 또는 색상, 크기(의류,신발)변경으로 인한 교환 반품은 7일 이내에 교환/반품가능하며 수거 및 재발송 비용을 고객님께서 부담하셔야 합니다.</li>
							<br>
							<li class="goods_exchange_cnts_size">&#40;2&#41;교환 및 반품이 불가능한경우</li>
							<li>고객님의 단순 변심 또는 색상, 크기 등의 변경을 위한 반품 및 교환시에는 상품의 태그와 포장상태(박스)를 보존하셔야 합니다.</li>
							<li>포장을 개봉하여 사용한 흔적이 있거나 포장이 훼손되어 상품 가치가 현저히 상실된 경우에는 교환 및 환불이 불가능합니다.</li>
							<li>(예: 가전제품, 식품, 음반, 의류 등)</li>
							<br>
							<li class="goods_exchange_cnts_size">&#40;3&#41;환불</li>
							<li>환불은 반송 확인 후 가능하며 반드시 고객만족센터와 상담 후 반송하여야 하며 적립금으로도 환불 받으실 수 있습니다.</li>
						</ul>
					</div>
					<div class="goods_exchange_cnts_title">환불안내</div>
					<div class="goods_exchange_cnts_sec">
						<ul>
							<li class="goods_exchange_cnts_size">&#40;1&#41;교환 및 반품이 가능한경우</li>
							<li>공급받으시는 상품의 내용이 표시, 광고 내용과 다르거나 상품이 파손/손상되었거나 불량 제품일 경우에는 공급받는 날로부터 7일 이내에 본사와 상담후 교환 및 반품이 </li>
							<li>가능하며 수거 및 재발송 비용은 본사가 부담합니다.</li>
							<li>단 고객님의 단순 변심 또는 색상, 크기(의류,신발)변경으로 인한 교환 반품은 7일 이내에 교환/반품가능하며 수거 및 재발송 비용을 고객님께서 부담하셔야 합니다.</li>
							<br>
							<li class="goods_exchange_cnts_size">&#40;2&#41;교환 및 반품이 불가능한경우</li>
							<li>고객님의 단순 변심 또는 색상, 크기 등의 변경을 위한 반품 및 교환시에는 상품의 태그와 포장상태(박스)를 보존하셔야 합니다.</li>
							<li>포장을 개봉하여 사용한 흔적이 있거나 포장이 훼손되어 상품 가치가 현저히 상실된 경우에는 교환 및 환불이 불가능합니다.</li>
							<li>(예: 가전제품, 식품, 음반, 의류 등)</li>
							<br>
							<li class="goods_exchange_cnts_size">&#40;3&#41;환불</li>
							<li>환불은 반송 확인 후 가능하며 반드시 고객만족센터와 상담 후 반송하여야 하며 적립금으로도 환불 받으실 수 있습니다.</li>
						</ul>
					</div>
					<div class="goods_exchange_cnts_title">AS안내</div>
					<div class="goods_exchange_cnts_sec">
						<ul>
							<li>&#40;1&#41;소비자분쟁해결 기준(공정거래위원회 고시)에 따라 피해를 보상받을 수 있습니다.</li>
							<br>
							<li>&#40;2&#41;상품에 대한 문의 : 상품 사용방법 및 상품에 대한 문의는 고객센터 02-588-4473 로 전화주시기 바랍니다.</li>
							<br>
							<li>&#40;3&#41; A/S : 상품 사용중 발생한 하자의 A/S는 제조사에서 처리되며, A/S문의는 초캠몰 1:1문의 또는 고객센터 02-588-4473으로 접수를 해주시기 바랍니다.</li>
						</ul>
					</div>
				</div>

			</div>
			<div id="goods_reviews"> 
				<div class="goods_detail_tab">
					<ul class="goods_detail_tab_name">
						<li><a href="#goods_detail">상품상세정보</a></li>
						<li><a href="#goods_delivery">배송안내</a></li>
						<li><a href="#goods_exchange">교환 및 반품안내</a></li>
						<li class="tab_name_on"><a href="#goods_reviews">상품후기</a></li>
						<li><a href="#relation">상품문의</a></li>
					</ul>
				</div>
				<div class="goods_reviews_cnts_title">
					<div class="goods_reviews_cnts_sub_title">상품후기</div>
					<div class="goods_reviews_cnts_btn">
						<div class="goods_reviews_full_btn"><a href="#">상품후기 전체보기</a></div>
                  		<div class="goods_reviews_wrt"><a>상품후기 글쓰기</a></div>                  
						
						<%-- <% if (loginClient == null || loginClient.getClientNum() == -1) { %>
	                  		<div class="goods_review_lock"><a>상품후기 글쓰기</a></div>
                  		<% } else { %>
                 		<% } %> --%> 
					</div>
				</div>
				<div class="goods_reviews_cnts_sec">
					<!-- <div class="review_list"></div> -->
				</div>
			</div>
			<div id="qna">
				<div class="goods_detail_tab">
					<ul class="goods_detail_tab_name">
						<li><a href="#goods_detail">상품상세정보</a></li>
						<li><a href="#goods_delivery">배송안내</a></li>
						<li><a href="#goods_exchange">교환 및 반품안내</a></li>
						<li><a href="#goods_reviews">상품후기</a></li>
						<li class="tab_name_on"><a href="#relation">상품문의</a></li>
					</ul>
				</div>
				<div class="goods_qna_cnts_title">
					<div class="goods_qna_cnts_sub_title">상품Q&A</div>
					<div class="goods_qna_cnts_btn">
						<div class="goods_qna_full_btn"><a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_list">상품문의 전체보기</a></div>
                  		<div class="goods_qna_wrt"><a>상품문의 글쓰기</a></div>            
						
						<%-- <% if (loginClient == null || loginClient.getClientNum() == -1) { %>
                  			<div class="goods_qna_lock"><a>상품후기 글쓰기</a></div>
                  		<% } else { %>
                 		<% } %> --%>
					</div>
				</div>
				<div class="goods_qna_cnts_sec"></div>
			</div>
			<div id="relation"></div>
		</div>
	</div>
</div>	
<!--  -->
<!-- 이미지 모달창 -->
<div class="background_modal">
	<div class="photo_modal">
		<div class="photo_modal_title">
			<div>이미지확대보기</div>
			<div class="photo_modal_title_info"></div>
			<div class="photo_modal_title_close"></div>
		</div>
		<div class="photo_modal_list">
			<div class="photo_modal_list_zoom"></div>
			<!-- <div class="photo_modal_list_slide"></div> -->
		</div>
	</div>
</div>
<!-- 상품후기 모달창 -->
<div class="background_review_writer"> 
	<div class="review_modal">
		<form id="review_form" action="<%=request.getContextPath()%>/index.jsp?workgroup=item_detail&work=review_writer" 
			method="post" enctype="multipart/form-data">
			<div class="goods_review_writer_title">상품후기</div>
			<div class="review_goods_box">
				<div class="review_goods_img"><img src="<%=request.getContextPath()%>/img_product/<%=product.getProductMainImg()%>"></div>
				<div class="review_goods_name"><%=product.getProductName()%></div>
				<input type="hidden" name="reviewProductNum" value="<%=product.getProductNum()%>">
				<%if(loginClient!=null){ %>
					<input type="hidden" name="reviewClientNum" value="<%=loginClient.getClientNum()%>">
				<%} %>
			</div>
			<div class="review_star">
				<div class="review_star_name">별점</div>
				<div><input type="number" min="1" max="5" placeholder="0" name="reviewLevel"></div>
			</div>
			<div class="review_writer_title">
				<div class="review_title_name">제목</div>
				<div><input type="text" name="reviewSubject"></div>
			</div>
			<div class="review_writer_content">
				<div class="review_content_name">내용</div>
				<div><textarea rows="10" cols="70" name="reviewContent"></textarea></div>
			</div>
			<div class="review_img_file">
				<div class="review_file_name">파일</div>
				<div><input type="file" name="reviewImage"></div>
			</div>
			<div class="review_btn">
				<button type="submit" class="review_save">리뷰 등록</button>
				<button type="reset" class="review_cencel">취소</button>
			</div>
		</form>
	</div>
</div>
<form id="orderForm" action="../cart/order.jsp" method="post"> <!-- 테스트 -->
</form>


<!--  -->
<script type="text/javascript">
displayReviews();
displayQnas();


document.querySelector(".goods_reviews_wrt").addEventListener("click",function(){	// 상품후기작성 on
	if(<%=loginClient.getClientNum()%>==-1){
		alert("로그인후 사용해주세요.");
		return;
	}
	document.querySelector(".background_review_writer").classList.add("on");
});
document.querySelector(".review_cencel").addEventListener("click",function(){	// 상품후기작성 off
	document.querySelector(".background_review_writer").classList.remove("on");
});


document.querySelector(".goods_qna_wrt").addEventListener("click",function(){
	if(<%=loginClient.getClientNum()%>==-1){
		alert("로그인후 사용해주세요.");
	}else{
		window.location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_write"; 
	}
		
});



document.getElementById('review_form').addEventListener('submit', function(event) {
    // 별점 검증
    var reviewLevel = document.querySelector('input[name="reviewLevel"]');
    if (reviewLevel.value < 1 || reviewLevel.value > 5) {
        alert("별점은 1에서 5 사이의 숫자를 입력해 주세요."); 
        event.preventDefault(); 
        return;
    }

    // 제목 검증
    var reviewSubject = document.querySelector('input[name="reviewSubject"]');
    if (reviewSubject.value.trim() == "") {
        alert("제목을 입력해 주세요.");
        event.preventDefault();
        return;
    }

    // 내용 검증
    var reviewContent = document.querySelector('textarea[name="reviewContent"]');
    if (reviewContent.value.trim() ==="") {
        alert("내용을 입력해 주세요.");
        event.preventDefault();
        return;
    }
});
var cartBtn=document.querySelector(".btn_add_cart"); // 장바구니 버튼
var orderBtn=document.querySelector(".btn_add_order"); // 바로구매 버튼
cartBtn.addEventListener("click", function(){
	var productNum = <%=product.getProductNum() %>;
    var clientNum = <%=loginClient.getClientNum()%>;  // 세션에서 클라이언트 번호 가져오기
	if(clientNum==null||clientNum==""){
		alert("로그인후 이용해주세요.");
		return;
	}
    
    
    // 선택된 옵션과 수량을 배열로 생성
    var options = [];
    var quantities = [];
    var list_count = document.querySelectorAll(".chosen_select_list");
    if(list_count.length==0){
		alert("옵션을 선택해주세요.");
		return;
    }
    list_count.forEach(function(item) {
        var optionName = item.querySelector(".cart_name").textContent;
        var quantity = item.querySelector("input").value;
        options.push(optionName);
        quantities.push(quantity);
    });
    
	$.ajax({
		type:"POST",
		url:"<%=request.getContextPath()%>/item_detail/cart_add.jsp", 
		data: {
            productNum: productNum,
            clientNum: clientNum,
            options: options,
            quantities: quantities
        }, 
        traditional: true, // 배열을 개별 파라미터로 보내기 위해 필요
		dataType:"json",  
		success: function(result){
			if(result.code=="success"){
				alert("장바구니 삽입 성공");				
			}else{
				alert("로그인후 사용해주세요.");
			}	
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
});


/* 결제 버튼 */
orderBtn.addEventListener("click", function(){
    var productNum = <%=product.getProductNum() %>;
    var clientNum = <%=loginClient.getClientNum()%>;  // 세션에서 클라이언트 번호 가져오기

    if (clientNum == null || clientNum == "") {
        alert("로그인 후 이용해주세요.");
        return;
    }
    
    // 선택된 옵션과 수량을 배열로 생성
    var options = [];
    var quantities = [];
    var list_count = document.querySelectorAll(".chosen_select_list");
    
    if (list_count.length == 0) {
        alert("옵션을 선택해주세요.");
        return;
    }
    
    list_count.forEach(function(item) {
        var optionName = item.querySelector(".cart_name").textContent;
        var quantity = item.querySelector("input").value;
        options.push(optionName);
        quantities.push(quantity);
    });
    
    $.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/item_detail/cart_add.jsp", 
        data: {
            productNum: productNum,
            clientNum: clientNum,
            options: options,
            quantities: quantities
        },
        traditional: true,
        dataType: "json",  
        success: function(result) {
            var cartNumList = result.cartNumList;
              
            if (result.code == "success") {

               cartNumList.forEach(function(cartNum) {
                    var hiddenInput = document.createElement('input');
                    hiddenInput.type = 'hidden';
                    hiddenInput.name = 'selectedCartNums';
                    hiddenInput.value = cartNum;
                    $("#orderForm").append(hiddenInput);   
               });
               
               document.getElementById('orderForm').action = "<%=request.getContextPath()%>/index.jsp?workgroup=cart&work=order";
                orderForm.submit();
               
            } else {
                alert("로그인후 사용해주세요.");
            }
        },
        error: function(xhr) {
            alert("에러코드 = " + xhr.status);
        }
    });
});
   
 
/* 상품리뷰 */
function displayReviews(){
	var productNum=<%=product.getProductNum()%>
    $.ajax({
        type:"GET",
        url:"<%=request.getContextPath()%>/item_detail/review_list.jsp",
        data:{"productNum":productNum},
        dataType:"json",
        success:function(result){
            $(".goods_reviews_cnts_sec").children().remove();
				
            if(result.code=="success"){
            	$(result.data).each(function(){
            		var maskedName = maskHalfOfId(this.name);
            		
					var html="<div class='review_list'>";
					html += "<div><img src='<%=request.getContextPath()%>/images/pngwing" + this.level + ".png'></div>";
					html+="<div>"+this.subject+"</div>";
					html+="<div>"+maskedName+"</div>";
					html+="<div>"+this.regdate+"</div>";
					html+="</div>";
					html+="<div class='review_content' style='display:none;'>"+this.content+"<br><br>";
					if(this.reviewimg != "null") { 
					    html += "<img src='<%=request.getContextPath()%>/review_images/" + this.reviewimg + "'>";
					}
					html+="</div>";
					$(".goods_reviews_cnts_sec").append(html);
					
            	}); 
            	
            	$(".review_list").click(function() {
                    $(this).next(".review_content").toggle(); // 클릭한 review_list의 다음 요소인 review_content를 토글
                });
            	
				                 
            }else{
                $(".goods_reviews_cnts_sec").html("<div class='no_review'>"+result.message+"</div>");
            }
        },
        error:function(xhr){
            alert("에러코드="+xhr.status);
        }
    });
}
// 마스킹 함수
function maskHalfOfId(id) {
    const length = id.length;
    const halfLength = Math.ceil(length / 3); 
    const visiblePart = id.slice(0, halfLength);
    const maskedPart = '*'.repeat(length - halfLength);
    return visiblePart + maskedPart;
}

/* qna문의 */
function displayQnas(){
	var productNum=<%=product.getProductNum()%>
	$.ajax({
		type:"GET",
		url:"<%=request.getContextPath()%>/item_detail/qna_list.jsp",
		data:{"productNum":productNum},
		dataType:"json",
		success:function(result){
            $(".goods_qna_cnts_sec").children().remove();
				
            if(result.code=="success"){
            	$(result.data).each(function(){
					var	id=this.id;
					//var html="<div class='qna_list'>";
					var html = "<div class='qna_list' data-id='" + id + "'>"; // data-id 속성 추가
					html+= "<div>"+this.qnanum+"</div>";
					if(this.status==1){
						html+="<div>비밀글 입니다.</div>";
					}else{
						html+="<div>"+this.title+"</div>";						
					}
					html+="<div>"+this.writer+"</div>";
					html+="<div>"+this.redate+"</div>";
					
					if(this.reply==="null" || this.reply ===""|| this.reply===undefined){
						html+="<div>미답변</div>";
					}else{
						html+="<div>답변완료</div>";
					}					
					html+="</div>";
					html+="<div class='qna_content' style='display:none;'>"+this.content+"<br><br>";
					if(this.qnaimg != "null") { 
					    html += "<img src='<%=request.getContextPath()%>/qna_images/" + this.qnaimg + "'>";
					}
					if(this.reply != "null"){
						html+="<div>└관리자 답글 = "+this.reply+"</div>";
					}
					html+="</div>";
					$(".goods_qna_cnts_sec").append(html);
					
            	}); 
            	$(".qna_list").click(function() {
                    var clickedId = $(this).data("id"); // data-id에서 아이디 가져오기
                    var sessionId = "<%=loginClient.getClientId()%>"; // 세션 아이디 가져오기
                    var sessionst= "<%=loginClient.getClientStatus()%>"; 
                    console.log(clickedId);
                    console.log(sessionId);
                    if (clickedId == sessionId || sessionst==9) { // 세션 아이디와 비교
                        var content = $(this).next(".qna_content");
                        if (content.length) { // 요소가 존재하는지 확인
                            content.toggle(); // 클릭한 qna_list의 다음 요소인 qna_content를 토글
                        }
                    } else { 
                        alert("토글할 권한이 없습니다."); // 권한이 없음을 알림
                    }
                });
				                 
            }else{
                $(".goods_qna_cnts_sec").html("<div class='no_review'>"+result.message+"</div>");
            }
        },
        error:function(xhr){
            alert("에러코드="+xhr.status);
        }
	
	
	});
}

/*  옵션 추가 부분 */
var select_box = document.querySelector(".chosen_select"); // select box
var select_add = document.querySelector(".chosen_total_list"); // 가격 출력 부분
var total_price = document.querySelector(".total_price"); // 총금액 부분

select_box.addEventListener("change", function() {
    var selected_opt = select_box.value;
    var price = <%= product.getProductPrice() %>;
    var id = "chosen_select_list_" + (document.querySelectorAll(".chosen_select_list").length + 1);
    
    if (isOptionSelected(selected_opt)) {
        alert("이미 선택된 옵션입니다.");
        return;
    }
    

    var html = "";
    html += "<div class='chosen_select_list' id=" + id + " >";
    html += "    <div class='cart_name'>" + selected_opt + "</div>";
    html += "    <div class='cart_number'>";
    html += "        <input type='number' min='1' value='1' style='font-size:15px;font-weight:500;width: 100%; height:100%;' placeholder='1'>";
    html += "    </div>";
    html += "    <div class='cart_price'>" + price + "원</div>";
    html += "    <div class='cart_del'></div>";
    html += "</div>";

    select_add.insertAdjacentHTML("afterbegin", html);
    priceView();
    updateTotalPrice(); 
    
    var deleteButton = document.querySelector("#" + id + " .cart_del");
    deleteButton.addEventListener("click", function() {
        this.parentElement.remove();
        priceView();
        updateTotalPrice(); 
    });

    var quantityInput = document.querySelector("#" + id + " input");
    quantityInput.addEventListener("change", function() {
        var quantity = this.value;
        var optionName = document.querySelector("#" + id + " .cart_name").textContent;
        console.log("선택된 옵션: " + optionName + ", 수량: " + quantity);

        // 수량 변경에 따라 가격 업데이트
        var itemPriceElement = document.querySelector("#" + id + " .cart_price");
        var itemPrice = price * quantity;
        itemPriceElement.textContent = itemPrice + "원";
        
        updateTotalPrice(); 
    });
});

// 상품 가격 view
function priceView() {
    var list_count = document.querySelectorAll(".chosen_select_list");
    if (list_count.length > 0) {
        select_add.style.display = "block";
    } else {
        select_add.style.display = "none";
    }
}

// 총 금액 업데이트 함수
function updateTotalPrice() {
    var total = 0;
    var list_count = document.querySelectorAll(".chosen_select_list");
    list_count.forEach(function(item) {
        var itemPriceElement = item.querySelector(".cart_price");
        var itemPrice = parseInt(itemPriceElement.textContent.replace("원", ""));
        total += itemPrice;
    });
    total_price.textContent = total + "원";
}
// 옵션 중복검사
function isOptionSelected(optionName) {
    var existingItem = Array.from(document.querySelectorAll(".chosen_select_list .cart_name"))
                            .find(el => el.textContent === optionName);
    return existingItem !== undefined;
}


</script>
<script type="text/javascript" src="js/item_detail.js"></script>
