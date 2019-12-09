package com.sp.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

// 로그인 성공 후 세션 및 쿠키 등의 처리를 위한 클래스
public class MyAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	@Autowired
	private MemberService service;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		HttpSession session = request.getSession();

		String userId = authentication.getName(); // 로그인 아이디

		try {
			// 로그인 날짜 변경
			service.updateLastLogin(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 로그인 정보를 세션에 저장
		Member dto = service.readMember(userId);
		SessionInfo info = new SessionInfo();
		info.setUserId(dto.getUserId());
		info.setUserName(dto.getUserName());

		session.setAttribute("member", info);

		super.onAuthenticationSuccess(request, response, authentication);
	}

}
