<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/memberManage.css">
<!-- Google Fonts -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<style>
	body, h1, h2, h3, h4, h5, h6, p, span, a {
	font-family: 'NanumSquare';
    color: #0d1e2d;
  }
</style>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
</head>
<body>
	<%@include file="../includes/admin/header.jsp" %>
                <div class="admin_content_wrap">
                	<div class="admin_content_subject">회원 관리</div>
                	
                	<div class="goods_table_wrap">
                	<!-- 상품 리스트 0 -->
                		<c:if test="${listcheck != 'empty'}">
                			<table class="goods_table">
                				<thead>
                					<tr>
                						<td class="th_column_1">회원 아이디</td>
                						<td class="th_column_1">회원 이름</td>
                						<td class="th_column_1">포인트</td>
                						<td class="th_column_1">충전 금액</td>
                						<td class="th_column_1">가입 날짜</td>
                					</tr>
                				</thead>
                			<c:forEach items = "${list }" var="list">
                			<tr>
                			
                				<td>
                					<a class="move" href="<c:out value="${list.memberId }"/>">
                						<c:out value="${list.memberId }"></c:out>
                					</a>
                				</td>
                				<td><c:out value="${list.memberName }"></c:out></td>
                				<td><c:out value="${list.point }"></c:out></td>
                				<td><c:out value="${list.money }"></c:out></td>
                				<td><fmt:formatDate value="${list.regDate }" pattern="yyyy-MM-dd"/></td>
                			</tr>
                			</c:forEach>
                			</table>
                		</c:if>
                		<!-- 상품 리스트 X -->
                		<c:if test="${listCheck == 'empty'}">
                			<div class="table_empty">
                				등록된 제품이 없습니다.
                			</div>
                		</c:if>
                	</div>
                	
                	<!-- 검색 영역 -->
                	<div class="search_wrap">
                		<form id="searchForm" action="/admin/memberManage" method="get">
                			<div class="search_input">
                				
                				<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword }"></c:out>'>
                				<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
                				<input type="hidden" name="amount" value='${pageMaker.cri.amount }'>
                				<input type="hidden" name="type" value="G">
                				<button class="btn search_btn">검 색</button>
                			</div>
                		</form>
                	</div>
                	
                	<!-- 페이지 이름 인터페이스 영역 -->
                	<div class="pageMaker_wrap">
                		<ul class="pageMaker">
                			
                			<!-- 이전 버튼 -->
                			<c:if test="${pageMaker.prev }">
                				<li class="pageMaker_btn prev">
                					<a href="${pageMaker.pageStart -1 }">이전</a>
                				</li>
                			</c:if>
                			
                			<!-- 페이지 번호 -->
                			<c:forEach begin = "${pageMaker.pageStart }" end="${pageMaker.pageEnd }" var= "num">
                				<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':'' }">
                					<a href= "${num }">${num }</a>
                				</li>
                			</c:forEach>
                			
                			<!-- 다음 버튼 -->
                			<c:if test="${pageMaker.next }">
                				<li class="pageMaker_btn next">
                					<a href="${pageMaker.pageEnd +1 }">다음</a>
                				</li>
                			</c:if>
                		</ul>
                	</div>
                	
                	<form id ="moveForm" action="/admin/memberManage" method="get">
                		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
                	</form>

                </div>
                
    <%@include file="../includes/admin/footer.jsp" %>


<script>

/* 삭제 버튼 */
$(".delete_btn").on("click", function(e){
	
	e.preventDefault();
	
	let id = $(this).data("memberid");
	let id1 = $(this).data("orderid");
	
	$("#deleteForm").find("input[name='memberId']").val(id);
	$("#deleteForm").find("input[name='orderId']").val(id1);
	$("#deleteForm").submit();
});

//상품 수정 페이지
$(".move").on("click", function(e){
	
	e.preventDefault();
	
	moveForm.append("<input type='hidden' name='memberId' value='"+$(this).attr("href")+"'>");
	moveForm.attr("action", "/admin/memberModify");
	moveForm.submit();
})


let searchForm = $('#searchForm');
let moveForm = $('#moveForm');

//검색 버튼 동작
$("#searchForm button").on("click", function(e){
	
	e.preventDefault();
	
	//검색 키워드 유효성 검사
	if(!searchForm.find("input[name='keyword']").val()){
		alert("키워드를 입력하십시오.");
		return false;
	}
	
	searchForm.find("input[name='pageNum']").val("1");
	
	searchForm.submit();
});

	
</script>
</body>
</html>