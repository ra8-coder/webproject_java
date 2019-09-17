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
<title>나의 메가박스</title>

<script type="text/javascript">
	
	function sendIt(user_pwd) {
		
		f = document.myForm;
		
		if(!f.user_pwd.value){
			alert("현재 비밀번호를 입력하세요!");
			f.user_pwd.focus();
			return;
		}
		
		if(!f.new_pwd1.value){
			alert("새 비밀번호를 입력하세요!");
			f.new_pwd1.foucs();
			return;	
		}
		
		if(!f.new_pwd2.value){
			alert("새 비밀번호를 한번 더 입력하세요!");
			f.new_pwd2.foucs();
			return;	
		}
		
		if(!(f.user_pwd.value==user_pwd)){
			alert("현재 비밀번호가 틀립니다!");
			f.user_pwd.focus();
			return;
		}
		
		if(!(f.new_pwd1.value==f.new_pwd2.value)){
			alert("새 비밀번호가 일치하지 않습니다!");
			f.new_pwd1.value = '';
			f.new_pwd2.value = '';
			f.new_pwd1.foucs();
			return;
		}

		f.action = "<%=cp%>/Mypage/updatePwd_ok.do";
		f.submit();
		
	}

</script>



</head>
<body>
<jsp:include page="../header.jsp" flush="false"/>
<div id="mypage">
<div style="clear: both;background-color: #f8f8f8; line-height: 20px; border-bottom: #352669 2px solid;padding-left: 20px;"><a href="<%=cp%>/Mypage/mypageMain.do"><span class="font"><br/>나의 메가박스<br/>&nbsp;<br/></span></a></div>
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
<form action="" name="myForm"  method="post">
	<br/>
<div style="clear: both;">
	<span class="title2">비밀번호 변경</span> &nbsp;&nbsp;&nbsp; 현재 비밀번호를 입력한 후 새로 사용할 비밀번호를 입력하세요
	<br/><br/>
</div>
<div style="clear: both;">
<table class="info">
	<tr>
		<th colspan="2">
		</th>
	</tr>
	<tr>
		<td width="200px" style="background-color: #f8f8f8">현재 비밀번호 
		</td>
		<td><input type="password" style="width: 150px" name="user_pwd">
		</td>
	</tr>
	<tr>
		<td width="200px" style="background-color: #f8f8f8">새 비밀번호 
		</td>
		<td><input type="password" style="width: 150px" name="new_pwd1">
		</td>
	</tr>
	<tr>
		<td width="200px" style="background-color: #f8f8f8">새 비밀번호 확인
		</td>
		<td><input type="password" style="width: 150px" name="new_pwd2"> &nbsp;&nbsp;&nbsp; 비밀번호 확인을 위해 한 번 더 입력해 주시기 바랍니다.
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<span style="line-height: 30px; vertical-align: middle;"><img alt="" src="<%=cp%>/mypage/image/icon_list.png">&nbsp;&nbsp;생년월일, 전화번호 등 개인 정보와 관련된 숫자, 연속된 숫자와 같이 쉬운 비밀번호는 다른 사람이 쉽게 알아낼 수 있으니 사용을 자제해 주세요.</span><br/>
		<span style="line-height: 30px; vertical-align: middle;"><img alt="" src="<%=cp%>/mypage/image/icon_list.png">&nbsp;&nbsp;비밀번호는 3-6개월마다 꼭 바꿔 주세요.</span><br/>
		<span style="line-height: 30px; vertical-align: middle;"><img alt="" src="<%=cp%>/mypage/image/icon_list.png">&nbsp;&nbsp;비밀번호 변경시 로그아웃됩니다. 변경한 비밀번호로 다시 로그인해주세요.</span><br/>
		</td>
	</tr>
</table>
</div>
</form>
</div>




<div align="center">
<br/><br/><br/>
<input type="button" value="취소" class="btn3" onclick="javascipt:location.href='<%=cp%>/Mypage/myInfo.do'">
<input type="button" value="수정" class="btn4" onclick="sendIt(${member.getUser_pwd()});">
</div>

</div>
<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>