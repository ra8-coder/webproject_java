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
<link rel="stylesheet" href="<%=cp%>/mypage/css/mypage.css" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>나의 메가박스</title>
</head>
<body>
<jsp:include page="../header.jsp" flush="false"/>
<div id="mypage">
<div style="clear: both;background-color: #f8f8f8; line-height: 20px; border-bottom: #352669 2px solid;padding-left: 20px;"><a href="<%=cp%>/Mypage/mypageMain.do"><span class="font"><br/>나의 메가박스<br/>&nbsp;<br/></span></a></div>
<br/>
<div><span class="font" style="padding-left: 20px;">${member.getUser_name() }</span> 님, 오늘도 영화처럼 멋진 하루 되세요!<br/><br/>
<br/><br/>
</div>

<div>
	<ul class="nav_gnb">     	
		<li>
           <a href="#"><img src="<%=cp%>/mypage/image/res.JPG" alt=""/><span>예매 확인/취소</span></a>
        </li>
        <li>
           <a href="<%=cp%>/Mypage/myMoivestory.do?linkpage=interestingList"><img src="<%=cp%>/mypage/image/moviestory.JPG" alt=""/><span>나의 무비스토리</span></a>
        </li>
        <li>
           <a href="<%=cp%>/Mypage/myInfo.do"><img src="<%=cp%>/mypage/image/update.JPG" alt=""/><span>개인정보수정</span></a>
        </li>
    </ul>
</div>

<div style="clear: both;">
	<br/>
<div style="clear: both;">
	<span class="title2">예매 확인/취소</span> &nbsp;&nbsp;&nbsp; 예매하신 영화 내역과 취소 내역을 확인할 수 있습니다.
	<br/><br/>
</div>



<div style="clear: both;">
	<ul>
		<li class="tab"><a href="<%=cp %>/mypage/list/bookingList.jsp" target="iframe1">예매 내역</a></li>
		<li class="tab"><a href="<%=cp %>/mypage/list/oldList.jsp" target="iframe1">지난 내역</a></li>
		<li class="tab"><a href="<%=cp %>/mypage/list/cancelList.jsp" target="iframe1">취소 내역</a></li>
	</ul>
</div>
	<br/><br/>

<div style="clear: both;">
<iframe  src="<%=cp %>/mypage/list/bookingList.jsp"  name="iframe1" width="1000px" height="700px" frameborder="0" style="overflow-y:hidden; width:100%; min-height:700px; height:100%;"></iframe>
</div>


</div>


</div>
<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>