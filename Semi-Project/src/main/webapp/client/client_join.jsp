<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 개별 CSS -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/join.css">

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
		<form id="join" action="<%=request.getContextPath() %>/index.jsp?workgroup=client&work=client_join_action" method="post">
		<input type="hidden" id="idCheckResult" value="false">
		<input type="hidden" id="emailCheckResult" value="false">
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
							<div id="idDupMsg" class="error">이미 사용중인 아이디입니다.</div>
							<div id="idOkMsg" class="pass">사용할 수 있는 아이디입니다.</div>
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
						<td><input type="text" name="email" id="email" style="width: 230px"> 
						<select id="domainSel" name="domainSel">
							<option id="domainSelf" selected>직접입력</option>
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
							<div id="emailDupMsg" class="error">이미 사용중인 이메일입니다.</div>
							<div id="emailOkMsg" class="pass">사용 가능한 이메일입니다.</div>
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
						<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly">
						<button type="button" id="zip_btn">우편번호검색</button>
							<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
						<input type="text" name="address1" id="address1" size="50" readonly="readonly">
							<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
						<input type="text" name="address2" id="address2" size="50">
						</td>
					</tr>
				</table>
	
				<div id="btnDiv">
					<button type="button" id="cancelBtn">메인으로</button>
 					<button type="submit" id="completeBtn">회원가입</button>
				</div>
			</div>
		</form>
	</div>
</div>


<!-- 개인 CODE 종료 -->


<!-- js -->

<script src="<%=request.getContextPath()%>/js/join.js"></script>

<!-- jsp, jquery -->

<script type="text/javascript">

$("#cancelBtn").click(function() {
	window.location.href = "<%=request.getContextPath()%>/index.jsp";
});

$("#id").blur(function() {
var idReg=/^[a-zA-Z]\w{5,19}$/g;
	
	$("#idMsg").css("display", "none");
	$("#idRegMsg").css("display", "none");
	$("#idDupMsg").css("display", "none");
	$("#idOkMsg").css("display", "none");
	
	$("#idCheckResult").val("false");
	
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
	} else {
		idDupCheck();		
	}
});

$("#email").blur(function() {
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	
	$("#emailMsg").css("display", "none");
	$("#emailRegMsg").css("display", "none");
	$("#emailDupMsg").css("display", "none");
	$("#emailOkMsg").css("display", "none");
	
	$("#emailCheckResult").val("false");

	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
	} else if ($("#domainSel").val() == "직접입력") {
		if(!emailReg.test($("#email").val())) {
			$("#emailRegMsg").css("display","block");
			submitResult=false;
		}
	} else {
		emailDupCheck();
	}
});

$("#domainSel").change(function() {
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	
	$("#emailMsg").css("display", "none");
	$("#emailRegMsg").css("display", "none");
	$("#emailDupMsg").css("display", "none");
	$("#emailOkMsg").css("display", "none");
	
	$("#emailCheckResult").val("false");

	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
	} else if ($("#domainSel").val() == "직접입력") {
		if(!emailReg.test($("#email").val())) {
			$("#emailRegMsg").css("display","block");
			submitResult=false;
		}
	} else {
		emailDupCheck();
	}
});

	
/* ID 중복 확인 */
function idDupCheck() {
	
	var id=$("#id").val();
	
	$.ajax({
		type: "get",
		url: "<%=request.getContextPath()%>/client/client_dup_check.jsp",
		data: "id="+id,
		dataType: "xml",
		success: function(xmlDoc) {
			var code=$(xmlDoc).find("code").text();
			if(code == "possible") {
				$("#idCheckResult").val("true");
				$("#idOkMsg").css("display","block");
			} else {
				$("#idDupMsg").css("display","block");
			}
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
}

/* email 중복 확인 */
function emailDupCheck() {
	
	var email="";
	var emailid=$("#email").val();
	var domain=$("#domainSel").val();
	
	if(domain=="직접입력") {
		email = emailid;
	} else {
		email = emailid+"@"+domain;
	}
	
	$.ajax({
		type: "get",
		url: "<%=request.getContextPath()%>/client/client_dup_check.jsp",
		data: "email="+email,
		dataType: "xml",
		success: function(xmlDoc) {
			var code=$(xmlDoc).find("code").text();
			if(code == "possible") {
				$("#emailCheckResult").val("true");
				$("#emailOkMsg").css("display","block");
			} else {
				$("#emailCheckResult").val("false");
				$("#emailDupMsg").css("display","block");
			}
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
}

</script>


