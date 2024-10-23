 <%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductAll();
%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/admin.css">
<%--<%@include file="/camp/security/admin_check.jspf" %>--%>
<h2 class="screen_out">관리자 페이지</h2>
<div class="admin_cont admin_member">
	<div class="top_admin">
		<h3 class="tit_admin">회원관리</h3>
	</div>
	<div class="cont_admin">
		<table class="tbl_admin">
			<tr>
				<th>회원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>우편번호</th>
				<th>기본주소</th>
				<th>상세주소</th>
				<th>회원가입날짜</th>
				<th>회원변경날짜</th>
				<th>마지막 로그인날짜</th>
				<th>회원상태</th>
				<th>처리</th>
			</tr>
			<tr>
				<td>1</td>
				<td>abc123</td>
				<td>홍길동</td>
				<td>abc123@itwill.xyz</td>
				<td>010-1111-1111</td>
				<td>22222</td>
				<td>서울시 강남구</td>
				<td>역삼동</td>
				<td>2024-07-10</td>
				<td>2024-07-11</td>
				<td>2024-07-19</td>
				<td>1</td>
				<td>
					<button type="button" class="btn_admin">[수정]</button>
					<button type="button" class="btn_admin">[삭제]</button>
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="admin_cont admin_product" id="addProduct" style="display:none">
	<div class="top_admin">
		<h3 class="tit_admin">상품관리</h3>
		<div class="wrap_btn">
			<button type="button" class="btn_admin btn_add_product">상품추가</button>
			<div class="add_product">
			<%--<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_insert_action --%>
				<form action="<%=request.getContextPath() %>/index.jsp?workgroup=product&work=product_insert_action" method="post" class="form_product" id="formProduct" enctype="multipart/form-data">
					<table class="tbl_product" id="tblProductAdd">
						<tr>
							<th>제품번호</th>
							<td style="background-color:#ccc;">자동입력</td>
						</tr>
						<tr>
							<th><label for="nameProduct">제품명</label></th>
							<td>
								<input type="text" class="inp_product" name="nameProduct" id="nameProduct">
								<span class="warn_form">값을 입력해 주세요.</span>
							</td>
						</tr>
						<tr>
							<th><label for="priceProduct">가격</label></th>
							<td>
								<input type="text" class="inp_product" name="priceProduct" id="priceProduct">
								<span class="warn_form">값을 입력해 주세요.</span>
							</td>
								
						</tr>
						<tr>
							<th><label for="comProduct">제조사</label></th>
							<td>
								<input type="text" class="inp_product" name="comProduct" id="comProduct">
								<span class="warn_form">값을 입력해 주세요.</span>
							</td>
							
						</tr>
						<tr>
							<th><label for="brandProduct">브랜드</label></th>
							<td>
								<input type="text" class="inp_product" name="brandProduct" id="brandProduct">
								<span class="warn_form">값을 입력해 주세요.</span>
							</td>
								
						</tr>
						<tr>
							<th><label for="originProduct">원산지</label></th>
							<td>
								<input type="text" class="inp_product" name="originProduct" id="originProduct">
								<span class="warn_form">값을 입력해 주세요.</span>
							</td>
								
						</tr>
						<tr>
							<th><label for="typeProduct">카테고리</label></th>
							<td>
								<select name="typeProduct" id="typeProduct" class="select_product">
									<option>1 : 텐트</option>
									<option>2 : 랜턴</option>
									<option>3 : 매트/침낭/해먹</option>
									<option>4 : 화로대/버너</option>
									<option>5 : 박스/웨건/가방</option>
								</select>
							</td>
						</tr>
						<%-- 
						<tr>
							<th>등록일</th>
							<td></td>
						</tr>
						--%>
						<tr>
							<th><label for="statusProduct">제품상태코드</label></th>
							<td>
								<select name="statusProduct" id="statusProduct" class="select_product">
									<option>1 : 판매중</option>
									<option>2 : 입고중</option>
									<option>3 : 재고없음</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><label for="imgMainProduct">제품이미지</label></th>
							<td>
								<input type="file" class="inp_product" name="imgMainProduct" id="imgMainProduct">
								<span class="warn_form">이미지를 등록해 주세요</span>
							</td>
						</tr>
						<tr>
							<th><label for="imgSubProduct">상세이미지</label></th>
							<td>
								<input type="file" class="inp_product" name="imgSubProduct" id="imgSubProduct">
								<span class="warn_form">이미지를 등록해 주세요</span>
							</td>
						</tr>
						<tr>
							<th><label for="rankProduct">메뉴분류</label></th>
							<td>
								<select name="rankProduct" id="rankProduct" class="select_product">
									<option>1 : 신상품</option>
									<option>2 : 베스트</option>
									<option>3 : 특가혜택</option>
									<option>4 : 재입고</option>
									<option>5 : 리퍼</option>
								</select>
							</td>
						</tr>
					</table>
					<div class="bottom_btn">
						<button type="submit" class="btn_form btn_submit" id="btnProductSubmit">등록</button>
						<button type="reset" class="btn_form btn_reset">초기화</button>
						<button type="button" class="btn_form btn_close">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="cont_admin">
		<table class="tbl_admin" id="tblProductList">
			<thead>
				<tr>
					<th>제품번호</th>
					<th>제품명</th>
					<th>가격</th>
					<th>제조사</th>
					<th>브랜드</th>
					<th>원산지</th>
					<th>카테고리</th>
					<th>등록일</th>
					<th>제품상태코드</th>
					<th>제품이미지</th>
					<th>상세이미지</th>
					<th>메뉴분류</th>
					<th>처리</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
			<% for(ProductDTO product : productList) { %>
			<tr>
				<td><%=product.getProductNum() %></td>
				<td><%=product.getProductName() %></td>
				<td><%=product.getProductPrice() %></td>
				<td><%=product.getProductCom() %></td>
				<td><%=product.getProductBrand() %></td>
				<td><%=product.getProductOrigin() %></td>
				<td><%=product.getProductType() %></td>
				<td><%=product.getProductReg() %></td>
				<td><%=product.getProductStatus() %></td>
				<td><%=product.getProductMainImg() %></td>
				<td><%=product.getProductSubImg() %></td>
				<td><%=product.getProductRank() %></td>
				<td>
					<button type="button" class="btn_admin btn_modify" id="btnModify">[수정]</button>
					<button type="button" class="btn_admin" id="btnRemove">[삭제]</button>
				</td>
			</tr>
			<% } %>
		</table>
	</div>
