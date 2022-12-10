package org.zerock.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.GoodsVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class GoodsServiceTests {

	@Autowired
	GoodsService service;
	
	@Test
	public void getCateInfoListTest1() {
		Criteria cri = new Criteria();
	
		String type = "TC";
		//String keyword = "테스트";
		String keyword = "테스트";	
		String cateCode="100001";

		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setCateCode(cateCode);
		
		System.out.println("List<CateFilterDTO> : " + service.getCateInfoList(cri));
		
	}
	
	@Test
	public void getCateInfoListTest3() {
		Criteria cri = new Criteria();
	
		String type = "T";
		String keyword = "테스트";
		//String keyword = "없음";	
		

		cri.setType(type);
		cri.setKeyword(keyword);
		
		System.out.println("List<CateFilterDTO> : " + service.getCateInfoList(cri));
		
	}
	
	/*상품 상세 정보*/
	@Test
	public void getGoodsInfoTest() {
		
		int GoodsId = 8324;
		
		GoodsVO goodsInfo = service.getGoodsInfo(GoodsId);
		
		System.out.println("==결과==");
		System.out.println("전체 : " + goodsInfo);
		System.out.println("GoodsId : " + goodsInfo.getGoodsCode() );
		System.out.println("이미지 정보 : " + goodsInfo.getImageList().isEmpty());
		
		
	}
}
