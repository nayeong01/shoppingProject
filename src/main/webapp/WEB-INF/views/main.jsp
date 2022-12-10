<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>

<!-- Google Fonts -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<style>
	body {
	font-family: 'NanumSquare';
    color: #0d1e2d;
  }
</style>
<script
	src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
</script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
 <!-- 다음주소 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
				<!-- 
				<li>
					NOTICE
				</li> -->
			</ul>
		</div>
		<div class="top_area">
			<!-- 검색영역 -->		
			<div class="search_area">
					<form id="searchForm" action="/search" method="get">
						<select name="type">
							<option value="T"></option>
						</select>
						<div class="search_input">
							<i class="fa fa-magnifying-glass" style="font-size: 15px;"></i>
							<input class= "search-bar__input" type="search" name="keyword" placeholder="검색">
						</div>
					</form>
			</div>
			
			<!-- 로고영역 -->
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
			<div class="slide_div_wrap">
				<div class="slide_div">
					<div>
						<a>
							<img src="../resources/img/배너1.JPG">
						</a>
					</div>
					<div>
						<a>
							<img src="../resources/img/배너2.JPG">
						</a>
					</div>
					 
					<div>
						<a>
							<img src="../resources/img/배너3.JPG">
						</a>
					</div>
					
				</div>
			</div>
			<div class="ls_wrap">
				<div class="ls_div_subject">
					평점순 상품
				</div>
				<div class="ls_div">
					<c:forEach items="${ls }" var="ls">
						<a href="/goodsDetail/${ls.goodsCode }">
							<div class="ls_div_content_wrap">
								<div class="ls_div_content">
									<div class="image_wrap" data-goodsid="${ls.imageList[0].goodsCode }" data-path="${ls.imageList[0].uploadPath }"data-uuid="${ls.imageList[0].uuid }"data-filename="${ls.imageList[0].fileName }">
										<img>
									</div>
									<div class="ls_category">
										[${ls.cateName }]
									</div>
									<div class="ls_rating">
										${ls.ratingAvg }
									</div>
									<div class="ls_goodsName">
										${ls.goodsName }
									</div>
															
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
			</div>
			<!-- 주문 요청 form -->
			<form class="order_form" action="/order" method="post">
				<!-- 주문자 회원번호 -->
				<input name="memberId" value="${memberInfo.memberId }" type="hidden">
				<!-- 주소록 & 받는이 -->
				<input name="addressee" type="hidden">
				<input name="memberAddr1" type="hidden">
				<input name="memberAddr2" type="hidden">
				<input name="memberAddr3" type="hidden">
				<!-- 사용 포인트 -->
				<input name="usePoint" type="hidden">
				<!-- 상품정보 -->
			</form>
			
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

$(document).ready(function(){
	
	let eResult = '<c:out value = "${order_result}"/>';
	
	checkResult(eResult);
	
	function checkResult(result){
		
		if(result === ''){
			return;
		}
		alert(eResult +"님의 주문이 완료되었습니다.");
	}
	
	if('${msg}'=='가입된 계정이 없습니다. 회원가입 페이지로 이동합니다.') {
		sessionStorage.removeItem('${msg}');
		
	} else if('${msg}'!='') {
		alert('${msg}');
	}
	
	//슬라이드 설정
	$(".slide_div").slick(
			{
				dots: true,
				autoplay: true,
				autoplaySpeed: 3000
			}
	);
	
	$(".ls_div").slick({

		slidesToShow:4,
		slidesToScroll:4,
		prevArrow : "<button type='button' class='ls_div_content_prev'><</button>", //이전 화살표
		nextArrow : "<button type='button' class='ls_div_content_next'>></button>", //다음 화살표
	});
	
	//이미지 삽입
	$(".image_wrap").each(function(i,obj){
		const bobj = $(obj);
		
		if(bobj.data("goodsid")){
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			
			const fileCallPath = encodeURIComponent(uploadPath+"/s_"+uuid+"_"+fileName);
			
			$(this).find("img").attr('src','/display?fileName='+fileCallPath);
		} else {
			$(this).find("img").attr('src','/resources/img/goodsNoImage.png');
		}
	});
	
});
	/* 로그아웃 버튼 작동 */
	$("#gnb_logout_button").click(function(){
		//alert("버튼 작동");
		$.ajax({
			type:"POST",
			url:"/member/logout.do",
			success:function(data){
				alert("로그아웃 성공");
				document.location.reload();
			}
		})
	})
</script>
</body>
</html>