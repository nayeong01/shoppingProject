<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/goodsEnroll.css">
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

<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
	
</style>

</head>
<body>
    
         <%@include file="../includes/admin/header.jsp" %>
            
                <div class="admin_content_wrap">
                	<div class="admin_content_subject"><span>상품 등록</span></div>
                	<div class="admin_content_main">
                	<form action="/admin/goodsEnroll" method="post" id="enrollForm">
                	
                	<div class="form_section">	
                		<div class="form_section_title">
                			<label>상품 이미지</label>
                		</div>
                		<div class="form_section_content">
                			<input type="file" id = "fileItem" name="uploadFile" style="height = 30px;">
                			<div id="uploadResult">
                				<div id = "result_card">
                				</div>
                			</div>
                		</div>
                	</div>
                	
                	<div class="form_section">	
                		<div class="form_section_title">
                			<label>상품 이름</label>
                		</div>
                		<div class="form_section_content">
                			<input name="goodsName">
                			<span class="ck_warn goodsName_warn">상품 이름을 입력해주세요.</span>
                		</div>
                	</div>
                	
                	<div class="form_section">
                		<div class="form_section_title">
                			<label>상품 카테고리</label>
                		</div>
                		<div class="form_section_content">
                		<div class="cate_wrap">
                			<span>대분류</span>
                			<select class="cate1">
                				<option selected value="none">선택</option>
                			</select>
                		</div>
                		<div class="cate_wrap">
                			<span>중분류</span>
                			<select class="cate2" name="goodsCate">
                				<option selected value="none">선택</option>
                			</select>
                		</div>
                		<span class="ck_warn goodsCate_warn">카테고리를 선택해주세요.</span> 
                		</div>
                	</div>

                	<div class="form_section">
                		<div class="form_section_title">
                			<label>상품 가격</label>
                		</div>
                		<div class="form_section_content">
                			<input name="goodsPrice">
                			<span class="ck_warn goodsPrice_warn">상품 가격을 숫자로 입력해주세요. </span>
                		</div>
                	</div>
                	
                	<div class="form_section">
                		<div class="form_section_title">
                			<label>상품 재고량</label>
                		</div>
                		<div class="form_section_content">
                			<input name="goodsStock">
                			<span class="ck_warn goodsStock_warn">상품 재고를 숫자로 입력해주세요.</span>
                		</div>
                	</div>
					
                	<div class="form_section">
                		<div class="form_section_title">
                			<label>상품 상세설명</label>
                		</div>
                		<div class="form_section_content bit">
                			<textarea name="goodsDetail" id="goodsDetail_textarea"></textarea>
                			<span class="ck_warn goodsDetail_warn">제품 상세설명을 입력해주세요.</span>
                		</div>
                	</div>

                </form>
                	<div class="btn_section">
                		<button id="cancelBtn" class="btn">취소</button>
                		<button id="enrollBtn" class="btn enroll_btn">등록</button>
                	</div>
                </div>
            </div>
            

   	<script>
   		let enrollForm = $("#enrollForm")
   	
   		//취소 버튼
   		$("#cancelBtn").click(function(){
   			location.href="/admin/goodsManage"
   		});
   		
   		//상품 등록 버튼
   		$("#enrollBtn").on("click", function(e){
   			
   			//체크 변수 : 각 항목의 통과 여부 의미하는 변수
   			let goodsNameCk = false;
   			let goodsCateCk = false;
   			let goodsPriceCk = false;
   			let goodsStockCk = false;
   			let goodsDetailCk = false;
   			let goodsImageCk = false;
   			
   			//체크 대상 변수
   			let goodsImage = $("input[name='goodsImage']").val();
   			let goodsName = $("input[name='goodsName']").val();
   			let goodsCate = $("select[name='goodsCate']").val();
   			let goodsPrice = $("input[name='goodsPrice']").val();
   			let goodsStock = $("input[name='goodsStock']").val();
   			let goodsDetail = $(".bit p").html(); // 이건 아마 위지윅 적용 때문에 다르게 입력받은거 같아

   			//상품 이름 유효성 검사
   			if(goodsName){
   				$(".goodsName_warn").css('display', 'none');
   				goodsNameCk = true;
   				
   			} else {
   				$(".goodsName_warn").css('display','block');
   				goodsNameCk = false;
   			}
   			
   			//카테고리 유효성 검사
   			if(goodsCate != 'none' ){
   				
   				$(".goodsCate_warn").css('display','none');
   				goodsCateCk = true;
   				
   			} else {

   				$(".goodsCate_warn").css('display','block');
   				goodsCateCk = false;
   			}
   			
   			//가격 유효성 검사			
   			if (goodsPrice != 0 && !isNaN(goodsPrice)){
   				$(".goodsPrice_warn").css('display','none');
   				goodsPriceCk = true;
   				
   			} else {
   				$(".goodsPrice_warn").css('display','block');
   				goodsPriceCk = false;
   			}
   			
   			
   			//재고량 유효성 검사
   			if (goodsStock !=0 && !isNaN(goodsStock)){
   				$(".goodsStock_warn").css('display','none');
   				goodsStockCk = true;
   				
   			} else {
   				$(".goodsStock_warn").css('display','block');
   				goodsStockCk = false;
   			}
   			
   			//상세설명 유효성 검사
   			if(goodsDetail != '<br data-cke-filler="true">'){
   				
   				$(".goodsDetail_warn").css('display','none');
   				goodsDetailCk=true;
   				
   			} else {
   				$(".goodsDetail_warn").css('display','block');
   				goodsDetailCk=false;
   			}
			
   			if(goodsNameCk && goodsCateCk && goodsPriceCk && goodsStockCk && goodsDetailCk){
   				  
   				enrollForm.submit();
   				
   			} else {
   				
   				return false;
   			}
   			
   		});
   		
   	//위지윅 적용
		
   		// 상품 상세설명
		ClassicEditor.create(document.querySelector("#goodsDetail_textarea")).catch(error=>{
			console.error(error);
		});
	
   	//카테고리
   		let cateList = JSON.parse('${cateList}'); //json객체를 jquery객체로 변환해주기
   	
   		let cate1Array = new Array();
   		let cate2Array = new Array();
   		
   		let cate1Obj = new Object();
   		let cate2Obj = new Object();
   		
   		let cateSelect1 = $(".cate1");
   		let cateSelect2 = $(".cate2");
   		
   		function makeCateArray(obj,array,cateList,tier){
   			for(let i = 0; i < cateList.length; i++){
   			
   				if(cateList[i].tier === tier){
   					obj = new Object();
   				
   					obj.cateName = cateList[i].cateName;
   					obj.cateCode = cateList[i].cateCode;
   					obj.cateParent = cateList[i].cateParent;
   				
   					array.push(obj);
   					
   			}
   		}
   	}
   		
   	//배열 초기화
   	makeCateArray(cate1Obj, cate1Array, cateList, 1);
   	makeCateArray(cate2Obj, cate2Array, cateList, 2);
   	
   		$(document).ready(function(){
   			console.log(cate1Array);
   			console.log(cate2Array);
   		});
   	
   		//대분류 <option> 태그
   	for(let i =0; i<cate1Array.length; i++){
   		cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>"+cate1Array[i].cateName+"</option>");
   	}
   	
   		// 중분류 <option> 태그
   		$(cateSelect1).on("change", function(){
   			
   			let selectVal1 = $(this).find("option:selected").val();
   			
   			cateSelect2.children().remove();
   			
   			cateSelect2.append("<option value='none'>선택</option>")
   			
   			for(let i=0; i < cate2Array.length; i++){
   				if(selectVal1 === cate2Array[i].cateParent){
   					cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>"+cate2Array[i].cateName+"</option>");
   				}
   			}
   			
   		});
   		
   		//이미지 업로드
   		$("input[type='file']").on("change", function(e){
   			
   			//이미지 존재시 삭제
   			if($(".imgDeleteBtn").length > 0){
   				
   				deleteFile();
   			}
   			
   			let formData = new FormData(); //가상의 <form>태그라고 생각하면 돼
   			let fileInput = $("input[name='uploadFile']");
   			let fileList = fileInput[0].files;
   			let fileObj = fileList[0];
   			
   			/*
   			if(!fileCheck(fileObj.name, fileObj.size)){
   				return false;
   			}
   			*/
   			
   			formData.append("uploadFile",fileObj);
   			
   			$.ajax({
   				url: '/admin/uploadAjaxAction', // 서버로 요청을 보낼 url
   				processData : false, // 서버로 전송할 데이터를 queryString 형태로 변환 여부
   				contentType : false,	// 서버로 전송되는 데이터의 content_type
   				data : formData, //서버로 전송할 데이터
   				type : 'POST', // 서버 요청 타입
   				dataType : 'json', // 서버로부터 반환받을 데이터 타입
   	   			success : function(result){
   	   				console.log(result);
   	   				showUploadImage(result);
   	   			},
   	   			error : function(result){
   	   				alert("이미지 파일이 아닙니다.");
   	   			}
   			});
   			
   			
   		});
   		
   		//var, method related with attachFile
   		let regex = new RegExp("(.*?)\.(jpg|png|JPG|PNG)$");
   		let maxSize = 1048576; // 1MB
   		
   		function fileCheck(fileName, fileSize){
   			
   			if(fileSize >= maxSize){
   				alert("파일 사이즈 초과");
   				return false;
   			}
   			
   			if(!regex.test(fileName)){
   				alert("해당 종류의 파일은 업로드할 수 없습니다.");
   				return false;
   			}
   			
   			return true;
   		}
   		
   		//이미지 출력
   		function showUploadImage(uploadResultArr){
   			
   			//전달받은 데이터 검증
   			if(!uploadResultArr || uploadResultArr.length == 0){return}
   			
   		let uploadResult = $("#uploadResult");
   		
   		let obj = uploadResultArr[0]; // 현재는 사진을 하나만 올리게 해놨으니까 첫번째 배열만 지정
   		
   		let str = "";
   		
   		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
   		
   		str +="<div id = 'result_card'>";
   		str +="<img src = '/display?fileName="+ fileCallPath+"'>";
   		str += "<div class='imgDeleteBtn' data-file='"+fileCallPath+"'>X</div>";
   		str += "<input type='hidden' name='imageList[0].fileName' value = '"+obj.fileName + "'>";
   		str += "<input type='hidden' name='imageList[0].uuid' value = '"+obj.uuid + "'>";
   		str += "<input type='hidden' name='imageList[0].uploadPath' value = '"+obj.uploadPath + "'>";
   		str += "</div>";
   		
   		uploadResult.append(str);
   		}
   		
   		//이미지 삭제 버튼 동작
   		$("#uploadResult").on("click",".imgDeleteBtn", function(e){
   			
   			deleteFile();
   			
   		})
   		//파일 삭제 메서드
   		function deleteFile(){
   			
   			let targetFile = $(".imgDeleteBtn").data("file"); //삭제 버튼에 file 경로 심기
   			
   			let targetDiv = $("#result_card"); // 미리보기 태그 대입
   			
   			$.ajax({
   				url : '/admin/deleteFile', 
   				data : {fileName : targetFile}, // fileName에 이미지 파일 경로 값 부여
   				dataType : 'text',
   				type : 'POST',
   				success : function(result){
   					console.log(result);
   					
   					targetDiv.remove();
   					$("input[type='file']").val("");
   				},
   				error : function(result){
   					console.log(result);
   					
   					alert("파일을 삭제하지 못하였습니다.")
   				}
   			});
   		}
   		
   		
   	</script>
   	
 <%@include file="../includes/admin/footer.jsp" %>
 
</body>
</html>