package org.zerock.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderDTO;
import org.zerock.domain.OrderPageDTO;
import org.zerock.service.MemberService;
import org.zerock.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/order/{memberId}")
	public String orderPageGET(@PathVariable("memberId") String memberId,  HttpServletRequest request,
								OrderPageDTO opd, Model model) throws Exception {
		
		log.info("orderPageGET()..................");
		
		model.addAttribute("orderList", orderService.getGoodsInfo(opd.getOrders()));
		model.addAttribute("memberInfo", memberService.getMemberInfo(memberId));
		
		return "/order";
		
	}
	
	@PostMapping("/order")
	public String orderPagePost(OrderDTO od, HttpServletRequest request,RedirectAttributes rttr) {
		
		System.out.println(od);
		
		orderService.order(od);
		
		MemberVO member = new MemberVO();
		member.setMemberId(od.getMemberId());
		
		rttr.addFlashAttribute("order_result", od.getMemberId());
		
		HttpSession session = request.getSession();
		
		try {
			MemberVO memberLogin = memberService.memberLogin(member);
			memberLogin.setMemberPw("");
			session.setAttribute("member", memberLogin);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/";
	}

}
