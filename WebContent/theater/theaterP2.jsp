<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	//한글을 3바이트로 받아줘서 안깨지게해주는것
	request.setCharacterEncoding("UTF-8");
	//  cp = ~/study 까지 경로
	String cp = request.getContextPath();
	String theater_id = request.getParameter("theater_id");
%>

<%
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화관정보</title>
<link rel="stylesheet" href="<%=cp%>/theater/css/box.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/theme.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/theme2.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/menubarP2.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/scheduleP2.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/theaterP2_menutab.css" type="text/css" />

<script src="https://code.jquery.com/jquery-1.8.3.min.js"></script>

<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=Tlct_X7cWLceZF11mFRe&submodules=geocoder"></script>


<script type="text/javascript">
	//달력팝업
	function showCalendar() {
		var date;
		var f = document.calendarForm;

		window.open("calendar.do","달력","location = no, menubar = no, directories=no,left=580, top=150, width=350, height=350, toolbar = no, enubar=no, status=no, scrollbars=no, resizable=no, status = no");
	}
	
	//키보드포커스
	$(function(){
		$('div.movie_time').on("focus", "a", function(){
			$(this).prev().trigger("mouseout");
			$(this).trigger("mouseover");
		});

		$('div.movie_time').on("focusout", "a", function(){
			$(this).trigger("mouseout");
		});
	});
	
	/* 영화 클릭시 상세보기  */
	 function showDetail(movie_id) {
	
		var url = "<%=cp %>/Movie/movie.do?movie_id=" + movie_id;
	
		var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=1100, height=650, left='+(screen.width-968)/2+'';
		
		window.open(url,"movieInfo",setting);
	} 
	
		/* 영화 클릭시 상세보기  */
	 function showPop(movie_id) {
	
		var url = "<%=cp %>/Movie/movie.do?movie_id="+movie_id;
	
		var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=1100, height=650, left='+(screen.width-968)/2+'';
		
		window.open(url,"movieInfo",setting);
	} 
		
		/* 영화 예매하기 링크  */
	 function letsReserve(screen_id) {
	
		var url = "<%=cp%>/Booking/seatSelect.do?screen_id="+screen_id;
	
		var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=1100, height=650, left='+(screen.width-968)/2+'';
		
		window.open(url,"movieInfo",setting);
	} 
</script>

</head>
<jsp:include page="../header2.jsp" flush="false" />
<body>

<!-- 첫이미지부터 탭메뉴전까지 -->
<div class="whole_wrap">
	<div class="main_wrap">
		<div class="P2_container" style="position: static; margin-top: 0px;">
 	
