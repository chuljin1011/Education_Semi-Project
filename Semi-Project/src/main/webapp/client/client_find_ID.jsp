<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 개별 CSS -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/find_ID.css">


<div id="findIDArea" class="findIDArea">

	<div id="findIDText" class="findIDText">
		<p>아이디 찾기</p>
	</div>
	<div id="findIDArea_sub" class="findIDArea_sub">
		<div id="findIDbox" class="findIDbox">	
			<div id="findIDbox_top">
				<p>회원아이디 찾기</p>
			</div>
			<div id="findIDbox_mid">
				<div id="findIDbox_mid_1">
					<ul>
						<li></li>
						<li><input type="text" name="name" id="name" placeholder="이름" class="inputbar"></li>
						<li><input type="text" name="email" id="email" placeholder="가입메일주소" style="width: 55%"> 
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
						</li>
					</ul>
				</div>
				<div id="findIDbox_mid_2">
					<button type="button" id="findBtn">아이디 찾기</button>
				</div>
				<br>
			</div>
			<hr>
			<div id="btnDiv">
				<button type="button" id="findPWBtn">비밀번호 찾기</button>
				<button type="button" id="loginBtn">로그인하기</button>
			</div>
			<div id="result"><!--홍길동님의 아이디는 [abc123]입니다. --></div>
		</div>
	</div>
</div>


<script type="text/javascript">

$("#loginBtn").click(function() {
	window.location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=client&work=client_login";
});

$("#findPWBtn").click(function() {
	window.location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=client&work=client_find_PW";
});


// 아이디 찾기
$("#findBtn").click(function() {

	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	
	$("#result").html("");
	
	// 이름 공백 시
	if($("#name").val()=="") {
		$("#result").html("이름을 입력하세요.");
	// 이메일 공백 시
	} else if($("#email").val()=="") {
		$("#result").html("이메일을 입력하세요.");
	// 도메인 직접입력 선택 시 이메일 형식 확인
	} else if ($("#domainSel").val() == "직접입력") {
		if(!emailReg.test($("#email").val())) {
			$("#result").html("입력한 이메일이 형식에 맞지 않습니다.");
		}
	} else {
		findByEmail();
	}
});
	


/* email로 ID 찾기 */
function findByEmail() {
	
	var name=$("#name").val();
	
	var email="";
	var emailid=$("#email").val();
	var domain=$("#domainSel").val();
	
	if(domain=="직접입력") {
		email = emailid;
	} else {
		email = emailid+"@"+domain;
	}
	
	$.ajax({
		type: "post",
		url: "<%=request.getContextPath()%>/client/client_find_ajax.jsp",
		data: {"name":name, "email":email, "find":"id"},
		dataType: "xml",
		success: function(xmlDoc) {
			var message=$(xmlDoc).find("message").text();
			
			$("#result").html(message);
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
}


</script>
