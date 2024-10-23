<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	if(request.getParameter("noticeNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
	
	int noticeNum=Integer.parseInt(request.getParameter("noticeNum"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//System.out.println("noticeNum="+noticeNum);
	
	NoticeDTO notice=NoticeDAO.getDAO().selectNoticeByNum(noticeNum);
	
	if(notice == null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;		
	}
	
	if(loginClient.getClientStatus() != 9 ){
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;		
	}
%>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/notice_write_style.css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<title>공지사항 수정</title>
	<div id="container">
		<div class="notice_write_head">
			<h2>공지사항 수정</h2>
		</div>
		<div>
		<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_modify_action"
			method="post" enctype="multipart/form-data" id="noticeForm">
			<input type="hidden" name="noticeNum" value="<%=noticeNum %>">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<input type="hidden" name="search" value="<%=search%>">
			<input type="hidden" name="keyword" value="<%=keyword%>">
		
			<table class="notice_write_table">
				<colgroup>
					<col style="width: 15%;">
					<col style="width: 85%;">
				</colgroup>
				<tr>
					<th scope="row">제목</th>
					<td style="display: flex;">
						<input type="text" name="noticeTitle" id="notice_title" value="<%=notice.getNoticeTitle() %>">
						<label class="checkbox-container">
							<input type="checkbox" name="noticeStatus" value="2"<% if(notice.getNoticeStatus()==2){ %>checked<%} %>>상단고정글
						</label>
						<div id="message" style="color: red;"></div>
					</td>
				</tr>
				<tr>
					<th scope="row">이미지</th>
					<td id="uploadBox">
						<div class="file_upload_sec">
							<div class="btn_upload_box">
								<input type="file" name="noticeImage" class="btn_upload"><br>
								<% if(notice.getNoticeImage() != null) { %>
									<div style="color: red;">이미지를 변경할 경우에만 파일을 입력해 주세요.</div><br>
									<img src="<%=request.getContextPath()%>/review_images/<%=notice.getNoticeImage()%>">
								<% } %>
							</div>
						</div>
					</td>
				</tr>
			</table>
			<div class="btn_center_box">
				<button type="button" class="btn_before" id="listBtn">이전</button>
				<button type="submit" class="btn_write_ok" id="saveBtn">저장</button>
			</div>
		</form>
		</div>
	</div>
	<script type="text/javascript">
	$("#notice_title").focus();
	
	$("#noticeForm").submit(function() {
		if($("noticeTitle").val()==""){
		$("#message").text("제목을 입력해 주세요.");
		$("#noticeTitle").focus();
		return false;
		}
	});
	
	$("#listBtn").click(function() {
		location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_list"
			+"&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>";
	});
	</script>
