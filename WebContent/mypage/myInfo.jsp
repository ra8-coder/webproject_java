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
<link rel="stylesheet" href="<%=cp%>/mypage/css/mypage.css" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<title>나의 메가박스</title>

<script type="text/javascript">
	
	function itemChange() {
		
		var seoul = ["강남","강동"];
		var kyung = ["김포","영통"];
		
		var selectItem = $('#city').val();
		
		var changeItem;
		
		if(selectItem == "서울"){
			changeItem = seoul;
		}
		
		else if(selectItem == "경기"){
			changeItem = kyung;
		}
		
		$('#district').empty();
		
		for(var count = 0; count < changeItem.length; count++){
			
			var option = $("<option>"+changeItem[count]+"</option>")
			$('#district').append(option);
		}
	}
	
	function sendIt(user_pwd) {
		
		f = document.myForm;
		
		if(!f.user_pwd.value){
			alert("비밀번호를 입력하세요!");
			f.user_pwd.focus();
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
			alert("휴대폰 번호를 입력하세요!");
			f.email.foucs();
			return;	
		}
		
		if(!(f.user_pwd.value==user_pwd)){
			alert("비밀번호가 틀립니다!");
			f.user_pwd.focus();
			return;
		}
		
		f.birth.value = f.year.value + "-" + f.month.value + "-" + f.day.value;
		f.tel.value = f.tel1.value + "-" + f.tel2.value + "-" + f.tel3.value

		f.action = "<%=cp%>/Mypage/myInfo_ok.do";
		f.submit();
		
	}
	
	function delImage(file_name) {
		
		if(file_name==null){
			
			alert("등록된 프로필 사진이 없습니다.");
			return;
		}
		else{
			
			f = document.myForm;

			if(confirm("프로필 사진을 삭제하시겠습니까?") == true){
	
				f.action = "<%=cp%>/Mypage/list/delImage_ok.do";
					
				f.submit();

			}else{
				return;
			}		
		}
	}


</script>



</head>
<body>
<jsp:include page="../header.jsp" flush="false"/>
<div id="mypage">

<div style="clear: both;background-color: #f8f8f8; line-height: 20px; border-bottom: #352669 2px solid;padding-left: 20px; padding-right: 40px;">
<span class="font"><a href="<%=cp%>/Mypage/mypageMain.do"><br/>나의 메가박스</a>
<span class="right"><input type="button" class="btn1" value="로그아웃" onclick="javascript:location.href='<%=cp%>/Login/log_out.do';"></span>
<br/>&nbsp;<br/></span>
</div>

<br/>
<div>
	<ul class="nav_gnb">     	
		<li>
           <a href="<%=cp%>/Mypage/myBooking.do"><img src="<%=cp%>/mypage/image/res.JPG" alt=""/><span>예매 확인/취소</span></a>
        </li>
        <li>
           <a href="<%=cp%>/Mypage/myMoivestory.do?linkpage=interestingList"><img src="<%=cp%>/mypage/image/moviestory.JPG" alt=""/><span>나의 무비스토리</span></a>
        </li>
        <li>
           <a href="<%=cp%>/Mypage/myInfo.do"><img src="<%=cp%>/mypage/image/update.JPG" alt=""/><span>개인정보수정</span></a>
        </li>
    </ul>
</div>
<br/><br/>
</div>


<div id="mypage">

<div style="clear: both;">
<form action="" name="myForm"  method="post" enctype="multipart/form-data">
	<br/>
<div style="clear: both;">
	<span class="title2">개인정보 수정</span> &nbsp;&nbsp;&nbsp; 회원님의 정보를 정확히 입력해주세요.
	<br/><br/>
</div>
<font color="#666">*표시 항목은 필수입력 항목입니다.</font>
<span class="right"><input type="button" class="btn2" value="비밀번호 변경" width="120px" onclick="javascipt:location.href='<%=cp%>/Mypage/updatePwd.do'"> 
	<input type="button" value="회원탈퇴" class="btn1" name="cancelMember" onclick="javascipt:location.href='<%=cp%>/Mypage/cancelMember.do'"></span>
