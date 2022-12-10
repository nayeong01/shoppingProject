package org.zerock.domain;

public class CateFilterDTO {
	
	/* 카테고리 이름 */
	private String cateName;
	
	/* 카테고리 넘버 */
	private String cateCode;
	
	/* 카테고리 상품 수 */
	private String cateCount;
	
	/* All, 리빙, 패션, 뷰티 분류 */
	private String cateGroup;

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
		this.cateGroup = cateCode.split("")[0];
	}

	public String getCateCount() {
		return cateCount;
	}

	public void setCateCount(String cateCount) {
		this.cateCount = cateCount;
	}

	public String getCateGroup() {
		return cateGroup;
	}


	@Override
	public String toString() {
		return "CateFilterDTO [cateName=" + cateName + ", cateCode=" + cateCode + ", cateCount=" + cateCount
				+ ", cateGroup=" + cateGroup + "]";
	}
	
	
	
}