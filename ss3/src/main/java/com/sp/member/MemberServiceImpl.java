package com.sp.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO dao;

	@Override
	public Member readMember(String userId) {
		Member dto=null;
		try {
			dto=dao.selectOne("member.readMember", userId);
			
			if(dto!=null) {
				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			// 회원정보 저장
			dao.insertData("member.insertMember", dto);
			
			// 권한저장
			dto.setAuthority("ROLE_USER");
			dao.insertData("member.insertAuthority", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			dao.updateData("member.updateMember", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateLastLogin(String userId) throws Exception {
		try {
			dao.updateData("member.updateLastLogin", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteMember(String userId) throws Exception {
		try {
			dao.deleteData("member.deleteMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertAuthority(Member member) throws Exception {
		try {
			dao.insertData("member.insertAuthority", member);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateAuthority(Member dto) throws Exception {
		try {
			dao.updateData("member.updateAuthority", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Member> listAuthority(String userId) {
		List<Member> list=null;
		try {
			list=dao.selectList("member.listAuthority", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
