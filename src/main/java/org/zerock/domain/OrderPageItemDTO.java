package org.zerock.domain;

import java.util.List;

public class OrderPageItemDTO {
	
	//뷰로부터 전달받을 값
	private int goodsCode;
	
	private int goodsCount;
	
	//DB로부터 꺼내올 값
	private String goodsName;
	
	private int goodsPrice;
	
	//만들어 낼 값
	private int totalPrice;
	
	private int point;
	
	private int totalPoint;
	
	//상품 이미지
	private List<AttachImageVO> imageList;
	
	
	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	public int getGoodsCode() {
		return goodsCode;
	}

	public void setGoodsCode(int goodsCode) {
		this.goodsCode = goodsCode;
	}

	public int getGoodsCount() {
		return goodsCount;
	}

	public void setGoodsCount(int goodsCount) {
		this.goodsCount = goodsCount;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public int getGoodsPrice() {
		return goodsPrice;
	}

	public void setGoodsPrice(int goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public int getPoint() {
		return point;
	}

	public int getTotalPoint() {
		return totalPoint;
	}


	public void initSaleTotal() {
		
		this.totalPrice = this.goodsPrice * this.goodsCount;
		this.point = (int)(Math.floor(this.goodsPrice*0.05));
		this.totalPoint = this.point * this.goodsCount;
	}

	@Override
	public String toString() {
		return "OrderPageItemDTO [goodsCode=" + goodsCode + ", goodsCount=" + goodsCount + ", goodsName=" + goodsName
				+ ", goodsPrice=" + goodsPrice + ", totalPrice=" + totalPrice + ", point=" + point + ", totalPoint="
				+ totalPoint + ", imageList=" + imageList + "]";
	}

	
}
