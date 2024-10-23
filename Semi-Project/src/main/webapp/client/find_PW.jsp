<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="css/find_ID.css">

<div id="findIDArea" class="findIDArea">

	<div id="findIDText" class="findIDText">
		<p>비밀번호 찾기</p>
	</div>
	<div id="findIDArea_sub" class="findIDArea_sub">
		<div id="findIDbox" class="findIDbox">
			<form action="findID.html" method="post" id="findIDform">
				<div id="findIDbox_top">
					<p>회원비밀번호 찾기</p>
				</div>
				<div id="findIDbox_mid">
					<div id="findIDbox_mid_1">
						<ul>
							<li></li>
							<li><input type="text" name="id" id="id" placeholder="아이디" style="margin-bottom: 5px"></li>
							<li><input type="text" name="id" id="id" placeholder="이름" style="margin-bottom: 5px"></li>
							<li>
								
									<input type="text" name="email" id="email" placeholder="가입메일주소" style="width: 55%">
									<select id="email_value">
										<option selected>직접입력</option>
										<option>naver.com</option>
										<option>hanmail.net</option>
										<option>daum.net</option>
										<option>naver.com</option>
										<option>nate.com</option>
										<option>hotmail.com</option>
										<option>gmail.com</option>
									</select></li>
								
							</ul>
					</div>
					<div id="findIDbox_mid_2">
						<button type="submit" id="findBtn">비밀번호 찾기</button>
					</div>
					<br>
				</div>
				<hr>
				<div id="btnDiv">
					<button type="button" id="findPWBtn">아이디 찾기</button>
					<button type="button" id="findIDBtn">로그인하기</button>
				</div>


			</form>
		</div>

	</div>



</div>