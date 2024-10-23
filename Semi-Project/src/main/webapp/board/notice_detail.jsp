<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	if(request.getParameter("noticeNum") == null) {//전달값이 없는 경우
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}

	int noticeNum=Integer.parseInt(request.getParameter("noticeNum"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	NoticeDTO notice=NoticeDAO.getDAO().selectNoticeByNum(noticeNum);
	//MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	if(notice == null){ 
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?workgroup=error&work=error_400");
		return;
	}
	
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
	NoticeDAO.getDAO().updateNoticeCount(noticeNum);
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/notice_detail_style.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<title>공지사항</title>
</head>
<body>
	<div id="container">
			<div id="contents">
				<div class="sub_content">
					<div class="content">
						<div class="board_zone_sec">
							<div class="board_zone_tit">
								<h2>공지사항</h2>
							</div>
							<div class="board_zone_cont">
								<div class="board_zone_view">
									<div class="board_view_tit">
										<h3><%=notice.getNoticeTitle()%></h3>
									</div>
									<div class="board_view_info">
										<span class="view_info_idip">
											<strong>관리자</strong>
										</span>
										<span class="view_info_day">
											<em><%=notice.getNoticeDate() %></em>
										</span>
										<span class="view_info_hits">
											<strong>조회수</strong>
											<%=notice.getNoticeCount() %>
										</span>
									</div>
									<div class="board_view_content">
										<div class="seem_cont">
											<div style="margin: 10px 0 10px 0;">
												<p>
												<% if(notice.getNoticeImage() != null) { %>
													<img src="<%=request.getContextPath()%>/notice_images/<%=notice.getNoticeImage()%>">
												<% } %>
													<br style="clear:both">
												</p>
											</div>
										</div>
									</div>
									<div class="board_view_comment">
										<div class="view_comment"></div>
									</div>
								</div>
								<div class="btn_right_box">
									<% if(loginClient != null && loginClient.getClientStatus() == 9) { %>
									<button type="button" class="btn_board_modify" id="modifyBtn">수정</button>
									<button type="button" class="btn_board_remove" id="removeBtn">삭제</button>
									<% } %>
									<button type="button" class="btn_board_list" id="listBtn">목록</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<script type="text/javascript">
	$("#listBtn").click(function() {
		location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_list"
			+"&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>";
	});
	
	$("#modifyBtn").click(function() {
		location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_modify"
			+"&noticeNum=<%=notice.getNoticeNum()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>";
	});
	
	$("#removeBtn").click(function() {
		if(confirm("게시글을 정말로 삭제 하시겠습니까?")) {
			location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_remove_action"
				+"&noticeNum=<%=notice.getNoticeNum()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>";
		}
	});
	</script>
</body>
</html>