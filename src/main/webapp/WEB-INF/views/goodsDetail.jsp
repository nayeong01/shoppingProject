<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/resources/css/goodsDetail.css">
<title>Insert title here</title>
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
		
		<div class="content_area">
			<div class="line"></div>
				<div class="reply_subject">
					<h2>PRODUCT</h2>
				</div>
			<div class="line"></div>
			<div class="content_top">
				
				<div class="ct_left_area">
					<div class="image_wrap" 
						data-goodscode="${goodsInfo.imageList[0].goodsCode}"
						data-path="${goodsInfo.imageList[0].uploadPath}"
						data-uuid="${goodsInfo.imageList[0].uuid}"
						data-filename="${goodsInfo.imageList[0].fileName}">
						<img>
					</div>
				</div>
				
				<div class="ct_right_area">
					<div class="title">
						<h1>
							${goodsInfo.goodsName}
						</h1>
					</div>
					<div class="line"></div>
					<div class="author">						
					</div>
					<div class="line"></div>
					<div class="price">
						<div class="discount_price">
							판매가 : <span class="discount_price_number"><fmt:formatNumber value="${goodsInfo.goodsPrice}" pattern="#,### 원"/></span>
						</div>
						<div>
							적립 포인트 : <span class="point_span"></span>원
						</div>
					</div>
					<div class="line"></div>
					<div class="button">
						<div class="button_quantity">
							주문수량
							<input type="text" class="quantity_input" value="1">
							<span>
								<button class="plus_btn">+</button>
								<button class="minus_btn">-</button>
							</span>
						</div>
						<div class="button_set">
							<a class="btn_cart">장바구니 담기</a>
							<a class="btn_buy">바로 구매</a>
						</div>
					</div>
				</div>
				
			</div>
			<div class="line"></div>
			<div class="reply_subject">
					<h2>DETAIL</h2>
			</div>
			<div class="line"></div>
			
			<div class="content_middle">
				<div class="goods_detail">
					${goodsInfo.goodsDetail }
				</div>
			</div>
			<div class="line"></div>
			
			<div class="content_bottom">
				<div class="reply_subject">
					<h2>REVIEW</h2>
				</div>
				
				<div class="line"></div>
				
				<c:if test="${member != null}">
					<div class="reply_button_wrap">
						<button>리뷰 쓰기</button>
					</div>
				</c:if>
				
				<div class="reply_not_div">
				</div>
				<ul class="reply_content_ul">
					<!-- 
					<li>
						<div class="comment_wrap">
							<div class="reply_top">
								<span class="id_span">test</span>
								<span class="date_span">2022-11-13</span>
								<span class="rating_span">평점 : <span class="rating_value_span">4</span>점</span>
								<a class="update_reply_btn">수정</a><a class="delete_reply_btn">삭제</a>
							</div>
							<div class="reply_bottom">
								<div class="reply_bottom_txt">댓글 test</div>
							</div>
						</div>
					</li>
					 -->
				</ul>
				<div class="repy_pageInfo_div">
					<ul class="pageMaker">
						<!-- 
						<li class="pageMaker_btn prev">
							<a>이전</a>
						</li>
						<li class="pageMaker_btn">
							<a>1</a>
						</li>
						<li class="pageMaker_btn">
							<a>2</a>
						</li>
						<li class="pageMaker_btn active">
							<a>3</a>
						</li>
						<li class="pageMaker_btn next">
							<a>다음</a>
						</li>
						 -->
					</ul>
				</div>
			</div>
			<!-- 주문 form -->
			<form action="/order/${member.memberId}" method="get" class="order_form">
				<input type="hidden" name="orders[0].goodsCode" value="${goodsInfo.goodsCode}">
				<input type="hidden" name="orders[0].goodsCount" value="">
			</form>
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
	$(document).ready(function(){
		
		/* 이미지 삽입 */
		const bobj = $(".image_wrap");
		
		if(bobj.data("goodscode")){
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			const fileCallPath = 
				encodeURIComponent(uploadPath + "/" + uuid + "_" + fileName);			
			
			bobj.find("img").attr('src', '/display?fileName=' + fileCallPath);
		}else{
			bobj.find("img").attr('src', '/resources/img/goodsNoImage.png');
		}
		
		/* 포인트 삽입 */
		let salePrice = "${goodsInfo.goodsPrice}"
		let point = salePrice*0.05;
		point = Math.floor(point);
		$(".point_span").text(point);
		
		/* 리뷰 리스트 출력 */
		const goodsId = '${goodsInfo.goodsCode}';
		
		$.getJSON("/reply/list", {goodsId : goodsId}, function(obj){
			makeReplyContent(obj);
		});
	}); //$(document).ready(function(){})
	
	// 수량 버튼 조작
	let quantity = $(".quantity_input").val();
	$(".plus_btn").on("click", function(){
		$(".quantity_input").val(++quantity);
	});
	$(".minus_btn").on("click", function(){
		if(quantity > 1){
			$(".quantity_input").val(--quantity);
		}
	});
	
	// 서버로 전송할 데이터
	const form = {
		memberId : '${member.memberId}',
		goodsId : '${goodsInfo.goodsCode}',
		goodsCount : ''
	}
	
	// 장바구니 추가 버튼
	$(".btn_cart").on("click", function(e){
		form.goodsCount = $(".quantity_input").val();
		$.ajax({
			url: '/cart/add',
			type: 'POST',
			data: form,
			success: function(result){
				cartAlert(result);
				//alert(result);
			}
		})
	});
	
	function cartAlert(result){
		if(result == '0'){
			alert("장바구니에 추가를 하지 못하였습니다.");
		}else if(result == '1'){
			alert("장바구니에 추가되었습니다.");
		}else if(result == '2'){
			alert("장바구니에 이미 추가되어져 있습니다.");
		}else if(result == '5'){
			alert("로그인이 필요합니다.");
		}
	}
	
	/* 바로구매 버튼 */
	$(".btn_buy").on("click", function(){
		
		const memberId = '${member.memberId}';
		
		if(memberId == ''){
			alert("로그인이 필요합니다.")			
		}else{
			let goodsCount = $(".quantity_input").val();
			$(".order_form").find("input[name='orders[0].goodsCount']").val(goodsCount);
			$(".order_form").submit();
		}		
	});
	
	/* 리뷰쓰기 */
	$(".reply_button_wrap").on("click", function(e){
		e.preventDefault();
		
		const memberId = '${member.memberId}';
		const goodsId = '${goodsInfo.goodsCode}';
		
		$.ajax({
			data : {
				goodsId : goodsId,
				memberId : memberId
			},
			url : '/reply/check',
			type : 'POST',
			success : function(result){
				if(result === '1'){
					alert("이미 등록된 리뷰가 존재 합니다.")
				}else if(result === '0'){
					let popUrl = "/replyEnroll/" + memberId + "?goodsId=" + goodsId;
					console.log(popUrl);
					let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
					
					window.open(popUrl,"리뷰 쓰기",popOption);
				}

			}
		});
		
		/*
		let popUrl = "/replyEnroll/" + memberId + "?goodsId=" + goodsId;
		console.log(popUrl);
		let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
		
		window.open(popUrl,"리뷰 쓰기",popOption);
		*/		
	});
	
	/* 댓글 페이지 정보 */
	const cri = {
			goodsId : '${goodsInfo.goodsCode}',
			pageNum : 1,
			amount : 10
	}
	
	/* 댓글 페이지 이동 버튼 동작 */
	$(document).on('click', '.pageMaker_btn a', function(e){
		e.preventDefault();
		
		let page = $(this).attr("href");
		cri.pageNum = page;
		
		replyListInit();
	})
	
	/* 댓글 데이터 서버 요청 및 댓글 동적 생성 메서드 */
	let replyListInit = function(){
		$.getJSON("/reply/list", cri , function(obj){
			
			makeReplyContent(obj);
			
		});		
	}
	
	/* 리뷰 수정 버튼 */
	$(document).on('click', '.update_reply_btn', function(e){
		e.preventDefault();
		let replyId = $(this).attr("href");
		let popUrl = "/replyUpdate?replyId=" + replyId + "&goodsId=" + '${goodsInfo.goodsCode}' + "&memberId=" + '${member.memberId}';	
		let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes"	
		
		window.open(popUrl,"리뷰 수정",popOption);
	});
	
	/* 리뷰 삭제 버튼 */
	$(document).on('click', '.delete_reply_btn', function(e){
		e.preventDefault();		
		let replyId = $(this).attr("href");
		
		$.ajax({
			data : {
				replyId : replyId,
				goodsId : '${goodsInfo.goodsCode}'
			},
			url : '/reply/delete',
			type : 'POST',
			success : function(result){
				replyListInit();
				alert('삭제가 완료되었습니다.');
			}
		});
	})
	
	/* 댓글(리뷰) 동적 생성 메서드 */
	function makeReplyContent(obj){
		if(obj.list.length === 0){
			$(".reply_not_div").html('<span>리뷰가 없습니다.</span>');
			$(".reply_content_ul").html('');
			$(".pageMaker").html('');
		} else{
			
			$(".reply_not_div").html('');
			
			const list = obj.list;
			const pf = obj.pageInfo;
			const userId = '${member.memberId}';
			
			/* list */			
			let reply_list = '';			
			
			$(list).each(function(i,obj){
				reply_list += '<li>';
				reply_list += '<div class="comment_wrap">';
				reply_list += '<div class="user_icon">';
				reply_list += '<i class="fa-solid fa-user"></i>';
				reply_list += '</div>';
				reply_list += '<div class="reply_top">';
				/* 아이디 */
				reply_list += '<span class="id_span">'+ obj.memberId+'</span>';
				/* 날짜 */
				reply_list += '<span class="date_span">'+ obj.regDate +'</span>';
				/* 평점 */
				reply_list += '<span class="rating_span">평점 : <span class="rating_value_span">'+ obj.rating +'</span>점</span>';
				if(obj.memberId === userId){
					reply_list += '<a class="update_reply_btn" href="'+ obj.replyId +'">수정</a><a class="delete_reply_btn" href="'+ obj.replyId +'">삭제</a>';
				}
				reply_list += '</div>'; //<div class="reply_top">
				reply_list += '<div class="reply_bottom">';
				reply_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
				reply_list += '</div>';//<div class="reply_bottom">
				reply_list += '</div>';//<div class="comment_wrap">
				reply_list += '</li>';
			});	
			
			$(".reply_content_ul").html(reply_list);
			
			/* 페이지 버튼 */
			let reply_pageMaker = '';
			/* prev */
			if(pf.prev){
				let prev_num = pf.pageStart -1;
				reply_pageMaker += '<li class="pageMaker_btn prev">';
				reply_pageMaker += '<a href="'+ prev_num +'">이전</a>';
				reply_pageMaker += '</li>';	
			}
			/* numbre btn */
			for(let i = pf.pageStart; i < pf.pageEnd+1; i++){
				reply_pageMaker += '<li class="pageMaker_btn ';
				if(pf.cri.pageNum === i){
					reply_pageMaker += 'active';
				}
				reply_pageMaker += '">';
				reply_pageMaker += '<a href="'+i+'">'+i+'</a>';
				reply_pageMaker += '</li>';
			}
			/* next */
			if(pf.next){
				let next_num = pf.pageEnd +1;
				reply_pageMaker += '<li class="pageMaker_btn next">';
				reply_pageMaker += '<a href="'+ next_num +'">다음</a>';
				reply_pageMaker += '</li>';	
			}
			console.log(reply_pageMaker);
			$(".pageMaker").html(reply_pageMaker);
		}
	}
	
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
	
</script>
</body>
</html>