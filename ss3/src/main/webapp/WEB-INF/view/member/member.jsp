﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.help-block {
	margin-bottom: 5px;
}
</style>

<script type="text/javascript">
function memberOk() {
	var f = document.memberForm;
	var str;

	str = f.userId.value;
	str = str.trim(); // util.js에 만들어 놓은 trim() 함수
	if(!str) {
		alert("아이디를 입력하세요. ");
		f.userId.focus();
		return;
	}
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		alert("아이디는 5~10자이며 첫글자는 영문자이어야 합니다.");
		f.userId.focus();
		return;
	}
	f.userId.value = str;

	str = f.userPwd.value;
	str = str.trim();
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.userPwd.focus();
		return;
	}
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.userPwd.focus();
		return;
	}
	f.userPwd.value = str;

	if(str!= f.userPwdCheck.value) {
        alert("패스워드가 일치하지 않습니다. ");
        f.userPwdCheck.focus();
        return;
	}
	
    str = f.userName.value;
	str = str.trim();
    if(!str) {
        alert("이름을 입력하세요. ");
        f.userName.focus();
        return;
    }
    f.userName.value = str;

    str = f.birth.value;
	str = str.trim();
    if(!str || !isValidDateFormat(str)) {
        alert("생년월일를 입력하세요[YYYY-MM-DD]. ");
        f.birth.focus();
        return;
    }
    
    str = f.tel1.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel2.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel3.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel3.focus();
        return;
    }
    
    str = f.email.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email.focus();
        return;
    }

   	f.action = "<%=cp%>/member/${mode}";

    f.submit();
}

function userIdCheck() {
	// 아이디 중복 검사
	var userId=$("#userId").val();

	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) { 
		var str="아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.";
		$("#userId").focus();
		$("#userId").parent().next(".help-block").html(str);
		return;
	}
	
	var url="<%=cp%>/member/userIdCheck";
	var query="userId="+userId;
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"JSON"
		,success:function(data) {
			var passed=data.passed;

			if(passed=="true") {
				var str="<span style='color:blue;font-weight: bold;'>"+userId+"</span> 아이디는 사용가능 합니다.";
				$("#userId").parent().next(".help-block").html(str);
			} else {
				var str="<span style='color:red;font-weight: bold;'>"+userId+"</span> 아이디는 사용할수 없습니다.";
				$("#userId").parent().next(".help-block").html(str);
				$("#userId").val("");
				$("#userId").focus();
			}
		}
	});
}
</script>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><span style="font-family: Webdings">2</span> ${mode=="member"?"회원 가입":"회원 정보 수정"} </h3>
    </div>
    
	<div>
		     
        <div class="alert-info">
            <span style="font-family: Webdings; font-weight: 600;">m</span> SPRING의 회원이 되시면 회원님만의 유익한 정보를 만날수 있습니다.
        </div>
		     
		<form name="memberForm" method="post">
		  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
		 <tr>
		     <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
		           <label style="font-weight: 900;">아이디</label>
		     </td>
		     <td style="padding: 0 0 15px 15px;">
		       <p style="margin-bottom: 5px;">
		           <input type="text" name="userId" id="userId" value="${dto.userId}"
                         onchange="userIdCheck();" style="width: 95%;"
                         ${mode=="update" ? "readonly='readonly' ":""}
                         maxlength="15" class="boxTF" placeholder="아이디">
		       </p>
		       <p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
		     </td>
		 </tr>
		
		 <tr>
		     <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
		           <label style="font-weight: 900;">패스워드</label>
		     </td>
		     <td style="padding: 0 0 15px 15px;">
		       <p style="margin-bottom: 5px;">
		           <input type="password" name="userPwd" maxlength="15" class="boxTF"
		                      style="width:95%;" placeholder="패스워드">
		       </p>
		       <p class="help-block">패스워드는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
		     </td>
		 </tr>
		
		 <tr>
		     <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
		           <label style="font-weight: 900;">패스워드 확인</label>
		     </td>
		     <td style="padding: 0 0 15px 15px;">
		       <p style="margin-bottom: 5px;">
		           <input type="password" name="userPwdCheck" maxlength="15" class="boxTF"
		                      style="width: 95%;" placeholder="패스워드 확인">
		       </p>
		       <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
		     </td>
		 </tr>
		
		 <tr>
		     <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
		           <label style="font-weight: 900;">이름</label>
		     </td>
		     <td style="padding: 0 0 15px 15px;">
		       <p style="margin-bottom: 5px;">
		           <input type="text" name="userName" value="${dto.userName}" maxlength="30" class="boxTF"
		                       style="width: 95%;"
		                      ${mode=="update" ? "readonly='readonly' ":""}
		                      placeholder="이름">
		       </p>
		     </td>
		 </tr>
		
		 <tr>
		     <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
		           <label style="font-weight: 900;">생년월일</label>
		     </td>
		     <td style="padding: 0 0 15px 15px;">
		       <p style="margin-bottom: 5px;">
		           <input type="text" name="birth" value="${dto.birth}" maxlength="10" 
		                      class="boxTF" style="width: 95%;" placeholder="생년월일">
		       </p>
		       <p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
		     </td>
		 </tr>
		 
		 <tr>
		     <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
		           <label style="font-weight: 900;">이메일</label>
		     </td>
		     <td style="padding: 0 0 15px 15px;">
		       <p style="margin-bottom: 5px;">
		           <input type="text" name="email" value="${dto.email}" maxlength="50"
		                     class="boxTF" style="width: 95%;" placeholder="이메일">
		       </p>
		     </td>
		 </tr>
		 
		 <tr>
		     <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
		           <label style="font-weight: 900;">전화번호</label>
		     </td>
		     <td style="padding: 0 0 15px 15px;">
		       <p style="margin-bottom: 5px;">
		           <select class="selectField" id="tel1" name="tel1" >
		               <option value="">선 택</option>
		               <option value="010" ${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
		               <option value="011" ${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
		               <option value="016" ${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
		               <option value="017" ${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
		               <option value="018" ${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
		               <option value="019" ${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
		           </select>
		           -
		           <input type="text" name="tel2" value="${dto.tel2}" class="boxTF" maxlength="4">
		           -
		           <input type="text" name="tel3" value="${dto.tel3}" class="boxTF" maxlength="4">
		       </p>
		     </td>
		 </tr>
		 
		 <c:if test="${mode=='member'}">
		  <tr>
		      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
		            <label style="font-weight: 900;">약관동의</label>
		      </td>
		      <td style="padding: 0 0 15px 15px;">
		        <p style="margin-top: 7px; margin-bottom: 5px;">
		             <label>
		                 <input id="agree" name="agree" type="checkbox" checked="checked"
		                      onchange="form.sendButton.disabled = !checked"> <a href="#">이용약관</a>에 동의합니다.
		             </label>
		        </p>
		      </td>
		  </tr>
		 </c:if>
		 </table>
		
		 <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		    <tr height="45"> 
		     <td align="center" >
		       <button type="button" name="sendButton" class="btn" onclick="memberOk();">${mode=="member"?"회원가입":"정보수정"}</button>
		       <button type="reset" class="btn">다시입력</button>
		       <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/';">${mode=="member"?"가입취소":"수정취소"}</button>
		     </td>
		   </tr>
		   <tr height="30">
		       <td align="center" style="color: blue;">${message}</td>
		    </tr>
		  </table>
		</form>
	</div>

</div>
