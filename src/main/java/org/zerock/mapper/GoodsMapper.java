package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.CateFilterDTO;
import org.zerock.domain.CateVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.GoodsVO;
import org.zerock.domain.SelectDTO;

public interface GoodsMapper {
	
	/* 상품 검색 */
	public List<GoodsVO> getGoodsList(Criteria cri);
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri);
	
	/* ALL 카테고리 리스트 */
	public List<CateVO> getCateCode0();
	
	/* 리빙 카테고리 리스트 */
	public List<CateVO> getCateCode1();
	
	/* 패션 카테고리 리스트 */
	public List<CateVO> getCateCode2();
	
	/* 뷰티 카테고리 리스트 */
	public List<CateVO> getCateCode3();
	
	/* 검색 대상 카테고리 리스트 */
	public String[] getCateList(Criteria cri);
	
	/* 카테고리 정보(+검색대상 갯수) */
	public CateFilterDTO getCateInfo(Criteria cri);
	
	//상품 정보
	public GoodsVO getGoodsInfo(int goodsCode);
	
	//평점순 상품 정보
	public List<SelectDTO> likeSelect();
	
	/* 상품 id 이름  */
	public GoodsVO getGoodsIdName(int goodsId);
}