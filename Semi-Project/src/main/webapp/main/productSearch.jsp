<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
	
	String workgroup=request.getParameter("workgroup");
	String work=request.getParameter("work");
	String rank=request.getParameter("rank");
	
	DecimalFormat df = new DecimalFormat("###,###");
	
%>

<%
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

int pageSize = 10;//게시글갯수 - 전달값이 없는 경우 사용할 기본값 저장
if (request.getParameter("pageSize") != null) {//전달값이 있는 경우
	pageSize = Integer.parseInt(request.getParameter("pageSize"));
}

//조회정보(조회대상과 조회단어)를 전달받아 PRODUCT 테이블에 저장된 행에서 조회정보가 포함된 
//행의 갯수를 검색하여 반환하는 ProductAO 클래스의 메소드 호출
int totalProduct = ProductDAO.getDAO().countProductList(search, keyword); //게시글의 총갯수

//페이지의 총갯수를 계산하여 저장
//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
int totalPage = (int) Math.ceil((double) totalProduct / pageSize);

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
if (endRow > totalProduct) {
	endRow = totalProduct;
}

String sort = request.getParameter("sort");
String orderby = "PRODUCT_REG"; // 기본 정렬 기준

if ("low".equals(sort)) {
    orderby = "PRODUCT_PRICE"; // 낮은 가격순
} else if ("high".equals(sort)) {
    orderby = "PRODUCT_PRICE DESC"; // 높은 가격순
}

//페이징 관련 정보(시작행번호, 종료행번호)와 게시글 조회기능 관련 정보(조회대상과 조회단어)를
//전달받아 REVIEW 테이블에 저장된 행에서 조회정보가 포함된 행을 페이징 처리로 검색하여
//List 객체를 반환하는 ReviewDAO 클래스의 메소드 호출
List<ProductDTO> productListPaging = ProductDAO.getDAO().getProductListPaging(startRow, endRow, search, keyword, orderby);

//게시글에 출력될 일련번호 시작값을 계산하여 저장
// => 게시글의 총갯수가 91개인 경우 => 1Page : 91, 2Page : 81, 3Page : 71, ...\
int displayNum = totalProduct - (pageNum - 1) * pageSize;
%>
<script type="text/javascript">
function setSort(sortby) {
    var url = "<%=request.getContextPath()%>/index.jsp?workgroup=main&work=productSearch"
        + "&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>&pageNum=<%=pageNum%>&sort=" + sortby;
    location.href = url; // 새 URL로 이동
}

$("#pageSize").change(function() {    
    location.href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=mypage_order_list"
        +"&pageSize="+$("#pageSize").val()+"&search=<%=search%>&keyword=<%=keyword%>&pageNum=<%=pageNum%>";
});
</script>
<div class="cont_product">
    <h3 class="tit_product">	
        <%-- <%=title % --%>
    </h3>
    <div class="wrap_filter">
        <span class="total_num" id="">상품 <b><%=totalProduct %></b>개</span>
        
        <div class="inner_filter clear_fix">
		    <ul class="list_filter">
		        <li><a href="#" class="link_filter on" onclick="setSort('date')">등록일순</a></li>
		        <li><a href="#" class="link_filter" onclick="setSort('low')">낮은 가격순</a></li>
		        <li><a href="#" class="link_filter" onclick="setSort('high')">높은 가격순</a></li>
		    </ul>
		    <select id="pageSize" class="select_filter">
		        <option value="5" <% if (pageSize == 5) { %>selected<% } %>>20개씩 보기</option>
		        <option value="10" <% if (pageSize == 10) { %>selected<% } %>>40개씩 보기</option>
		        <option value="20" <% if (pageSize == 20) { %>selected<% } %>>60개씩 보기</option>
		    </select>
		</div>
    </div>
    <ul class="list_product">
        <% for(ProductDTO product : productListPaging) { %>
        <li>
            <a href="index.jsp?workgroup=item_detail&work=item_detail&num=<%=product.getProductNum() %>" class="link_product" id="product<%=product.getProductNum()%>">
                <span class="wrap_img">
                    <img src="<%=request.getContextPath() %>/img_product/<%=product.getProductMainImg() %>" alt="<%=product.getProductMainImg() %>" class="img_product">
                </span>
                <span class="name_product"><%=product.getProductName() %></span>
            </a>
            <span class="screen_out">가격</span><span class="product_price"><%=df.format(product.getProductPrice()) %>원</span>
        </li>
        <% } %>
    </ul>
    <%-- 페이지 번호 출력 --%>
    <%
        // 페이지 블럭에 출력될 시작 페이지 번호와 종료 페이지 번호 계산
        int blockSize = 5;
        int startPage = (pageNum - 1) / blockSize * blockSize + 1;
        int endPage = startPage + blockSize - 1;

        if (endPage > totalPage) {
            endPage = totalPage;
        }
    %>

    <%-- <%
    	String myUrl = request.getContextPath() + "/index.jsp?workgroup=main&work=productSearch"
            + "&pageSize=" + pageSize + "&search=" + search + "&keyword=" + keyword + "&sort=" + orderby;
	%>	 --%>	
	<%
    	String myUrl = request.getContextPath() + "/index.jsp?workgroup=main&work=productSearch"
            + "&pageSize=" + pageSize + "&search=" + search + "&keyword=" + keyword /* + "&sort=" + orderby  + "&pageNum=" + pageNum*/ ;
	%>	
	<%-- <%
	    // 현재 URL의 쿼리 문자열을 가져옵니다.
	    String queryString = request.getQueryString();
	
	    // 기본 URL 설정
	    String baseUrl = request.getContextPath() + "/index.jsp?workgroup=main&work=productSearch";
		
	    // 기본 쿼리 매개변수 설정
	    String myUrl = baseUrl + "&pageSize=" + pageSize + "&search=" + search + "&keyword=" + keyword + "&sort=" + orderby;
	
	    // 페이지 번호에 따라 URL을 수정합니다.
	    if (queryString != null) {
	        // 페이지 번호를 변경하기 위해 기존의 쿼리 문자열을 처리합니다.
	        String[] params = queryString.split("&");
	        for (String param : params) {
	            // 페이지 번호가 아닌 매개변수만 myUrl에 추가합니다.
	            if (!param.startsWith("pageNum=")) {
	                myUrl += "&" + param;
	            }
	        }
	    }
	    
	%> --%>
    <div id="page_list" style="text-align: center;">
        <%-- 이전 블럭 링크 --%>
        <% if (startPage > blockSize) { %>
            <a href="<%=myUrl%>&pageNum=<%=startPage - blockSize%>">[이전]</a>
        <% } else { %>
            [이전]
        <% } %>
        
        <% for(int i = startPage; i <= endPage; i++) { %>
            <% if (pageNum != i) { %>
                <a href="<%=myUrl%>&pageNum=<%=i%>">[<%=i %>]</a>
            <% } else { %>
                [<%=i %>]
            <% } %>
        <% } %>
        
        <%-- 다음 블럭 링크 --%>
        <% if (endPage < totalPage) { %>
            <a href="<%=myUrl%>&pageNum=<%=startPage + blockSize%>">[다음]</a>
        <% } else { %>
            [다음]
        <% } %>
    </div>
</div>

<%-- <script type="text/javascript">
// 입력 태그(게시글 갯수)의 입력값을 변경한 경우 호출되는 이벤트 처리 함수 등록
$("#pageSize").change(function() {    
    location.href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=mypage_order_list"
        +"&pageNum=<%=pageNum%>&pageSize="+$("#pageSize").val()+"&search=<%=search%>&keyword=<%=keyword%>";
});
</script> --%>