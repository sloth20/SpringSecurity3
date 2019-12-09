package com.sp.member;

import java.util.List;

public interface MemberService {
	public Member readMember(String userId);
	
	public void insertMember(Member dto) throws Exception;
	
	public void updateMember(Member dto) throws Exception;
	public void updateLastLogin(String userId) throws Exception;
	
	public void deleteMember(String userId) throws Exception;
	
	public void insertAuthority(Member dto) throws Exception;
	public void updateAuthority(Member dto) throws Exception;
	public List<Member> listAuthority(String userId);
}
