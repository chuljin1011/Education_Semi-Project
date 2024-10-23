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
	String type=request.getParameter("type");
	String sort=request.getParameter("sort");
	
	String title="";
	if(type.equals("1")){
		title="텐트";
	}else if(type.equals("2")){
		title="랜턴";
	}else if(type.equals("3")){
		title="매트/침낭/해먹";
	}else if(type.equals("4")){
		title="화로대/버너";
	}else if(type.equals("5")){
		title="박스/웨건/가방";
	}
	
	//List<ProductDTO> productList=ProductDAO.getDAO().selectProductType(Integer.parseInt(type));
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductTypeSortDate(Integer.parseInt(type));
	
	if(sort.equals("priceDesc")){
		productList=ProductDAO.getDAO().selectProductTypeSortPD(Integer.parseInt(type));
	}else if(sort.equals("priceAsc")){
		productList=ProductDAO.getDAO().selectProductTypeSortPA(Integer.parseInt(type));
	}
	
	DecimalFormat df = new DecimalFormat("###,###");

%>
<div class="cont_product">
	<h3 class="tit_product">
		<%=title %>
	</h3>
	<div class="wrap_filter">
		<span class="total_num">상품 <b><%=productList.size() %></b>개</span>
		<div class="inner_filter clear_fix">
			<ul class="list_filter">
				<li><a href="index.jsp?workgroup=product&work=product_list_type&type=<%=request.getParameter("type") %>&sort=date" class="link_filter<%if("product".equals(workgroup) && "product_list_type".equals(work) && "date".equals(sort)){%> on<%}%>">등록일순</a></li>
				<li><a href="index.jsp?workgroup=product&work=product_list_type&type=<%=request.getParameter("type") %>&sort=priceAsc" class="link_filter<%if("product".equals(workgroup) && "product_list_type".equals(work) && "priceAsc".equals(sort)){%> on<%}%>">낮은 가격순</a></li>
				<li><a href="index.jsp?workgroup=product&work=product_list_type&type=<%=request.getParameter("type") %>&sort=priceDesc" class="link_filter<%if("product".equals(workgroup) && "product_list_type".equals(work) && "PriceDesc".equals(sort)){%> on<%}%>">높은 가격순</a></li>
			</ul>
			<select class="select_filter">
				<option>20개씩 보기</option>
				<option>40개씩 보기</option>
				<option>60개씩 보기</option>
			</select>
		</div>
		
	</div>
	<ul class="list_product">
		<% for(ProductDTO product : productList) { %>
		<li>
			<a href="index.jsp?workgroup=item_detail&work=item_detail&num=<%=product.getProductNum()%>	" class="link_product" id="product<%=product.getProductNum()%>">
				<span class="wrap_img">
					<img src="<%=request.getContextPath() %>/img_product/<%=product.getProductMainImg() %>" alt="<%=product.getProductMainImg() %>" class="img_product">
				</span>
				<span class="name_product"><%=product.getProductName() %></span>
			</a>
			<span class="screen_out">가격</span><span class="product_price"><%=df.format(product.getProductPrice()) %>원</span>
		</li>
		<% } %>
	</ul>
</div>
