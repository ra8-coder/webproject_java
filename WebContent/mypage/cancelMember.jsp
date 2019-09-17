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
			alert("비밀번호를 입력하세요!");
			f.user_pwd.focus();
			return;
		}
		
		if(!(f.user_pwd.value==user_pwd)){
			alert("비밀번호가 일치하지 않습니다!");
			f.user_pwd.focus();
			return;
		}

		f.action = "<%=cp%>/Mypage/cancelMember_ok.do";
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
	<span class="title2">회원탈퇴</span> 
	<br/><br/>
</div>
<div style="clear: both;">
<table class="info">
	<tr>
		<th colspan="2"><font color="#503396">[주의] 메가박스 회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</font>
		</th>
	</tr>
	<tr>
		<td><br/>
		<span><b>1. 즉시 회원 정보가 삭제 됩니다.</b></span><br/>
		<span><img alt="" src="<%=cp%>/mypage/image/icon_list.png">&nbsp;&nbsp;모든 개인정보는 바로 파기됩니다.</span><br/><br/>
		</td>
	</tr>
	<tr>
		<td><br/>
		<span><b>2. 탈퇴 후 삭제 내역 (회원 탈퇴하시면 회원정보와 개인 보유 포인트 등 정보가 삭제되며 데이터는 복구되지 않습니다.)</b></span><br/>
		<span><img alt="" src="<%=cp%>/mypage/image/icon_list.png">&nbsp;&nbsp;영화 관람 내역</span><br/>
		<span><img alt="" src="<%=cp%>/mypage/image/icon_list.png">&nbsp;&nbsp;나의 한줄평</span><br/><br/>
		</td>
	</tr>
	<tr>
		<td><br/>
		<span><b>3. 회원님의 비밀번호를 입력하시고 [탈퇴] 버튼을 클릭해주세요.</b></span><br/>
		<span><img alt="" src="<%=cp%>/mypage/image/icon_list.png">&nbsp;&nbsp;비밀번호&nbsp;&nbsp;	 <input type="password" style="width: 200px" name="user_pwd"></span><br/><br/>
		</td>
	</tr>
</table>
</div>
</form>
</div>




<div align="center">
<br/><br/><br/>
<input type="button" value="취소" class="btn3" onclick="javascipt:location.href='<%=cp%>/Mypage/myInfo.do'">
<input type="button" value="탈퇴" class="btn4" onclick="sendIt(${member.getUser_pwd()});">
</div>

</div>
<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>