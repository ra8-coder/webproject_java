<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String path = cp + "/mv/imageFile";
	
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

<div style="clear: both;background-color: #f8f8f8; line-height: 20px; border-bottom: #352669 2px solid;padding-left: 20px; padding-right: 40px;">
<span class="font"><a href="<%=cp%>/Mypage/mypageMain.do"><br/>나의 메가박스</a>
<span class="right"><input type="button" class="btn1" value="로그아웃" onclick="javascript:location.href='<%=cp%>/Login/log_out.do';"></span>
<br/>&nbsp;<br/></span>
</div>

<br/>

<div><span class="font" style="padding-left: 20px;">${member.getUser_name() }</span> 님, 오늘도 영화처럼 멋진 하루 되세요!<br/><br/>
<br/><br/>
</div>

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
<br/><br/><br/><br/><br/>
<div>

<div class="box" style="background-color: #e1e1e1">
	<table bgcolor="#e1e1e1">
		<tr>
			<td><span class="title">개인정보</span> <span class="right"><input type="button" value="수정하기" class="btn1" onclick="javascript:location.href='<%=cp%>/Mypage/myInfo.do'"></span></td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td>휴대폰  <span class="right">${member.getTel() }</span></td>
		</tr>
		<tr>
			<td>선호 영화관 
			<span class="right">
			<c:if test="${empty preferredTheater}">
				없음
			</c:if>
			${preferredTheater }		
			</span></td>
		</tr>
		
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>
</div>
<div class="box">
	<table>
		<tr>
			<td colspan="2"><span class="title">최근 예매 내역</span>  <span class="right"><input type="button" value="더보기" class="btn1" onclick="javascript:location.href='<%=cp%>/Mypage/myBooking.do'"></span></td>
		</tr>
		<c:if test="${empty recentBookedList}">
			<tr>
				<td colspan="2" rowspan="3" height="140px" style="text-align: center;"> <font color="#666">최근 예매 내역이 없습니다</font>
				</td>
			</tr>
		</c:if>
		<c:forEach items="${recentBookedList }" var="dto" begin="0" end="1">
			<tr>
				<td class="bookedList"><img src="<%=path %>/${dto.getFile_name()}" alt="포스터" height="72px" width="52px">
				</td>
				<td class="bookedList">
				<b>${dto.getMovie_name() }</b><br/>${dto.getDistrict() }<br/>${dto.getStart_time() }
				</td>
			</tr>	
		</c:forEach>
			
	</table>
</div>
<div class="box">
	<table>
		<tr>
			<td><span class="title">나의 무비스토리</span></td>
		</tr>
		<tr>
			<td><img alt="" src="<%=cp%>/mypage/image/main_icon1.png"><a href="<%=cp%>/Mypage/myMoivestory.do?linkpage=interestingList"><span class="myMovie">&nbsp;&nbsp;&nbsp;보고싶어</span><span class="right">${wishMovieCount }</span></a></td>
		</tr>
		<tr>
			<td><img alt="" src="<%=cp%>/mypage/image/main_icon2.png"><a href="<%=cp%>/Mypage/myMoivestory.do?linkpage=seenList"><span class="myMovie">&nbsp;&nbsp;&nbsp;본영화</span><span class="right">${seenMovieCount }</span></a></td>
		</tr>
		<tr>
			<td><img alt="" src="<%=cp%>/mypage/image/main_icon4.png"><a href="<%=cp%>/Mypage/myMoivestory.do?linkpage=myCommentList"><span class="myMovie">&nbsp;&nbsp;&nbsp;나의 한줄평</span><span class="right">${commentCount }</span></a></td>
		</tr>
	</table>
</div>

</div>

</div>
<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>