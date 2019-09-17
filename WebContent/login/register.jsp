<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	//POST 방식에서 한글깨짐을 방지
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=cp%>/login/css/register.css"
	type="text/css" />
<title>회원 가입</title>
</head>
<jsp:include page="../header.jsp" flush="false" />
<body>
	<div id="title">회원가입</div>


<form  method="post" name="myForm">
	<div id="register">
		<div style="clear: both;">
			<br />
			<div style="clear: both;">
				<span class="title2">회원가입</span> &nbsp;&nbsp;&nbsp; 회원님의 정보를 정확히
				입력해주세요. <br /> <br />
			</div>
			<font color="#666">*표시 항목은 필수입력 항목입니다.</font> <br /> <br />
			
			<div>
				<table class="info">
					<tr>
						<th colspan="2"><b>기본정보 (필수입력)</b></th>
					</tr>
					<tr>
						<td>* 아이디</td>
						<td><input type="text" value="" name="id"
							style="width: 150px"></td>
					</tr>
					<tr>
						<td width="150px">* 비밀번호</td>
						<td><input type="password" name="pwd" style="width: 150px"></td>
					</tr>
					<tr>
						<td>* 이름</td>
						<td><input type="text" value="" name="name"
							style="width: 150px"></td>
					</tr>
					<tr>
						<td>* 생년월일</td>
						<td><input type="text" style="width: 50px" maxlength="4"
							name="year" value="">년&nbsp;&nbsp; <input type="text"
							style="width: 40px" maxlength="2" name="month" value="">월&nbsp;&nbsp;
							<input type="text" style="width: 40px" maxlength="2"
							name="day" value="">일</td>
					</tr>
					<tr>
						<td>* 휴대폰</td>
						<td><input type="text" style="width: 50px" maxlength="3"
							name="tel1" value="">&nbsp;-&nbsp; <input type="text"
							style="width: 50px" maxlength="4" name="tel2" value="">&nbsp;-&nbsp;
							<input type="text" style="width: 50px" maxlength="4" name="tel3"
							value=""></td>
					</tr>
					<tr>
						<td>* 이메일</td>
						<td><input type="text" value="" name="email"
							style="width: 180px"></td>
					</tr>
				</table>


				<table class="info">
					<tr>
						<th colspan="2">부가정보 (선택입력)</th>
					</tr>
					<tr>
						<td width="150px">주소</td>
						<td><input type="text" name="addr"></td>
					</tr>
				</table>
			</div>
			<div align="center" style="margin-top: 50px">
				<input type="hidden" value="aaa" name="birth">
				<input type="hidden" value="aaa" name="tel">
				<input type="button" value="확인" class="btn1" onclick="sendIt();">
				<input type="button" value="취소" class="btn1" onclick="javascipt:location.href='<%=cp %>/Login/login.do'">
			</div>
		</div>

	</div>
</form>


<script type="text/javascript">

function sendIt() {
	
	f = document.myForm;
	
	if(!f.id.value){
		alert("아이디를 입력하세요!");
		f.id.focus();
		return;
	}
	
	if(!f.pwd.value){
		alert("비밀번호를 입력하세요!");
		f.pwd.focus();
		return;
	}
	
	if(!f.name.value){
		alert("이름을 입력하세요!");
		f.name.foucs();
		return;	
	}
	
	if(!f.year.value){
		alert("생년월일을 입력하세요!");
		f.year.foucs();
		return;	
	}
	
	if(!f.month.value){
		alert("생년월일을 입력하세요!");
		f.month.foucs();
		return;	
	}
	
	
	if(!f.day.value){
		alert("생년월일을 입력하세요!");
		f.day.foucs();
		return;	
	}
	
	if(!f.tel1.value){
		alert("휴대폰 번호를 입력하세요!");
		f.tel1.foucs();
		return;	
	}
	
	if(!f.tel2.value){
		alert("휴대폰 번호를 입력하세요!");
		f.tel2.foucs();
		return;	
	}
	
	if(!f.tel3.value){
		alert("휴대폰 번호를 입력하세요!");
		f.tel3.foucs();
		return;	
	}
	
	if(!f.email.value){
		alert("이메일을 입력하세요!");
		f.email.foucs();
		return;	
	}
	
	f.birth.value = f.year.value + "-" + f.month.value + "-" + f.day.value;
	f.tel.value = f.tel1.value + "-" + f.tel2.value + "-" + f.tel3.value

	f.action = "<%=cp%>/Login/register_ok.do";
	f.submit();
	
}

</script>
</body>



<jsp:include page="../footer.jsp" flush="false" />
</html>