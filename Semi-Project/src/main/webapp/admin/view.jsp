<%@page import="xyz.itwill.dto.DeliveryDTO"%>
<%@page import="xyz.itwill.dao.DeliveryDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.dto.ClientDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.ClientDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 코드 -->  
<%
String search=request.getParameter("search");
if(search == null) {search="";}

String keyword=request.getParameter("keyword");
if(keyword == null) {keyword="";}
	
int pageNum=1;
if(request.getParameter("pageNum") != null) {pageNum=Integer.parseInt(request.getParameter("pageNum"));}

int pageSize=20; //페이지 size 30고정

String solt = "desc";
if(request.getParameter("solt") != null) {solt=request.getParameter("solt");}

int totalDelivery=DeliveryDAO.getDAO().selectTotalDelivery(search, keyword); //게시글의 총갯수
        	
int totalPage=(int)Math.ceil((double)totalDelivery/pageSize); //페이지의 총갯수를 계산하여 저장

if(pageNum <= 0 || pageNum > totalPage) {pageNum=1;} //전달받은 페이지번호가 비상적인 경우 1page

int startRow=(pageNum-1)*pageSize+1; //페이지번호에 대한 게시글의 시작 행번호를 계산하여 저장

int endRow=pageNum*pageSize; //페이지번호에 대한 게시글의 종료 행번호를 계산하여 저장

if(endRow > totalDelivery) {endRow=totalDelivery;} //종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행변호

//client 정보 호출
List<DeliveryDTO> deliveryList=DeliveryDAO.getDAO().selectDeliveryList(startRow, endRow, search, keyword, solt);

int displayNum=(pageNum-1)*pageSize+1;

%>    
    

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/admin1.css">
<%--<%@include file="/camp/security/admin_check.jspf" %>--%>


