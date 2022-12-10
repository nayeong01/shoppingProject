<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/css/search.css">

<!-- Google Fonts -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<style>
	body, h1, h2, h3, h4, h5, h6, p, span, a, li, td {
	font-family: 'NanumSquare';
    color: #0d1e2d;
  }
</style>
<title>Insert title here</title>
<script
	src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
</script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<div class="wrapper">
	<div class="wrap">
		<div class="top_gnb_area">
			<ul class="list">
				<c:if test = "${member == null}">	<!-- 로그인 x -->			
					<li>
						<a href="/member/login">Login</a>
					</li>
					<li>
						<a href="/member/join">Join Us!</a>
					</li>
				</c:if>
				<c:if test = "${member != null}">	<!-- 로그인 o -->
					<c:if test="${member.adminCk == 1}">	<!-- 관리자 계정 -->
						<li><a href="/admin/main">Admin Page</a>
					</c:if>
					<li>
						<a id="gnb_logout_button">Logout</a>
					</li>
					<li>
						<a href="/orderList">MY PAGE</a>
					</li>
					<li>
						<i class="fa-solid fa-lock"></i>
						<a href="/cart/${member.memberId}">Cart</a>
					</li>
				</c:if>
			</ul>
		</div>
		<div class="top_area">
			<div class="search_area">
				<form id="searchForm" action="/search" method="get">
					<select name="type" id="type">
						<option value="T" selected></option>
						<option value="c"></option>
					</select>
					<div class="search_input">
						<i class="fas fa-search"></i>
						<input class= "search-bar__input" type="search" name="keyword" placeholder="검색" onclick="search()">
					</div>
				</form>
			</div>
			
			<!-- 로그영역 -->
			<div class="logo_area">
				<a href="/"><img src="/resources/img/로고시안1.png"></a>				
			</div>
			<div class="login_area">
				<!-- 로그인 하지 않은 상태--> 
				<c:if test = "${member == null}">
					<!-- <div class="login_button"><a href="/member/login">로그인</a></div>
					<span><a href="/member/join">회원가입</a></span>-->
				</c:if>
				<!-- 로그인한 상태 -->
				<c:if test="${member != null}">
					<div class="login_success_area">
						<table>
							<tr>
								<td>회원  </td>
								<td  style="padding-left:15px" >${member.memberName}</td>
							</tr>
							<tr>
								<td>충전금액  </td>
								<td  style="padding-left:15px" ><fmt:formatNumber value="${member.money}" pattern="\#,###.##"/></td>
							</tr>
							<tr>
								<td>포인트  </td>
								<td style="padding-left:15px" ><fmt:formatNumber value="${member.point}" pattern="#,###P"/></td>
							</tr>
						</table>
						
						<!-- <span>회원 : ${member.memberName}</span>
						<span>충전금액 : <fmt:formatNumber value="${member.money}" pattern="\#,###.##"/></span>
						<span>포인트 : <fmt:formatNumber value="${member.point}" pattern="#,###"/></span>-->
						<a href="/member/logout.do">로그아웃</a>
					</div>
				</c:if>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="navi_bar_area">
			<div class="dropdown">
				<button class="dropbtn">ALL
					<i class="fa fa-caret-down"></i>
				</button>
				<div class="dropdown-content">
					<c:forEach items="${cate0}" var="cate">
						<a href="search?type=c&cateCode=${cate.cateCode}">${cate.cateName}</a>
					</c:forEach>
				</div>
			</div>
			<div class="dropdown">
				<button class="dropbtn">리빙
					<i class="fa fa-caret-down"></i>
				</button>
				<div class="dropdown-content">
					<c:forEach items="${cate1}" var="cate">
						<a href="search?type=c&cateCode=${cate.cateCode}">${cate.cateName}</a>
					</c:forEach>
				</div>
			</div>
			<div class="dropdown">
				<button class="dropbtn">패션
					<i class="fa fa-caret-down"></i>
				</button>
				<div class="dropdown-content">
					<c:forEach items="${cate2}" var="cate">
						<a href="search?type=c&cateCode=${cate.cateCode}">${cate.cateName}</a>
					</c:forEach>
				</div>
			</div>
			<div class="dropdown">
				<button class="dropbtn">뷰티
					<i class="fa fa-caret-down"></i>
				</button>
				<div class="dropdown-content">
					<c:forEach items="${cate3}" var="cate">
						<a href="search?type=c&cateCode=${cate.cateCode}">${cate.cateName}</a>
					</c:forEach>
				</div>
			</div>
		</div>
			
		<div class="content_area">
			<!-- 게시물 o -->
			<c:if test="${listcheck != 'empty'}">
				<div class="list_search_result">
					<table class="type_list">
						<colgroup>
							<col width="110">
							<col width="*">
							<col width="120">
							<col width="120">
							<col width="120">
						</colgroup>
						<tbody id="searchList>">
							<c:forEach items="${list}" var="list">
								<tr>
									<td class="image">
										<div class="image_wrap" 
											data-goodscode="${list.imageList[0].goodsCode}"
											data-path="${list.imageList[0].uploadPath}"
											data-uuid="${list.imageList[0].uuid}"
											data-filename="${list.imageList[0].fileName}">
											<a href="/goodsDetail/${list.goodsCode }"><img></a>
										</div>							
									</td>
									<td class="detail">
										<div class="category">
											[${list.cateName}]
										</div>										
										<div class="title">
											<a href="/goodsDetail/${list.goodsCode}">
												${list.goodsName}
											</a>
										</div>
									</td>
									<td class="info">
										<div class="rating">
											<fmt:formatNumber value="${list.ratingAvg }" pattern="#.# 점"/>
										</div>
									</td>
									
									<td class="price">
										<div class="org_price">
											<fmt:formatNumber value="${list.goodsPrice}" pattern="#,### 원"/>											
										</div>										
									</td>
									<td class="option"></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<!-- 페이지 이동 인터페이스 -->
				<div class="pageMaker_wrap">
					<ul class="pageMaker">
						<!-- 이전 버튼 -->
						<c:if test="${pageMaker.prev }">
							<li class="pageMaker_btn_prev">
								<a href="${pageMaker.pageStart -1}">이전</a>
							</li>
						</c:if>
						
						<!-- 페이지 번호 -->
						<c:forEach begin="${pageMaker.pageStart }" end="${pageMaker.pageEnd }" var="num">
							<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
						
						<!-- 다음 버튼 -->
						<c:if test="${pageMaker.next}">
							<li class="pageMaker_btn next">
								<a href="${pageMaker.pageEnd + 1 }">다음</a>
							</li>
						</c:if>
					</ul>
				</div>
				
				<form id="moveForm" action="/search" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					<input type="hidden" name="cateCode" value="<c:out value="${pageMaker.cri.cateCode}"/>">
					<input type="hidden" name="type" value="${pageMaker.cri.type}">					
				</form>
			</c:if>
			
			<!-- 게시물 x -->
			<c:if test="${listcheck ==  'empty'}">
				<div class="table_empty">
					검색결과가 없습니다.
				</div>
			</c:if>
		</div>
		
		<!-- Footer 영역 -->
		<div class="footer">			
			<div class="footer_nav">
				<div class="footer_nav_container">
					<h1>ZEROWASTE FOR THE EARTH</h1>
					<div class="list">
					</div>
				</div>
					<div class="footer_container">
						<div class="footer_right">
						<h2>CONTECT</h2>
							<ul>
							<li>(주)영구상점 대표 : 김나영, 최선미</li>
							<li>대표 이메일 : olive_yeong@naver.com, gkgkdkwnaak1@naver.com </li>
							<li>교환/반품주소 : 충북 청주시 서원구 사직대로 93 이지빌딩 3~5층</li>
							</ul>
						</div>
					<div class="clearfix"></div>
				</div>
			</div><!-- class="footer_nav" -->
			<div class="copy_right">
			<p>COPYRIGHT(C) <strong>ezdesign.com</strong>	ALL RIGHTS RESERVED.</p>
			</div>
		</div>
	</div><!-- class="wrap" -->
