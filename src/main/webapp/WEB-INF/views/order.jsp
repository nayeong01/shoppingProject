<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/order.css">

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
						<li>
							<a href="/admin/main">Admin Page</a>
						</li>
					</c:if>
					<li>
						<a id="gnb_logout_button">Logout</a>
					</li>					
					<li>
						<a href="/orderList">My Page</a>
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
				<div class="content_subject"><span>ORDER</span></div>
				<div class="content_main">
					<!-- 회원 정보 -->
					<div class="member_info_div">
					<table class="table_text_align_center memberInfo_table">
						<tbody>
							<tr>
								<th style="width:25%;">주문자</th>
								<td style = "width: *">${memberInfo.memberName } | ${memberInfo.memberMail }</td>
							</tr>
						</tbody>
					</table>
					</div>
					<!-- 상품 정보 -->
					<div class="orderGoods_div">
						<!-- 상품 종류 -->
						<div class="goods_kind_div">
							주문상품 <span class="goods_kind_div_kind"></span>종 <span class="goods_kind_div_count"></span>개
						</div>
						<!-- 상품 테이블 -->
						<table class="goods_subject_table">
							<colgroup>
								<col width = "15%">
								<col width = "45%">
								<col width = "40%">
							</colgroup>
							<tbody>
								<tr>
									<th>이미지</th>
									<th>상품 정보</th>
									<th>판매가</th>
								</tr>
							</tbody>
						</table>
						<table class="goods_table">
							<colgroup>
									<col width="15%">
									<col width="45%">
									<col width="40%">
							</colgroup>
							<tbody>
								<c:forEach items="${orderList }" var="ol">
									<tr>
										<td>
											<div class="image_wrap" data-goodsid = "${ol.imageList[0].goodsCode }" data-path="${ol.imageList[0].uploadPath }" data-uuid="${ol.imageList[0].uuid }" data-filename ="${ol.imageList[0].fileName }">
												<img>
											</div>         
										</td>
										<td>${ol.goodsName }</td>
										<td class="goods_table_price_td">
											<fmt:formatNumber value="${ol.goodsPrice}" pattern="#,### 원"/> | 수량 ${ol.goodsCount }개
											<br>
											<fmt:formatNumber value="${ol.totalPrice }" pattern="#,### 원"/>
											<br>
											[<fmt:formatNumber value="${ol.totalPoint }" pattern="#,###"/>P]   
											<input type="hidden" class="individual_goodsPrice_input" value="${ol.goodsPrice }">
											<input type="hidden" class="individual_goodsCount_input" value="${ol.goodsCount }">
											<input type="hidden" class="individual_totalPrice_input" value="${ol.totalPrice }">
											<input type="hidden" class="individual_point_input" value="${ol.point }">
											<input type="hidden" class="individual_totalPoint_input" value="${ol.totalPoint }">
											<input type="hidden" class="individual_goodsCode_input" value="${ol.goodsCode }">
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- 배송지 정보 -->
					<div class="addressInfo_div">
						<div class="addressInfo_button_div">
							<button class="address_btn address_btn_1" onclick="showAdress('1')" style="background-color:rgb(142,129,113);">사용자 정보 주소록</button>
							<button class="address_btn address_btn_2"onclick="showAdress('2')" style="background-color:rgb(238,229,217);">직접 입력</button>
						</div>
						<div class="addressInfo_input_div_wrap">
							<div class="addressInfo_input_div addressInfo_input_div_1" style="display: block">
								<table>
									<colgroup>
										<col width="25%">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th>이름</th>
											<td>
												${memberInfo.memberName }
											</td>
										</tr>
										<tr>
											<th>주소</th>
											<td>
												${memberInfo.memberAddr1 } ${memberInfo.memberAddr2 }<br>${memberInfo.memberAddr3 }
												<input class="selectAddress" value="T" type="hidden">
												<input class="addressee_input" value="${memberInfo.memberName }" type = "hidden">
												<input class="address1_input" type="hidden" value="${memberInfo.memberAddr1 }">
												<input class="address2_input" type="hidden" value="${memberInfo.memberAddr2 }">
												<input class="address3_input" type="hidden" value="${memberInfo.memberAddr3 }">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="addressInfo_input_div addressInfo_input_div_2">
								<table>
									<colgroup>
										<col width="25%">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th>이름</th>
											<td>
												<input class="addressee_input">
											</td>
										</tr>
										<tr>
											<th>주소</th>
											<td>
												<input class="selectAddress" value="F" type="hidden">
												<input class="address1_input" readonly="readonly"><a class="address_search_btn" onclick="execution_daum_address()">주소 찾기</a>
												<br>
												<input class="address2_input" readonly="readonly">
												<br>
												<input class="address3_input">
												
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- 포인트 정보 -->
					<div class="point_div">
						<div class="point_div_subject">포인트 사용</div>
						<table class="point_table">
							<colgroup>
								<col width="25%">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>포인트 사용</th>
									<td>
										${memberInfo.point } | <input class="order_point_input" value="0">원
										<a class="order_point_input_btn order_point_input_btn_N" data-state="N">모두 사용</a>
										<a class="order_point_input_btn order_point_input_btn_Y" data-state="Y" style="display:none;">사용 취소</a>
									</td>
								</tr>	
							</tbody>
						</table>
					</div>
					<!-- 주문 종합 정보 -->
					<div class="total_info_div">
						<!-- 가격 종합 정보 -->
						<div class="total_info_price_div">
							<ul>
								<li>
									<span class="price_span_label">상품 금액</span>
									<span class="totalPrice_span">100000</span>원
								</li>
								<li>
									<span class="price_span_label">배송비</span>
									<span class="delivery_price_span">100000</span>원
								</li>
								<li>
									<span class="price_span_label">할인 금액</span>
									<span class="usePoint_span">100000</span>원
								</li>
								<li class="price_total_li">
									<strong class="price_span_label total_price_label">최종 결제 금액</strong>
									<strong class="strong_red">
										<span class="total_price_red finalTotalPrice_span">
											1500000
										</span>원
									</strong>
								</li>
								<li class="point_li">
									<span class="price_span_label">적립예정 포인트</span>
									<span class="totalPoint_span">4960원</span>
								
								</li>
							</ul>
						</div>
						<!-- 버튼 영역 -->
						<div class="total_info_btn_div">
							<a class="order_btn">결제 하기</a>
						</div>
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
	//주문 조합정보란 최신화
	setTotalInfo();
	
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
	})
	
});

