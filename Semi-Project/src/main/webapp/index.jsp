<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	//페이지 몸체부에 포함될 JSP 문서의 작업 폴더명을 반환받아 저장
	String workgroup=request.getParameter("workgroup");
	if(workgroup == null) {
		workgroup="main";
	}

	//페이지 몸체부에 포함될 JSP 문서의 파일명을 반환받아 저장
	String work=request.getParameter("work");
	if(work == null) {
		work="main_page";
	}
	//전달값을 사용하여 페이지 몸체부에 포함될 JSP 문서의 컨텍스트 경로를 생성하여 저장
	String contentPath=workgroup+"/"+work+".jsp";
	
	String headerPath="/header.jsp";
	if(workgroup.equals("admin")) {
		headerPath="/header_admin.jsp";
	}

%>   
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/font.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css">
<link rel="stylesheet" type="text/css" href="css/slick-theme.css">
<link rel="icon" href="images/logo_favicon.png"/>
<link rel="apple-touch-icon" href="images/logo_favicon.png"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>


<title>Nature Gear</title>
</head>
<body>
	<div id="mainWrap" class="wrap_main">
		<%--<%@include file="header.jspf" %> --%>
		<%--<%@include file="header_admin.jspf" %>--%>
		 <jsp:include page="<%=headerPath %>"/>
		
		<div id="mAticle" class="cont_article<%if(workgroup=="main"&&work=="main_page"){%> main<%}%>">
			<jsp:include page="<%=contentPath %>"/>		
			<%
				String returnUrl=(String)request.getAttribute("returnUrl");
				if(returnUrl != null) {
					
					//System.out.println("Return URL: " + returnUrl);  // 디버깅 출력
					response.sendRedirect(returnUrl);
					return;
				}
			%>
		</div>
		
		<%@include file="footer.jspf" %>
	</div>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/main.js"></script>
</body>
</html>