<div class="sc no1"
		style="background-repeat: no-repeat; height: 450px; border: 1px solid black; 
		background-image: 
		<c:if test="${theater_id eq '1' }">
		url(http://image2.megabox.co.kr/mop/cinema/2014/51/C2345A-5B27-4E50-A432-B9754B2A3F16.jpg);
		</c:if>
		<c:if test="${theater_id eq '2' }">
		url(http://image2.megabox.co.kr/mop/cinema/2017/D9/AE0200-6A48-4342-9B24-B1A77D1C4CA7.jpg);
		</c:if>
		<c:if test="${theater_id eq '3' }">
		url(http://image2.megabox.co.kr/mop/cinema/2018/57/703AF3-6E8B-4149-ABA3-E270FD395135.jpg);
		</c:if>
		<c:if test="${theater_id eq '4' }">
		url(http://image2.megabox.co.kr/mop/cinema/2014/A5/DF9DFB-4533-4B70-8A8E-22C8672D6C1A.jpg);
		</c:if>
		">

<div class="whole_wrap narrow">
	<p class="P2_ti_box">
		<img src="http://image2.megabox.co.kr/mop/home/theater/slogan.png" alt="라이프시어터" class="slogan">
		<font style="color: #fff; font-size: 37px; font-weight: bolder;">
		<c:if test="${theater_id eq '1' }">
		메가박스 강남	
		</c:if>
		<c:if test="${theater_id eq '2' }">
		메가박스 강동	
		</c:if>
		<c:if test="${theater_id eq '3' }">
		메가박스 김포	
		</c:if>
		<c:if test="${theater_id eq '4' }">
		메가박스 영통	
		</c:if>
		</font>
	</p>
	<p class="P2_btn_box">
		<button class="top_btn2" type="button" onclick="">선호영화관</button>
	</p>
	<p class="P2_tx_box">
		<c:if test="${theater_id eq '1' }">
		강남의 중심! 강남 소비문화의 중심지인 지하철 2호선 , 신분당선  - 강남역과 연결 <br>
		로맨틱 멀티플렉스! 젊은 도시 강남이 한 눈에 보이는 최상의 View를 제공 <br>
		&lt;프라다&gt;가 선택한 수려한 디자인의 상영관 의자를 체험해보세요!
		</c:if>
		<c:if test="${theater_id eq '2' }">
		강동구청역 도보 5분 거리에 위치! <br>
		10개관 총 1500석 규모! 249석의 대형 상영관에서 생생한 관람을! <br>
		안락하고 쾌적한 관람을 위한 가죽시트 도입! 
		</c:if>
		<c:if test="${theater_id eq '3' }">
		김포의 랜드마크! 메가박스 김포점 <br>
		최신 바코 디지털 영사기와 음향 시스템으로 더욱 선명한 화질과 실감나는 음향! <br>
		쾌적하고 편안한 시트, 테이블이 마련되어 있는 4관!!	
		</c:if>
		<c:if test="${theater_id eq '4' }">
		11개관, 1873석의 전관 디지털 상영시스템, 전관 가죽 시트 <br>
		가장 진화된 상영관 MX관, Meyer Sound와 Dolby ATMOS 시스템, 와이드 시트 <br>
		어린이들을 위한 복합 문화 공간 메가키즈박스
		</c:if>
	</p>
</div>
</div>

<!-- 텝메뉴 시작 -->
<div class="sc no2" align="center">
	<div class=whole_wrap>
		<div id="topMenu" class="P2_menu">
			<ul>
				<li class="topMenuLi"><a class="menuLink">서울</a>
					<ul class="submenu">
						<li><a class="submenuLink"
							href="<%=cp%>/Theater/theaterP2_ok.do?theater_id=1">강남</a></li>
						<li><a class="submenuLink">강남대로(씨티)</a></li>
						<li><a class="submenuLink"
							href="<%=cp%>/Theater/theaterP2_ok.do?theater_id=2">강동</a></li>
						<li><a class="submenuLink">동대문</a></li>
						<li><a class="submenuLink">마곡</a></li>
						<li><a class="submenuLink">목동</a></li>
						<li><a class="submenuLink">상봉</a></li>
						<li><a class="submenuLink">상암월드컵경기장</a></li>
						<li><a class="submenuLink">센트럴</a></li>
						<li><a class="submenuLink">송파파크하비오</a></li>
					</ul></li>
				<li>|</li>
				<li class="topMenuLi"><a class="menuLink">경기</a>
					<ul class="submenu">
						<li><a class="submenuLink"
							href="<%=cp%>/Theater/theaterP2_ok.do?theater_id=3">김포</a></li>
						<li><a class="submenuLink">미사강변</a></li>
						<li><a class="submenuLink">별내</a></li>
						<li><a class="submenuLink">수원</a></li>
						<li><a class="submenuLink">시흥배곧</a></li>
						<li><a class="submenuLink">양주</a></li>
						<li><a class="submenuLink"
							href="<%=cp%>/Theater/theaterP2_ok.do?theater_id=4">영통</a></li>
						<li><a class="submenuLink">오산</a></li>
						<li><a class="submenuLink">일산</a></li>
						<li><a class="submenuLink">킨텍스</a></li>
					</ul></li>
				<li>|</li>
				<li class="topMenuLi"><a class="menuLink">인천</a>
					<ul class="submenu">
						<li><a class="submenuLink">검단</a></li>
						<li><a class="submenuLink">인천논현</a></li>
						<li><a class="submenuLink">미사강변</a></li>
						<li><a class="submenuLink">청라지젤</a></li>
						<li><a class="submenuLink">송도</a></li>
						<li><a class="submenuLink">청라</a></li>
					</ul></li>
				<li>|</li>
				<li class="topMenuLi"><a class="menuLink">대전/충정/세종</a>
					<ul class="submenu">
						<li><a class="submenuLink">공주</a></li>
						<li><a class="submenuLink">대전</a></li>
						<li><a class="submenuLink">세종</a></li>
						<li><a class="submenuLink">오창</a></li>
						<li><a class="submenuLink">제천</a></li>
						<li><a class="submenuLink">진천</a></li>
						<li><a class="submenuLink">천안</a></li>
						<li><a class="submenuLink">충주</a></li>
						<li><a class="submenuLink">흥성내포</a></li>
					</ul></li>
				<li>|</li>
				<li class="topMenuLi"><a class="menuLink">부산/대수/경상</a>
					<ul class="submenu">
						<li><a class="submenuLink">거창</a></li>
						<li><a class="submenuLink">경산하양</a></li>
						<li><a class="submenuLink">구미</a></li>
						<li><a class="submenuLink">김천</a></li>
						<li><a class="submenuLink">대구(칠성로)</a></li>
						<li><a class="submenuLink">덕천</a></li>
						<li><a class="submenuLink">문경</a></li>
						<li><a class="submenuLink">부산대</a></li>
						<li><a class="submenuLink">사천</a></li>
						<li><a class="submenuLink">서면</a></li>
					</ul></li>
				<li>|</li>
				<li class="topMenuLi"><a class="menuLink">광주/전라</a>
					<ul class="submenu">
						<li><a class="submenuLink">광주(충장로)</a></li>
						<li><a class="submenuLink">광주하남</a></li>
						<li><a class="submenuLink">목포</a></li>
						<li><a class="submenuLink">송천</a></li>
						<li><a class="submenuLink">여수</a></li>
						<li><a class="submenuLink">전대(광주)</a></li>
						<li><a class="submenuLink">첨단</a></li>
						<li><a class="submenuLink">광주상무</a></li>
						<li><a class="submenuLink">남원</a></li>
						<li><a class="submenuLink">목포하당(포르모)</a></li>
					</ul></li>
				<li>|</li>
				<li class="topMenuLi"><a class="menuLink">강원</a>
					<ul class="submenu">
						<li><a class="submenuLink">남춘천</a></li>
						<li><a class="submenuLink">속초</a></li>
						<li><a class="submenuLink">원주</a></li>
						<li><a class="submenuLink">원주센트럴</a></li>
					</ul></li>
				<li>|</li>
				<li class="topMenuLi"><a class="menuLink">제주</a>
					<ul class="submenu">
						<li><a class="submenuLink">제주</a></li>
						<li><a class="submenuLink">제주아라</a></li>
					</ul></li>
			</ul>
		</div>
<!-- 텝메뉴 끝  -->
	

<!-- 광고 삽입 부분 & 상영시간표 교통안내 링크s 시작 -->
<table border="0" align="center" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="5" align="center"
				style="padding-bottom: 10px; padding-top: 60px; height: 62px;">
	
	<a href="http://ad.imp.joins.com/NetInsight/event/clk
	/fIOKES4jxIeSbz457g7R9CJhHcY8OPKou7gwYFVsuxCIAbZaZ0VW
	SENyc1RwNlVoUms5R2xsTS1RAstB1t83tup9fAO2RUFaVHdHNTRSZ
	3F5RXNINm1Ja1RSdwbZMG1lZ2Fib3hfcC9zdWIvc3ViQHN1Yl9jaW
	5lbWFfYm90dG9tX3JpZ2h0Xzk3MHg4MAfN7kgIzQFfCYWjdGlktld
	XeVEtVHFLUzZlS1ZyeUl2ZWJCVlGjX3J0y0HW3ze26n18pF9tbm2gp
	F91aWTZb0ZlcV9wbVprVHY2MlY3eWJSekJnYWhEcWlRZDgxTDY4MWxJ
	NW5IOHljUWlFQU01bWpTYkNBYlprTVd0cFRtcFpSMVJHZVcxWVJUVTV
	TVlZFU2twM0FzdEIxdGY4WGlnRV9BUExRZGJYX0Y0b0JQd6RfY2lktlB
	zbEpzYzJiU1FPNTJZaFJSeVNmV1EKgaFyww" 
	target="_blank" style="display:block;text-align:center;width:100%;background-color:white;">
	<img src="http://mlink-cdn.netinsight.co.kr/2018/08/20/9ac4fd474764e1e6a515cf614d8fba3b.jpg" width="1140" height="80" border="0"></a>
		
		</td>
	</tr>
	
	<tr>
		<td align="left" style="padding-bottom: 10px; height: 10px; margin-bottom: 20px;"></td>
	</tr>
	<tr align="center">
		<td>
			<div id="topMenu2">
				<ul>
					<li class="topMenuLi2"><a class="menuLink2" href="#mtime_link">상영시간표</a>
						<ul class="submenu2">
						</ul></li>
					<li>|</li>
					<li class="topMenuLi2"><a class="menuLink2" href="#theaterinfo_link">층별안내</a>
						<ul class="submenu2">
						</ul></li>
					<li>|</li>
					<li class="topMenuLi2"><a class="menuLink2" href="#howtogo_link">약도/교통/주차</a>
						<ul class="submenu2">
						</ul></li>
					<li>|</li>
					<li class="topMenuLi2"><a class="menuLink2" href="#price_link">관람료</a>
						<ul class="submenu2">
						</ul></li>
					<li>|</li>
				</ul>
			</div>
		</td>
	</tr>
</table>
<!-- 링크 끝  -->

<!-- 달력 부분  -->
<div id="theaterSchedule">

<form action="" name="calendarForm">
	<table border="0" align="center" cellspacing="0" cellpadding="0"
		width="1140px">
		<tr>
			<td colspan="5" style="padding-bottom: 3px">
				<h3 id="mtime_link">상영시간표</h3>
			</td>
		</tr>
		<tr>
			<td colspan="5" height="2"
				style="background-color: #BDBDBD; padding-bottom: 3px"></td>
		</tr>
		<tr>
			<td style="height: 62px; width: 100px;" align="center"><a
				onclick="showCalendar();">달력</a></td>
			<td style="width: 50px;" align="center">
				<!--  <a href="calender.jsp?year=< %= nowYear %>&month=< %= nowMonth%>"><img src="./image/today.jpg" align="left"></a> -->
				<a
				href="<%=cp %>/Theater/theaterP2_ok.do?theater_id=${theater_id}&year=<%=preYear %>&month=<%=preMonth%>&day=<%=preDay%>">
					<img src="../theater/image/화살표1.png" width="30" height="30"
					border="2" align="middle">
			</a>
			</td>
			<td style="width: 200px; padding: 0px;" align="center"><font
				style="font-size: 30px;"><b>&nbsp;<%=month%>월&nbsp;&nbsp;<%=day%>일
				</b>&nbsp;</font></td>
			<td style="width: 50px;" align="center"><a
				href="<%=cp %>/Theater/theaterP2_ok.do?theater_id=${theater_id}&year=<%=nextYear %>&month=<%=nextMonth%>&day=<%=nextDay %>">
					<img src="../theater/image/화살표2.png" width="30" height="30"
					border="2" align="middle">
			</a></td>
			<td></td>
		</tr>
	</table>
</form>
<!-- 달력 끝  -->

<!-- 영화 스케쥴 lists 뿌리는 부분  -->
<div class="mtime_container">
	<script type="text/javascript">
	//키보드포커스
	$(function(){
		$('div.movie_time').on("focus", "a", function(){
			$(this).prev().trigger("mouseout");
			$(this).trigger("mouseover");
		});

		$('div.movie_time').on("focusout", "a", function(){
			$(this).trigger("mouseout");
		});
	});
	</script>

<form name="myForm1" method="post">
<table border="0" class="m_time_tb v2" width="1140px">
	<tbody>	
	
	
	<c:forEach var="dto" items="${lists }">
	<c:if test="${!dto.screen_num.equals(screen_num1) }">	
	<c:set var="i" value="0"/>		
		<tr class="lineheight_80" style="width: 1140px;">
			<th class="title">
			
			<div>
				<c:if test="${dto.age_limit eq 'all'}">
				<span class="age_m age_all">
				전체관람가
				</span>
				</c:if>
				<c:if test="${dto.age_limit eq '12'}">
				<span class="age_m age_12">
				12세관람가
				</span>
				</c:if>
				<c:if test="${dto.age_limit eq '15'}">
				<span class="age_m age_15">
				15세관람가
				</span>
				</c:if>
				<c:if test="${dto.age_limit eq '18'}">
				<span class="age_m age_18">
				18세관람가
				</span>
				</c:if>
				
				<strong>
					<a href="javascript:showDetail(${dto.movie_id})"  title="영화상세 보기">${dto.movie_name }</a>
				</strong>
			</div>
			</th>

			<th class="room">
				<div>${dto.screen_num }관</div>
				<small>${dto.type }</small>
			</th>
			</c:if>
			
<!-- 5번째 이후 밑으로 출력 시작  -->
			<c:if test="${i/5 eq '1' }">
			
			<tr class="lineheight_80" style="width: 1140px;">
			<th class="title">
			
				<div>
					<c:if test="${dto.age_limit eq 'all'}">
					<span>
					
					</span>
					</c:if>
					<c:if test="${dto.age_limit eq '12'}">
					<span>
					
					</span>
					</c:if>
					<c:if test="${dto.age_limit eq '15'}">
					<span>
					
					</span>
					</c:if>
					<c:if test="${dto.age_limit eq '18'}">
					<span>
					
					</span>
					</c:if>
					
					<strong>
						
					</strong>
				</div>
			</th>
			
			<th class="room">
			<div></div>
			<small></small>
			</th>
			</c:if>
<!-- 5번째 이후 밑으로 출력 끝 -->
				<td headers="th_theaterschedule_title th_theaterschedule_room">
				<input type="hidden" name = "screen_id" value = "${dto.screen_id}">
					<input type="hidden" name = "age_limit" value = "${dto.age_limit}">
					<input type="hidden" name = "movie_name" value = "${dto.movie_name}">
					<input type="hidden" name = "screen_num" value = "${dto.screen_num}">
					<input type="hidden" name = "start_time" value = "${dto.start_time}">
					<input type="hidden" name = "district" value = "${dto.district}">
					<input type="hidden" name ="type" value ="${dto.type }">
					
				
					<div class="movie_time">

						
						<p class="time_info">
							<span class="type"></span>
							<span class="time">${dto.start_time }~${dto.end_time }</span>
							<span class="seat">${dto.seatedseat }/${dto.seatnumber }</span>
							<span class="reserve"><a href="javascript:letsReserve(${dto.screen_id})">예매하기</a></span>
							
						
						
						<strong class="ico_box">
						
						</strong>
					
						</p>
					</div>
				</td>
				<c:set var="screen_num1" value="${dto.screen_num}" />	
				<c:set var="i" value="${i+1 }"/>
				
			
		</c:forEach>
	</tbody>
</table>
</form>
	<p class="m_time_notice" align="left">
	* 지연입장에 의한 관람불편을 최소화하고자 본 영화는 약 10분 후 시작됩니다.<br>
	* 쾌적한 관람 환경을 위해 상영시간 이전에 입장 부탁드립니다.<br>
	</p>

</div><!-- mtime_container 끝  -->
<!-- lists 끝  -->

		</div><!-- theaterSchedule div 끝 -->
	</div><!-- whole_wrap 끝  -->
</div><!-- sc n02 끝  -->


		<!-- 층 안내 시작 -->
		<div class="floorinfo" style="padding-top: 100px; padding-left: 10px;">
			<div style="position: relative; width: 1140px; margin: 0 auto;">
				<h3 id="theaterinfo_link">층별안내</h3>
				<c:if test="${theater_id==1 }">
					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>8층</strong>
						<p>매표소, 매점, 무인발권기, 남자/여자 화장실, 상영관 (MX관, COMFORT관, 3~9관)</p>
					</div>

					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>9층</strong>
						<p>1관, 2관, 남자 · 여자 화장실, 엘리베이터, 비상계단3</p>
					</div>

					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>10층</strong>
						<p>3관, 4관, 엘리베이터2, 남자 · 여자 화장실, 비상계단 3</p>
					</div>

					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>11층</strong>
						<p>5관, 6관, 7관, 엘리베이터2, 남자 · 여자 화장실, 비상계단 3</p>
					</div>
				</c:if>
				
				<c:if test="${theater_id==2 }">
					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>1층</strong>
						<p>매표소, 매점, 무인 발권기, 로비, 엘리베이터, 남·여 화장실, 남·여 장애인 화장실, 캡슐 토이, 투썸 플레이스</p>
					</div>

					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>2층</strong>
						<p>1관·2관, 로비, 엘리베이터, 음료 자판기, 남·여 화장실</p>
					</div>

					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>3층</strong>
						<p>3관·4관, 로비, 엘리베이터, 음료 자판기, 남·여 화장실</p>
					</div>

					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>4층</strong>
						<p>5관~10관, 로비, 엘리베이터, 음료 자판기, 남·여 화장실</p>
					</div>
				</c:if>
				
				<c:if test="${theater_id==3 }">
					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>7층</strong>
						<p>매표소, 매점, 카페, 게임존, 남/녀 화장실</p>
					</div>
					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>8층</strong>
						<p>1관, 2관, 3관, 남/여 화장실</p>
					</div>
				</c:if>
				
				<c:if test="${theater_id==4 }">
					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>5층</strong>
						<p>7관, 8관, 9관, 매표, 매점, 무인발권기, 화장실(남,여,장애인)</p>
					</div>
					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>6층</strong>
						<p>메가키즈박스,게임톡톡, 화장실(남,여)</p>
					</div>
					<div class="floorP2" style="margin-bottom: 15px;">
						<strong>7층</strong>
						<p>MX관, 2관, 3관, 4관, 5관, 6관, 화장실(남,여,장애인)</p>
					</div>
				</c:if>

			</div>
		</div>
		<!-- 층 안내 끝 -->
		<!-- 약도/교통/주차 시작 -->
		<div class="floorinfo" style="padding-top: 10px; padding-left: 10px;">
			<div style="position: relative; width: 1140px; margin: 0 auto;">
				<h3 id="howtogo_link">교통/약도/주차</h3>

				<div class="mapInfo" style="margin-bottom: 15px;">
					<p>
						도로명 주소 :
						<c:if test="${theater_id==1 }">서울특별시 서초구 서초대로77길 3 아라타워 8층</c:if>
						<c:if test="${theater_id==2 }">서울특별시 강동구 성내로 48</c:if>
						<c:if test="${theater_id==3 }">경기도 김포시 걸포로 6 걸포동, 미도프라자 7층,8층 / 전화번호 1544-0070</c:if>
						<c:if test="${theater_id==4 }">경기도 수원시 영통구 봉영로 1579 롯데쇼핑플라자 5층</c:if>
					</p>
				</div>
				<div class="mapInfo" style="margin-bottom: 15px;">
					<p>
						지번 주소 :
						<c:if test="${theater_id==1 }">서울특별시 서초구 서초동 1317-20 아라타워 8층</c:if>
						<c:if test="${theater_id==2 }">서울특별시 강동구 성내동 549-1</c:if>
						<c:if test="${theater_id==3 }">경기도 김포시 걸포동 1574-3 미도프라자 7층,8층</c:if>
						<c:if test="${theater_id==4 }">경기도 수원시 영통구 영통동 960-1 롯데쇼핑플라자 5층</c:if>
					</p>
				</div>
			</div>
		</div>
		<!-- 약도/교통/주차 끝 -->

	<!-- 네이버 지도 API  -->
    <div id="map" style="width:100%;height:400px;"></div>


    <script>
      var map = new naver.maps.Map('map');
      
	
		if(<%=theater_id%>==1){
			var myaddress = '서울특별시 서초구 서초대로77길 3';// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
		}else if(<%=theater_id%>==2){ 
			var myaddress = '서울특별시 강동구 성내로 48';
		}else if(<%=theater_id%>==3){ 
			var myaddress = '경기도 김포시 걸포로 6';
		}else if(<%=theater_id%>==4){ 
			var myaddress = '경기도 수원시 영통구 봉영로 1579';
		}

		naver.maps.Service.geocode({address: myaddress}, function(status, response) {
          if (status !== naver.maps.Service.Status.OK) {
              return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
          }
          var result = response.result;
          // 검색 결과 갯수: result.total
          // 첫번째 결과 결과 주소: result.items[0].address
          // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
          map.setCenter(myaddr); // 검색된 좌표로 지도 이동
          // 마커 표시
          var marker = new naver.maps.Marker({
            position: myaddr,
            map: map
          });
          // 마커 클릭 이벤트 처리
          naver.maps.Event.addListener(marker, "click", function(e) {
            if (infowindow.getMap()) {
                infowindow.close();
            } else {
                infowindow.open(map, marker);
            }
          });
          // 마크 클릭시 인포윈도우 오픈
          var infowindow = new naver.maps.InfoWindow({
              content: '<h4> [메가박스 강남]</h4><a href="https://developers.naver.com" target="_blank"><img src="../theater/image/mega_pic.jpg"></a>'
          });
      });
      </script>

<!-- 네이버 지도 API  -->

		<!-- 약도/교통/주차 시작 -->
		<div class="trafficInfo"
			style="padding-top: 10px; padding-left: 10px;">
			<div style="width: 1140px; margin: 0 auto;">
				<h3 id="price_link">교통안내</h3>


				<c:if test="${theater_id==1 }">
				<div class="traffic bus mb13">
					<div class="traInfo">
						<ul>
							<li>140번, 144번, 145번, 146번, 360번, 402번, 407번, 408번, 420번, 440번, 441번, 462번, 470번, 471번</li>
							<li>3412번, 4412번, 서초03번, 서초 09번</li>
							<li>9404번, 9408번, 9409번, 9503번, 9711번, 9500번, 9501번, 9510번, 9800번, 9801번, 9802번, 9901번 <br/>M4403번, M7412번</li>
						</ul>
					</div>
				</div>
				<div class="traffic metro mb30">
					<div class="traInfo">
						<ul>
							<li>지하철 2호선 , 신분당선 ‘강남역 -> 지하철 9번(구 5번) 출구 좌측 연결통로 이용</li>
						</ul>
					</div>
				</div>
				
					
					
				</c:if>
				

				<c:if test="${theater_id==2 }">
				<div class="traffic bus mb13">
					<div class="traInfo">
						<ul>
							<li>3319번, 3321번, 3220번, 3212번, 3214번, 3411번, 3318번, 3321번</li>
							<li>340번, 341번, 351번</li>
							<li>마을버스 강동 01</li>
							<li>16번, 30번, 30-1번, 30-3번, 70번, 112번, 112-1번, 112-5번</li>
						</ul>
					</div>
				</div>
				<div class="traffic metro mb30">
					<div class="traInfo">
						<ul>
							<li>8호선 강동구청역 2번 출구 도보 5분 (400m)</li>
						</ul>
					</div>
				</div>
				</c:if>

				<c:if test="${theater_id==3 }">
				<div class="traffic bus mb13">
					<div class="traInfo">
						<ul>
							<li>3000, 9008, 8600</li>
							<li>20, 33, 60-3, 81-1</li>
						</ul>
					</div>
				</div>
				</c:if>
				

				<c:if test="${theater_id==4 }">
				<div class="traffic bus mb13">
					<div class="traInfo">
						<ul>
							<li>13-1, 7, 82-2, 2, 2-1, 3, 51, 63, 63-1, 4-1, 11-1, 7-2, 720-1</li>
							<li>1112, 1007-1, 3001, 3001-1, 900, 5100, 7000, 7200</li>
						</ul>
					</div>
				</div>
				<div class="traffic metro mb30">
					<div class="traInfo">
						<ul>
							<li>지하철 분당선 ‘영통역’ 하차 → 지하철 8번 출구 이용</li>
						</ul>
					</div>
				</div>
				</c:if>


				<div class="trafficInfo"
					style="padding-top: 10px; padding-left: 10px; text-align: left; font-weight: bold;">
					<ul>
						<li><strong style="padding-left: 5px; font-size: 15px; font-weight: bolder;">주차요금</strong>
							<ul>
								<li>영화 관람 시 3시간 2,000원, 이후 10분당 500원</li>
								<li>요금 정산 시 카드 결제만 가능하며 현금 결제는 어렵습니다.</li>
								<li>수용 가능한 차량 수가 한정적이므로 가급적 대중교통을 이용해 주시기 바랍니다.</li>
							</ul></li>
					</ul>

				</div>
			</div>
		</div>
			<!-- 약도/교통/주차 끝 -->

<!-- 관람료  -->
<div class="sc no5" id="menu4"
	style="background-color: white;" align="center">

	<div id="theaterpay">
		<div class="whole_wrap" style="width: 1140px">
			<h3 style="color: #000000; padding-left: 10px; padding-top: 20px; font-size: 25px; text-align: left;
			 margin-bottom: 20px;" class="theater_pay">관람료</h3>
			
			<div align="left" style="padding-bottom: 10px;">
			<font style="color: #000000; font-size: 20px; text-align: left;">1. 영화관람료</font>
			</div>

			<table class="table_dark" summary="영화관람료">
				<caption class="blind2">영화관람료: 상영관, 구분, 상영시간, 성인, 청소년,
					어린이, 우대 등의 항목으로 구성된 표입니다</caption>
				<thead>
					<tr>
						<th scope="col" style="width: 14.28%;">상영관</th>
						<th scope="col" style="width: 14.28%;">구분</th>
						<th scope="col" style="width: 14.28%;">상영시간</th>
						<th scope="col" style="width: 14.28%;">성인</th>
						<th scope="col" style="width: 14.28%;">청소년</th>
						<th scope="col" style="width: 14.28%;">어린이</th>
						<th scope="col" style="width: 14.28%;">우대</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="16">일반관</td>
						<td rowspan="4">월요일~목요일</td>
						<td>조조(10시 전)</td>
						<td>7,000</td>
						<td>6,000</td>
						<td>6,000</td>
						<td>5,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>8,000</td>
						<td>8,000</td>
						<td>6,000</td>
						<td>5,000</td>
					</tr>
					<tr>
						<td>일반(13시~23시 전)</td>
						<td>11,000</td>
						<td>8,000</td>
						<td>6,000</td>
						<td>5,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>9,000</td>
						<td>7,000</td>
						<td>6,000</td>
						<td>5,000</td>
					</tr>
					<tr>
						<td rowspan="4">금요일~일요일<br> 공휴일
						</td>
						<td>조조(10시 전)</td>
						<td>8,000</td>
						<td>6,000</td>
						<td>6,000</td>
						<td>5,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>11,000</td>
						<td>9,000</td>
						<td>7,000</td>
						<td>5,000</td>
					</tr>
					<tr>
						<td>일반(12시~23시 전)</td>
						<td>12,000</td>
						<td>9,000</td>
						<td>7,000</td>
						<td>5,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>10,000</td>
						<td>8,000</td>
						<td>7,000</td>
						<td>5,000</td>
					</tr>
					<tr>
						<td rowspan="4">월요일~목요일<br> (3D)
						</td>
						<td>조조(10시 전)</td>
						<td>9,000</td>
						<td>8,000</td>
						<td>8,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>10,000</td>
						<td>9,000</td>
						<td>8,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>일반(13시~23시 전)</td>
						<td>12,000</td>
						<td>9,000</td>
						<td>8,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>11,000</td>
						<td>8,000</td>
						<td>8,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td rowspan="4">금요일~일요일<br> 공휴일<br> (3D)
						</td>
						<td>조조(10시 전)</td>
						<td>10,000</td>
						<td>9,000</td>
						<td>9,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>13,000</td>
						<td>11,000</td>
						<td>9,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>일반(13시~23시 전)</td>
						<td>14,000</td>
						<td>11,000</td>
						<td>9,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>12,000</td>
						<td>10,000</td>
						<td>9,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td rowspan="16">MX관</td>
						<td rowspan="4">월요일~목요일</td>
						<td>조조(10시 전)</td>
						<td>10,000</td>
						<td>9,000</td>
						<td>9,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>11,000</td>
						<td>11,000</td>
						<td>11,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>일반(13시~23시 전)</td>
						<td>13,000</td>
						<td>11,000</td>
						<td>11,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>12,000</td>
						<td>10,000</td>
						<td>10,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td rowspan="4">금요일~일요일<br> 공휴일
						</td>
						<td>조조(10시 전)</td>
						<td>11,000</td>
						<td>9,000</td>
						<td>9,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>13,000</td>
						<td>12,000</td>
						<td>12,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>일반(13시~23시 전)</td>
						<td>14,000</td>
						<td>12,000</td>
						<td>12,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>13,000</td>
						<td>10,000</td>
						<td>10,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td rowspan="4">월요일~목요일<br> (3D)
						</td>
						<td>조조(10시 전)</td>
						<td>12,000</td>
						<td>11,000</td>
						<td>11,000</td>
						<td>11,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>13,000</td>
						<td>12,000</td>
						<td>12,000</td>
						<td>11,000</td>
					</tr>
					<tr>
						<td>일반(13시~23시 전)</td>
						<td>15,000</td>
						<td>12,000</td>
						<td>12,000</td>
						<td>11,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>14,000</td>
						<td>11,000</td>
						<td>11,000</td>
						<td>11,000</td>
					</tr>
					<tr>
						<td rowspan="4">금요일~일요일<br> 공휴일<br> (3D)
						</td>
						<td>조조(10시 전)</td>
						<td>12,000</td>
						<td>11,000</td>
						<td>11,000</td>
						<td>11,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>15,000</td>
						<td>13,000</td>
						<td>13,000</td>
						<td>11,000</td>
					</tr>
					<tr>
						<td>일반(13시~23시 전)</td>
						<td>16,000</td>
						<td>13,000</td>
						<td>13,000</td>
						<td>11,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>15,000</td>
						<td>12,000</td>
						<td>12,000</td>
						<td>11,000</td>
					</tr>
					<tr>
						<td rowspan="8">COMFORT관</td>
						<td rowspan="4">월요일~목요일</td>
						<td>조조(10시 전)</td>
						<td>8,000</td>
						<td>7,000</td>
						<td>7,000</td>
						<td>6,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>9,000</td>
						<td>9,000</td>
						<td>7,000</td>
						<td>6,000</td>
					</tr>
					<tr>
						<td>일반(13시~23시 전)</td>
						<td>12,000</td>
						<td>9,000</td>
						<td>7,000</td>
						<td>6,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>10,000</td>
						<td>8,000</td>
						<td>7,000</td>
						<td>6,000</td>
					</tr>
					<tr>
						<td rowspan="4">금요일~일요일<br> 공휴일
						</td>
						<td>조조(10시 전)</td>
						<td>9,000</td>
						<td>7,000</td>
						<td>7,000</td>
						<td>6,000</td>
					</tr>
					<tr>
						<td>브런치(10시~13시)</td>
						<td>12,000</td>
						<td>10,000</td>
						<td>8,000</td>
						<td>6,000</td>
					</tr>
					<tr>
						<td>일반(12시~23시 전)</td>
						<td>13,000</td>
						<td>10,000</td>
						<td>8,000</td>
						<td>6,000</td>
					</tr>
					<tr>
						<td>심야(23시~)</td>
						<td>11,000</td>
						<td>9,000</td>
						<td>8,000</td>
						<td>6,000</td>
					</tr>
				</tbody>
			</table>
			
			<div align="left" style="padding-bottom: 10px;">
			<font style="color: #000000; font-size: 20px; text-align: left;">2. 요금제 기준</font>
			</div>
			
			<table class="table_dark" summary="관람료, 요금제 기준">
				<caption class="blind2">요금제 기준: 구분, 적용기준, 증빙서류의 항목으로
					구성된 표입니다.</caption>
				<thead>
					<tr>
						<th scope="col">구분</th>
						<th scope="col">적용기준</th>
						<th scope="col">증빙서류</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="1">어린이 요금</td>
						<td>만7세 ~ 만12세 (초등학생)</td>
						<td>의료보험증, 주민등록 등,초본</td>
					</tr>
					<tr>
						<td rowspan="1">청소년 요금</td>
						<td>만13세 ~ 만18세 (중학생~고등학생)</td>
						<td>학생증, 교복, 청소년증, 그 외 청소년 확인 가능 서류</td>
					</tr>
					<tr>
						<td rowspan="1">마티네 요금</td>
						<td>매주 화요일 14시 전 영화</td>
						<td>메가박스 멤버십 카드</td>
					</tr>
				</tbody>
			</table>

			<dl class="icon_list theater dark">
				<dt>* 48개월 미만의 경우 증빙원(예:의료보험증,주민등록 초/등본 등) 지참 시에만 무료관람 가능</dt>
				<dt>* 마티네 요금 : 메가박스 멤버십 회원대상, 매주 화요일 첫 회 ~ 14시 전 상영작까지
					6,000원에 관람이 가능한 요금제 (일부 특별관의 경우 추가요금이 발생)</dt>
			</dl>
			
			<div align="left" style="padding-bottom: 10px;">
			<font style="color: #000000; font-size: 20px; text-align: left;">3. 우대적용기준</font>
			</div>
			
			<table class="table_dark" summary="관람료, 우대적용기준">
				<caption class="blind2">우대적용기준: 구분, 적용기준, 증빙서류의 항목으로
					구성된 표입니다.</caption>
				<thead>
					<tr>
						<th scope="col">구분</th>
						<th scope="col">적용기준</th>
						<th scope="col">증빙서류</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="1">국가유공자</td>
						<td>본인 외 동반 1인까지</td>
						<td>국가유공자증</td>
					</tr>
					<tr>
						<td rowspan="1">장애인</td>
						<td>장애인1급~3급까지 동반 1인<br> 장애인4급~6급은 본인만
						</td>
						<td>(장애인)복지카드</td>
					</tr>
					<tr>
						<td rowspan="1">경로</td>
						<td>만 65세 이상 본인만</td>
						<td>신분증</td>
					</tr>
					<tr>
						<td rowspan="1">미취학아동</td>
						<td>만4세~만6세 까지 본인<br> (부모동반시 적용)
						</td>
						<td>의료보험증, 주민등록 등,초본</td>
					</tr>
					<tr>
						<td rowspan="1">군.경.소방종사자</td>
						<td>군인,경찰,소방관 본인</td>
						<td>(군인,경찰,소방)공무원증, 정복</td>
					</tr>
				</tbody>
			</table>
		</div>
<!-- //content_wrap -->
			</div>
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" flush="false" />
</div>

</body>
</html>