<br/><br/>
<div>
<table height="120px">
	<tr>		
		<c:if test="${empty member.getFile_name()}">
		<td rowspan="2">
		<img class="radius" src="<%=cp%>/mypage/image/profile_m.png" align="middle" width="100px" height="100px"/>
		</td>
		</c:if>
		<c:if test="${!empty member.getFile_name()}">
		<td rowspan="2">
		<img class="radius" src="<%=cp%>/memberImages/${member.getFile_name()}" align="middle" width="100px" height="100px">
		</td>
		</c:if>
		<td style="text-align: center;"><b>${member.getUser_id() }</b><br/><br/>
		<div class="filebox">
		<label for="file_upload">찾아보기</label>
		<input type="file" value="찾아보기" name="file_name" id="file_upload">
		</div>
		<input type="button" value="삭제" class="btn5" onclick="delImage('${member.getFile_name()}');">
		</td>
	</tr>
</table>
</div>
<div style="clear: both;">
<table class="info">
	<tr>
		<th colspan="2"><b>기본정보 (필수입력)</b>
		</th>
	</tr>
	<tr>
		<td width="150px">* 비밀번호 
		</td>
		<td><input type="password" style="width: 150px" name="user_pwd">
		</td>
	</tr>
	<tr>
		<td>* 이름
		</td>
		<td>${member.getUser_name() }
		</td>
	</tr>
	<tr>
		<td>* 생년월일
		</td>
		<td>
		<input type="text" style="width: 50px" maxlength="4" name="year" value="<c:out value="${fn:substring(member.getBirth(),0,fn:length(member.getBirth())-6) }"></c:out>">년&nbsp;&nbsp; 
		<input type="text" style="width: 40px" maxlength="2" name="month" value="<c:out value="${fn:substring(member.getBirth(),fn:length(member.getBirth())-5,fn:length(member.getBirth())-3) }"></c:out>">월&nbsp;&nbsp; 
		<input type="text" style="width: 40px" maxlength="2" name="day" value="<c:out value="${fn:substring(member.getBirth(),fn:length(member.getBirth())-2,fn:length(member.getBirth())) }"></c:out>">일
		<input type="hidden" value="" name="birth">
		</td>
	</tr>
	<tr>
		<td> * 휴대폰
		</td>
		<td>
		<input type="text" style="width: 50px" maxlength="3" name="tel1" value="<c:out value="${fn:substring(member.getTel(),0,fn:length(member.getTel())-10) }"></c:out>">&nbsp;-&nbsp;
		<input type="text" style="width: 50px" maxlength="4" name="tel2" value="<c:out value="${fn:substring(member.getTel(),fn:length(member.getTel())-9,fn:length(member.getTel())-5) }"></c:out>">&nbsp;-&nbsp;
		<input type="text" style="width: 50px" maxlength="4" name="tel3" value="<c:out value="${fn:substring(member.getTel(),fn:length(member.getTel())-4,fn:length(member.getTel())) }"></c:out>">
		<input type="hidden" value="" name="tel">
		</td>
	</tr>
	<tr>
		<td> * 이메일 
		</td>
		<td><input type="text" name="email" value="${member.getEmail() }" style="width: 180px">
		</td>
	</tr>
</table>
</div>

<div style="height: 30px; clear: both;"></div>

<div style="clear: both;">
<table class="info">
	<tr>
		<th colspan="2">부가정보 (선택입력)</th>
	</tr>
	<tr>
		<td width="150px"> 주소 
		</td>
		<td><input type="text" style="width: 250px" name="addr" value="${member.getAddr() }">
		</td>
	</tr>
	<tr>
		<td> 선호영화관
		</td>
		<td>
			<c:if test="${empty preferredTheater}">
				현재 : 없음&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</c:if>
			<c:if test="${!empty preferredTheater}">
				현재 : ${preferredTheater }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</c:if>
			
		
			<select id="city" onchange="itemChange();" name="city">
				<option value="">선택</option>
				<option value="서울">서울</option>
				<option value="경기">경기</option>	
			</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select id="district" name="district">
			</select>
		</td>
	</tr>
</table>
</div>
</form>
</div>


<div align="center">
<br/><br/><br/>
<input type="button" value="취소" class="btn3" onclick="javascipt:location.href='<%=cp%>/Mypage/mypageMain.do'">
<input type="button" value="수정" class="btn4" onclick="sendIt('${member.getUser_pwd()}');">
</div>

</div>
<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>