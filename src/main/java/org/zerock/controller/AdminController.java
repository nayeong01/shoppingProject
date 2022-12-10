package org.zerock.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.GoodsVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderCancelDTO;
import org.zerock.domain.OrderDTO;
import org.zerock.domain.PageDTO;
import org.zerock.service.AdminService;
import org.zerock.service.CartService;
import org.zerock.service.MemberService;
import org.zerock.service.OrderService;
import org.zerock.service.ReplyService;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin")
@Log4j
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ReplyService replyService;	
	
	
	//관리자 메인페이지 이동
	@RequestMapping(value="main", method= RequestMethod.GET)
	public void adminMainGET() throws Exception{
		log.info("관리자 페이지 이동");
	}
	
	//상품 관리(상품목록) 페이지 접속
	@RequestMapping(value="/goodsManage", method=RequestMethod.GET)
	public void goodsManageGET(Criteria cri, Model model) throws Exception{
		
		log.info("상품 관리(상품목록) 페이지 접속");
		
		//상품 리스트 데이터
		List list = adminService.goodsGetList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list",list);
		}else {
			model.addAttribute("listCheck","empty");
		}
		
		//페이지 이동 인터페이스 데이터
		
		model.addAttribute("pageMaker", new PageDTO(cri, adminService.goodsGetTotal(cri)));
	}
	
	//첨부 파일 업로드
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile, HttpServletRequest request) {
		
		log.info("uploadAjaxActionPOST.............");
		
		//이미지 파일 체크
		for(MultipartFile multipartFile: uploadFile) {
			
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			
			try {
				type = Files.probeContentType(checkfile.toPath());
				log.info("MIME TYPE: "+ type);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (!type.startsWith("image")) {
				List<AttachImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}
		}//for
		
		String path = request.getSession().getServletContext().getRealPath("/resources/img/upload");
		
		String uploadFolder = path;
		
		//날짜 폴더 경로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //오늘 날짜를 지정된 형식으로  저장
		
		Date date = new Date();
		
		String str = sdf.format(date); //date 값을 format 메서드의 인자값으로 지정
		
		String datePath = str.replace("-", File.separator); //str의 '-'을 File.separator 로 변경
		
		//datePath = datePath.replace("\\", "/");
		
		//폴더 생성
		File uploadPath = new File(uploadFolder,datePath); //'upload\yyyy\MM\dd'경로의 디렉터리를 대상으로 하는 File 객체로 초기화
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs(); //폴더 생성
		}
		
		//이미지 정보 담는 객체
		List<AttachImageVO> list = new ArrayList();
		
		//향상된 for
		for(MultipartFile multipartFile : uploadFile) {
			
			//이미지 정보 객체
			AttachImageVO vo = new AttachImageVO();
			
			//파일 이름
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);
			
			//uuid 적용 파일 이름 : 같은 이름인 이미지가 덮어쓰이지 않게 랜덤으로 이름을 부여
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);
			
			uploadFileName = uuid + "_" + uploadFileName;
			
			//파일 위치, 파일 이름을 합친 File 객체
			File saveFile = new File(uploadPath, uploadFileName);
			
			//파일 저장
			try {
				multipartFile.transferTo(saveFile);
				
				File thumbnailFile = new File(uploadPath, "s_"+uploadFileName); // 썸네일 객체 이름 생성
				
				BufferedImage bo_image = ImageIO.read(saveFile); //버퍼드 타입의 이미지로 변경
				
				//비율
				double ratio = 3;
				
				//넓이 높이
				int width = (int) (bo_image.getWidth()/ratio);
				int height = (int) (bo_image.getHeight()/ratio);
				
				BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR); //넓이, 높이, 이미지 타입
				
				Graphics2D graphic = bt_image.createGraphics(); //썸네일에 그릴 객체 적용
				
				graphic.drawImage(bo_image, 0,0,width,height,null); // 썸네일에 원본 이미지 그리기
				
				ImageIO.write(bt_image, "jpg", thumbnailFile); // 만든 썸네일을 파일로 저장하기
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			list.add(vo);
			
			log.info("=======================================");
			log.info("파일 이름 : " + multipartFile.getOriginalFilename());
			log.info("파일 타입 : " + multipartFile.getContentType());
			log.info("파일 크기 : " + multipartFile.getSize());
		} //for
		
		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
		
		return result;
	}
	
	//이미지 파일 삭제
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName, HttpServletRequest request){
		log.info("deleteFile........." + fileName);
		
		File file = null;
		
		try {
			
			String path = request.getSession().getServletContext().getRealPath("/resources/img/upload/");
			
			//썸네일 파일 삭제
			file = new File(path +URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			//원본 파일 삭제
			String originalFileName = file.getAbsolutePath().replace("s_", "");
			
			log.info("originalFileName : " + originalFileName);
			
			file = new File(originalFileName);
			
			file.delete();
			
		} catch(Exception e) {
			e.printStackTrace();
			
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
			
		}//catch
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	//상품 등록 페이지 접속
	@RequestMapping(value="goodsEnroll", method=RequestMethod.GET)
	public void goodsEnrollGET(Model model) throws Exception{
		
		log.info("상품 등록 페이지 접속");
		
		ObjectMapper objm = new ObjectMapper();
		
		List list = adminService.cateList();
		
		String cateList = objm.writeValueAsString(list);
		
		model.addAttribute("cateList", cateList);
	}
	
	//상품 등록
	@PostMapping("/goodsEnroll")
	public String goodsEnrollPOST(GoodsVO goods, RedirectAttributes rttr) {
		
		log.info("상품 등록 POST........"+goods);
		log.info(goods.getGoodsCode());
		
		adminService.goodsEnroll(goods);
		
		rttr.addFlashAttribute("enroll_result", goods.getGoodsName());
		
		return "redirect:/admin/goodsManage";
	}
	
	//상품 조회 페이지
	@GetMapping({"/goodsDetail", "/goodsModify"})
	public void goodsGetInfoGET(int goodsCode, Criteria cri, Model model) throws JsonProcessingException {
		
		log.info("goodsGetInfo()................" + goodsCode);
		
		ObjectMapper mapper = new ObjectMapper();
		
		//카테고리 리스트 데이터
		model.addAttribute("cateList", mapper.writeValueAsString(adminService.cateList()));
		
		//목록 페이지 조건 정보 (조회하고 다시 목록 페이지로 돌아오기 위해서 가져옴)
		model.addAttribute("cri",cri);
		
		//조회 페이지 정보
		model.addAttribute("goodsInfo", adminService.goodsGetDetail(goodsCode));
	}
	
	//상품 정보 수정
	@PostMapping("/goodsModify")
	public String goodsModifyPOST(GoodsVO vo, RedirectAttributes rttr) {
		
		log.info("goodsmodifyPOST..............."+vo);
		
		int result = adminService.goodsModify(vo);
		
		rttr.addFlashAttribute("modify_result", result);
		
		return "redirect:/admin/goodsManage";
	}
	
	//상품 정보 삭제
	@PostMapping("/goodsDelete")
	public String goodsDeletePOST(int goodsCode, RedirectAttributes rttr, HttpServletRequest request) {
		log.info("goodsDeletePOST.............");
		
		List<AttachImageVO> fileList = adminService.getAttachInfo(goodsCode);
		
		if(fileList != null) {
			
			List<Path> pathList = new ArrayList();
			
			String path1 = request.getSession().getServletContext().getRealPath("/resources/img/upload");
			
			//원본이미지
			fileList.forEach(vo ->{
				
				Path path = Paths.get("path1", vo.getUploadPath(), vo.getUuid()+"_"+vo.getFileName());
				pathList.add(path);
			
			//썸네일 이미지
				path = Paths.get("path1", vo.getUploadPath(), "s_"+ vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);
			});	
			
			pathList.forEach(path ->{
				path.toFile().delete();
			});
			
		}
		
		int result = adminService.goodsDelete(goodsCode);
		
		rttr.addFlashAttribute("delete_result", result);
		
		return "redirect:/admin/goodsManage";
	}
	
	//주문 현황 페이지
	@GetMapping("/orderList")
	public String orderListGET(Criteria cri, Model model) {
		
		List<OrderDTO> list = adminService.getOrderList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck","empty");
		}
		
		//페이지 이동 인터페이스 데이터
		model.addAttribute("pageMaker", new PageDTO(cri, adminService.getOrderTotal(cri)));
		
		return "/admin/orderList";
	}
	
	//주문 삭제
	@PostMapping("/orderCancel")
	public String orderCancelPOST(OrderCancelDTO dto, HttpServletRequest request) {
		
		orderService.orderCancel(dto);
		
		MemberVO member = new MemberVO();
		member.setMemberId(dto.getMemberId());
		
		HttpSession session = request.getSession();
		
		
		try {
			MemberVO memberLogin = memberService.memberLogin(member);
			memberLogin.setMemberPw("");
			session.setAttribute("member", memberLogin);
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return "redirect:/admin/orderList?keyword="+ dto.getKeyword()+"&amount="+dto.getAmount()+"&pageNum="+dto.getPageNum();
	}
	
	//회원 리스트
	@RequestMapping(value="memberManage", method=RequestMethod.GET)
	public void memberManageGET(Criteria cri, Model model) throws Exception{
		
		log.info("회원 관리 페이지 접속.....................");
		
		//회원 목록 데이터
		List list = adminService.memberGetList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list",list);
			
		}else {
			model.addAttribute("listCheck","empty");
		}
		
		model.addAttribute("pageMaker", new PageDTO(cri, adminService.getMemberTotal(cri)));
	}
	
	
	//회원 수정 페이지
	@GetMapping("/memberModify")
		public void memberGetInfoGET(String memberId, Criteria cri, Model model) throws JsonProcessingException {
			
			log.info("memberGetInfo()................" + memberId);
			
			//목록 페이지 조건 정보 (조회하고 다시 목록 페이지로 돌아오기 위해서 가져옴)
			model.addAttribute("cri",cri);
			
			//조회 페이지 정보
			model.addAttribute("memberInfo", adminService.memberGetDetail(memberId));
		}
	
	//회원 정보 수정
		@PostMapping("/memberModify")
		public String memberModifyPOST(OrderCancelDTO dto, RedirectAttributes rttr) {
			
			log.info("membermodifyPOST..............."+dto);
			
			int result = adminService.memberModify(dto);
			
			rttr.addFlashAttribute("modify_result", result);
			
			return "redirect:/admin/memberManage";
		}
	
	//회원 삭제
		@PostMapping("/memberDelete")
		public String memberDeletePOST(OrderCancelDTO dto, HttpServletRequest request) {
			
			//카드 목록 지우기
			cartService.memberDelete(dto.getMemberId());
			
			//댓글 목록 지우기
			replyService.memberDelete(dto.getMemberId());
			
			//상세주문 지우기
			orderService.orderListDelete(dto.getOrderId());
			
			//주문 지우기
			orderService.memberDelete(dto.getMemberId());
			
			//회원 탈퇴
			adminService.memberDelete(dto.getMemberId());
			
			return "redirect:/admin/memberManage";
		}
	
	
}
