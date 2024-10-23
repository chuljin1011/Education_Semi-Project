<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- NOTICE 테이블에 저장된 행을 검색하여 검색된 행을 HTML 태그에 포함해 응답하는 JSP 문서 --%>
<%-- => NOTICE 테이블에 저장된 행을 페이지 단위로 구분하여 검색해 응답 처리 - 페이징 처리 --%>
<%-- => [페이지번호] 태그를 클릭한 경우 [/notice/notice_main.jsp] 문서를 요청하여 페이지 이동 
- 페이지번호, 게시글갯수, 조회대상, 조회단어 전달 : 조회기능을 유지하기 위해 조회대상과 조회단어 전달 --%>
<%-- => [검색]태그를 클릭한 경우 [/notice/notice_main.jsp] 문서를 요청하여 페이지 이동
- 조회대상, 조회단어 전달 : 페이지번호와 게시글갯수는 기본값 사용 --%>
<%-- => [글쓰기] 태그를 클릭한 경우 [/notice/notice_write.jsp] 문서를 요청하여 페이지 이동 
- 관리자에게만 태그를 출력하여 링크가 제공되도록 작성 --%>
<%-- 게시글의 [글제목]을 클릭한 경우 [/notice/notice_detail.jsp] 문서를 요청하여 페이지 이동
- 글번호, 페이지번호, 게시글갯수, 조회대상, 조회단어 전달 --%>
<%
	//게시글 조회기능에 필요한 전달값(조회대상과 조회단어)을 반환받아 저장
	String search=request.getParameter("search");//조회대상
	if(search == null) {//전달값이 없는 경우 - 조회기능을 사용하지 않은 경우
		search="";
	}
	
	String keyword=request.getParameter("keyword");//조회단어
	if(keyword == null) {
		keyword="";
	}
	
	//페이징 처리에 필요한 전달값(페이지번호와 게시글갯수)을 반환받아 저장
	int pageNum=1;//페이지번호 - 전달값이 없는 경우 사용할 기본값 저장
	if(request.getParameter("pageNum") != null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=16;//게시글갯수
	
	//조회정보(조회대상과 조회단어)를 전달받아 REVIEW 테이블에 저장된 행에서 조회정보가 포함된 
	//행의 갯수를 검색하여 반환하는 NoticeDAO 클래스의 메소드 호출
	//int totalNotice=NoticeDAO.getDAO().selectTotalNotice(search, keyword);//게시글의 총갯수
	int totalNotice=NoticeDAO.getDAO().selectTotalNoticeND(search, keyword);//게시글의 총갯수
	
	//페이지의 총갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalNotice/pageSize);
	
	//전달받은 페이지번호가 비정상적인 경우 첫번째 페이지를 요청할 수 있는 기본값 저장
	if(pageNum <= 0 || pageNum > totalPage) {
		pageNum=1;
	}
	
	//페이지번호에 대한 게시글의 시작 행번호를 계산하여 저장
	//ex) 1Page : 1, 2Page : 17, 3Page : 33, 4Page : 49, ...
	int startRow=(pageNum-1)*pageSize+1;
	
	//페이지번호에 대한 게시글의 종료 행번호를 계산하여 저장
	//ex) 1Page : 16, 2Page : 32, 3Page : 48, 4Page : 64, ...
	int endRow=pageNum*pageSize;	
	
	//마지막 페이지의 게시글의 종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행변호 변경
	if(endRow > totalNotice) {
		endRow=totalNotice;
	}
	
	//페이징 관련 정보(시작행번호, 종료행번호)와 게시글 조회기능 관련 정보(조회대상과 조회단어)를
	//전달받아 NOTICE 테이블에 저장된 행에서 조회정보가 포함된 행을 페이징 처리로 검색하여
	//List 객체를 반환하는 NoticeDAO 클래스의 메소드 호출
	//List<NoticeDTO> noticeList=NoticeDAO.getDAO().selectNoticeList(startRow, endRow, search, keyword);
	List<NoticeDTO> noticeList=NoticeDAO.getDAO().selectNoticeListND(startRow, endRow, search, keyword);
	
	//세션에 저장된 권한 관련 정보가 저장된 속성값을 객체로 반환받아 저장
	// => 관리자에게만 글쓰기 권한 제공
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
	//서버의 현재 날짜와 시간이 저장된 Date 객체를 생성하여 SimpleDateFormat 객체에 저장된
	//패턴의 문자열로 변환하여 저장
	// => 게시글의 작성날짜와 비교하여 게시글 작성날짜를 다르게 출력되도록 응답 처리
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//게시글에 출력될 일련번호 시작값을 계산하여 저장
	// => 게시글의 총갯수가 91개인 경우 => 1Page : 91, 2Page : 81, 3Page : 71, ...\
	//int displayNum=totalNotice-(pageNum-1)*pageSize;
	
%>
<!DOCTYPE html>
<html>
<head>


<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/notice_list_style.css">


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
						        <div class="board_head">
						            <div>
						                <h2>공지사항</h2>
						            </div>
						            <div>
						            <% if(loginClient != null && loginClient.getClientStatus()==9) { %>
						                <button type="button" id="writeBtn">글쓰기</button>
						            <% } %>
						            </div>
						        </div>
						    </div>
		                    <div class="board_zone_con">
		                        <div class="board_zone_list">
		                            <table class="board_list_table" style="width: 100%;">
		                                <thead>
		                                    <tr class="board_list_head">
		                                        <th class="board_num">번호</th>
		                                        <th class="board_title">제목</th>
		                                        <th class="board_date">날짜</th>
		                                        <th class="board_writer">작성자</th>
		                                        <th class="board_count">조회</th>
		                                    </tr>
		                                </thead>
		                                <tbody>
		                                <% if(totalNotice == 0) { // 검색된 게시글이 없는 경우 %>
								            <tr style="height: 10px;">
								                <td class="board_table_nosearch" colspan="5">검색된 게시글이 없습니다.</td>
								            </tr>
								        <% } else { 
								            int displayNum = totalNotice-((pageNum-1)*pageSize); %>
								            <% for(NoticeDTO notice : noticeList) { 
								                //if(notice.getNoticeStatus() != 0) { // 삭제된 게시글이 아닌 경우에만 출력
								                	//displayNum--;
								            %>
								            <tr class="board_table_content">
								                <!-- 일련번호 출력 -->
								                <% if(notice.getNoticeStatus()==2) {//2 : 상단고정글 %>
								                <td>
								                	<img src="images/icon_board_notice.png">
								                </td>
								                <% } else { %>
								                <td class="board_num"><%= displayNum %></td> <!-- 1부터 시작 -->
								                <% } %>
								                <!-- 공지사항 제목 출력 -->
								                <td class="board_tit">
								                    <%
								                        String url = request.getContextPath() + "/index.jsp?workgroup=board&work=notice_detail"
								                        + "&noticeNum=" + notice.getNoticeNum() + "&pageNum=" + pageNum + "&search=" + search + "&keyword=" + keyword;
								                    %>
								                    <a href="<%=url%>"><%=notice.getNoticeTitle() %></a>
								                </td>
								                
								                <!-- 게시글 작성일 출력 -->
								                <td class="board_date">
								                    <% if(currentDate.equals(notice.getNoticeDate().substring(0, 10))) { %>
								                        <%=notice.getNoticeDate().substring(11) %>
								                    <% } else { %>
								                        <%=notice.getNoticeDate().substring(0, 10) %>
								                    <% } %>
								                </td>
								                
								                <!-- 작성자 출력 -->
								                <td class="board_writer">관리자</td>
								                
								                <!-- 게시글 조회수 출력 -->
								                <td class="board_count"><%=notice.getNoticeCount() %></td>
								            </tr>
								            <% 
								            	displayNum--;
								                //} // if 문 끝
								            } // for 문 끝
								        } // if 문 끝 %>
		                                </tbody>
		                            </table>
		                            
		                            <!-- 페이지 번호 출력 -->
		                            <%
		                         		//하나의 페이지블럭에 출력될 페이지번호의 갯수 설정
		                    			int blockSize=5;
		                            
			                          	//페이지블럭에 출력될 시작 페이지번호를 계산하여 저장
			                    		//ex) 1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
			                    		int startPage=(pageNum-1)/blockSize*blockSize+1;
			                    		
			                    		//페이지블럭에 출력될 종료 페이지번호를 계산하여 저장
			                    		//ex) 1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
			                    		int endPage=startPage+blockSize-1;
			                    		
			                    		//종료 페이지번호가 페이지 총갯수보다 큰 경우 종료 페이지번호 변경
			                    		if(endPage > totalPage) {
			                    			endPage=totalPage;
			                    		}
		                            %>
		                            <%
										String myUrl=request.getContextPath()+"/index.jsp?workgroup=board&work=notice_list"
											+"&search="+search+"&keyword="+keyword;
									%>
		
		                            <div class="pagination" id="page_list">
		                            	<%-- 이전 블럭으로 출력할 수 있는 링크 제공 --%>
		                            	<% if(totalPage > 5) { %>
			                            	<% if(startPage > blockSize) { %>
			                            		<a href="<%=myUrl%>&pageNum=<%=startPage-blockSize %>">◁</a>
			                            	<% } else { %>
			                            		◁
			                            	<% } %>
		                            	<% } %>
		                            	
		                            	<% for(int i = startPage; i <= endPage; i++) { %>
		                            		<!-- 현재 처리중인 페이지 번호와 출력된 페이지 번호가 같이 않은 경우 링크 제공 -->
		                            		<!-- 현재 처리 중인 페이지 : pageNum, 출련된 페이지 : startPage -->
		                            		<% if(pageNum != i) { %>
		                            			<a href="<%=myUrl%>&pageNum=<%=i%>"><%=i %>&nbsp;</a>
		                            		<% } else { %>
		                            			<%=i %>
		                            		<% } %>
		                            	<% } %>
		                            	
		                            	<!--  다음 블록을 출력할 수 있는 링크 제공 -->
		                            	<% if(totalPage > 5) { %>
			                            	<% if(endPage != totalPage) { %>
			                            		<a href="<%=myUrl%>&pageNum=<%=startPage+blockSize%>">▷</a>
			                            	<% } else { %>
			                            		▷
			                            	<% } %>
		                            	<% } %>
		                            </div>
		                            
		                            <%-- 조회기능을 제공하기 위한 form 태그 --%>
		                            <div class="board_search_box">
			                            <form action="<%=request.getContextPath() %>/index.jsp?workgroup=board&work=notice_list" method="post">
			                            	<%-- select 태그로 전달되는 값은 반드시 컬럼명을 전달되도록 작성 --%>
			                            	<select name="search">
			                            		<option value="notice_title" <% if(search.equals("notice_title")) { %>selected<% } %>>&nbsp;제목&nbsp;</option>
			                            	</select>
			                            	<input type="text" class="text" name="keyword" value="<%=keyword %>">
			                                <button type="submit" class="btn_board_search">검색</button>
			                            </form>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
				</div>
			</div>
		</div>
	<script type="text/javascript" src="js/main.js"></script>
	<script type="text/javascript">
	
	$("#writeBtn").click(function() {
		location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_write";
	});
	</script>
</body>
</html>