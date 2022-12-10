package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper membermapper;
	
	/* 회원가입 */
	@Override
	public void memberJoin(MemberVO member) throws Exception{		
		membermapper.memberJoin(member);		
	}
	
	/* 아이디 중복 검사 */
	@Override
	public int idCheck(String memberId) throws Exception {		
		return membermapper.idCheck(memberId);
	}
	
	/* 로그인 */
	@Override
	public MemberVO memberLogin(MemberVO member) throws Exception{		
		return membermapper.memberLogin(member);
	}
	
	//아이디가 있는지 확인하고,
	@Override
	public MemberVO memberIdSearch(MemberVO searchVO) {
		// TODO Auto-generated method stub
		return membermapper.memberIdSearch(searchVO);
	}
	
	//있다면 비밀번호 변경해주기
	@Override
	public int memberPwdCheck(MemberVO searchVO) {
		// TODO Auto-generated method stub
		return membermapper.memberPwdCheck(searchVO);
	}

	@Override
	public void passwordUpdate(MemberVO searchVO) {
		// TODO Auto-generated method stub
		membermapper.passwordUpdate(searchVO);
	}

	@Override
	public MemberVO getMemberInfo(String memberId) {
		// TODO Auto-generated method stub
		return membermapper.getMemberInfo(memberId);
	}

	@Override
	public void insertN(MemberVO member) {
		// TODO Auto-generated method stub
		membermapper.insertN(member);
		
	}

	@Override
	public MemberVO naverChk(MemberVO member) {
		// TODO Auto-generated method stub
		return membermapper.naverChk(member);
	}

	@Override
	public void updateN(MemberVO member) {
		// TODO Auto-generated method stub
		membermapper.updateN(member);
	}
	
	@Override
	public void updateMembers(MemberVO modifyVO) {
		// TODO Auto-generated method stub
		membermapper.updateMembers(modifyVO);
	}

}
