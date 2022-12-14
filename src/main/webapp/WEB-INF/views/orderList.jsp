<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/cart.css">

<!-- Google Fonts -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<style>
	body, h1, h2, h3, h4, h5, h6, p, span {
	font-family: 'NanumSquare';
    color: #0d1e2d;
  }

</style>
<style>
/*
 section#content ul li { display:inline-block; margin:10px; }
 section#content div.goodsThumb img { width:200px; height:200px; }
 section#content div.goodsName { padding:10px 0; text-align:center; }
 section#content div.goodsName a { color:#000; }
*/
 section#content {
  padding:10px 20px;
  margin-bottom:20px;
  
  }
 section#content ul li {
  
  border:5px solid rgb(238,229,217);
  padding:10px 20px;
  margin-bottom:20px;
  
  }
 section#content .orderList span {
  font-size:20px;
  font-weight:bold;
  display:inline-block;
  width:90px;
  margin-right:10px;
  
  }
 
 section#content ul li {
   list-style:none;
  }
  
  .line{
  	width: 100%;
	border-top:1px solid #c6c6cf;  		
  		}
  		
  .subject{
 	background-color: rbg(238, 229, 217);
 	
  }		
  .subject span{
  
    font-size:20px;
    font-weight:bold;
   	display:inline-block;
  	width:100%;
  	margin-right:10px;
  	padding:2%;
  	background: rbg(238, 229, 217);
  }
  
  .orderList{
  	padding:3%;
  }
  .date{
  	padding:2% 0% 0.5% 2%;
  	font-size:15px;
  }
  
  .section#content>a{
  	color: rgb(142,129,113);
    font-weight:bold;
  }
  
  .modify_btn{
	height: 32px;
    width: 80px;
    font-weight: 600;
    font-size: 16px;
    color: #ffffff;
    position: absolute;
    background-color: rgb(142,129,113);
    border:0;
    outline:0;
}

	.modify_btn a{
	
	color: #ffffff;
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
				<c:if test = "${member == null}">	<!-- ????????? x -->			
					<li>
						<a href="/member/login">Login</a>
					</li>
					<li>
						<a href="/member/join">Join Us!</a>
					</li>
				</c:if>
				<c:if test = "${member != null}">	<!-- ????????? o -->
					<c:if test="${member.adminCk == 1}">	<!-- ????????? ?????? -->
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
			<!-- ???????????? -->		
			<div class="search_area">
					<form id="searchForm" action="/search" method="get">
						<select name="type">
							<option value="T"></option>
						</select>
						<div class="search_input">
							<i class="fa fa-magnifying-glass" style="font-size: 15px;"></i>
							<input class= "search-bar__input" type="search" name="keyword" placeholder="??????">
						</div>
					</form>
			</div>
			
			<!-- ???????????? -->
			<div class="logo_area">
				<a href="/"><img src="/resources/img/????????????1.png"></a>				
			</div>
			<div class="login_area">
				<!-- ????????? ?????? ?????? ??????--> 
				<c:if test = "${member == null}">
					<!-- <div class="login_button"><a href="/member/login">?????????</a></div>
					<span><a href="/member/join">????????????</a></span>-->
				</c:if>
				<!-- ???????????? ?????? -->
				<c:if test="${member != null}">
					<div class="login_success_area">
						<table>
							<tr>
								<td>??????  </td>
								<td  style="padding-left:15px" >${member.memberName}</td>
							</tr>
							<tr>
								<td>????????????  </td>
								<td  style="padding-left:15px" ><fmt:formatNumber value="${member.money}" pattern="\#,###.##"/></td>
							</tr>
							<tr>
								<td>?????????  </td>
								<td style="padding-left:15px" ><fmt:formatNumber value="${member.point}" pattern="#,###P"/></td>
							</tr>
						</table>
						
						<!-- <span>?????? : ${member.memberName}</span>
						<span>???????????? : <fmt:formatNumber value="${member.money}" pattern="\#,###.##"/></span>
						<span>????????? : <fmt:formatNumber value="${member.point}" pattern="#,###"/></span>-->
						<a href="/member/logout.do">????????????</a>
					</div>
				</c:if>
			</div>
			<div class="clearfix"></div>
		</div>
			<div class="content_area">
				<div class="content_subject"><span>MY PAGE</span></div>
				<div class="line"></div>
				<div class="subject"><span>?????? ?????? ??????</span></div>	
				<div class="line"></div>
				<div style="margin:10px; padding-left:4%; text-align:left;">
				<button class="modify_btn"><a href="/member/updateMember">?????? ??????</a></button>
				</div>
				<section id="content">
 				<ul class="orderList">
  				<li>
  				<div>
   					<p style="margin-bottom:10px;"><span>??????</span>${member.memberName}</p>
   					<div class="line"></div>
   					<p style="margin-bottom:10px; margin-top:10px;"><span>?????????</span>${member.memberId}</p>
   					<div class="line"></div>
   					<p style="margin-bottom:10px; margin-top:10px;"><span>????????????</span>${member.memberTel}</p>
   					<div class="line"></div>
   					<p style="margin-bottom:10px; margin-top:10px;"><span>?????????</span>${member.memberMail}</p>
   					<div class="line"></div>
   					<p style="margin-top:10px;"><span>??????</span>(${member.memberAddr1}) ${member.memberAddr2} ${member.memberAddr3}</p>
  				</div>
  				</li>
 				</ul>
			</section>
			<div class="line"></div>	
			<div class="subject"><span>??????????????????</span></div>	
			<div class="line"></div>
			<section id="content">
 				<ul class="orderList">
  				<c:forEach items="${orderList}" var="orderList">
  				<p class="date">???????????? ${orderList.orderDate }</p>
  				<li>
  				<div>
   					<p><span>????????????</span><a style="text-decoration: underline; font-weight:bolder; color:grey" onclick="window.open(this.href, '_blank', 'width=800, height=600'); return false;" href="/orderView?n=${orderList.orderId }">${orderList.orderId}</a></p>
   					<p><span>?????????</span>${orderList.addressee}</p>
   					<p><span>??????</span>(${orderList.memberAddr1}) ${orderList.memberAddr2} ${orderList.memberAddr3}</p>
   					<p><span>????????????</span>${orderList.orderState}</p>
  				</div>
  				</li>
  				</c:forEach>
 				</ul>

			</section>
			</div>

		<!-- Footer ?????? -->
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
							<li>(???)???????????? ?????? : ?????????, ?????????</li>
							<li>?????? ????????? : olive_yeong@naver.com, gkgkdkwnaak1@naver.com </li>
							<li>??????/???????????? : ?????? ????????? ????????? ???????????? 93 ???????????? 3~5???</li>
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

/* ???????????? ?????? ?????? */
$("#gnb_logout_button").click(function(){
	//alert("?????? ??????");
	$.ajax({
		type:"POST",
		url:"/member/logout.do",
		success:function(data){
			alert("???????????? ??????");
			document.location = "/";
		}
	})
})
</script>
</body>

</html>