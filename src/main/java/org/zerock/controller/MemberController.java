package org.zerock.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.naver.NaverLoginBO;
import org.zerock.service.MemberService;

import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	//private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	//NaverLoginBO
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
		}
	
	//회원가입 페이지 이동
	@RequestMapping(value="join", method=RequestMethod.GET)
	public void loginGET(HttpSession session) {
		log.info("회원가입 페이지 진입");
	}
	
	//아이디 찾기 페이지 이동
	@RequestMapping(value = "search_id", method = RequestMethod.GET)
	public String search_id(HttpServletRequest request, Model model,
	        MemberVO searchVO) {
	    
	    log.info("아이디 찾기 페이지 진입");
	    return "/member/search_id";
	}
	
	//아이디 찾기
	@RequestMapping(value = "search_result_id", method=RequestMethod.POST)
	public String search_result_id(HttpServletRequest request, Model model, MemberVO searchVO,
			@RequestParam("memberName") String memberName,
			@RequestParam("memberTel") String memberTel
			) {
		
		try {
			
			searchVO.setMemberName(memberName);
			searchVO.setMemberTel(memberTel);
			MemberVO memberSearch = memberservice.memberIdSearch(searchVO);

			model.addAttribute("searchVO", memberSearch);
			
		} catch(Exception e) {
			System.out.println(e.toString());
			model.addAttribute("msg","오류가 발생하였습니다.");
		}
		
		return "/member/search_result_id";
	}
	 
	//비번 찾기 페이지 이동
	@RequestMapping(value = "search_pwd", method = RequestMethod.GET)
	public String search_pwd(HttpServletRequest request, Model model,
	        MemberVO searchVO) {
	    
	    log.info("비밀번호 찾기 페이지 진입");
	    return "/member/search_pwd";
	}
	
	//비밀번호 찾기
	@RequestMapping(value="search_result_pwd", method=RequestMethod.POST)
	public String search_result_pwd(HttpServletRequest request, Model model,
			@RequestParam(required = false, value="memberName") String memberName,
			@RequestParam(required = false, value="memberTel") String memberTel,
			@RequestParam(required= false, value="memberId") String memberId,
			MemberVO searchVO) {
		
		try {
			searchVO.setMemberName(memberName);
			searchVO.setMemberTel(memberTel);
			searchVO.setMemberId(memberId);
			
			int memberSearch = memberservice.memberPwdCheck(searchVO);
			
			if(memberSearch == 0) {
				model.addAttribute("msg", "기입된 정보가 잘못되었습니다.");
				return "/member/search_pwd";
			}
			
			String newPwd = RandomStringUtils.randomAlphanumeric(10);
			String encodePw = pwEncoder.encode(newPwd);
			searchVO.setMemberPw(encodePw);
			
			memberservice.passwordUpdate(searchVO);
			
			model.addAttribute("newPwd", newPwd);
			
		} catch(Exception e) {
			System.out.println(e.toString());
			model.addAttribute("msg", "오류가 발생되었습니다.");
		}
		
		return "/member/search_result_pwd";
	}
	
	
	//회원가입
	@RequestMapping(value="join", method = RequestMethod.POST)
	public String joinPOST(MemberVO member,HttpSession session) throws Exception {
		/*
		log.info("join 진입");		
		memberservice.memberJoin(member);
		log.info("join Service 성공");*/
		String rawPw = "";
		String encodePw = "";
		String naverLogin = "";
		
		rawPw = member.getMemberPw();
		naverLogin = member.getNaverLogin();
		encodePw = pwEncoder.encode(rawPw);
		member.setMemberPw(encodePw);
		
		if(naverLogin == "") {
		memberservice.memberJoin(member);
		return "redirect:/";
		
		} else {
			memberservice.insertN(member);
			MemberVO naverIdChk = memberservice.naverChk(member);
			session.setAttribute("member", naverIdChk);
			return "redirect:/";
		}
	}
	
	//로그인 페이지 이동
	@RequestMapping(value="login",method = {RequestMethod.GET,RequestMethod.POST})
	public String joinGET(Model model, HttpSession session) {
		log.info("로그인 페이지 진입");
		//네이버 아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
				
		System.out.println("네이버 : "+ naverAuthUrl);
				
		//네이버
		model.addAttribute("url",naverAuthUrl);
		
		return "/member/login";
	}
	
		//네이버 로그인 성공시 callback
		@RequestMapping(value = "/naver_success", method = { RequestMethod.GET, RequestMethod.POST })
		public String callbackNaver(Model model, @RequestParam String code, 
				@RequestParam String state, HttpSession session, HttpServletRequest request)
				throws Exception, ParseException  {
			
			System.out.println("로그인 성공 callbackNaver");
			
			OAuth2AccessToken oauthToken;
			oauthToken = naverLoginBO.getAccessToken(session, code, state);
			
			//1.로그인 사용자 정보를 읽어온다.
			apiResult = naverLoginBO.getUserProfile(oauthToken); //String 형식의 json 데이터
			log.info(apiResult);
			
			/** apiResult json 구조
			{"resultcode":"00",
			 "message":"success",
			 "response":{"id":"33666449","nickname":"shinn****",
			 			"age":"20-29","gender":"M","email":"sh@naver.com",
			 			"name":"\uc2e0\ubc94\ud638"}}
			**/
			
			//2. String 형식인 apiResult를 json형태로 바꿈
			JSONParser parser = new JSONParser();
			JSONObject jsonObject;
			
			jsonObject = (JSONObject) parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) jsonObject.get("response");
			
			//프로필 조희
			String naverId = (String)jsonObj.get("id");
			String naverNickname = (String)jsonObj.get("nickname");
			String naverEmail = (String)jsonObj.get("email");
			String naverTel = (String)jsonObj.get("mobile");
			
			//네이버 같은 경우 진짜 ID+@ 형식이기 때문에 문자열을 잘라서 id값을 추출하는 작업을 ㅍ\ㅕㄹ친다.
			String target = "@";
			int target_num = naverEmail.indexOf(target);
			//네이버 진짜 ID
			String newId = (String) naverEmail.substring(0,target_num);
			log.info(newId);
			
			MemberVO member = new MemberVO();
			member.setMemberId(newId);
			member.setMemberName(naverNickname);
			member.setMemberMail(naverEmail);
			member.setMemberTel(naverTel);
			member.setNaverLogin(naverId);
			
			log.info(naverTel);
			log.info(naverEmail);
			
			//네이버로 연동된 회원정보 찾기 =>[가입된 이메일] 또는 [네이버 고유번호 id]를 조회하여 비교
			MemberVO naverIdChk = memberservice.naverChk(member);
			//1. 홈페이지에 연동된 정보가 하나도 없을 때 => 회원가입 절차 진행
			if(naverIdChk == null) {
				session.setAttribute("user", member);
				session.setAttribute("msg", "가입된 계정이 없습니다. 회원가입 페이지로 이동합니다.");
				return "member/join";
				
			//2. 가입된 이메일은 있으나 네이버와의 연동이 안된경우
			} else if(naverIdChk.getNaverLogin() == null && naverIdChk.getMemberMail()!=null) {
				//2-1 가입된 계정에 네이버 연동 진행
				memberservice.updateN(member);
				//2-2 연동이 끝났으면 자동 로그인
				session.setAttribute("msg", "네이버 아이디와 연동이 완료되었습니다.");
				session.setAttribute("member", naverIdChk);	//session에 사용자의 정보 저장
				return "redirect:/";		//메인페이지 이동

			//3. 둘다 아니라면 네이버로 가입된 상태.
			} else {
				session.setAttribute("member", naverIdChk);		//session에 사용자의 정보 저장
				return "redirect:/";		//메인페이지 이동
		}
	}
			
	
	//아이디 중복 검사
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String memberId) throws Exception{
		log.info("memberIdChk() 진입");
		
		int result = memberservice.idCheck(memberId);
		
		log.info("결과값 = " + result);
		
		if(result != 0) {
			return "fail"; //중복 아이디가 존재
		}else {
			return "success";
		}
	}
	
	/* 이메일 인증 */
	@RequestMapping(value="/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public void mailCheckGET(String email) throws Exception{
		
		/* View로부터 넘어온 데이터 확인 */
		log.info("이메일 데이터 전송 확인");
		log.info("인증번호 : " + email);
	}
	
	/* 로그인 */
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginPost(
			HttpServletRequest request, 
			MemberVO member, 
			RedirectAttributes rttr) throws Exception{
		
		HttpSession session = request.getSession();
		String rawPw = "";
		String encodePw = "";
		
		MemberVO vo = memberservice.memberLogin(member);	//제출한 아이디와 일치하는 아이디 있는지
		
		if(vo != null) {		// 일치하는 아이디 존재시
			rawPw = member.getMemberPw();		//사용자가 제출한 비밀번호
			encodePw = vo.getMemberPw(); //데이터베이스에 저장한 인코딩된 비밀번호
			
			if(true == pwEncoder.matches(rawPw, encodePw)) { //비밀번호 일치여부 판단
				vo.setMemberPw("");		//인코딩된 비밀번호 정보 지움
				session.setAttribute("member", vo);		//session에 사용자의 정보 저장
				return "redirect:/";		//메인페이지 이동
			}else {
				rttr.addFlashAttribute("result",0);
				return "redirect:/member/login";		//로그인 페이지로 이동
			}
		}else {			//일치하는 아이디가 존재하지 않을시(로그인 실패)
			rttr.addFlashAttribute("result", 0);
			return "redirect:/member/login"; //로그인 페이지로 이동
		}
		/*log.info("login 메서드 진입");
		log.info("전달된 데이터 : " + member);
		HttpSession session = request.getSession();
		MemberVO vo = memberservice.memberLogin(member);
		
		if(vo == null) {
			int result = 0;
			rttr.addFlashAttribute("result", result);
			return "redirect:/member/login";
		}
		session.setAttribute("member", vo);
		
		return "redirect:/main";*/
	}
	
	/* 메인페이지 로그아웃 */
	@RequestMapping(value="logout.do", method= RequestMethod.GET)
	public String logoutMainGET(HttpServletRequest request) throws Exception{
		
		log.info("logoutMainGET 메서드 진입");
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	/* 비동기방식 로그아웃 메서드 */	
	@RequestMapping(value="logout.do", method=RequestMethod.POST)
	@ResponseBody
	public void logoutPOST(
			HttpServletRequest request) throws Exception{
		log.info("비동기 로그아웃 메서드 진입");
		
		HttpSession session = request.getSession();
		
		session.invalidate();
	}
	
	/* 회원정보 수정 페이지*/
	@RequestMapping(value="/updateMember", method = RequestMethod.GET)
	public String updateMember() {
		log.info("회원정보 수정 페이지 진입");
		return "member/updateMember";
	}
	
	/* 회원정보 수정 */
	@RequestMapping(value="/updateMember", method = RequestMethod.POST)
	public String registerUpdater(MemberVO modifyVO, HttpSession session) {
		log.info("회원정보 수정 진입");
		String rawPw = "";
		String encodePw = "";
		
		rawPw = modifyVO.getMemberPw();
		encodePw = pwEncoder.encode(rawPw);
		modifyVO.setMemberPw(encodePw);
		
		memberservice.updateMembers(modifyVO);
		session.invalidate();
		return "redirect:/";
	}
	

}
