package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.AttachImageVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminMapperTests {
	
	@Autowired
	private AdminMapper mapper;
	/*
	@Test
	public void goodsEnrollTest() throws Exception{
		
		GoodsVO goods = new GoodsVO();
		
		goods.setGoodsName("mapper");
		goods.setGoodsCate("100001");
		goods.setGoodsPrice(100);
		goods.setGoodsStock(30);
		goods.setGoodsDetail("mapper");
		
		System.out.println("Before GoodsVO : "+ goods);
		
		mapper.goodsEnroll(goods);
		
		System.out.println("After GoodsVO : "+ goods);
	}
	
	//카테고리 리스트
	@Test
	public void cateListTest() throws Exception{
		
		System.out.println("cateList()............."+mapper.cateList());
	}
	
	// 상품 리스트 & 상품 총 개수
	@Test
	public void goodsGetListTest() {
		Criteria cri = new Criteria();
		
		//검색 조건
		cri.setKeyword("수세미");
		
		//검색 리스트
		List list = mapper.goodsGetList(cri);
		for (int i=0; i < list.size(); i++) {
			System.out.println("result.........."+i+" : "+ list.get(i));
		}
		
		//상품 총 개수
		int result = mapper.goodsGetTotal(cri);
		System.out.println("result.........."+ result);
	}
	
	@Test
	public void goodsGetDetailtest() {
		
		int goodsCode = 150;
		
		GoodsVO result = mapper.goodsGetDetail(goodsCode);
		
		System.out.println("상품 조회 데이터: "+ result);
	}

	
	//상품 정보 수정
	@Test
	public void goodsModifyTest() {
		GoodsVO goods = new GoodsVO();
		
		goods.setGoodsCode(8222);
		goods.setGoodsName("mapperTest");
		goods.setGoodsCate("200001");
		goods.setGoodsDetail("테스트 입니다.");
		goods.setGoodsImage("테스트 입니다.");
		goods.setGoodsStock(32);
		
		mapper.goodsModify(goods);
	}
	
	
	@Test
	public void goodsDeleteTest() {
		
		int goodsCode = 8222;
		
		int result = mapper.goodsDelete(goodsCode);
		
		if(result == 1) {
			System.out.println("삭제 성공");
		}
	}
	
	
	@Test
	public void deleteImageAllTest() {
		
		int goodsCode = 8264;
		
		mapper.deleteImageAll(goodsCode);
	}
	
	
	@Test
	public void checkImageListTest() {
		
		mapper.checkFileList();
	}
	*/
	
	@Test
	public void getAttachInfoTest() {
		int goodsCode = 8264;
		
		List<AttachImageVO> list = mapper.getAttachInfo(goodsCode);
		
		System.out.println("list : "+ list);
	}
}
