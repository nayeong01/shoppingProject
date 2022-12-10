<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/goodsDetail.css">
 
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>

<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
</style>
</head>
<body>
<%@include file="../includes/admin/header.jsp" %>

<div class="admin_content_wrap">
	<div class="admin_content_subject"><span>상품 상세</span></div>
	
	<div class="admin_content_main">
				
		<div class="form_section">
			<div class="form_section_title">
				<label>상품 이미지</label>
			</div>
			<div class="form_section_content">
				<div id="uploadResult">
				
				</div>
			</div>
		</div>
		
		<div class="form_section">
			<div class="form_section_title">
				<label>상품 이름</label>	
			</div>
			<div class="form_section_content">
				<input name="goodsName" value="<c:out value='${goodsInfo.goodsName}'/>" disabled>
			</div>
		</div>
		
		<div class="form_section">
			<div class="form_section_title">
				<label>등록 날짜</label>
			</div>
			<div class="form_section_content">
				<input value="<fmt:formatDate value='${goodsInfo.goodsDate }' pattern='yyyy-MM-dd'/>" disabled>
			</div>
		</div>
		
		<div class="form_section">
			<div class="form_section_title">
				<label>최근 수정 날짜</label>
			</div>
			<div class="form_section_content">
				<input value="<fmt:formatDate value='${goodsInfo.goodsUpdateDate }' pattern='yyyy-MM-dd'/>" disabled>
			</div>
		</div>
		
		<div class="form_section">
			<div class="form_section_title">
				<label>상품 카테고리</label>
			</div>
			<div class="form_section_content">
				<div class="cate_wrap">
					<span>대분류</span>
					<select class="cate1" disabled>
						<option value="none">선택</option>
					</select>
				</div>
				<div class="cate_wrap">
					<span>중분류</span>
					<select class="cate2" disabled>
						<option value="none">선택</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="form_section">
			<div class="form_section_title">
				<label>상품 가격</label>
			</div>
			<div class="form_section_content">
				<input name="goodsPrice" value="<c:out value='${goodsInfo.goodsPrice }'/>" disabled >
			</div>
		</div>
		
		<div class="form_section">
        	<div class="form_section_title">
            	<label>상품 재고</label>
            </div>
         	<div class="form_section_content">
          		<input name="goodsStock" value="<c:out value='${goodsInfo.goodsStock}'/>" disabled>
             </div>
        </div>
        
        <div class="form_section">
        	<div class="form_section_title">
            	<label>상품 상세설명</label>
            </div>
         	<div class="form_section_content bit">
          		<textarea name="goodsDetail" id ="goodsDetail_textarea" disabled>${goodsInfo.goodsDetail }</textarea>
             </div>
        </div>

		<div class="btn_section">
			<button id = "cancelBtn" class="btn">상품 목록</button>
			<button id = "modifyBtn" class="btn enroll_btn">수정</button>
		</div>
		
		<!-- 주문 form -->
		<form action="/order/${member.memberId }" method = "get" class="order_form">
			<input type="hidden" name="orders[0].goodsCode" value="${goodsInfo.goodsCode }">
			<input type="hidden" name="orders[0].goodsCount" value="">
		</form>
	</div>
	
	<form id="moveForm" action="/admin/goodsManage" method="get">
		<input type="hidden" name="pageNum" value="${cri.pageNum }">
		<input type="hidden" name="amount" value="${cri.amount }">
		<input type="hidden" name="keyword" value="${cri.keyword }">
	</form>
</div>

<%@include file="../includes/admin/footer.jsp" %>
<script>
	
	//위지윅 적용 - 상품 상세설명
	ClassicEditor
		.create(document.querySelector("#goodsDetail_textarea"))
		.then(editor=>{
			console.log(editor);
			editor.isReadOnly = true;
		})
		.catch(error =>{
			console.error(error);
		});
	

	$(document).ready(function(){
		
		//카테고리
		let cateList = JSON.parse('${cateList}'); //json객체를 jquery객체로 변환해주기
	   	
			let cate1Array = new Array();
			let cate2Array = new Array();
			
			let cate1Obj = new Object();
			let cate2Obj = new Object();
			
			let cateSelect1 = $(".cate1");
			let cateSelect2 = $(".cate2");
			
		//카테고리 배열 초기화 메서드
		function makeCateArray(obj, array, cateList, tier){
			for(let i = 0; i < cateList.length; i++){
				if(cateList[i].tier === tier){
					obj = new Object();
					
					obj.cateName=cateList[i].cateName;
					obj.cateCode=cateList[i].cateCode;
					obj.cateParent=cateList[i].cateParent;
					
					array.push(obj);
				}
			}
		}
		
		//배열 초기화
		
		makeCateArray(cate1Obj,cate1Array, cateList,1);
		makeCateArray(cate2Obj, cate2Array, cateList,2);
		
		
		
		//중분류 지정된 카테고리 선택하게 하기
		let targetCate1 = '';
		let targetCate2 = '${goodsInfo.goodsCate}';
		
		//targetCate2 객체로 변경하기
		for(let i = 0; i < cate2Array.length; i++){
			if(targetCate2 === cate2Array[i].cateCode){
				targetCate2 = cate2Array[i];
			}
		} // for
		
		//cateParent와 동일한 값을 가지는 중분류를 항목에 추가하기
		for(let i=0; i<cate2Array.length; i++){
			if(targetCate2.cateParent === cate2Array[i].cateParent){
				cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>"+ cate2Array[i].cateName+"</option>");
			}
		}
		
		//DB에 저장되어 있는 항목이 선택되게 출력되도록 하기
		$(".cate2 option").each(function(i,obj){
			if(targetCate2.cateCode === obj.value){
				$(obj).attr("selected", "selected");
			}
		});
		
		//대분류 선택하게 하기
		//cateParent와 동일한 값을 가지는 대분류를 항목에 추가하기
		for(let i=0; i<cate1Array.length; i++){
				cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>"+ cate1Array[i].cateName+"</option>");
		}
		
		//DB에 저장되어 있는 항목이 선택되게 출력되도록 하기
		$(".cate1 option").each(function(i,obj){
			if(targetCate2.cateParent === obj.value){
				$(obj).attr("selected", "selected");
			}
		});
		
		//이미지 정보 호출
		let goodsCode = '<c:out value = "${goodsInfo.goodsCode}"/>';
		let uploadResult = $("#uploadResult");
		
		$.getJSON("/getAttachList", {goodsCode : goodsCode}, function(arr){
			
			//이미지가 없는 경우
			if(arr.length === 0){
				
				let str = "";
				str += "<div id='result_card'>";
				str += "<img src='/resources/img/goodsNoImage.png'>";
				str += "</div>";
				
				uploadResult.html(str);
				
				return;
			}
			
			//이미지가 있는 경우
			let str ="";
			let obj = arr[0];
			
			let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			str += "<div id='result_card'";
			str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
			str += ">";
			str += "<img src='/display?fileName=" + fileCallPath +"'>";
			str += "</div>";
			
			uploadResult.html(str);
			
		});
		
	}); //document end
		
		//목록 이동 버튼
		$("#cancelBtn").on("click", function(e){
			e.preventDefault();
			$("#moveForm").submit();
		});
		
		// 수정 페이지 이동
		$("#modifyBtn").on("click", function(e){
			e.preventDefault;
			let addInput = '<input type = "hidden" name="goodsCode" value="${goodsInfo.goodsCode}">';
			$("#moveForm").append(addInput);
			$("#moveForm").attr("action","/admin/goodsModify");
			$("#moveForm").submit();
		});

	
</script>
</body>
</html>