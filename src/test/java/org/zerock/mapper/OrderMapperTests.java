package org.zerock.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.GoodsVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderDTO;
import org.zerock.domain.OrderItemDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		"file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class OrderMapperTests {

	@Autowired
	private OrderMapper mapper;
	
	@Test
	public void getOrderInfoTest() {
		
		OrderItemDTO orderInfo = mapper.getOrderInfo(8282);
		
		System.out.println("result : "+orderInfo);
		
	}
	
	@Test
	public void enrollOrderTest() {
		
		OrderDTO ord = new OrderDTO();
		List<OrderItemDTO> orders = new ArrayList();
		
		OrderItemDTO order1 = new OrderItemDTO();
		
		order1.setGoodsCode(8282);
		order1.setGoodsCount(3);
		order1.setGoodsPrice(17000);
		order1.initSaleTotal();
		
		ord.setOrders(orders);
		
		ord.setOrderId("2022_test1");
		ord.setAddressee("test");
		ord.setMemberId("admin");
		ord.setMemberAddr1("test");
		ord.setMemberAddr2("test");
		ord.setMemberAddr3("test");
		ord.setOrderState("배송준비");
		ord.getOrderPriceInfo();
		ord.setUsePoint(1000);
		
		mapper.enrollOrder(ord);
	}
	
	@Test
	public void enrollOrderItemTest() {
		OrderItemDTO oid = new OrderItemDTO();
		
		oid.setOrderId("2022_test1");
		oid.setGoodsCode(8282);
		oid.setGoodsCount(1);
		oid.setGoodsPrice(8000);
		oid.initSaleTotal();
		
		mapper.enrollOrderItem(oid);
	}
	
	@Test
	public void deductMoneyTest() {
		MemberVO member = new MemberVO();
		
		member.setMemberId("admin");
		member.setMoney(500000);
		member.setPoint(10000);
		
		mapper.deductMoney(member);
	}
	
	@Test
	public void deductStockTest() {
		GoodsVO goods = new GoodsVO();
		
		goods.setGoodsCode(8282);
		goods.setGoodsStock(54);
		
		mapper.deductStock(goods);
	}
	
}
