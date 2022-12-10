<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
body{
  	margin : 0;	
  	font-family: 'NanumSquare';
    color: #0d1e2d;
  	}
  	/* 전체 배경화면 색상 */
.wrapper_div{
		background-color: #f5f5f5;
	    height: 100%;  	
  	}
  	 /* 팝업창 제목 */
  	.subject_div{
	    width: 100%;
	    background-color: rgb(238,229,217);
	    color: black;
	    padding: 2%;
	    font-weight: bold;
	    font-size: 23px;
  	}
 .orderInfo {
 	border:5px solid rgb(238,229,217);
 	padding:10px 20px;
 	margin:20px 0;
 	}
 .orderInfo span { font-size:20px; font-weight:bold; display:inline-block; width:90px; }
 
 .orderView li { margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #999; }
 .orderView li::after { content:""; display:block; clear:both; }
 
 .orderView ul {
   list-style:none;
  }
 
 .gdsInfo { float:left; width:calc(100% - 220px); line-height:2; list-style:none;}
 .gdsInfo ul {
 	list-style:none;
 	}
 .gdsInfo span { font-size:20px; font-weight:bold; display:inline-block; width:100px; margin-right:10px; }

	
</style>
<title>Insert title here</title>
<script
	src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
</script>
</head>
<body>
	<div class="wrapper_div">
		<div class="subject_div">
			주문 제품 목록
		</div>
	</div>

<section id="content">

 <div class="orderInfo">
  <c:forEach items="${orderView}" var="orderView" varStatus="status">
   
   <c:if test="${status.first}">
    <p><span>수령인</span>${orderView.addressee}</p>
    <p><span>주소</span>(${orderView.memberAddr1}) ${orderView.memberAddr2} ${orderView.memberAddr3}</p>
   	<p><span>전화번호</span>${orderView.memberTel}</p>
   </c:if>
   
  </c:forEach>
 </div>
 
 <ul class="orderView">
  <c:forEach items="${orderView}" var="orderView">     
  <li>
   <div class="gdsInfo">
    <p>
     <span>상품명</span>${orderView.goodsName}<br/>
     <span>구입 수량</span>${orderView.goodsCount} 개<br />
     <span>개당 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.goodsPrice}" /> 원 <br/>
     <span>최종 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.goodsPrice * orderView.goodsCount}" /> 원                  
    </p>
   </div>
  </li>     
  </c:forEach>
 </ul>
</section>
</body>
</html>