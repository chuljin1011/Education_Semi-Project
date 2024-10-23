<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/security/login_check.jspf"%>
<%
    String pageNum = "1", pageSize = "16";

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

<title>상품문의 쓰기</title>

<div id="container">
    <div id="contents">
        <div class="sub_content">
            <div class="content">
                <div class="board_zone_sec">
                    <div class="board_zone_tit">
                        <h2>상품문의</h2>
                    </div>
                    
                    <form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_write_action"
                          method="post" enctype="multipart/form-data" id="qnaForm">
                        <input type="hidden" name="pageNum" value="<%=pageNum %>">
                        <input type="hidden" name="qnaProductNum" id="qnaProductNum"> <!-- 선택된 상품 번호를 저장할 숨겨진 필드 -->
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
                                                            <option>문의내용</option>
                                                            <option>상품</option>
                                                            <option>배송</option>
                                                            <option>반품/환불</option>
                                                            <option>교환/변경</option>
                                                            <option>기타</option>
                                                        </select>
                                                        <input type="checkbox" name="qnaStatus" value="2">비밀글
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row" id="qna_writer">작성자</th>
                                                <td>
                                                    <input type="text" name="qnaWriter" id="qnaWriter">
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
                                                    <select id="productList" name="productNum" style="width: 127px;">
                                                        <option value="">상품 선택</option>
                                                    </select>
                                                    <div id="message2" style="color: red;"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">제목</th>
                                                <td>
                                                    <input type="text" name="qnaTitle" id="qnaTitle">
                                                    <div id="message3" style="color: red;"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">본문</th>
                                                <td class="write_editor">
                                                    <textarea class="content_editor" name="qnaContent" id="qnaContent"cols="30" rows="10"></textarea>
                                                    <div id="message4" style="color: red;"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">첨부파일</th>
                                                <td id="uploadBox">
                                                    <div class="file_upload_sec">
                                                        <div class="btn_upload_box">
                                                            <input type="file" name="qnaImage" class="btn_upload">
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
                                <button type="submit" class="btn_write_ok">저장</button>
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
    location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_list&pageNum=<%=pageNum%>";
});

$(document).ready(function() {
    var products = JSON.parse('<%= jsonString %>'); // JSON 문자열을 변수에 저장

    $('#productType').change(function() {
        var selectedType = parseInt($(this).val(), 10);

        var filteredProducts = products.filter(function(product) {
            return product.productType === selectedType;
        });

        var productList = $('#productList');
        productList.empty();
        productList.append('<option value="">상품 선택</option>');
        $.each(filteredProducts, function(index, product) {
            productList.append('<option value="' + product.productNum + '">' + product.productName + '</option>');
        });
    });

    $('#productList').change(function() {
        //var selectedProductNum = $(this).val();
        $('#qnaProductNum').val($(this).val()); // 숨겨진 필드에 선택된 상품 번호 저장
    });
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
