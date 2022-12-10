<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<html>
<head>

<meta charset="UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>아이디 찾기</title>

<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
rel="stylesheet">
 
<!-- Custom styles for this template-->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-grandient-primary">
<form commandName="searchVO" id="createForm" action = "${path }/member/search_result_id" method="post">


<div class="row justify-content-center">
<div class="col-xl-10 col-lg-12 col-md-9">
<div class="card o-hidden border-0 shadow-lg my-5">
<div class="card-body p-0">

<div class="row">
<div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
<div class="col-lg-6">
<div class="p-5">
	<div class="text-center">
		<h1 class="h4 text-gray-900 mb-2">Forgot Your ID?</h1>
	</div>
		<div class="form-group">
			<input type="text" class="form-control form-control-user"
			id="memberName" name="memberName" placeholder="Enter name...">
		</div>
		<div class="form-group">
			<input type="email" class="form-control form-control-user"
			id="memberTel" name="memberTel" placeholder="Enter phone number...">
		</div>
		<a href="javascript:void(0)" onclick="fnSubmit(); return false;" class="btn btn-primary btn-user btn-block">
			Search ID
		</a>
	<hr>
	<div class="text-center">
      <a class="small" href="/member/join">Create an Account!</a>
  	</div>
  	<div class="text-center">
      <a class="small" href="/member/login">Already have an account? Login!</a>
  	</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
 
<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
 
<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin-2.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>

var path="${pageContext.request.contextPath}";

$(document).ready(function(){
	var msg="${msg}";
	if(msg != ""){
		alert(msg);
	}
});

function fnSubmit(){
	
	var email_rule =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var tel_rule = /^\d{2,3}-\d{3,4}-\d{4}$/;
	
	if($('#memberName').val()==null || $("#memberName").val()==""){
		alert("이름을 입력해주세요.");
		$("#memberName").focus();
		
		return false;
	}
	
	if($("#memberTel").val()==null||$("#memberTel").val()==""){
		alert("전화번호를 입력해주세요.");
		$("#memberTel").focus();
		
		return false;
	}
	
	if(!tel_rule.test($("#memberTel").val())){
		alert("전화번호 형식에 맞게 입력해주세요.");
		
		return false;
	}
	
	if(confirm("아이디를 찾으시겠습니까?")){
		
		$("#createForm").submit();
		
		return false;
	}
}
</script> 
</form>
</body>
</html>