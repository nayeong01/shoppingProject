<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/css/navi_bar.css">

<!-- Google Fonts -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<style>
	body, h1, h2, h3, h4, h5, h6, p, span, a {
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
</head>
<body>
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
</body>
</html>