</div>

<div class="admin_cont admin_delivery" style="display:none">
	<div class="top_admin">
		<h3 class="tit_admin">배송관리</h3>
		<%--
		<div class="wrap_btn">
			<button type="button" class="btn_admin">배송정보 수정</button>
		</div>
		--%>
	</div>
	<div class="cont_admin">
		<table class="tbl_admin">
			<tr>
				<th>배송번호</th>
				<th>주문번호</th>
				<th>배송 생성일</th>
				<th>배송 수정일</th>
				<th>배송 요청사항</th>
				<th>배송상태</th>
				<th>처리</th>
			</tr>
			<tr>
				<td>1</td>
				<td>1</td>
				<td>2024-07-10</td>
				<td>2024-07-12</td>
				<td>집 앞에 놓아주세요.</td>
				<td>배송완료</td>
				<td><button type="button" class="btn_admin">[수정]</button></td>
			</tr>
		</table>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
   	 //상품등록 [초기화]버튼 눌렀을때
     $(".btn_reset").click(function(){
		 $(".add_product input").val("");
		 $(".select_product option").eq(0).prop("selected",true);
		 $(".warn_form").css("display", "none");
     });
  	//상품등록 [닫기]버튼 눌렀을때
  	 $(".btn_close").click(function(){	
		 $(".inp_product").val("");
	   	 $(".warn_form").css("display", "none");
  	 });
  	
	 // 입력 필드를 배열로 저장
	 $("#formProduct").submit(function(event) {
        var submitResult = true;

        // 입력 필드를 배열로 저장
        var requiredFields = [
            "#nameProduct",
            "#priceProduct",
            "#comProduct",
            "#brandProduct",
            "#originProduct",
            "#imgMainProduct",
            "#rankProduct"
        ];

        // 모든 .warn_form 숨기기
        $(".warn_form").css("display", "none");

        // 필드별 검증
        requiredFields.forEach(function(field) {
            if ($(field).val().trim() === "") {
                $(field).next(".warn_form").css("display", "block");
                submitResult = false;
            }
        });

        // submitResult가 false인 경우 폼 제출 막기
        if (!submitResult) {
            event.preventDefault();
        }

        return submitResult;
    });
    
	//상품관리 페이지에서[삭제]를 클릭한 경우 호출될 이벤트 처리함수 등록
    $(document).on('click', '#btnRemove', function() {
        var num = $(this).closest('tr').children('td').eq(0).text();	
        //alert(num);
       location.href="<%=request.getContextPath()%>/product/product_remove_action.jsp?num="+num;	
    });
	
	
    // 수정 버튼 클릭 이벤트 처리
    $(document).on('click', '.btn_modify', function() {
        var $row = $(this).closest('tr');
        $row.find('td').each(function(index, td) {
            if (index < 11) { // Assuming there are 12 columns (0-11) and the last column is for buttons
                var text = $(td).text();
                $(td).html('<input type="text" value="' + text + '">');
            }
        });
        $(this).text('저장').removeClass('btn_modify').addClass('btn_save');
    });

    // 저장 버튼 클릭 이벤트 처리
    $(document).on('click', '.btn_save', function() {
        var $row = $(this).closest('tr');
        var product = {
            productNum: $row.find('td').eq(0).text(),
            productName: $row.find('td').eq(1).find('input').val(),
            productPrice: $row.find('td').eq(2).find('input').val(),
            productCom: $row.find('td').eq(3).find('input').val(),
            productBrand: $row.find('td').eq(4).find('input').val(),
            productOrigin: $row.find('td').eq(5).find('input').val(),
            productType: $row.find('td').eq(6).find('input').val(),
            productStatus: $row.find('td').eq(8).find('input').val(),
            productMainImg: $row.find('td').eq(9).find('input').val(),
            productSubImg: $row.find('td').eq(10).find('input').val(),
            productRank: $row.find('td').eq(11).find('input').val()
        };

        // Ajax를 통해 서버에 저장 요청
        $.ajax({
            url: '<%=request.getContextPath()%>/product/product_update_action.jsp',
            method: 'POST',
            data: product,
            success: function(response) {
                $row.find('td').each(function(index, td) {
                    if (index < 11) {
                        var text = $(td).find('input').val();
                        $(td).text(text);
                    }
                });
                alert('수정이 완료되었습니다.');
                $row.find('.btn_save').text('수정').removeClass('btn_save').addClass('btn_modify');
            },
            error: function(xhr, status, error) {
                alert('수정 중 오류가 발생했습니다.');
            }
        });
    });

	
    
  	<%--
  	//상품목록 불러오는 AJAX 함수
    displayProduct();
	//AJAX
	function displayProduct(){
		$.ajax({
			type: "post",
			url: "<%=request.getContextPath()%>/product/product_admin_list.jsp",
			dataType: "json",
			success: function(result) {
				//댓글목록태그의 자식태그를 삭제 처리 - 기존 댓글 삭제
				$("#tblProductList tbody").children().remove();
				
				if(result.code == "success") {//검색된 댓글정보가 있는 경우
					//Array 객체를 일괄처리하기 위해 each() 멤버함수 호출
					$(result.data).each(function() {
						//Array 객체의 요소값(Object 객체 - 제품정보)를 HTML 태그로 변환
						var html="<tr>";//댓글태그
						html+="<td>"+this.productNum+"</td>";
						html+="<td>"+this.productName+"</td>";
						html+="<td>"+this.productPrice+"</td>";
						html+="<td>"+this.productCom+"</td>";
						html+="<td>"+this.productBrand+"</td>";
						html+="<td>"+this.productOrigin+"</td>";
						html+="<td>"+this.productType+"</td>";
						html+="<td>"+this.productReg+"</td>";
						html+="<td>"+this.productStatus+"</td>";
						html+="<td>"+this.productMainImg+"</td>";
						html+="<td>"+this.productSubImg+"</td>";
						html+="<td>"+this.productRank+"</td>";
						html+="<td><button type='button' class='btn_admin'>[수정]</button><button type='button' class='btn_admin'>[삭제]</button></td>"
						html+="</tr>";
						
						//마지막 자식태그로 추가하여 출력 처리 
						$("#tblProductList tbody").append(html);
					});
				} else {
					
				}
			}, 
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
		});	
	}
	--%>
	
	//origin
	<%-- //상품 추가하는 AJAX 함수
	$("#btnProductSubmit").click(function(){
		
     	// 입력 필드를 배열로 저장
        var requiredFields = [
            "#nameProduct",
            "#priceProduct",
            "#comProduct",
            "#brandProduct",
            "#originProduct",
            "#imgMainProduct",
            "#imgSubProduct",
            "#rankProduct"
        ];

        // 필드별 검증
        requiredFields.forEach(function(field) {
            if ($(field).val().trim() == "") {
                $(field).next(".warn_form").css("display", "block");
                //submitResult = false;
            }else if($(field).val().trim() != "") {
            	 $(field).next(".warn_form").css("display", "none");
            }
        });
        
        var productName = $("#nameProduct").val();
        var productPrice = $("#priceProduct").val();
        var productCom = $("#comProduct").val();
        var productBrand = $("#brandProduct").val();
        var productOrigin = $("#originProduct").val();
        var productType = $("#typeProduct").val();
        var productStatus = $("#statusProduct").val();
        var productMainImg = $("#imgMainProduct").val();
        var productSubImg = $("#imgSubProduct").val();
        var productRank = $("#rankProduct").val();
        
		$.ajax({	
			type: "post",
			url: "<%=request.getContextPath()%>/product/product_admin_add.jsp",
			data: {"productName":productName, "productPrice":productPrice, "productCom":productCom, "productBrand":productBrand, "productOrigin":productOrigin
				, "productType":productType, "productStatus":productStatus, "productMainImg":productMainImg, "productSubImg":productSubImg, "productRank":productRank},
			dataType: "json",
			success: function(result) {
				if(result.code == "success") {
					displayProduct();//제품목록 출력
				} else {
					alert("상품 삽입 실패");
				}
			},
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
			
		});
        
        if($(".add_product input").val() != ""){        
        	$(".add_product").hide();
        }
	}); --%>
	<%--
	$("#btnProductSubmit").click(function() {
	    // 입력 필드를 배열로 저장
	    var requiredFields = [
	        "#nameProduct",
	        "#priceProduct",
	        "#comProduct",
	        "#brandProduct",
	        "#originProduct",
	        "#imgMainProduct",
	        "#imgSubProduct",
	        "#rankProduct"
	    ];

	    // 필드별 검증
	    var submitResult = true; // 제출 결과를 기록하는 변수
	    requiredFields.forEach(function(field) {
	        if ($(field).val().trim() === "") {
	            $(field).next(".warn_form").css("display", "block");
	            submitResult = false; // 빈 필드 발견 시 false
	        } else {
	            $(field).next(".warn_form").css("display", "none");
	        }
	    });

	    // 모든 필드가 유효한 경우에만 AJAX 요청 전송
	    if (submitResult) {
	        var productData = {
	            productName: $("#nameProduct").val(),
	            productPrice: $("#priceProduct").val(),
	            productCom: $("#comProduct").val(),
	            productBrand: $("#brandProduct").val(),
	            productOrigin: $("#originProduct").val(),
	            productType: $("#typeProduct").val(),
	            productStatus: $("#statusProduct").val(),
	            productMainImg: $("#imgMainProduct").val(),
	            productSubImg: $("#imgSubProduct").val(),
	            productRank: $("#rankProduct").val()
	        };

	        $.ajax({
	            type: "post",
	            url: "<%=request.getContextPath()%>/product/product_admin_add.jsp",
	            data: productData,
	            dataType: "json",
	            success: function(result) {
	                if (result.code === "success") {
	                    displayProduct(); // 제품 목록 출력
	                    // 입력 필드 초기화
	                    requiredFields.forEach(function(field) {
	                        $(field).val(""); // 입력 필드 초기화
	                        $(field).next(".warn_form").css("display", "none"); // 경고 메시지 숨기기
	                    });
	                } else {
	                    alert("상품 삽입 실패: " + (result.message || "알 수 없는 오류입니다.")); // 실패 메시지 개선
	                }
	            },
	            error: function(xhr) {
	                alert("에러 발생: " + xhr.status + " - " + xhr.statusText); // 에러 메시지 개선
	            }
	        });
	        $(".add_product").hide();
	    }
	});
	--%>
	
	<%--
	$("#btnProductSubmit").click(function(){
        //var submitResult = true;

        // 입력 필드를 배열로 저장
        var requiredFields = [
            "#nameProduct",
            "#priceProduct",
            "#comProduct",
            "#brandProduct",
            "#originProduct",
            "#imgMainProduct",
            "#imgSubProduct",
            "#rankProduct"
        ];

        // 필드별 검증
        requiredFields.forEach(function(field) {
            if ($(field).val().trim() === "") {
                $(field).next(".warn_form").css("display", "block");
                //submitResult = false;
            }
        });

        // submitResult가 false인 경우 폼 제출 막기
        //if (!submitResult) {
        //    event.preventDefault();
       // }

        //return submitResult;
        
        var productName = $("#nameProduct").val();
        var productPrice = $("#priceProduct").val();
        var productCom = $("#comProduct").val();
        var productBrand = $("#brandProduct").val();
        var productOrigin = $("#originProduct").val();
        var productType = $("#typeProduct").val();
        var productStatus = $("#statusProduct").val();
        var productMainImg = $("#imgMainProduct").val();
        var productSubImg = $("#imgSubProduct").val();
        var productRank = $("#rankProduct").val();
        
		$.ajax({	
			type: "post",
			url: "<%=request.getContextPath()%>/product/product_admin_add.jsp",
			data: {"productName":productName, "productPrice":productPrice, "productCom":productCom, "productBrand":productBrand, "productOrigin":productOrigin
				, "productType":productType, "productStatus":productStatus, "productMainImg":productMainImg, "productSubImg":productSubImg, "productRank":productRank},
			dataType: "json",
			success: function(result) {
				if(result.code == "success") {
					displayProduct();//제품목록 출력
				} else {
					alert("상품 삽입 실패");
				}
			},
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
			
		});
		$("#tblProductAdd").hide();
	});
	--%>
	
    
});

</script>
