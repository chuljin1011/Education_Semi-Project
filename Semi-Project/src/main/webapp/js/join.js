/* ID_input focus */
$("#id").focus();

/* 우편번호 기능 */
$("#zip_btn").click(function() {
	new daum.Postcode({
		oncomplete: function(data) {
			$("#zipcode").val(data.zonecode);
			$("#address1").val(data.address);
		}
	}).open();
});


/* 입력 시 에러 검출 */ // => ID 중복확인을 위해 jsp file로 이동
/*
var idCheckResult=false;
var idReg=/^[a-zA-Z]\w{5,19}$/g;

$("#id").blur(function() {
	
	$("#idMsg").css("display", "none");
	$("#idRegMsg").css("display", "none");
	$("#idDupMsg").css("display", "none");
	$("#idOkMsg").css("display", "none");
	
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");

	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");

	} else {
		idDupCheck();		
	}
	
});
*/


$("#passwd").blur(function() {
var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	
	$("#passwdMsg").css("display", "none");
	$("#passwdRegMsg").css("display", "none");
	
	if($("#passwd").val()=="") {
		$("#passwdMsg").css("display","block");

	} else if(!passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
	} 
});


$("#repasswd").blur(function() {
	
	$("#repasswdMsg").css("display","none");
	$("#repasswdMatchMsg").css("display", "none");
	
	if($("#repasswd").val()=="") {
		$("#repasswdMsg").css("display","block");

	} else if($("#passwd").val()!=$("#repasswd").val()) {
		$("#repasswdMatchMsg").css("display","block");
	}
});


$("#name").blur(function() {

	$("#nameMsg").css("display", "none");

	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
	}
});

/* 입력 시 에러 검출 */ // => email 중복확인을 위해 jsp file로 이동
/*
$("#email").blur(function() {
	
	$("#emailMsg").css("display", "none");

	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
	}
});
*/

/* submit */
$("#completeBtn").click(function() {
	var submitResult=true;
	
	$(".error").css("display", "none");
	
	/* ID 검증 */
	
	if($("#idCheckResult").val()=="false") {
		submitResult=false;
	}
	
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		submitResult=false;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		submitResult=false;
	} 
	
	/* PW 검증 */
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#passwd").val()=="") {
		$("#passwdMsg").css("display","block");
		submitResult=false;
	} else if(!passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	
	/* PW확인 검증 */
	if($("#repasswd").val()=="") {
		$("#repasswdMsg").css("display","block");
		submitResult=false;
	} else if($("#passwd").val()!=$("#repasswd").val()) {
		$("#repasswdMatchMsg").css("display","block");
		submitResult=false;
	}
	
	/* Email 검증 */
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if ($("#domainSel").val() == "직접입력") {
		if(!emailReg.test($("#email").val())) {
			$("#emailRegMsg").css("display","block");
			submitResult=false;
		}
	} else if($("#emailCheckResult").val()=="false") {
		submitResult=false;
	}
	
	/* 휴대폰번호 검증 */
	var mobileReg=/\d{11,12}/;
	if($("#mobile").val()=="") {
		$("#mobileMsg").css("display","block");
		submitResult=false;
	} else if(!mobileReg.test($("#mobile").val())) {
		$("#mobileRegMsg").css("display","block");
		submitResult=false;
	}
		
	/* 주소 검증 */
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	if($("#address1").val()=="") {
		$("#address1Msg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
	 
});


/* ID 체크 함수 */ //jsp file 로 이동
/*
function idDupCheck() {
	
	idCheckResult=false;
	var id=$("#id").val();
	
	$.ajax({
		type: "get",
		url: "<%=request.getContextPath()%>/client/client_id_check.jsp",
		data: "id="+id,
		dataType: "xml",
		success: function(xmlDoc) {
			var code=$(xmlDoc).find("code").text();
			if(code == "possible") {
				idCheckResult=true;
				$("#idOkMsg").css("display","block");
			} else {
				idCheckResult=false;
				$("#idDupMsg").css("display","block");
			}
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
}
*/