<%-- 배송 관리 --%>
<div class="admin_cont admin_delivery">
	<div class="top_admin"  id="title_delivery">
		<img alt="고객관리" src="<%=request.getContextPath()%>/images/delivery_management.png">
		<h3 class="tit_admin">배송관리</h3>
	</div>
	<div id="sort_admin">
		<div id="sort_admin1">정렬 기준 :
			<select id="sel_sort" class="sel_sort">
				<option value="desc" <% if(solt.equals("desc")) { %> selected <% } %>>신규 주문순</option>
				<option value="asc" <% if(solt.equals("asc")) { %> selected <% } %>>이전 주문순</option>
			</select>
		</div>
		<div id="sort_admin2_delivery">
			<select id="sel_keyword">
				<option value="delivery_num" <% if(search.equals("delivery_num")) { %> selected <% } %>>배송번호</option>
				<option value="order_num" <% if(search.equals("order_num")) { %> selected <% } %>>주문번호</option>
				<option value="delivery_create" <% if(search.equals("delivery_create")) { %> selected <% } %>>주문 접수일</option>
			</select>
			<input type="text" id="input_search" value="<%= keyword%>">
			<button type="button" class="btn_admin btn_use" id="btn_search">조회</button>
		</div>
	</div>
	
	<div class="cont_admin">
		<table class="tbl_admin">
			<tr>
				<th>No</th>
				<th>배송번호</th>
				<th>주문번호</th>
				<th>주문 접수일</th>
				<th>배송 변경일</th>
				<th>배송상태</th>
				<th></th>
			</tr>
			
			<!-- 수정바 -->
			
			<% if(totalDelivery == 0) { %>
				<tr class="view_tr">
					<td colspan="13">조건에 맞는 배송정보가 존재하지 않습니다.</td>
					<td></td>
				</tr>
				
			<% } else { %>
			<% for(DeliveryDTO delivery : deliveryList) { %>
				<% int status = delivery.getOrdStatus(); %>
			<tr class="view_tr" <% if(displayNum%2==0){%> style="background-color:#f9f9f9;"<%} %>>
				<%-- 일련번호 출력 --%>
				<td><%=displayNum %></td>
				<% displayNum++; %>
				
				<td><%=delivery.getDeliveryNum() %></td>
				<td><%=delivery.getOrderNum() %></td>
				<td><%=delivery.getDeliveryCreate() %></td>
				<td><%=delivery.getDeliveryUpdate() %></td>
				<td style="width:480px;">	
					<input type="text" value="<%=status%>">
					<% if(status==1) { %>
					<button type="button" value=1 class="btn_admin btn_use btn_status status_sel" id="btn_S1<%=displayNum%>">주문취소</button>
					<% } else { %>
					<button type="button" value=1 class="btn_admin btn_use btn_status" id="btn_S1<%=displayNum%>">주문취소</button>
					<% } %>
					
					<% if(status==2) { %>
					<button type="button" value=2 class="btn_admin btn_use btn_status status_sel" id="btn_S2<%=displayNum%>">입금대기</button>
					<% } else { %>
					<button type="button" value=2 class="btn_admin btn_use btn_status" id="btn_S2<%=displayNum%>">입금대기</button>
					<% } %>
					
					<% if(status==3) { %>
					<button type="button" value=3 class="btn_admin btn_use btn_status status_sel" id="btn_S3<%=displayNum%>">주문접수</button>
					<% } else { %>
					<button type="button" value=3 class="btn_admin btn_use btn_status" id="btn_S3<%=displayNum%>">주문접수</button>
					<% } %>
					
					<% if(status==4) { %>
					<button type="button" value=4 class="btn_admin btn_use btn_status status_sel" id="btn_S4<%=displayNum%>">상품준비중</button>
					<% } else { %>
					<button type="button" value=4 class="btn_admin btn_use btn_status" id="btn_S4<%=displayNum%>">상품준비중</button>
					<% } %>
					
					<% if(status==5) { %>
					<button type="button" value=5 class="btn_admin btn_use btn_status status_sel" id="btn_S5<%=displayNum%>">배송중</button>
					<% } else { %>
					<button type="button" value=5 class="btn_admin btn_use btn_status" id="btn_S5<%=displayNum%>">배송중</button>
					<% } %>
					
					<% if(status==6) { %>
					<button type="button" value=6 class="btn_admin btn_use btn_status status_sel" id="btn_S6<%=displayNum%>">배송완료</button>
					<% } else { %>
					<button type="button" value=6 class="btn_admin btn_use btn_status" id="btn_S6<%=displayNum%>">배송완료</button>
					<% } %>
					
					<% if(status==7) { %>
					<button type="button" value=7 class="btn_admin btn_use btn_status status_sel" id="btn_S7<%=displayNum%>">구매확정</button>
					<% } else { %>
					<button type="button" value=7 class="btn_admin btn_use btn_status" id="btn_S7<%=displayNum%>">구매확정</button>
					<% } %>
				</td>
				<td style="width:80px;">
					<button type="button" class="btn_admin btn_use btn_delete" id="btn_delete<%=displayNum%>">주문취소</button>
				</td>
			<% } %>
			</tr>
		<% } %>
		</table>
		
		<%-- 페이지 번호 출력 --%>
		<%
		int blockSize=10;
		
		int startPage=(pageNum)/blockSize*blockSize+1; 

		int endPage=startPage+blockSize-1;
		
		//종료 페이지번호가 페이지 총갯수보다 큰 경우 종료 페이지번호 변경
		if(endPage > totalPage) { endPage=totalPage; }
		%>
		
		<%-- URL 저장 --%>
		<%
		String myUrl=request.getContextPath()+"/index.jsp?workgroup=admin&work=admin_delivery"
			+"&search="+search+"&keyword="+keyword;
		%>
		
		<div id="page_list">
		<%-- 처음으로 버튼 --%>
		<% if(startPage > blockSize) { %>
			<div class="case_page" style="padding-left:3px;"><a href="<%=myUrl%>&pageNum=1">《&nbsp;처음</a></div>
		<% } %>
		<%-- 이전 버튼 --%>
		<% if(startPage > blockSize) { %>
			<div class="case_page" style="padding-left:3px;"><a href="<%=myUrl%>&pageNum=<%=startPage-blockSize%>">〈&nbsp;이전</a></div>
		<% } %>
	
		<%-- 페이지 버튼 --%>
		<% for(int i = startPage ; i <= endPage ; i++) { %>
			<% if(pageNum != i) { %>
				<div class="case_page"><a href="<%=myUrl%>&pageNum=<%=i%>"><%=i %></a></div>
			<%} else { %>
				<div class="case_page"><p style="text-decoration:underline;"><%=i %></p></div>
			<% } %>
		<% } %>

		<%-- 다음 버튼 --%>
		<% if(endPage != totalPage) { %>
			<div class="case_page" style="padding-right:3px;"><a href="<%=myUrl%>&pageNum=<%=startPage+blockSize%>">다음&nbsp;〉</a></div>
		<% } %>
		<%-- 맨뒤로 버튼 --%>
		<% if(endPage != totalPage) { %>
			<div class="case_page" style="padding-right:3px;"><a href="<%=myUrl%>&pageNum=<%=totalPage%>">맨뒤&nbsp;》</a></div>
		<% } %>
		</div>
	</div>
</div>
		

<script type="text/javascript">

<%-- 정렬 기준 설정 --%>
$("#sel_sort").change(function() {
	var selSolt = $("#sel_sort").val();
	location.href = "<%=myUrl%>&pageNum=<%=pageNum%>&solt="+selSolt;
});


