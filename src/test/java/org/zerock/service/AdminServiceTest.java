package org.zerock.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.GoodsVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminServiceTest {
	
	@Autowired
	private AdminService service;
	
	//상품 등록 & 상품 이미지 등록 테스트
	@Test
	public void goodsEnrollTests() {
		
		GoodsVO goods = new GoodsVO();
		
		//상품 정보
		goods.setGoodsName("service 테스트");
		goods.setGoodsCate("100001");
		goods.setGoodsDetail("상세설명");
		goods.setGoodsPrice(10000);
		goods.setGoodsStock(20);
		
		//이미지 정보
		List<AttachImageVO> imageList = new ArrayList<AttachImageVO>();
		
		AttachImageVO image1 = new AttachImageVO();
		AttachImageVO image2 = new AttachImageVO();
		
		image1.setFileName("test Image 1");
		image1.setUploadPath("test image 1");
		image1.setUuid("test11111");
		
		image2.setFileName("test Image 2");
		image2.setUploadPath("test image 2");
		image2.setUuid("test222222");
		
		imageList.add(image1);
		imageList.add(image2);
		
		goods.setImageList(imageList);
		
		//goodsEnroll() 메서드 호출
		service.goodsEnroll(goods);
		
		System.out.println("등록된 VO : "+ goods);

	
	}

}
