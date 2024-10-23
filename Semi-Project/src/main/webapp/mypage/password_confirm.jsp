<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 사용자로부터 비밀번호를 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [입력완료] 태그를 클릭한 경우 전달값에 따라 다른 JSP 문서를 요청하여 페이지 이동 - 입력값(비밀번호) 전달 --%>

<style>


#passwordForm {
    max-width: 200px; /* 최대 폭 */
    margin: 20px auto; /* 중앙 정렬 */
    padding: 40px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    background-color: #f9f9f9; /* 배경색 */
    text-align: center; /* 텍스트 중앙 정렬 */
}

#passwordForm p {
    font-size: 18px; /* 글자 크기를 18px로 설정 */
    text-align: center; /* 텍스트 중앙 정렬 */
    margin: 10px 0; /* 위아래 여백 설정 */
}

/* 비밀번호 입력 필드 스타일 */
#passwd {
    width: 80%; /* 폭을 100%로 설정 */
    padding: 10px; /* 내부 여백 */
    margin-bottom: 10px; /* 아래 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 모서리 둥글게 */
}

/* 버튼 스타일 */
#submitBtn {
    width: 100%; /* 폭을 100%로 설정 */
    padding: 10px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 4px; /* 모서리 둥글게 */
    background-color: #ccc; /* 배경색 */
    color: white; /* 글자색 */
    font-size: 16px; /* 글자 크기 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* 버튼 호버 효과 */
#submitBtn:hover {
    background-color: #7fffd4; /* 호버 시 배경색 변경 */
}	

/* 메시지 스타일 */
#message {
    font-weight: bold; /* 글씨 두껍게 */
}
</style>

<%@include file="/security/login_check.jspf" %>    
<%
	//전달값을 반환받아 저장
	String action=request.getParameter("action");

	
	String message=(String)session.getAttribute("message");
	if(message == null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>


<form method="post" id="passwordForm">
<% if(action.equals("update")) { %>
	<p>회원정보 변경을 위한<br>비밀번호 인증</p>
<% } else { %>
	<p>회원정보 탈퇴를 위한<br>비밀번호 인증</p>
<% } %>
	<input type="password" name="passwd" id="passwd">
	<button type="button" id="submitBtn">입력완료</button>
</form>
<p id="message" style="color: red;"><%=message %></p>

<script type="text/javascript">
$("#passwd").focus();	// 비밀번호 입력 필드에 포커스

$("#submitBtn").click(function() {
	if($("#passwd").val() == "") {	// 비밀번호 입력 확인
		$("#message").text("비밀번호를 입력해 주세요.");	// 비밀번호가 입력되지 않았을 경우, 메시지 영역에 "비밀번호를 입력해 주세요."라는 텍스트 표시
		return;	// 비밀번호가 없는 경우, 함수 실행을 중단하고 이후의 코드를 실행하지 않음
	}
	
	//전달값에 따라 form 태그의 action 속성값을 다르게 설정
	<% if(action.equals("update")) { %>
		$("#passwordForm").attr("action", "<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=mypage_client_update")
	<% } else { %>
		$("#passwordForm").attr("action", "<%=request.getContextPath()%>/index.jsp?workgroup=mypage&work=mypage_client_delete")
	<% } %>
	
	$("#passwordForm").submit();//form 태그 실행
});
</script>