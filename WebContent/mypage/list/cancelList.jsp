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
<title>Insert title here</title>
<link rel="stylesheet" href="<%=cp%>/mypage/css/list.css" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<style type="text/css">

body {
scrollbar-face-color:#FFFFFF;
scrollbar-highlight-color: #FFFFFF;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #FFFFFF;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #FFFFFF
}
</style>

</head>
<body>
<div id="list">
<table>
	<tr>
		<td colspan="7" height="1px" style="border-bottom: 2px solid #503396;text-align: left"><font style="font-size: 12pt; color:#503396; font-weight: bold;">취소 내역</font></td>
	</tr>
	<tr>
		<th class="num">NO</th>
		<th class="resNum">예매번호</th>
		<th class="movieTitle">영화명</th>
		<th class="cinema">영화관</th>
		<th class="playDate">상영일시</th>
		<th class="saleDate">예매일</th>
		<th class="saleDate">취소일시</th>
	</tr>
	<!-- DB에서 정보 불러서 돌려야함 -->
	<c:if test="${!empty canceledList }">
	<c:set var="i" value="1"/>
	<c:forEach items="${canceledList }" var="dto">
	<tr>
		<td>${i }
		<c:set var="i" value="${i+1 }"/>
		</td>
		<td>${dto.getBooked_id() }</td>
		<td>${dto.getMovie_name() }</td>
		<td>${dto.getDistrict() } ${dto.getScreen_num()}관</td>
		<td>${dto.getStart_time() }</td>
		<td><c:out value="${fn:substring(dto.getReservation_date(),0,fn:length(dto.getReservation_date())-3) }"></c:out></td>
		<td>${dto.getCancel_date() }</td>
	</tr>
	</c:forEach>
	</c:if>
	<c:if test="${empty canceledList }">
		<tr>
			<td colspan="7">예매 취소 내역이 없습니다.
			</td>
		</tr>
	</c:if>
</table>


</div>
</body>
</html>