//주소입력란 버튼 동작(숨김, 등장)
function showAdress(className){
	//컨텐츠 동작
	//모두 숨기기
		$(".addressInfo_input_div").css('display','none');
	//컨텐츠 보이기
		$(".addressInfo_input_div_"+className).css('display','block');
	
	//버튼 색상 변경
		//모든 색상 동일
			$(".address_btn").css('backgroundColor','rgb(238,229,217)');
		//지정 색상 변경
			$(".address_btn_"+className).css('backgroundColor','rgb(142,129,113)');
	
	//selectAddress T/F
	//모든 selelctAddress F만들기(직접입력)
		$(".addressInfo_input_div").each(function(i, obj){
			$(obj).find(".selectAddress").val("F");
		});
	//선택한 selectAddress T만들기(기존정보 선택)
		$(".addressInfo_input_div_" + className).find(".selectAddress").val("T");
}

function execution_daum_address(){
	console.log("동작");
	new daum.Postcode({
		oncomplete: function(data){
			//팝업에서 검색결과 항목을 클릭했을 때 실행할 코드를 작성하는 부분입니다.
			//각 주소의 노출 규칙에 따라 주소를 조합한다.
			//내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기한다.
			var addr = ''; //주소 변수
			var extraAddr = ''; //참고항목 변수
			
			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if(data.userSelectedType==='R'){ //사용자가 도로명 주소를 선택했을 경우
				addr=data.roadAddress;
			} else { //사용자가 지번 주소를 선택했을 경우
				addr = data.jibunAddress;
			}
			
			//사용자가 선택한 주소가 도로명 타입일 때 참고항목을 조합한다.
			if(data.userSelectedType==='R'){
				//법정동명이 있을 경우 추가한다. (법정리는 제외)
				//법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if(data.bname !==''&& /[동|로|가]&/g.test(data.bname)){
					extraAddr += data.bname;
				}
				//건물명이 있고, 공동주택일 경우 추가한다.
				if(data.buildingName !==''&& data.apartment === 'Y'){
					extraAddr += ( extraAddr !==''? ', '+data.buildingName : data.buildingName);
					
				}
				//표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if(extraAddr !==''){
					extraAddr = ' (' + extraAddr + ')';
				}
				//추가해야 할 코드
				//주소변수 문자열과 참고항목 문자열 합치기
				addr += extraAddr;
			}else{
					addr += ' ';
				}
			
			//제거해야 할 코드
			//우편번호와 주소 정보를 해당 필드에 넣는다.
			$(".address1_input").val(data.zonecode);
			$(".address2_input").val(addr);
			//커서를 상세주소 필드로 이동한다.
			$(".address3_input").val("상세정보",false);
			$(".address3_input").focus();
			}
	}).open();
} //address end