</div><!-- class="wrapper" -->
<script>

	/* 로그아웃 버튼 작동 */
	$("#gnb_logout_button").click(function(){
		//alert("버튼 작동");
		$.ajax({
			type:"POST",
			url:"/member/logout.do",
			success:function(data){
				alert("로그아웃 성공");
				document.location = "/";
			}
		})
	})
	
	/* 페이지 이동 버튼 */
	const moveForm = $('#moveForm');
	
	$(".pageMaker_btn a").on("click", function(e){
		
		e.preventDefault();
		
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		moveForm.submit();
	})
	
	/* 검색 필터 */
	let buttonA = $("#filter_button_a");
	let buttonB = $("#filter_button_b");
	
	buttonA.on("click", function(){
		$(".filter_b").css("display", "none");
		$(".filter_a").css("display", "block");
		buttonA.attr("class", "filter_button filter_active");
		buttonB.attr("class", "filter_button");
	});
	
	buttonB.on("click", function(){
		$(".filter_a").css("display", "none");
		$(".filter_b").css("display", "block");
		buttonB.attr("class", "filter_button filter_active");
		buttonA.attr("class", "filter_button");
	});
	
	$(document).ready(function(){
		
		//검색 타입 selected
		const selectedType = '<c:out value="${pageMaker.cri.type}"/>';
		if(selectedType != ""){
			$("select[name='type']").val(selectedType).attr("selected", "selected");
		}
		
		/* 이미지 삽입 */
		$(".image_wrap").each(function(i, obj){
			const bobj = $(obj);
			
			if(bobj.data("goodscode")){
				const uploadPath = bobj.data("path");
				const uuid = bobj.data("uuid");
				const fileName = bobj.data("filename");
				const fileCallPath = 
					encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
				
				$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);				
			}else{
				$(this).find("img").attr('src', '/resources/img/goodsNoImage.png');
			}
			
		})
	});
	
	function search(){
		$('#type option:eq(0)').prop('selected', true);
		$('#type option:eq(0)').attr('selected','selected');
		$('#keyword').val('');
	}
	
</script>
</body>
</html>