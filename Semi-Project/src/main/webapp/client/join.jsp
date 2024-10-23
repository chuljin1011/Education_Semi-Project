<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 개별 CSS -->
<link rel="stylesheet" type="text/css" href="css/join.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div id="join_termsArea" class="join_termsArea">

	<div id="head_text" class="head_text">
		<div id="head_text_left" class="head_text_left">
			<p>회원가입</p>
		</div>
		<div id="head_text_right" class="head_text_right">
			<p>
				01 약관동의 &nbsp;▶&nbsp; <span id="current_stage"> 02 정보입력
					&nbsp;▶</span> &nbsp;03 가입완료
			</p>
		</div>
	</div>
	<hr>
	
	<!-- 메인 입력 -->
	<div id="join_box">
		<form id="join" action="" method="post">
			<div id="info_text">
				<div id="info_text_1">
					<p>기본정보</p>
				</div>
				<div id="info_text_2">
					<p>
						<span id="red_point">■</span> &nbsp;표시는 반드시 입력해야 하는 항목 입니다.
					</p>
				</div>
			</div>
	
	
			<div id=insert_Frame>
				<table>
					<tr>
						<th><span id="red_point">■</span> 아이디</th>
						<td><input type="text" name="id" id="id">
							<div id="idMsg" class="error">아이디를 입력해 주세요.</div>
							<div id="idRegMsg" class="error">아이디는 영문자로 시작되는 영문자,숫자,_의 6~20범위의 문자로만 작성 가능합니다.</div>
							<div id="idCheckMsg" class="error">아이디 중복 검사를 반드시 실행해 주세요.</div>
						</td>
					</tr>
					<tr>
						<th><span id="red_point">■</span> 비밀번호</th>
						<td><input type="password" name="passwd" id="passwd">
							<div id="passwdMsg" class="error">비밀번호를 입력해 주세요.</div>
							<div id="passwdRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div>
						</td>
					</tr>
					<tr>
						<th><span id="red_point">■</span> 비밀번호 확인</th>
						<td><input type="password" name="repasswd" id="repasswd">
							<div id="repasswdMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
							<div id="repasswdMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로 맞지 않습니다.</div>
						</td>
					</tr>
					<tr>
						<th><span id="red_point">■</span> 이름</th>
						<td><input type="text" name="name" id="name">
						<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
						</td>
					</tr>
					<tr>
						<th><span id="red_point">■</span> 이메일</th>
						<td><input type="text" name="email" id="email" style="width: 230px"> <select>
							<option selected>직접입력</option>
							<option>naver.com</option>
							<option>hanmail.net</option>
							<option>daum.net</option>
							<option>naver.com</option>
							<option>nate.com</option>
							<option>hotmail.com</option>
							<option>gmail.com</option>
						</select>
							<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
							<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
						</td>
					</tr>
					<tr>
						<th><span id="red_point">■</span> 휴대폰번호</th>
						<td><input type="text" name="mobile" id="mobile" size="12" placeholder="- 없이 입력하세요.">
							<div id="mobileMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
							<div id="mobileRegMsg" class="error">전화번호는 11~12 자리의 숫자로만 입력해 주세요.</div>
						</td>
					</tr>
					<tr>
						<th><span id="red_point">■</span> 주소</th>
						<td>
						<input type="text" name="zipCode" id="zipCode" size="7" readonly="readonly">
						<button type="button" id="zip_btn">우편번호검색</button>
						<input type="text" name="address1" id="address1" size="50" readonly="readonly">
						<input type="text" name="address2" id="address2" size="50">
							<div id="zipCodeMsg" class="error">우편번호를 입력해 주세요.</div>
							<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
							<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
						</td>
					</tr>
				</table>
	
				<div id="btnDiv">
					<button type="button" id="cancelBtn">취소</button>
					<button type="button" id="completeBtn">회원가입</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script src="<%=request.getContextPath()%>/js/join.js"></script>

<!-- 개인 CODE 종료 -->



<!-- jsp Jquery -->



<script type="text/javascript">

$("#name").val("abcdef");

/* 
$("#join").submit(function() {
	var submitResult=true;
	
	$(".error").css("display", "none");
	
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		submitResult=false;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		submitResult=false;
	} else if($("#idCheckResult").val()=="0") {
		$("#idCheckMsg").css("display","block");
		submitResult=false;
	}
	
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#passwd").val()=="") {
		$("#passwdMsg").css("display","block");
		submitResult=false;
	} else if(!passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	
	
};

 */

</script>