//포인트 입력
//0 이상 & 최대 포인트 수 이하
$(".order_point_input").on("propertychange change keyup paste input", function(){
	
	const maxPoint = parseInt('${memberInfo.point}');
	const totalPrice = parseInt($(element).find(".individual_totalPrice_input").val());
	
	let inputValue=parseInt($(this).val()); // this는 order_point_input을 의미함
	
	if(inputValue < 0){
		$(this).val(0);
	} else if (inputValue > maxPoint){
		$(this).val(maxPoint);
	}
	
	//주문 조합 정보란 최신화
	setTotalInfo();
});

//포인트 모두사용 취소 버튼
//Y: 모두 사용 상태 / N: 모두 취소 상태
$(".order_point_input_btn").on("click", function(){
	const maxPoint = parseInt('${memberInfo.point}');
	
	let state = $(this).data("state");
	
	if(state =='N'){
		
		console.log("n동작");
		//모두 사용
		//값 변경
		$(".order_point_input").val(maxPoint);
		
		//글 변경
		$(".order_point_input_btn_Y").css("display", "inline-block");
		$(".order_point_input_btn_N").css("display","none");
		
		//주문 조합 정보란 최신화
		setTotalInfo();
		
	} else if(state=='Y'){
		console.log("y동작");
		//취소
		//값 변경
		$(".order_point_input").val(0);
		
		//글 변경
		$(".order_point_input_btn_Y").css("display","none");
		$(".order_point_input_btn_N").css("display","inline-block");
		
		//주문 조합 정보란 최신화
		setTotalInfo();
	}
});

//총 주문 정보 세팅(배송비, 총가격, 마일리지, 물품 수, 종류)
function setTotalInfo(){
	
	let totalPrice = 0; //총가격
	let totalCount = 0; //총 갯수
	let totalKind = 0; // 총 종류
	let totalPoint = 0; // 총 마일리지
	let deliveryPrice = 0; //배송비
	let usePoint = 0; // 사용포인트
	let finalTotalPrice = 0; //최종가격(총가격+ 배송비)
	
	$(".goods_table_price_td").each(function(index, element){
		//총 가격
		totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
		//총 갯수
		totalCount += parseInt($(element).find(".individual_goodsCount_input").val());
		//총 종류
		totalKind +=1;
		//총 마일리지
		totalPoint += parseInt($(element).find(".individual_totalPoint_input").val());
	});
	
	//배송비 결정
	if(totalPrice >= 30000){
		deliveryPrice =0;
	} else if(totalPrice ==0){
		deliveryPrice =0;
	} else {
		deliveryPrice = 3000;
	}
	
	//사용 포인트
	usePoint = $(".order_point_input").val();
	finalTotalPrice = totalPrice - usePoint + deliveryPrice;
	
	//값 삽입
	//총 가격
	$(".totalPrice_span").text(totalPrice.toLocaleString());
	//총 갯수
	$(".goods_kind_div_count").text(totalCount);
	//총 종류
	$(".goods_kind_div_kind").text(totalKind);
	//총 마일리지
	$(".totalPoint_span").text(totalPoint.toLocaleString());
	//배송비
	$(".delivery_price_span").text(deliveryPrice.toLocaleString());
	//최종 가격(총가격+배송비)
	$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
	//할인가(사용 포인트)
	$(".usePoint_span").text(usePoint.toLocaleString());
}

//주문 요청
$(".order_btn").on("click", function(){
	
	//주소 정보 & 받는이
	$(".addressInfo_input_div").each(function(i, obj){
		if($(obj).find(".selectAddress").val()==="T"){
			$("input[name='addressee']").val($(obj).find(".addressee_input").val());
			$("input[name='memberAddr1']").val($(obj).find(".address1_input").val());
			$("input[name='memberAddr2']").val($(obj).find(".address2_input").val());
			$("input[name='memberAddr3']").val($(obj).find(".address3_input").val());
		}
	});
	
	//사용 포인트
	$("input[name='usePoint']").val($(".order_point_input").val());
	
	//상품 정보
	let form_contents='';
	$(".goods_table_price_td").each(function(index, element){
		let goodsCode = $(element).find(".individual_goodsCode_input").val();
		let goodsCount = $(element).find(".individual_goodsCount_input").val();
		let goodsCode_input = "<input name='orders["+index+"].goodsCode' type='hidden' value='" + goodsCode +"'>";
		form_contents += goodsCode_input;
		let goodsCount_input = "<input name='orders["+index+"].goodsCount' type='hidden' value='"+goodsCount+"'>";
		form_contents += goodsCount_input;
	});
	$(".order_form").append(form_contents);
	
	//서버 전송
	$(".order_form").submit();
})

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