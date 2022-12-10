package org.zerock.domain;

public class OrderItemDTO {
	/*DB 데이터*/
	//주문 번호
	private String orderId;
	
	//상품 번호
	private int goodsCode;
	
	//주문 수량
	private int goodsCount;
	
	//zero_orderItem 기본키
	private int orderItemId;
	
	//상품 한 개 가격
	private int goodsPrice;
	
	//상품 한 개 구매 시 획득 포인트
	private int savePoint;
	
	
	/*DB에 없는 데이터*/
	
	//총가격(할인이 적용된 가격 * 주문 수량)
	private int totalPrice;
	
	//총 획득 포인트(상품 한 개 구매 시 획득 포인트 * 수량)
	private int totalSavePoint;

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
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

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getGoodsPrice() {
		return goodsPrice;
	}

	public void setGoodsPrice(int goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	public int getSavePoint() {
		return savePoint;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public int getTotalSavePoint() {
		return totalSavePoint;
	}

	public void initSaleTotal() {
		this.totalPrice = this.goodsPrice* this.goodsCount;
		this.savePoint = (int)(Math.floor(this.goodsPrice*0.05));
		this.totalSavePoint = this.savePoint * this.goodsCount;
	}

	@Override
	public String toString() {
		return "OrderItemDTO [orderId=" + orderId + ", goodsCode=" + goodsCode + ", goodsCount=" + goodsCount
				+ ", orderItemId=" + orderItemId + ", goodsPrice=" + goodsPrice + ", savePoint=" + savePoint
				+ ", totalPrice=" + totalPrice + ", totalSavePoint=" + totalSavePoint + "]";
	}
	
	
	
}
