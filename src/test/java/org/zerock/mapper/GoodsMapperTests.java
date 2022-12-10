package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.CateFilterDTO;
import org.zerock.domain.Criteria;
import org.zerock.domain.GoodsVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class GoodsMapperTests {
	
	@Autowired
	private GoodsMapper mapper;
	
	@Test
	public void getGoodsListTest() {
		
		Criteria cri = new Criteria();
		// 테스트 키워드
		//cri.setKeyword("test");
		System.out.println("cri : " + cri);
		
		List<GoodsVO> list = mapper.getGoodsList(cri);
		System.out.println("list : " + list);
		
		System.out.println("==========");
		int goodsTotal = mapper.goodsGetTotal(cri);
		System.out.println("totla : " + goodsTotal);
		
	}
	
	@Test
	public void getGoodsListTest1() {		
		Criteria cri = new Criteria();		
		String type = "T";
		String keyword = "수세미";		//테이블에 등록된 제품 이름 데이터
		String catecode = "";
		
		cri.setType(type);
		cri.setKeyword(keyword);		
		cri.setCateCode(catecode);
		
		List<GoodsVO> list = mapper.getGoodsList(cri);
		
		System.out.println("cri : " + cri);
		System.out.println("list : " + list);
	}
	
	@Test 
	public void getGoodsListTest2() {
		Criteria cri = new Criteria();
		String type = "C";
		String keyword = "";
		String catecode = "100003";		
		
		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setCateCode(catecode);
		
		List<GoodsVO> list = mapper.getGoodsList(cri);
		
		System.out.println("cri : " + cri);
		System.out.println("list : " + list);
	}
	
	@Test 
	public void getGoodsListTest3() {
		Criteria cri = new Criteria();
		String type = "CT";			// 카테고리에 존재하는 책
		String keyword = "테스트";	// 카테고리에 존재하지 않는 책
		//String keyword = "없음";
		String catecode = "100001";
		
		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setCateCode(catecode);
		
		List<GoodsVO> list = mapper.getGoodsList(cri);
		
		System.out.println("cri : " + cri);
		System.out.println("list : " + list);	
		
	}
	
	@Test
	public void getCateListTest1() {
		
		Criteria cri = new Criteria();
		
		String type = "TC";
		String keyword = "수세미";
		//String type = "A";
		//String keyword = "유홍준";		

		cri.setType(type);
		cri.setKeyword(keyword);
		//cri.setAuthorArr(mapper.getAuthorIdList(keyword));		
		
		String[] cateList = mapper.getCateList(cri);
		for(String codeNum : cateList) {
			System.out.println("codeNum ::::: " + codeNum);
		}
		
		
	}
	
	@Test
	public void getCateInfoTest1() {
		
		Criteria cri = new Criteria();
		
		String type = "TC";
		String keyword = "수세미";	
		String cateCode="100002";

		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setCateCode(cateCode);
		
		CateFilterDTO result = mapper.getCateInfo(cri);

		System.out.println(result);
		
		
	}
	
}
