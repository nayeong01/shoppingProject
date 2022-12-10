package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.CartDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		"file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartMapperTests {
	
	@Autowired
	private CartMapper mapper;
	
	/* 카트 추가 */
	@Test
	public void addCart() throws Exception {
		String memberId = "admin";
		int goodsId = 828;
		int count = 2;
		
		CartDTO cart = new CartDTO();
		cart.setMemberId(memberId);
		cart.setGoodsId(goodsId);
		cart.setGoodsCount(count);
		
		int result = 0;
		result = mapper.addCart(cart);
		
		System.out.println("결과 : " + result);
	}
	
	@Test
	public void deleteOrderCart() {
		String memberId = "admin";
		int goodsId = 8282;
		
		CartDTO dto = new CartDTO();
		dto.setMemberId(memberId);
		dto.setGoodsId(goodsId);
		
		mapper.deleteOrderCart(dto);
	}
}