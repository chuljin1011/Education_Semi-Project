<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/security/login_check.jspf"%>
<%
	if(request.getParameter("qnaNum") == null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
	
	int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
	String pageNum = request.getParameter("pageNum");
	
	QnaDTO qna = QnaDAO.getDAO().selectQnaByNum(qnaNum);
	
	if(qna == null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;		
	}
	
	if(loginClient.getClientNum() != qna.getQnaClientNum() && loginClient.getClientStatus() != 9){
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;		
	}
	
	List<ProductDTO> productList = ProductDAO.getDAO().selectProductAll();
	
    // JSON 형식으로 변환
    StringBuilder json = new StringBuilder();
    json.append("[");
    for (int i = 0; i < productList.size(); i++) {
        ProductDTO product = productList.get(i);
        json.append("{");
        json.append("\"productNum\":").append(product.getProductNum()).append(",");
        json.append("\"productName\":\"").append(product.getProductName()).append("\",");
        json.append("\"productType\":").append(product.getProductType());
        json.append("}");
        if (i < productList.size() - 1) {
            json.append(",");
        }
    }
    json.append("]");
    String jsonString = json.toString(); // JSON 문자열을 변수에 저장
    //System.out.println("Generated JSON: " + jsonString); // 서버 콘솔에 출력

%>

<meta charset="UTF-8">
<link rel="stylesheet" href="css/qna_write_style.css">
<link rel="stylesheet" href="css/common.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<title>상품문의 수정</title>

<div id="container">
	<div id="contents">
        <div class="sub_content">
            <div class="content">
                <div class="board_zone_sec">
                    <div class="board_zone_tit">
                    <% if(loginClient.getClientStatus() == 9) { %>
                        <h2>상품문의 답변</h2>
                    <% } else { %>
                        <h2>상품문의 수정</h2>                    
                    <% } %>
                    </div>
                    
                    <form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_modify_action"
									method="post" enctype="multipart/form-data" id="qnaForm">
						<input type="hidden" name="qnaNum" value="<%=qnaNum%>">
						<input type="hidden" name="pageNum" value="<%=pageNum %>">
						<input type="hidden" name="qnaProductNum" id="qnaProductNum" value="<%=qna.getQnaProductNum()%>"> <!-- 선택된 상품 번호를 저장할 숨겨진 필드 -->
                    	<div class="board_zone_cont">
							<div class="board_zone_write">
								<div class="board_write_box">								
									<table class="board_write_table">
										<colgroup>
											<col style="width: 15%;">
											<col style="width: 85%;">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row">말머리</th>
												<td>
													<div class="category_select">
														<select class="tune" id="category" name="qnaSubject" style="width: 127px;">
															<option value="문의내용" <%= "문의내용".equals(qna.getQnaSubject()) ? "selected" : "" %>>문의내용</option>
															<option value="상품" <%= "상품".equals(qna.getQnaSubject()) ? "selected" : "" %>>상품</option>
															<option value="배송" <%= "배송".equals(qna.getQnaSubject()) ? "selected" : "" %>>배송</option>
															<option value="반품/환불" <%= "반품/환불".equals(qna.getQnaSubject()) ? "selected" : "" %>>반품/환불</option>
															<option value="교환/변경" <%= "교환/변경".equals(qna.getQnaSubject()) ? "selected" : "" %>>교환/변경</option>
															<option value="기타" <%= "기타".equals(qna.getQnaSubject()) ? "selected" : "" %>>기타</option>
														</select>
														<input type="checkbox" name="qnaStatus" value="2" <% if(qna.getQnaStatus() == 2){ %>checked<% } %>>비밀글
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" id="qna_writer">작성자</th>
												<td>
													<input type="text" name="qnaWriter" id="qnaWriter"value="<%=qna.getQnaWriter()%>">
													<div id="message1" style="color: red;"></div>
												</td>
											</tr>
                                            <tr>
                                                <th scope="row">상품 선택</th>
                                                <td>
                                                    <select id="productType" name="productType" style="width: 127px;">
                                                        <option value="">카테고리</option>
                                                        <option value="1">텐트</option>
                                                        <option value="2">랜턴</option>
                                                        <option value="3">매트/침낭/해먹</option>
                                                        <option value="4">화로대/버너</option>
                                                        <option value="5">박스/웨건/가방</option>
                                                    </select>
                                                    <select id="productList" name="productNum" id="productNum"style="width: 127px;">
                                                        <option value="">상품 선택</option>
                                                    </select>
                                                    <div id="message2" style="color: red;"></div>
                                                </td>
                                            </tr>
											<tr>
												<th scope="row">제목</th>
												<td>
													<input type="text" name="qnaTitle" value="<%=qna.getQnaTitle()%>">
													<div id="message3" style="color: red;"></div>
												</td>
											</tr>
											<tr>
												<th scope="row">본문</th>
												<td class="write_editor">
													<textarea class="content_editor" name="qnaContent" id="qnaContent"cols="30" rows="10"><%=qna.getQnaContent()%></textarea>
													<div id="message4" style="color: red;"></div>
												</td>
											</tr>
											<% if(loginClient.getClientStatus() == 9) { %>
											<tr>
												<th scope="row">답변</th>
												<td>
													<textarea class="content_editor" name="qnaReply" cols="30" rows="5"></textarea>
												</td>
											</tr>
											<% } %>
											<tr>
												<th scope="row">첨부파일</th>
												<td id="uploadBox">
													<div class="file_upload_sec">
														<div class="btn_upload_box">
															<input type="file" name="qnaImage" class="btn_upload">
															<% if(qna.getQnaImage() != null) { %>
																<div style="color: red;">이미지를 변경할 경우에만 파일을 입력해 주세요.</div><br>
																<img src="<%=request.getContextPath()%>/qna_images/<%=qna.getQnaImage()%>" alt="첨부된 이미지">
															<% } %>
														</div>
													</div>
												</td>
											</tr>
										</tbody>
										</table>
									</div>
								</div>
								<div class="btn_center_box">
									<button type="button" class="btn_before" id="listBtn">이전</button>
									<button type="submit" class="btn_write_ok">수정</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
$("#qna_writer").focus();

$("#listBtn").click(function(){
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_detail"
			+"&qnaNum=<%=qna.getQnaNum()%>&pageNum=<%=pageNum%>";
});

$(document).ready(function() {
    var products = JSON.parse('<%= jsonString %>'); // JSON 문자열을 변수에 저장
    var selectedProductNum = $('#qnaProductNum').val(); // 숨겨진 필드에서 선택된 상품 번호 가져오기

    $('#productType').change(function() {
        var selectedType = parseInt($(this).val(), 10);
        var filteredProducts = products.filter(function(product) {
            return product.productType === selectedType;
        });

        var productList = $('#productList');
        productList.empty();
        productList.append('<option value="">상품 선택</option>');
        $.each(filteredProducts, function(index, product) {
            var selected = (product.productNum == selectedProductNum) ? 'selected' : '';
            productList.append('<option value="' + product.productNum + '" ' + selected + '>' + product.productName + '</option>');
        });
    });

    $('#productList').change(function() {
        var selectedProductNum = $(this).val();
        $('#qnaProductNum').val(selectedProductNum); // 숨겨진 필드에 선택된 상품 번호 저장
    });

    // 페이지 로드 시 초기 선택 상태 설정
    if (selectedProductNum) {
        var selectedProduct = products.find(function(product) {
            return product.productNum == selectedProductNum;
        });
        if (selectedProduct) {
            $('#productType').val(selectedProduct.productType).change();
        }
    }
});

$("#qnaForm").submit(function(){
	if($("#qnaWriter").val() == "") {
		$("#message1").text("작성자를 입력해 주세요.");
		$("#qnaWriter").focus();
		return false;
	}
	
	if($("#productType").val() == "") {
		$("#message2").text("상품을 선택해 주세요.");
		return false;
	}
	
	if($("#qnaTitle").val() == "") {
		$("#message3").text("제목을 입력해 주세요.");
		$("#qnaTitle").focus();
		return false;
	}
	
	if($("#qnaContent").val() == "") {
		$("#message4").text("본문을 입력해 주세요.");
		$("#qnaContent").focus();
		return false;
	}
	
});
</script>
