<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=cp%>/loginPage/data/login.css" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

<script type="text/javascript">

function login() {
	
	f = document.myForm;
	
	str = f.user_id.value;
	str = str.trim();
    if(!str) {
        alert("\n아이디를 입력하세요. ");
        f.user_id.focus();
        return;
    }
	f.user_id.value = str;
	
	str = f.user_pwd.value;
	str = str.trim();
    if(!str) {
        alert("\n비밀번호를 입력하세요. ");
        f.user_pwd.focus();
        return;
    }
	f.user_pwd.value = str;
	
	f.action = "<%=cp%>/Login/login_ok.do";
	
	f.submit();
	
}


</script>

<title>로그인</title>
</head>
<body>

<!-- header 추가 -->
<jsp:include page="../header.jsp" flush="false"/>

<div id="login">

<div style="clear: both;">
<img src="<%=cp %>/loginPage/image/megabox.JPG"><br/><br/>
<span>MEGABOX</span>에 오신것을 환영합니다.
</div>

<div style="clear: both">
<br/><br/>
</div>

<span>MEGABOX</span> 로그인
<br/><br/>

<form action="" name="myForm">
<table align="center">
	<tr>
		<td><input type="text" name="user_id" class="boxTX" placeholder="아이디"></td>
		<td rowspan="2"><input type="button" value="로그인" class="btn" onclick="login();"></td>
	</tr>
	<tr>
		<td><input type="password" name="user_pwd" class="boxTX" placeholder="비밀번호"></td>
	</tr>
	<tr>
		<td align="left"><font color="red" size="2"><b>${message}</b></font></td>
	</tr>
	<tr>
		<td colspan="2"><br/>
		<a href="<%=cp %>/Login/register.do">회원가입</a>&nbsp;&nbsp;&nbsp; 
		<a href="<%=cp %>/Login/findUser.do">ID/PW찾기</a>
		</td>
	</tr>

</table>
</form>

</div>

<!-- footer추가 -->
<jsp:include page="../footer.jsp" flush="false"/>


</body>
</html>