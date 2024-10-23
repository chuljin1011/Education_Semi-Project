<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.QnaDAO"%>
<%@page import="xyz.itwill.dto.QnaDTO"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getParameter("qnaNum") == null) {//전달값이 없는 경우
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}

	int qnaNum=Integer.parseInt(request.getParameter("qnaNum"));
	String pageNum=request.getParameter("pageNum");
	
	QnaDTO qna=QnaDAO.getDAO().selectQnaByNum(qnaNum);
	
	if(qna == null){ 
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
	
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
    String maskedIp = qna.getQnaIp();
    if (qna.getQnaIp() != null && qna.getQnaIp().length() > 3) {
        maskedIp = qna.getQnaIp().substring(0, qna.getQnaIp().length() - 3) + "***";
    }
	
    ProductDTO product=ProductDAO.getDAO().selectProduct(qna.getQnaProductNum());
    
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/qna_detail_style.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<title>상품문의</title>
</head>
<body>
	<!-- Body -->
	<div class="contents">
		<!-- 문의사항 상세내용 Body -->
        <div class="sub_content">
            <div class="content">
                <div class="board_zone_sec">
                    <div class="board_zone_tit">
                        <h2>상품문의</h2>
                    </div>
                    <div class="board_zone_cont">
                        <div class="board_zone_view">
							<div class="board_view_tit">
								<h3>[<%=qna.getQnaSubject() %>]<%=qna.getQnaTitle() %></h3>
							</div>
							<div class="board_view_info">
								<span class="view_info_idip">
									<strong>
									<% String writerName=qna.getQnaWriter();%>
									<% if(writerName != null && writerName.length() > 1) {  %>
										<% String maskedName=writerName.substring(0,1) + "*" + writerName.substring(2); %>
											<%=maskedName %>
									<% } else { %>
											<%=writerName %>
									<% } %>									
									</strong>
									<em>(IP: <%=maskedIp %>)</em>
								</span>
								<span class="view_info_day">
									<em><%=qna.getQnaDate() %></em>
								</span>
							</div>
							<div class="board_view_content">
								<div class="view_goods_select">
									<div class="view_goods_select_item">
										<div class="view_select_item_img">
										<img src="<%=request.getContextPath()%>/img_product/<%=product.getProductMainImg() %>">
											<div class="product_info">
												<p><%=product.getProductName() %></p>
												<p id="product_price">판매금액 <%=product.getProductPrice() %>원</p>
											</div>
										</div>
									</div>
								</div>
								<div class="board_view_qa">
									<div class="view_question_box">
										<p style="font-weight: bold">Q.</p>
											<p>
											<% if(qna.getQnaImage() != null) { %>
												<img src="<%=request.getContextPath()%>/qna_images/<%=qna.getQnaImage()%>">
											<% } %>
											</p>
											<p>
											<%=qna.getQnaContent().replace("\n", "<br>") %>
											</p>
											<br>
											<p style="font-weight: bold">A.</p>
											<p>
											<% if(qna.getQnaReply() != null ) { %>
											<%=qna.getQnaReply().replace("\n", "<br>") %>
											<% }  %>
											</p>
										<div class="seem_cont"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="btn_right_box">
					<% if (loginClient != null && (loginClient.getClientNum() == qna.getQnaClientNum() || loginClient.getClientStatus() == 9)) { %>
					    <!-- 내가 쓴 글일 때 또는 관리자일 때 버튼 활성화 -->
					    <button type="button" class="btn_board_del" id="removeBtn">
					        <strong>삭제</strong>
					    </button>
					    <button type="button" class="btn_board_edit" id="modifyBtn">
					        <strong>수정</strong>
					    </button>
					<% } %>
							<button type="button" class="btn_board_list"  id="listBtn">
								<strong>목록</strong>
							</button>
						</div>
                    </div>
                </div>
            </div>
        </div>
	</div>
	<script type="text/javascript">
	$("#listBtn").click(function() {
		location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_list"
				+"&pageNum=<%=pageNum%>";
	});
	$("#removeBtn").click(function() {
		if(confirm("게시글을 정말로 삭제 하시겠습니까?")) {
			location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_remove_action"
					+"&qnaNum=<%=qnaNum%>&pageNum=<%=pageNum%>";
		}
	});
	$("#modifyBtn").click(function() {
		location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_modify"
				+"&qnaNum=<%=qnaNum%>&pageNum=<%=pageNum%>";
	});
	
	</script>
</body>
</html>