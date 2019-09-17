<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	Calendar cal = Calendar.getInstance();

	//오늘날짜
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH) + 1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);
  
	//클라이언트에서 넘어온 데이터

	String strYear = request.getParameter("year"); //사용자에게 년,월 값을 받아옴
	String strMonth = request.getParameter("month");
	String strDay = request.getParameter("day");

	//표시할 달력의 년,월
	int year = nowYear; //오늘날짜로 초기화
	int month = nowMonth;
	int day = nowDay;

	if (strYear != null) { //사용자가 입력한 값이 null이 아니면
		year = Integer.parseInt(strYear); //사용자가 선택한 년도	
	}
	if (strMonth != null) {
		month = Integer.parseInt(strMonth); //사용자가 선택한 월
	}
	if (strDay != null) {
		day = Integer.parseInt(strDay);
	}
 
	int preYear = year;
	int preMonth = month;
	int preDay = day - 1;

	if (preDay < 1) {
		preYear = year;
		preMonth = month - 1;
		cal.set(preYear, preMonth, 1);
		preDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	if (preMonth < 1) { //월이 0보다 작으면
		preYear = year - 1; //-1년 
		preMonth = 12; // 월 = 12
	}

	int nextYear = year;
	int nextMonth = month;
	int nextDay = day + 1;

	if (nextDay > cal.getActualMaximum(Calendar.DAY_OF_MONTH)) {
		nextDay = 1;
		nextMonth = month + 1;
		nextYear = year;
	}

	if (nextMonth > 12) { //월이 12보다 크면
		nextYear = year + 1; //+1년
		nextMonth = 1; //월 = 1
	}

	//표시할 달력 셋팅
	cal.set(year, month - 1, day); //년 월 일
	int startDay = 1; //월의 첫날은 1
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);//월의 마지막날

	int week = cal.get(Calendar.DAY_OF_WEEK);
	
	String screenId = request.getParameter("screen_id");
	
	String str;
	String strUrl;

	strUrl = cp + "/Booking/seatSelect.do";
	str = "window.open('" + strUrl + "', 'Think', ";
	str = str + "'left=100, ";
	str = str + "top=20, ";
	str = str + "width=1100, ";
	str = str + "height=650, ";
	str = str + "toolbar=no, ";
	str = str + "menubar=no, ";
	str = str + "status=no, ";
	str = str + "scrollbars=no, ";
	str = str + "resizable=no')";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=cp%>/timetable/style.css"
	type="text/css" />
<link rel="stylesheet" href="<%=cp%>/timetable/dd.css" type="text/css" />
<title>영화별 상영시간표</title>

<script type="text/javascript">
	function goNextPage(screen_id){
	var f= document.myForm1;
	
	window.open("<%=str%>");
	f.action ="<%=cp%>/Booking/seatSelect.do?screen_id="+screen_id ;
	f.submit();
	
}

</script>



