package org.zerock.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.CateFilterDTO;
import org.zerock.domain.CateVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.GoodsVO;
import org.zerock.domain.SelectDTO;
import org.zerock.mapper.AdminMapper;
import org.zerock.mapper.AttachMapper;
import org.zerock.mapper.GoodsMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class GoodsServiceImpl implements GoodsService{
	
	@Setter(onMethod_ = @Autowired)
	private GoodsMapper goodsMapper;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	/* 상품 검색 */
	@Override
	public List<GoodsVO> getGoodsList(Criteria cri) {
		
		log.info("getGoodsList().......");
		
		String type= cri.getType();
		String[] typeArr = type.split("");
		
		List<GoodsVO> list = goodsMapper.getGoodsList(cri);
		
		list.forEach(goods -> {
			int goodsId = goods.getGoodsCode();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(goodsId);
			
			goods.setImageList(imageList);
			
		});
		
		return list;
	}
	
	/* 상품 총 갯수 */
	@Override
	public int goodsGetTotal(Criteria cri) {
		log.info("goodsGetTotal().......");
		
		return goodsMapper.goodsGetTotal(cri);
	}
	
	/* ALL 카테고리 리스트 */
	@Override
	public List<CateVO> getCateCode0() {
		log.info("getCateCode0().........");
		return goodsMapper.getCateCode0();
	}
	
	/* 리빙 카테고리 리스트 */
	@Override
	public List<CateVO> getCateCode1() {
		log.info("getCateCode1().........");
		return goodsMapper.getCateCode1();
	}
	
	/* 패션 카테고리 리스트 */
	@Override
	public List<CateVO> getCateCode2() {
		log.info("getCateCode2().........");
		return goodsMapper.getCateCode2();
	}
	
	/* 뷰티 카테고리 리스트 */
	@Override
	public List<CateVO> getCateCode3() {
		log.info("getCateCode3().........");
		return goodsMapper.getCateCode3();
	}
	
	/* 검색결과 카테고리 필터 정보 */
	@Override
	public List<CateFilterDTO> getCateInfoList(Criteria cri){
		
		List<CateFilterDTO> filterInfoList = new ArrayList<CateFilterDTO>();
		
		String[] typeArr = cri.getType().split("");
		
		String[] cateList = goodsMapper.getCateList(cri);
		
		String tempCateCode = cri.getCateCode();
		
		for(String cateCode : cateList) {
			cri.setCateCode(cateCode);
			CateFilterDTO filterInfo = goodsMapper.getCateInfo(cri);
			filterInfoList.add(filterInfo);
		}
		cri.setCateCode(tempCateCode);
		
		return filterInfoList;
	}
	
	/* 상품 정보 */
	@Override
	public GoodsVO getGoodsInfo(int goodsCode) {
		
		GoodsVO goodsInfo = goodsMapper.getGoodsInfo(goodsCode);
		goodsInfo.setImageList(adminMapper.getAttachInfo(goodsCode));
		
		return goodsInfo;
	}

	@Override
	public List<SelectDTO> likeSelect() {
		// TODO Auto-generated method stub
		List<SelectDTO> list = goodsMapper.likeSelect();
		
		list.forEach(dto->{
			int goodsCode = dto.getGoodsCode();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(goodsCode);
			
			dto.setImageList(imageList);
		});
		
		return list;
	}
	
	@Override
	public GoodsVO getGoodsIdName(int goodsId) {
		// TODO Auto-generated method stub
		return goodsMapper.getGoodsIdName(goodsId);
	}
}