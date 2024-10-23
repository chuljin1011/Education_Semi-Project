<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductAll();
%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/admin.css">
<div class="admin_cont admin_product" id="addProduct">
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
					<th style="width:39px;">제품번호</th>
					<th style="width:140px;">제품명</th>
					<th style="width:39px;">가격</th>
					<th style="width:40px;">제조사</th>
					<th style="width:40px;">브랜드</th>
					<th style="width:40px;">원산지</th>
					<th style="width:40px;">카테고리</th>
					<th style="width:47px;">등록일</th>
					<th style="width:39px;">제품상태코드</th>
					<th style="width:50px;">제품이미지</th>
					<th style="width:55px;">상세이미지</th>
					<th style="width:39px;">메뉴분류</th>
					<th style="width:40px;">처리</th>
				</tr>
			</thead>
			<tbody>
			   <% for(ProductDTO product : productList) { %>
			   <form action="<%=request.getContextPath()%>/index.jsp?workgroup=product&work=product_update_action" method="post" enctype="multipart/form-data">
			       <tr>
			           <td>
			              <span class="value_product"><%=product.getProductNum() %></span>
			              <input type="text" class="inp_modify"name="numProductModify" value="<%=product.getProductNum() %>">
			           </td>
			           <td>
			               <span class="value_product"><%=product.getProductName() %></span>
			               <input type="text" class="inp_modify" name="nameProductModify" value="<%=product.getProductName() %>">
			           </td>
			           <td>
			               <span class="value_product"><%=product.getProductPrice() %></span>
			               <input type="text" class="inp_modify" name="priceProductModify" value="<%=product.getProductPrice() %>">
			           </td>
			           <td>
			               <span class="value_product"><%=product.getProductCom() %></span>
			               <input type="text" class="inp_modify" name="comProductModify" value="<%=product.getProductCom() %>">
			           </td>
			           <td>
			               <span class="value_product"><%=product.getProductBrand() %></span>
			               <input type="text" class="inp_modify" name="brandProductModify" value="<%=product.getProductBrand() %>">
			           </td>
			           <td>
			               <span class="value_product"><%=product.getProductOrigin() %></span>
			               <input type="text" class="inp_modify" name="originProductModify" value="<%=product.getProductOrigin() %>">
			           </td>
			           <td>
			               <span class="value_product"><%=product.getProductType() %></span>
			               <select name="typeProductModify" class="select_product_modify">
			                   <option value="1" <%= product.getProductType() == 1 ? "selected" : "" %>>텐트</option>
			                   <option value="2" <%= product.getProductType() == 2 ? "selected" : "" %>>랜턴</option>
			                   <option value="3" <%= product.getProductType() == 3 ? "selected" : "" %>>매트/침낭/해먹</option>
			                   <option value="4" <%= product.getProductType() == 4 ? "selected" : "" %>>화로대/버너</option>
			                   <option value="5" <%= product.getProductType() == 5 ? "selected" : "" %>>박스/웨건/가방</option>
			               </select>
			           </td>
			           <td><%=product.getProductReg() %></td>
			           <td>
			               <span class="value_product"><%=product.getProductStatus() %></span>
			               <select name="statusProductModify" class="select_product_modify">
			                   <option value="1" <%= product.getProductStatus() == 1 ? "selected" : "" %>>판매중</option>
			                   <option value="2" <%= product.getProductStatus() == 2 ? "selected" : "" %>>입고중</option>
			                   <option value="3" <%= product.getProductStatus() == 3 ? "selected" : "" %>>재고없음</option>
			               </select>
			           </td>
			           <td>
			               <span class="value_product"><%=product.getProductMainImg() %></span>
			               <input type="hidden" name="existingMainImg" value="<%=product.getProductMainImg() %>">
			               <input type="file" class="inp_modify" name="imgMainProductModify">
			           </td>
			           <td>
			               <span class="value_product"><%=product.getProductSubImg() %></span>
			               <input type="hidden" name="existingSubImg" value="<%=product.getProductSubImg() %>">
			               <input type="file" class="inp_modify" name="imgSubProductModify">
			           </td>
			           <td>
			               <span class="value_product"><%=product.getProductRank() %></span>
			               <select name="rankProductModify" class="select_product_modify">
			                   <option value="1" <%= product.getProductRank() == 1 ? "selected" : "" %>>신상품</option>
			                   <option value="2" <%= product.getProductRank() == 2 ? "selected" : "" %>>베스트</option>
			                   <option value="3" <%= product.getProductRank() == 3 ? "selected" : "" %>>특가혜택</option>
			                   <option value="4" <%= product.getProductRank() == 4 ? "selected" : "" %>>재입고</option>
			                   <option value="5" <%= product.getProductRank() == 5 ? "selected" : "" %>>리퍼</option>
			               </select>
			           </td>
			           <td>
			               <button type="button" class="btn_admin btn_modify">[수정]</button>
			               <button type="button" class="btn_admin btn_remove">[삭제]</button>
			               <button type="submit" class="btn_admin btn_save" style="display:none;">[저장]</button>
			               <button type="button" class="btn_admin btn_cancel" style="display:none;">[취소]</button>
			           </td>
			       </tr>
			   </form>
			   <% } %>
			</tbody>


			
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
            "#imgSubProduct",
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
    $(document).on('click', '.btn_remove', function() {
        var num = $(this).closest('tr').children('td').eq(0).text();	
        //alert(num);
       location.href="<%=request.getContextPath()%>/product/product_remove_action.jsp?num="+num;	
    });
	
	
    // 입력 필드를 배열로 저장
   
    var submitResult = false;
	 $("#formProductUpdate").submit(function(event) {
		
       submitResult = false;

       
       if (!submitResult) {
           event.preventDefault();
       }

       return submitResult;
   	});
	
	
	
	
	 // 수정 버튼 클릭 이벤트 처리
	    $(document).on('click', '.btn_modify', function() {
	        var $row = $(this).closest('tr');
	        
	        $row.find(".value_product").hide();
	        $row.find(".inp_modify, .select_product_modify").show();
	        $row.find('.btn_save, .btn_cancel').show();
	        
	        $(this).hide();
	        $(this).next('.btn_remove').hide();
	    });

	    // 취소 버튼 클릭 이벤트 처리
	    $(document).on('click', '.btn_cancel', function() {
	        var $row = $(this).closest('tr');
	        
	        $row.find(".value_product").show();
	        $row.find(".inp_modify, .select_product_modify").hide();
	        $row.find('.btn_save, .btn_cancel').hide();

	        $row.find('.btn_modify').show();
	        $row.find('.btn_remove').show();
	    });



    
});





</script>