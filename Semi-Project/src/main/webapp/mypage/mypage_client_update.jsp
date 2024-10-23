<%@page import="xyz.itwill.dao.DeliveryDAO"%>
<%@page import="xyz.itwill.dto.DeliveryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<link rel="stylesheet" type="text/css"
	href="css/mypage_client_update.css">
<link rel="stylesheet" type="text/css" href="css/join.css">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 로그인 체크를 위한 JSP Include -->
<%@ include file="/security/login_check.jspf" %>

<div class="sub-menu-link">
	<p>홈 > 마이페이지</p>
</div>
<div class="container" style="margin-bottom: 100px;">
	<div class="left-sidebar">

		<hr>
		<h2>마이페이지</h2>
		<hr>

		<ul class="left-sidebar-menu">
			<li>
				<hr>
				<h3>쇼핑정보</h3>
				<ul class="left-sidebar-menu-child">
					<li><a
						href="index.jsp?workgroup=mypage&work=mypage_order_list"> -
							주문목록/배송조회</a></li>
					<li><a href="">- 취소/반품/교환 내역</a></li>
					<li><a href="">- 환불/입금 내역</a></li>
				</ul>
			</li>
			<li>
				<hr>
				<h3>고객센터</h3>
				<ul class="left-sidebar-menu-child">
					<li><a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_write">- 1:1 문의</a></li>
				</ul>
			</li>
			<li>
				<hr>
				<h3>회원정보</h3>
				<ul class="left-sidebar-menu-child">
					<li><a
						href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=password_confirm&action=update">-
							회원정보 변경</a></li>
					<li><a
						href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=password_confirm&action=delete">-
							회원 탈퇴</a></li>
				</ul>
			</li>
			<li>
				<hr>
				<h3>나의 상품문의</h3>
				<ul class="left-sidebar-menu-child">
					<!-- QnA 페이지로 이동 후 내가 작성한 글만 조회-->
					<li><a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=qna_list&myNotice=true">- 나의 상품문의</a></li>
				</ul>
			</li>
			<li>
				<hr>
				<h3>나의 상품후기</h3>
				<ul class="left-sidebar-menu-child">
					<li><a href="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=myreview">- 나의 상품후기</a></li>
				</ul>
			</li>
		</ul>
	</div>
	
	<form id="join"
		action="<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=mypage_client_update_action"
		method="post">
		<!-- 로그인한 사용자의 번호(클라이언트넘버)를 히든처리하여 전달 -->
		<input type="hidden" name="num" value="<%=loginClient.getClientNum()%>">

		<div class="main-content">
			<div id="join_box" style="position: relative; top: -115px">
				<!-- 아이디 체크 및 이메일 체크 결과를 저장할 숨겨진 필드 -->
				<input type="hidden" id="idCheckResult" value="false"> <input
					type="hidden" id="emailCheckResult" value="false">
				<div id="info_text">
					<div id="info_text_1">
						<p>기본정보 수정</p>
					</div>
					<div id="info_text_2">
						<p>
							<span id="red_point">■</span> &nbsp;필수 입력
						</p>
					</div>
				</div>

				<!-- value 값은 현제 로그인한 사용자의 번호를 ClientDTO 객체에 설정 - 타겟 지정 후 
				대응 되는 값을 가져와 출력-->
				<div id=insert_Frame>
					<table>
						<tr>
							<th><span id="red_point">■</span> 아이디</th>
							<td><input type="text" name="id" id="id"
								value="<%=loginClient.getClientId()%>" readonly="readonly">
						</tr>
						<tr>
							<th><span id="red_point">&nbsp;&nbsp;</span> 비밀번호</th>
							<td><input type="password" name="passwd" id="passwd">
								<div id="passwdMsg" class="error">비밀번호를 입력해 주세요.</div>
								<span style="margin-left: 5px"> 비밀번호를 변경하지 않을 경우 입력하지마세요</span>
								<div id="passwdRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가
									반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div></td>
						</tr>
						<tr>
							<th><span id="red_point">&nbsp;&nbsp;</span> 비밀번호 확인</th>
							<td><input type="password" name="repasswd" id="repasswd">
								<div id="repasswdMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
								<div id="repasswdMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로
									맞지 않습니다.</div></td>
						</tr>
						<tr>
							<th><span id="red_point">■</span> 이름</th>
							<td><input type="text" name="name" id="name"
								value="<%=loginClient.getClientName()%>" readonly="readonly">
								<div id="nameMsg" class="error">이름을 입력해 주세요.</div></td>
						</tr>
						<tr>
							<th><span id="red_point">■</span> 이메일</th>
							<td><input type="text" name="email" id="email"
								style="width: 230px" value="<%=loginClient.getClientEmail()%>" readonly="readonly"> 
								<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
								<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
								<div id="emailDupMsg" class="error">이미 사용중인 이메일입니다.</div>
								<div id="emailOkMsg" class="pass">사용 가능한 이메일입니다.</div></td>
						</tr>
						<tr>
							<th><span id="red_point">■</span> 휴대폰번호</th>
							<td><input type="text" name="mobile" id="mobile" size="12" value="<%= loginClient.getClientMobile().replace("-", "") %>"
								placeholder="- 없이 입력하세요." readonly="readonly" >
								<div id="mobileMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
								<div id="mobileRegMsg" class="error">전화번호는 11~12 자리의 숫자로만
									입력해 주세요.</div></td>
						</tr>
						<tr>
							<th><span id="red_point">■</span> 주소</th>
							<td><input type="text" name="zipcode" id="zipcode" size="7"
								readonly="readonly" value="<%=loginClient.getClientAddress1()%>">
								<button type="button" id="zip_btn">우편번호검색</button>
								<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div> <input
								type="text" name="address1" id="address1" size="50"
								readonly="readonly" value="<%=loginClient.getClientAddress1()%>">
								<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div> <input
								type="text" name="address2" id="address2" size="50" 
								value="<%= (loginClient.getClientAddress2() != null) ? loginClient.getClientAddress2() : "" %>"></td>
						</tr>
					</table>

					<div id="btnDiv">
						<button type="button" id="cancelBtn">돌아가기</button>
						<button type="submit" id="completeBtn">정보수정</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- js -->

