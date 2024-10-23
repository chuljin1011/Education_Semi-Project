<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String url=request.getParameter("url");
	if(url == null) {
		url="";
	}

	String message=(String)session.getAttribute("message");
	if(message == null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	String id=(String)session.getAttribute("id");
	if(id == null) {
		id="";
	} else {
		session.removeAttribute("id");
	}
%>

<!-- 개별 CSS -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/login.css">

<div id="loginArea" class="loginArea">

	<div id="loginText" class="loginText">
		<p>로그인</p>
	</div>
	
	<div id="loginArea_sub" class="loginArea_sub">
		<div id="loginbox" class="loginbox">
			<form id="loginform" action="<%=request.getContextPath() %>/index.jsp?workgroup=client&work=client_login_action" method="post">
				<div id="loginbox_top">
					<p>회원 로그인</p>
				</div>
				<div id="loginbox_mid">
				<input type="hidden" name="url" value="<%=url%>"> <!-- 특정 페이지에서 로그인 시 URL 전달하여 로그인 직 후 마지막 페이지로 돌아가기용 -->
				
					<div id="loginbox_mid_1">
						<ul>
							<li></li>
							<li>
							<input type="text" name="id" id="id" placeholder="아이디" value="<%=id%>">
							<div id="idMsg" class="error">아이디를 입력해 주세요.</div>
							</li>
							<li>
							<input type="password" name="passwd" id="passwd" placeholder="비밀번호">
							<div id="passwdMsg" class="error">비밀번호를 입력해 주세요.</div>
							</li>
							<li><input type="checkbox" name="id_save" id="id_save">
								<label for="id_save">아이디 저장</label></li>
							<li><div id="id_passwd_check"><%=message %></div></li>
						</ul>
					</div>
					
					<div id="loginbox_mid_2">
						<button type="button" id="login_btn">로그인</button>
					</div>
					<hr>
				</div>
				
				<div id="loginbox_bottom">
					<button type="button" id="joinBtn">회원가입</button>
					<button type="button" id="findIDBtn">아이디 찾기</button>
					<button type="button" id="findPWBtn">비밀번호 찾기</button>
				</div>
			</form>
		</div>
	</div>
</div>



<!-- jsp, jquery -->

<script type="text/javascript">

/* 버튼 정의 */
$("#joinBtn").click(function() {
	window.location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=client&work=client_join_terms";
});

$("#findIDBtn").click(function() {
	window.location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=client&work=client_find_ID";
});

$("#findPWBtn").click(function() {
	window.location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=client&work=client_find_PW";
});


/* id focus */
$("#id").focus();


/* 로그인 */

$("#login_btn").click(function() {

	$("#idMsg").css("display", "none");
	$("#passwdMsg").css("display", "none");
	
		if($("#id").val()=="") {
			$("#idMsg").css("display","block");
			$("#id").focus();
			return;
		}
		
		if($("#passwd").val()=="") {
			$("#passwdMsg").css("display","block");
			$("#passwd").focus();
			return;
		}
		
		$("#loginform").submit();
});

</script>

