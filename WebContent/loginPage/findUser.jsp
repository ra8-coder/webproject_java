<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<title>아이디/비밀번호 찾기</title>

<script type="text/javascript">
	
	function find_id() {
		
		f = document.findID;
		
		if(!f.user_name.value){
			alert("이름을 입력하세요!");
			f.user_name.focus();
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
		
		f.birth.value = f.year.value + "-" + f.month.value + "-" + f.day.value;
		f.tel.value = f.tel1.value + "-" + f.tel2.value + "-" + f.tel3.value

		f.action = "<%=cp%>/Login/findUser_id.do";
		f.submit();
		
	}
	

	function find_pw() {
		
		f = document.findPW;
		
		if(!f.user_id.value){
			alert("아이디를 입력하세요!");
			f.user_id.focus();
			return;
		}	
		
		if(!f.user_name.value){
			alert("이름을 입력하세요!");
			f.user_name.focus();
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
		
		f.tel.value = f.tel1.value + "-" + f.tel2.value + "-" + f.tel3.value

		f.action = "<%=cp%>/Login/findUser_pw.do";
		f.submit();
	}


</script>

</head>
<body>
<jsp:include page="../header.jsp" flush="false"/>

<div id="find">

<div style="clear: both; margin-left: 50px">
	<div style="clear: both;">
	<br/><br/><br/>
		<span class="title2">아이디 / 비밀번호 찾기</span> 
		<br/><br/>
	</div>

	<div style="float: left; width: 400px; margin-right: 20px">
	
	<form action="" name="findID"  method="post"><br/>
	<table class="info">
	<tr>
		<th colspan="2" width="400px"><b>아이디 찾기</b>
		</th>
	</tr>
	<tr>
		<td width="100px">이름
		</td>
		<td><input type="text" class="boxTX" name="user_name">
		</td>
	</tr>
	<tr>
		<td>법정 생년월일
		</td>
		<td>
		<input type="text" style="width: 50px" maxlength="4" name="year" value="<c:out value="${fn:substring(member.getBirth(),0,fn:length(member.getBirth())-6) }"></c:out>">년&nbsp;&nbsp; 
		<input type="text" style="width: 40px" maxlength="2" name="month" value="<c:out value="${fn:substring(member.getBirth(),fn:length(member.getBirth())-5,fn:length(member.getBirth())-3) }"></c:out>">월&nbsp;&nbsp; 
		<input type="text" style="width: 40px" maxlength="2" name="day" value="<c:out value="${fn:substring(member.getBirth(),fn:length(member.getBirth())-2,fn:length(member.getBirth())) }"></c:out>">일
		<input type="hidden" value="" name="birth">
		</td>
	</tr>
	<tr>
		<td>휴대폰
		</td>
		<td>
		<input type="text" style="width: 50px" maxlength="3" name="tel1" value="<c:out value="${fn:substring(member.getTel(),0,fn:length(member.getTel())-10) }"></c:out>">&nbsp;-&nbsp;
		<input type="text" style="width: 50px" maxlength="4" name="tel2" value="<c:out value="${fn:substring(member.getTel(),fn:length(member.getTel())-9,fn:length(member.getTel())-5) }"></c:out>">&nbsp;-&nbsp;
		<input type="text" style="width: 50px" maxlength="4" name="tel3" value="<c:out value="${fn:substring(member.getTel(),fn:length(member.getTel())-4,fn:length(member.getTel())) }"></c:out>">
		<input type="hidden" value="" name="tel">
		</td>
	</tr>
	<tr>
		<td colspan="2"><span style="float: right;"><input type="button" value="확인" class="btn2" onclick="find_id();"></span></td>
	</tr>
	</table>
	</form>
	</div>
	
	<div style="float: left; width: 400px;margin-left: 20px">
	<form action="" name="findPW"  method="post"><br/>
	<table class="info">
	<tr>
		<th colspan="2" width="400px"><b>비밀번호 찾기</b>
		</th>
	</tr>
	<tr>
		<td width="100px">아이디</td>
		<td><input type="text" class="boxTX" name="user_id"></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input type="text" class="boxTX" name="user_name"></td>
	</tr>
	<tr>
		<td>휴대폰
		</td>
		<td>
		<input type="text" style="width: 50px" maxlength="3" name="tel1" value="<c:out value="${fn:substring(member.getTel(),0,fn:length(member.getTel())-10) }"></c:out>">&nbsp;-&nbsp;
		<input type="text" style="width: 50px" maxlength="4" name="tel2" value="<c:out value="${fn:substring(member.getTel(),fn:length(member.getTel())-9,fn:length(member.getTel())-5) }"></c:out>">&nbsp;-&nbsp;
		<input type="text" style="width: 50px" maxlength="4" name="tel3" value="<c:out value="${fn:substring(member.getTel(),fn:length(member.getTel())-4,fn:length(member.getTel())) }"></c:out>">
		<input type="hidden" value="" name="tel">
		</td>
	</tr>
	<tr>
		<td colspan="2"><span style="float: right;"><input type="button" value="확인" class="btn2" onclick="find_pw();"></span></td>
	</tr>
	</table>
	</form>
</div>

<div style="clear: both;"></div>
<div style="clear: both"><br/>
	<font size="3" color="#351f66" style="font-weight: bold;">${message }</font></div>
</div>
<div style="clear: both;text-align: center;"><input type="button" value="돌아가기" class="btn3" onclick="<%=cp %>"></div>
</div>
<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>