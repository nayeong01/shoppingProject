package org.zerock.domain;

import java.util.List;

public class CartDTO {
	
	private int cartId;
	
	private String memberId;
	
	private int goodsId;
	
	private int goodsCount;
	
	//zero_goods
	private String goodsName;
	
	private int goodsPrice;
	
	//추가
	
	private int totalPrice;
	
	private int point;
	
	private int totalPoint;
	
	/* 상품 이미지 */
	private List<AttachImageVO> imageList;

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
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

	public int getTotalPrice() {
		return totalPrice;
	}


	public int getPoint() {
		return point;
	}

	public int getTotalPoint() {
		return totalPoint;
	}


	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}
	
	public void initSaleTotal() {
		this.goodsPrice = (int) (this.goodsPrice);
		this.totalPrice = this.goodsPrice * this.goodsCount;
		this.point = (int)(Math.floor(this.goodsPrice*0.05));
		this.totalPoint = this.point * this.goodsCount;
	}

	@Override
	public String toString() {
		return "CartDTO [cartId=" + cartId + ", memberId=" + memberId + ", goodsId=" + goodsId + ", goodsCount="
				+ goodsCount + ", goodsName=" + goodsName + ", goodsPrice=" + goodsPrice + ", totalPrice=" + totalPrice
				+ ", point=" + point + ", totalPoint=" + totalPoint + ", imageList=" + imageList + "]";
	}
	
	
}
