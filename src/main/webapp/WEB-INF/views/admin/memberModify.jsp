<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/memberModify.css">

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
  crossorigin="anonymous"></script>
  <script src="https://cdn.ckeditor.com/ckeditor5/35.2.0/classic/ckeditor.js"></script>
</head>
<body>
         <%@include file="../includes/admin/header.jsp" %>
            
                <div class="admin_content_wrap">
                	<div class="admin_content_subject"><span>회원 정보 수정</span></div>
                	<div class="admin_content_main">
                	<form action="/admin/memberModify" method="post" id="modifyForm">
                	
                	<div class="form_section">	
                		<div class="form_section_title">
                			<label>회원 아이디</label>
                		</div>
                		<div class="form_section_content">
                		<input name="memberId" value="${memberInfo.memberId }" readonly="readonly">
                		<span class="ck_warn memberId_warn">회원 아이디를 입력해주세요.</span>
                		</div>
                	</div>
                	
                	<div class="form_section">	
                		<div class="form_section_title">
                			<label>회원 이름</label>
                		</div>
                		<div class="form_section_content">
                			<input name="memberName"value="${memberInfo.memberName }">
                			<span class="ck_warn memberName_warn">회원 이름을 입력해주세요.</span>
                		</div>
                	</div>
                	
                <div class="form_section">
					<div class="form_section_title">
						<label>회원 포인트</label>
					</div>
					<div class="form_section_content">
						<input name="point" value="${memberInfo.point }">
						<span class="ck_warn point_warn">회원 포인트를 입력해주세요.</span>
					</div>
				</div>

                	<div class="form_section">
                		<div class="form_section_title">
                			<label>회원 충전 금액</label>
                		</div>
                		<div class="form_section_content">
                			<input name="money"value="${memberInfo.money}">
                			<span class="ck_warn money_warn">충전 금액을 입력해주세요.</span>
                		</div>
                	</div>		
                	
                </form>
                	<div class="btn_section">
                		<button id="cancelBtn" class="btn">취소</button>
                		<button id="modifyBtn" class="btn modify_btn">수정</button>
                	</div>
                </div>
                
                <form id="moveForm" action="/admin/memberManage" method="get" >
 						<input type="hidden" name="pageNum" value="${cri.pageNum}">
						<input type="hidden" name="amount" value="${cri.amount}">
						<input type="hidden" name="keyword" value="${cri.keyword}">
						<input type="hidden" name='memberId' value="${memberInfo.memberId}">
				</form>
            </div>
            

 			<%@include file="../includes/admin/footer.jsp" %>
 			
<script>

   	//취소 버튼
   	$("#cancelBtn").on("click", function(e){
   		
   		e.preventDefault();
   		
   		$("#moveForm").submit();
   	});
   	
   	//수정버튼
   	$("#modifyBtn").on("click", function(e){
   		
   		e.preventDefault();
   		
   	//체크 변수 : 각 항목의 통과 여부 의미하는 변수
			let memberIdCk = false;
			let memberNameCk = false;
			let pointCk = false;
			let moneyCk = false;
			
			//체크 대상 변수
			let memberId = $("input[name='memberId']").val();
			let memberName = $("input[name='memberName']").val();
			let point = $("input[name='point']").val();
			let money = $("input[name='money']").val();

			//이름 유효성 검사
			if(memberName){
				$(".memberName_warn").css('display', 'none');
				memberNameCk = true;
				
			} else {
				$(".memberName_warn").css('display','block');
				memberNameCk = false;
			}
			
			//아이디 유효성 검사
			if(memberId){
				$(".memberId_warn").css('display', 'none');
				memberIdCk = true;
				
			} else {
				$(".memberId_warn").css('display','block');
				memberIdCk = false;
			}
			
			//포인트 유효성 검사			
   			if (point != 0 && !isNaN(point)){
   				$(".point_warn").css('display','none');
   				pointCk = true;
   				
   			} else {
   				$(".point_warn").css('display','block');
   				pointCk = false;
   			}
			
			
   			//충전금액 유효성 검사			
   			if (money != 0 && !isNaN(money)){
   				$(".money_warn").css('display','none');
   				moneyCk = true;
   				
   			} else {
   				$(".money_warn").css('display','block');
   				moneyCk = false;
   			}
   			
   			if(memberNameCk && memberIdCk && pointCk && moneyCk){
 				  
   				$("#modifyForm").submit();
   				
   			} else {
   				
   				return false;
   			}
   		
   	});
 
   	
   	
</script>
 
</body>
</html>