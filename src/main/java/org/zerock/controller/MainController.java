package org.zerock.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.GoodsVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderDTO;
import org.zerock.domain.OrderListDTO;
import org.zerock.domain.PageDTO;
import org.zerock.domain.ReplyDTO;
import org.zerock.service.AttachService;
import org.zerock.service.GoodsService;
import org.zerock.service.OrderService;
import org.zerock.service.ReplyService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {
	
	@Autowired
	private AttachService attachService;
	
	@Autowired
	private GoodsService goodsService;	
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private OrderService orderService;
	
	//메인 페이지 이동
	@RequestMapping(value = "/", method = {RequestMethod.GET,RequestMethod.POST})
	public String mainPageGET(Model model,HttpServletRequest request){
		log.info("메인 페이지 진입");
		
		model.addAttribute("cate0", goodsService.getCateCode0());
		model.addAttribute("cate1", goodsService.getCateCode1());
		model.addAttribute("cate2", goodsService.getCateCode2());
		model.addAttribute("cate3", goodsService.getCateCode3());
		model.addAttribute("ls",goodsService.likeSelect());
		
		String path = request.getSession().getServletContext().getRealPath("/resources/img/upload/");
		System.out.println(path);
		return "main";
	
	}
	
	/* 이미지 출력 */
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName,HttpServletRequest request){
		
		String path = request.getSession().getServletContext().getRealPath("/resources/img/upload/");
		
		fileName = fileName.replace("\\", "/");
		
		log.info("fileName = " + fileName);
		
		File file = new File(path +fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			//FileCopyUtils : 파일과 stream 복사에 사용할 수 있는 메서드
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/* 이미지 정보 반환 */
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int goodsCode){
		
		log.info("getAttachList.........." + goodsCode);
		
		return new ResponseEntity<List<AttachImageVO>>(attachService.getAttachList(goodsCode), HttpStatus.OK);
		
	}
	
	/* 상품 검색 */
	@GetMapping("/search")
	public String searchGoodsGET(Criteria cri, Model model) {
		log.info("cri : " + cri);
		
		List<GoodsVO> list = goodsService.getGoodsList(cri);
		log.info("pre list : " + list);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			log.info("list : " + list);			
		}else {
			model.addAttribute("listcheck", "empty");
			model.addAttribute("cate0", goodsService.getCateCode0());
			model.addAttribute("cate1", goodsService.getCateCode1());
			model.addAttribute("cate2", goodsService.getCateCode2());
			model.addAttribute("cate3", goodsService.getCateCode3());
			return "search";
		}
		model.addAttribute("pageMaker", new PageDTO(cri, goodsService.goodsGetTotal(cri)));
		
		String[] typeArr = cri.getType().split("");
		
		for(String s : typeArr) {
			if(s.equals("T") || s.equals("C")) {
				model.addAttribute("filter_info", goodsService.getCateInfoList(cri));
			}
		}				
		
		model.addAttribute("cate0", goodsService.getCateCode0());
		model.addAttribute("cate1", goodsService.getCateCode1());
		model.addAttribute("cate2", goodsService.getCateCode2());
		model.addAttribute("cate3", goodsService.getCateCode3());
		
		return "search";
	}
	
	/* 상품 상세 */
	@GetMapping("/goodsDetail/{goodsCode}")
	public String goodsDetailGET(
			@PathVariable("goodsCode")int goodsCode,
			Model model) {
		log.info("goodsDetailGET()..........");
		
		model.addAttribute("goodsInfo", goodsService.getGoodsInfo(goodsCode));
		
		return "/goodsDetail";
	}
	
	/* 리뷰 쓰기 */
	@GetMapping("/replyEnroll/{memberId}")
	public String replyEnrollWindowGET(@PathVariable("memberId")String memberId, int goodsId, Model model) {
		GoodsVO goods = goodsService.getGoodsIdName(goodsId);
		model.addAttribute("goodsInfo", goods);
		model.addAttribute("memberId", memberId);
		
		return "/replyEnroll";
	}
	
	/* 리뷰 수정 팝업창 */
	@GetMapping("/replyUpdate")
	public String replyUpdateWindowGET(ReplyDTO dto, Model model) {
		GoodsVO goods = goodsService.getGoodsIdName(dto.getGoodsId());
		model.addAttribute("goodsInfo", goods);
		model.addAttribute("replyInfo", replyService.getUpdateReply(dto.getReplyId()));
		model.addAttribute("memberId", dto.getMemberId());
		
		return "/replyUpdate";
	}
	
	/* 마이페이지 주문 목록 */
	@GetMapping("/orderList")
	public void getOrderList(HttpSession session, OrderDTO dto, Model model) throws Exception{
		
		log.info("getOrderList...............");
			
		MemberVO member =(MemberVO)session.getAttribute("member");
		String memberId = member.getMemberId();
			
		dto.setMemberId(memberId);
			
		List<OrderDTO> orderList = orderService.getOrderList(dto);
			
		model.addAttribute("orderList", orderList);		
	}
		
	/* 주문 상세 목록 */
	@GetMapping("/orderView")
	public void OrderView (HttpSession session, @RequestParam("n") String orderId,
			OrderDTO dto, Model model) throws Exception {
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String memberId = member.getMemberId();
			
		log.info("get order View()................."+memberId);
			
		dto.setMemberId(memberId);
		dto.setOrderId(orderId);
			
		List<OrderListDTO> orderView = orderService.orderView(dto);
			
		model.addAttribute("orderView", orderView);
		
	}
}