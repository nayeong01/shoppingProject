package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		"file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class MemberMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper membermapper;
	
	@Test
	public void memberJoin() throws Exception{
		
		MemberVO member = new MemberVO();
		
		member.setMemberId("test");			//회원 id
		member.setMemberPw("test");			//회원 비밀번호
		member.setMemberName("test");		//회원 이름
		member.setMemberMail("test");		//회원 메일
		member.setMemberAddr1("test");		//회원 우편번호
		member.setMemberAddr2("test");		//회원 주소
		member.setMemberAddr3("test");		//회원 상세주소
		member.setMemberTel("222-2222-2222"); //회원 전화번호
		
		membermapper.memberJoin(member);
	}
	/*
	@Test
	public void memberLogin() throws Exception{
		MemberVO member = new MemberVO();
		
		member.setMemberId("test1");
		member.setMemberPw("test1");
		
		membermapper.memberLogin(member);
		log.info("결과값 : " + membermapper.memberLogin(member));
	}
	*/
}
