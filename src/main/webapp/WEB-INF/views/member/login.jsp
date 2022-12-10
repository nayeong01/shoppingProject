<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/member/login.css">

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
	crossorigin="anonymous">
</script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
<body>
	<div class="wrapper">
		<div class="wrap">
			<form id="login_form" method="post">
				<fieldset style="border-radius : 20px; border-color : rgba(238, 229, 217); border : none;">
					<div class="logo_wrap">
						<span>Login</span>
					</div>
					<div class="login_wrap">
						<div class="id_wrap">
							<div class="id_input_box">
								<span class="material-symbols-outlined">person</span>
								<input class="id_input" name="memberId" >
							</div>
						</div>
						<div class="pw_wrap">
							<div class="pw_input_box">
								<span class="material-symbols-outlined">key</span>
								<input class="pw_input" name="memberPw" type="password">
							</div>
						</div>
						<c:if test = "${result == 0}">
							<div class = "login_warn">
								사용자ID 또는 비밀번호를 잘못 입력하셨습니다. 
							</div>
						</c:if>
						<div class="login_button_wrap">						
							<input type="button" class="login_button" value="로그인">
							
						</div>
						<!-- 네이버 로그인 창으로 이동 -->
						<div id="naver_id_login" style="text-align:center; padding:1%;"><a href="${url}">
						<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a>
						</div>
						<div class="a_search">
							<a href="/member/search_id">아이디 찾기</a>	| 
							<a href="/member/search_pwd">비밀번호 찾기</a> | 
							<a href="/member/join">회원가입</a>
						</div>
						
						<div class="space"></div>
						<div class="clearfix"></div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	<script>
	/* 로그인 버튼 클릭 메서드 */
	$(".login_button").click(function(){
			//alert("로그인 버튼 작동");
			
			$("#login_form").attr("action", "/member/login.do");
			$("#login_form").submit();
		});
	</script>
</body>
</html>