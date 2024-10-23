<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 개별 CSS -->
<link rel="stylesheet" type="text/css" href="css/login.css">

<div id="loginArea" class="loginArea">

	<div id="loginText" class="loginText">
		<p>로그인</p>
	</div>
	
	<div id="loginArea_sub" class="loginArea_sub">
		<div id="loginbox" class="loginbox">
			<form action="login.html" method="post" id="loginform">
				<div id="loginbox_top">
					<p>회원 로그인</p>
				</div>
				<div id="loginbox_mid">
				
					<div id="loginbox_mid_1">
						<ul>
							<li></li>
							<li><input type="text" name="id" id="id" placeholder="아이디"></li>
							<li><input type="password" name="passwd" id="passwd"
								placeholder="비밀번호"></li>
							<li><input type="checkbox" name="id_save" id="id_save">
								<label for="id_save">아이디 저장</label></li>
						</ul>
					</div>
					
					<div id="loginbox_mid_2">
						<button type="button" id="submitBtn">로그인</button>
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
<!-- 개인 CODE 종료 -->