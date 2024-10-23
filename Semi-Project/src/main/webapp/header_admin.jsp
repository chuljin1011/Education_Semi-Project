<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String workgroup=request.getParameter("workgroup");
	String work=request.getParameter("work");
%>    

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/admin.css">
<div id="wrapHead" class="wrap_head admin">
	<div class="wrap_top">
		<div class="inner_top">
			<span class="admin_welcome"><span class="login_name">[관리자]</span>님, 환영합니다.</span>
			<a href="index.jsp?" class="link_top type2">쇼핑몰 돌아가기</a>
		</div>
	</div>
	<div class="inner_head clear_fix">
		<h1>
			<span class="screen_out">네이쳐기어</span>
			<a href="index.jsp?" class="link_tit"><img src="images/logo_camp.png" alt="네이쳐기어"></a>
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
	</div>
	<div class="wrap_nav">
		<div class="inner_nav clear_fix">
			<div class="wrap_gnb">
				<h2 class="screen_out">관리 주요 메뉴</h2>
				<ul class="list_gnb">
					<li><a href="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=admin_product" class="link_gnb manage_client<%if("admin".equals(workgroup) && "admin_product".equals(work)){%> on<%}%>">상품관리</a></li>
					<li><a href="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=admin_client" class="link_gnb manage_product<%if("admin".equals(workgroup) && "admin_client".equals(work)){%> on<%}%>">회원관리</a></li>
					<li><a href="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=admin_delivery" class="link_gnb manage_delivery<%if("admin".equals(workgroup) && "admin_delivery".equals(work)){%> on<%}%>">배송관리</a></li>
				</ul>
			</div>	
		</div>
	</div>
</div>