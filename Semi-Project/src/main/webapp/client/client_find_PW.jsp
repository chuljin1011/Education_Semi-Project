<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 개별 CSS -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/find_PW.css">


<div id="findPWArea" class="findPWArea">

	<div id="findPWText" class="findPWText">
		<p>비밀번호 찾기</p>
	</div>
	<div id="findPWArea_sub" class="findPWArea_sub">
		<div id="findPWbox" class="findPWbox">
			<div id="findPWbox_top">
				<p>회원비밀번호 찾기</p>
			</div>
			<div id="findPWbox_mid">
				<div id="findPWbox_mid_1">
					<ul>
						<li></li>
						<li><input type="text" name="id" id="id" placeholder="아이디" class="inputbar"></li>
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
				<div id="findPWbox_mid_2">
					<button type="button" id="findBtn" class="findBtn">비밀번호 찾기</button>
				</div>
			</div>
			<div id="findPWbox_mid_hidden">
				<div id="findPWbox_mid_3">
					<ul>
						<li><div class="newpasswdText">새로 사용하실 비밀번호를 입력하세요.</div></li>
						<li><input type="password" name="newpasswd" id="newpasswd" placeholder="신규 비밀번호" style="margin-bottom: 5px"></li>
						<li><input type="password" name="renewpasswd" id="renewpasswd" placeholder="신규 비밀번호 확인" style="margin-bottom: 5px"></li>
					</ul>
				</div>
				<div id="findPWbox_mid_4">
					<button type="button" id="updateBtn" class="findBtn">비밀번호 변경</button>
				</div>
			</div>
			<div id="newpasswdMsg" class="error">신규 비밀번호를 입력해주세요.</div>
			<div id="renewpasswdMsg" class="error">신규 비밀번호 확인을 입력해주세요.</div>
			<div id="repasswdMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로 맞지 않습니다.</div>
			<hr>
			<div id="btnDiv">
				<button type="button" id="findIDBtn">아이디 찾기</button>
				<button type="button" id="loginBtn">로그인하기</button>
			</div>
			<div id="result"></div>
		</div>
	</div>
</div>



<script type="text/javascript">

var clientNum=0;

$("#loginBtn").click(function() {
	window.location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=client&work=client_login";
});

$("#findIDBtn").click(function() {
	window.location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=client&work=client_find_ID";
});

$("#findPWbox_mid_hidden").css("display", "none");
$("#findPWbox_mid").css("display", "flex");


/* 비밀번호 찾기 */
$("#findBtn").click(function() {

	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	
	$("#result").html("");
	
	// 아이디 공백 시
	if($("#id").val()=="") {
		$("#result").html("아이디를 입력하세요.");
	// 이름 공백 시
	} else if($("#name").val()=="") {
		$("#result").html("이름을 입력하세요.");
	// 이메일 공백 시
	} else if($("#email").val()=="") {
		$("#result").html("이메일을 입력하세요.");
	// 도메인 직접입력 선택 시 이메일 형식 확인
	} else if ($("#domainSel").val() == "직접입력") {
		if(!emailReg.test($("#email").val())) {
			$("#result").html("입력한 이메일이 형식에 맞지 않습니다.");
		} else {
			findByID();
		}
		
	} else {
		findByID();
	}
});
 

/* ID로 정보 확인 */
function findByID() {
	
	var name=$("#name").val();
	var id=$("#id").val();
	
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
		data: {"name":name, "email":email, "id":id, "find":"pw"},
		dataType: "xml",
		success: function(xmlDoc) {
			var message=$(xmlDoc).find("message").text();
			var code=$(xmlDoc).find("code").text();
			
			if(message=="complete") {
				$("#findPWbox_mid_hidden").css("display", "flex"); //신규 비밀번호 입력창
				$("#findPWbox_mid").css("display", "none"); //기존 창 블라인드
				clientNum = code;
			} else {
				$("#result").html(message);
			}
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
}


/* 비밀번호 변경 */	
 
$("#updateBtn").click(function() {

	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	$("#result").html("");
	
	// 신규 비밀번호 공백 확인
	if($("#newpasswd").val()=="") {
		$("#result").html("신규 비밀번호를 입력하세요.");
		$("#newpasswd").focus();
	// 신규 비밀번호 문자형식 확인
	} else if(!passwdReg.test($("#newpasswd").val())) {
		$("#result").html("비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.");
		$("#newpasswd").focus();
	// 신규 비밀번호 확인 공백 확인
	} else if($("#renewpasswd").val()=="") {
		$("#result").html("신규 비밀번호 확인 입력하세요.");
		$("#renewpasswd").focus();
	// 신규 비밀번호 일치 확인
	} else if($("#newpasswd").val()!=$("#renewpasswd").val()) {
		$("#result").html("신규 비밀번호가 일치하지 않습니다.");
		$("#renewpasswd").focus();
	} else {
		modifyPasswd();
	}
});
 
 
/* 비밀번호 변경 */

function modifyPasswd() {
	
	var passwd=$("#newpasswd").val();
	
	$.ajax({
		type: "post",
		url: "<%=request.getContextPath()%>/client/client_newPasswd.jsp",
		data: {"passwd":passwd, "num":clientNum},
		dataType: "xml",
		success: function(xmlDoc) {
			var code=$(xmlDoc).find("code").text();
			
			if(code=="complete") {
				$("#result").html("비밀번호가 변경 되었습니다.");
			} else {
				$("#result").html("비밀번호가 변경 되지 않았습니다. 고객센터에 문의 바랍니다.");
			}
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
} 
 
 
 
 

</script>