package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {
	
	//회원가입
	public void memberJoin(MemberVO member);
	
	/* 아이디 중복 검사 */
	public int idCheck(String memberId);
	
	/* 로그인 */
	public MemberVO memberLogin(MemberVO member);
	
	//아이디 찾기
	public MemberVO memberIdSearch(MemberVO searchVO);
	
	//등록된 아이디 있는지 확인
	public int memberPwdCheck(MemberVO searchVO);

	//새로운 비밀번호 보내주기
	public void passwordUpdate(MemberVO searchVO);
	
	//주문자 주소 정보
	public MemberVO getMemberInfo(String memberId);
	
	//네이버 전용 회원가입
	public void insertN(MemberVO member);
	
	//네이버 연동 여부
	public MemberVO naverChk(MemberVO member);
	
	//네이버 연동 업데이트
	public void updateN(MemberVO member);
	
	//회원정보 수정
	public void updateMembers(MemberVO modifyVO);
}
