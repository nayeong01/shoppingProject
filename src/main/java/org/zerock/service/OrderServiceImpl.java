package org.zerock.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.CartDTO;
import org.zerock.domain.GoodsVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderCancelDTO;
import org.zerock.domain.OrderDTO;
import org.zerock.domain.OrderItemDTO;
import org.zerock.domain.OrderListDTO;
import org.zerock.domain.OrderPageItemDTO;
import org.zerock.mapper.AttachMapper;
import org.zerock.mapper.CartMapper;
import org.zerock.mapper.GoodsMapper;
import org.zerock.mapper.MemberMapper;
import org.zerock.mapper.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private GoodsMapper goodsMapper;
	
	@Override
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders) {
		// TODO Auto-generated method stub
		
		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();
		
		for(OrderPageItemDTO ord : orders) {
			
			OrderPageItemDTO goodsInfo = orderMapper.getGoodsInfo(ord.getGoodsCode());
			
			goodsInfo.setGoodsCount(ord.getGoodsCount());
			
			goodsInfo.initSaleTotal();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(goodsInfo.getGoodsCode());
			
			goodsInfo.setImageList(imageList);
			
			result.add(goodsInfo);

		}
		
		return result;
	}

	@Override
	@Transactional
	public void order(OrderDTO ord) {
		
		//사용할 데이터 가져오기
		//회원 정보
		MemberVO member = memberMapper.getMemberInfo(ord.getMemberId());
		
		//주문정보
		List<OrderItemDTO> ords = new ArrayList<>();
		for(OrderItemDTO oit : ord.getOrders()) {
			OrderItemDTO orderItem = orderMapper.getOrderInfo(oit.getGoodsCode());
			//수량 세팅
			orderItem.setGoodsCount(oit.getGoodsCount());
			//기본정보 세팅
			orderItem.initSaleTotal();
			//List 객체 추가
			ords.add(orderItem);
			
			System.out.println(orderItem);
		}
		
		//OrderDTO 세팅
		ord.setOrders(ords);
		ord.getOrderPriceInfo();
		
		//DB 주문, 주문상품(배송정보) 넣기
		//orderId 만들기 및 OrderDTO 객체 orderId에 저장
		Date date =new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyyyMMddss");
		String orderId = member.getMemberId()+ format.format(date);
		ord.setOrderId(orderId);
		
		//DB 넣기
		orderMapper.enrollOrder(ord); //zero_order 등록
		for(OrderItemDTO oit : ord.getOrders()) { //zero_orderItem 등록
			oit.setOrderId(orderId);
			orderMapper.enrollOrderItem(oit);
		}
		
		//비용 포인트 변동 적용
		
		//비용 차감 & 변동 돈 Member 객체 적용
		int calMoney = member.getMoney();
		calMoney -=ord.getOrderFinalSalePrice();
		member.setMoney(calMoney);
		
		//포인트 차감, 포인트 증가 & 변동 포인트 Member 객체 적용
		int calPoint = member.getPoint();
		calPoint = calPoint - ord.getUsePoint()+ord.getOrderSavePoint();
		member.setPoint(calPoint);
		
		//변동 돈, 포인트 DB 적용
		orderMapper.deductMoney(member);
		
		//재고 변동 적용
		for(OrderItemDTO oit : ord.getOrders()) {
			//변동 재고 값 구하기
			GoodsVO goods = goodsMapper.getGoodsInfo(oit.getGoodsCode());
			goods.setGoodsStock(goods.getGoodsStock()-oit.getGoodsCount());
			//변동 DB 적용
			orderMapper.deductStock(goods);
		}
		
		//장바구니 제거
		for(OrderItemDTO oit : ord.getOrders()) {
			CartDTO dto = new CartDTO();
			dto.setMemberId(ord.getMemberId());
			dto.setGoodsId(oit.getGoodsCode());
			
			cartMapper.deleteOrderCart(dto);
		}

	}

	@Override
	@Transactional
	public void orderCancel(OrderCancelDTO dto) {
		// TODO Auto-generated method stub
		//주문, 주문 상품 객체
		
		//회원
		MemberVO member = memberMapper.getMemberInfo(dto.getMemberId());
		
		//주문상품
		List<OrderItemDTO> ords= orderMapper.getOrderItemInfo(dto.getOrderId());
		
		for(OrderItemDTO ord : ords) {
			ord.initSaleTotal();
		}
		
		//주문
		OrderDTO orw = orderMapper.getOrder(dto.getOrderId());
		orw.setOrders(ords);
		
		orw.getOrderPriceInfo();
		
		//주문상품 취소 DB
		orderMapper.orderCancel(dto.getOrderId());
		
		//돈, 포인트, 재고 변환
		//돈
		int calMoney = member.getMoney();
		calMoney += orw.getOrderFinalSalePrice();
		member.setMoney(calMoney);
		
		//포인트
		int calPoint = member.getPoint();
		calPoint = calPoint + orw.getUsePoint() - orw.getOrderSavePoint();
		member.setPoint(calPoint);
		
		//DB 적용
		orderMapper.deductMoney(member);
		
		//재고
		for(OrderItemDTO ord : orw.getOrders()) {
			GoodsVO goods = goodsMapper.getGoodsInfo(ord.getGoodsCode());
			goods.setGoodsStock(goods.getGoodsStock() + ord.getGoodsCount());
			orderMapper.deductStock(goods);
		}
	}
	
	@Override
	public List<OrderDTO> getOrderList(OrderDTO dto) throws Exception{
		// TODO Auto-generated method stub
		return orderMapper.getOrderList(dto);
	}

	@Override
	public List<OrderListDTO> orderView(OrderDTO dto) throws Exception{
		// TODO Auto-generated method stub
		return orderMapper.orderView(dto);
	}
	
	@Override
	public void memberDelete(String memberId) {
		// TODO Auto-generated method stub
		orderMapper.memberDelete(memberId);
	}

	@Override
	public void orderListDelete(String orderId) {
		// TODO Auto-generated method stub
		orderMapper.orderListDelete(orderId);
	}
}