<script type="text/javascript">
$(document).ready(function() {
    $("#cancelBtn").click(function() {
        window.location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=mypage";
    });
});
</script>

<script type="text/javascript">
$("#join").submit(function () {
	var submitResult = true;
	
	$(".error").css("display","none");
	
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#passwd").val()!="" && !passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	
	if($("#passwd").val()!=$("#repasswd").val()) {
		$("#repasswdMatchMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	}

	var mobileReg=/\d{11,12}/;
	if($("#mobile").val()=="") {
		$("#mobileMsg").css("display","block");
		submitResult=false;
	} else if(!mobileReg.test($("#mobile").val())) {
		$("#mobileRegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#address1").val()=="") {
		$("#address1Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#address2").val()=="") {
		$("#address2Msg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
	
});

$("#zip_btn").click(function() {
	new daum.Postcode({
		oncomplete: function(data) {
			$("#zipcode").val(data.zonecode);
			$("#address1").val(data.address);
		}
	}).open();
});

</script>




<script type="text/javascript">
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
		url: "<%=request.getContextPath()%>
	/client/client_dup_check.jsp",
			data : "email=" + email,
			dataType : "xml",
			success : function(xmlDoc) {
				var code = $(xmlDoc).find("code").text();
				if (code == "possible") {
					$("#emailCheckResult").val("true");
					$("#emailOkMsg").css("display", "block");
				} else {
					$("#emailCheckResult").val("false");
					$("#emailDupMsg").css("display", "block");
				}
			},
			error : function(xhr) {
				alert("에러코드 = " + xhr.status);
			}
		});
	}
</script>