</head>
<body>
	<jsp:include page="../header3.jsp" flush="false" />
	<div class="sub_navi ">
		<div class="sub_navi_wrap">
			<ul class="clearfix">
				<li><a class="timetable i0 "
					href="<%=cp%>/Timetable/movieGuide.do" title="예매안내 바로가기">예매안내</a></li>
				<li><a class="timetable i1 "
					href="<%=cp%>/Timetable/movieTime.do" title="영화별 상영시간표 바로가기">영화별
						상영시간표</a></li>
				<li><a class="timetable i2 "
					href="<%=cp%>/Theater/theater.do" title="영화관별 상영시간표 바로가기">영화관별
						상영시간표</a></li>

			</ul>
		</div>
	</div>
	
	<form name="myForm" method="post" action="">
		<table width="230px" height="503px" style="margin: 0px;" align="center">
			<tr align="center">
				<c:forEach var="dto" items="${lists1 }" begin="0" end="3">
					<td><a href="<%=cp%>/Timetable/movieTime_ok.do?movie_id=${dto.movie_id}#middle-img" >
						<img src="${imagePath}/${dto.movie_name}.PNG" width="230" height="330">
					</a></td>
				</c:forEach>
			</tr>
			<tr align="center">
				<c:forEach var="dto" items="${lists1 }" begin="4" end="7">
					<td><a href="<%=cp%>/Timetable/movieTime_ok.do?movie_id=${dto.movie_id}#middle-img" >
						<img src="${imagePath}/${dto.movie_name}.PNG" width="230" height="330" id="middle-img">
					</a></td>
				</c:forEach>
			</tr>
		</table>
	</form>
	<br /><br />

	<table align="center" width="250" cellpadding="2" cellspacing="1" style="margin-top: -20px; margin-bottom: 20px;">

		<tr>
			<td align="center" style="font-size: 20pt; color: #503396">			
				<a href="<%=cp %>/Timetable/movieTime_ok.do?movie_id=${movie_id}&year=<%=preYear%>&month=<%=preMonth%>&day=<%=preDay%>">
				<img src="${imagePath}/화살표1.png" width="30" height="30" border="0" align="middle"></a><b>&nbsp; <%=month%>월&nbsp;&nbsp; <%=day%>일</b> 
				<a href="<%=cp %>/Timetable/movieTime_ok.do?movie_id=${movie_id }&year=<%=nextYear %>&month=<%=nextMonth%>&day=<%=nextDay %>">
				<img src="${imagePath}/화살표2.png" width="30" height="30" border="0" align="middle"></a>
			</td>
		</tr>
	</table>

	<c:if test="${movie_id==null }">
		<p align="center"><img src="${imagePath}/nullmovie.PNG" width="160" height="120" border="0" align="middle" ></p>
	</c:if>
	
	<form name="myForm1" method="post">
	<table border="0" class="scheduleP2" style="width: 1140px;">
		<c:forEach var="dto" items="${lists }">
			<c:if test="${!dto.district.equals(district1)||!dto.screen_num.equals(screen_num1) }">
				<tr>
					<th	style="width: 50px; font-size: 14px; text-align: right; padding-right: 15px; padding-left: 10px;"><div>${dto.city}</div>
						<small>${dto.district}</small></th>
					<th	style="width: 110px; padding-left: 15px; padding-right: 10px; border-right: 1px solid #e5e5e5;"><div>${dto.movie_name}</div>
						<small>
						<c:if test="${dto.age_limit eq 'all'}">전체관람가</c:if> <c:if test="${dto.age_limit ne 'all'}">${dto.age_limit}세 관람가</c:if>
						</small>
					</th>
					<th style="width: 100px; font-size: 14px; text-align: right; padding-right: 15px; padding-left: 10px;"><div>${dto.screen_num}관</div>
						<small>${dto.type}</small>
					</th>
					<td>
			</c:if>

			<div class="movie_time">
				<p class="mtime_info">
					<span class="time">${dto.start_time }~${dto.end_time }</span> 
					<span class="seat"> ${dto.seatedseat}/${dto.seatnumber}</span><br>
					
					<input type="hidden" name = "screen_id" value = "${dto.screen_id}">
					<input type="hidden" name = "age_limit" value = "${dto.age_limit}">
					<input type="hidden" name = "movie_name" value = "${dto.movie_name}">
					<input type="hidden" name = "screen_num" value = "${dto.screen_num}">
					<input type="hidden" name = "start_time" value = "${dto.start_time}">
					<input type="hidden" name = "district" value = "${dto.district}">
					<input type="hidden" name ="type" value ="${dto.type }">
					

					<br/><br><a href="<%=cp %>" onclick="window.open('<%=cp%>/Booking/seatSelect.do?screen_id=${dto.screen_id}', 'search', 'top=20x, left=100px, height=650px, width=1100px')">예매</a>
					

				</p>
			</div>
			<c:set var="district1" value="${dto.district }" />
			<c:set var="screen_num1" value="${dto.screen_num}" />
		</c:forEach>
	</table>
	</form>


	<br /><br /><br /><br /><br />
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>