<%-- 검색 설정 --%>
$("#btn_search").click(function() {
	var selkeyword = $("#sel_keyword").val();
	var insearch = $("#input_search").val();
	location.href = "<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=admin_delivery&search="+selkeyword+"&keyword="+insearch;
});

<%-- 삭제 버튼 --%>




<%-- 수정 버튼 --%>
$(".btn_insert").click(function() {
	init();
	listView();
	var clickedButton = $(this);
    var parentTr = clickedButton.closest('tr');
    
    $("#modify_tr").show().insertAfter(parentTr);
    parentTr.css("display", "none"); // 기존 행 숨김
    
    for(i=0; i < parentTr.children().length - 1; i++) {
  		var change = parentTr.children().eq(i).text();
  		if ($("#modify_tr").children().eq(i).find('p').length != 0 ) {
  			$("#modify_tr").children().eq(i).children().text(change);
  		} else {
  			$("#modify_tr").children().eq(i).children().val(change);
  		}
    }
});

<%-- 상태 변경 버튼 --%>
$(".btn_status").click(function() {

	var clickBtn = $(this);
	var parentTr = clickBtn.closest('tr');
	
    var num = $("#modify_Num").text();
    var name = $("#modify_Name").val();
    var mobile = $("#modify_Mobile").val();
    var zipcode = $("#modify_Zipcode").val();
    var address1 = $("#modify_Address1").val();
    var address2 = $("#modify_Address2").val();
    var updateDate = $("#modify_UpdateDate").text();
    var modify_Status = $("#modify_Status").val();
    
    var status = 1; 
    if (modify_Status == "일반회원") {
    	status = 1;
    } else if (modify_Status == "탈퇴회원") {
    	status = 0;
	} else {
    	status = 9;
	}

    /* Ajax */
    $.ajax({
		type: "post",
		url: "<%=request.getContextPath()%>/admin/admin_client_update.jsp",
		data: {
			"num":num, 
			"name":name, 
			"mobile":mobile, 
			"zipcode":zipcode, 
			"address1":address1, 
			"address2":address2, 
			"status":status, 
			},
		dataType: "xml",
		success: function(xmlDoc) {
			var code=$(xmlDoc).find("code").text();
			
			if(code=="complete") {
				/* SQL 완료 시 기존 행에 반영 */
				var changeTr = $("#modify_tr").prev();
				
				/* 수정박스 숨김 및 수정 된 행 표출 */
				$("#modify_tr").css("display", "none");
				changeTr.css("display", "table-row");
				listView();
							    
			    /* 수정 된 행에 수정값 반영 */
			    for(i=0; i < $("#modify_tr").children().length - 1; i++) {
			  		var change = "";
			  		if ($("#modify_tr").children().eq(i).find('p').length != 0 ) {
			  			change = $("#modify_tr").children().eq(i).children().text();
			  		} else {
			  			change = $("#modify_tr").children().eq(i).children().val();
			  		}			  		
			  		changeTr.children().eq(i).text(change);
			    }
			    
			    /* 현재 일자 */
			    var today = new Date();
			    var year = today.getFullYear();
			    var month = (today.getMonth() + 1).toString().padStart(2, '0');
			    const day = today.getDate().toString().padStart(2, '0');
			    var modifyDay = year+"-"+month+"-"+day;
			    
			    /* 변경일자 적용 */
			    changeTr.children().eq(10).text(modifyDay);
			    
			    /* 회원 상태 폰트 재설정 */
			    switch (changeTr.children().eq(12).text()) {
			    case "관리자":
			    	changeTr.children().eq(12).css("font-weight", "bold");
			    	changeTr.children().eq(12).css("color", "black");
			    	break;
			    case "탈퇴회원":
			    	changeTr.children().eq(12).css("font-weight", "normal");
			    	changeTr.children().eq(12).css("color", "#c80000");
			    	break;
			    default:
			    	changeTr.children().eq(12).css("font-weight", "normal");
			    	changeTr.children().eq(12).css("color", "black");
			    	break;
			    }			
			} else {
				console.log("admin_client_modify - incomplete");
			}
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
});


<%-- 수정 - 취소 버튼 --%>
$("#btn_cancel").click(function() {
	$(".view_tr").css("display", "table-row");
	$("#modify_tr").css("display", "none");
});







/* 펑션 모음 */

<%-- 수정박스 초기화 --%>
function init() {
	$("#modify_tr td p").text("");
	$("#modify_tr td input").val("");
	$("#modify_tr td select").val("일반회원");
}

<%-- 리스트 불러오기 --%>
function listView() {
	$(".view_tr").css("display", "table-row");
}


</script>

