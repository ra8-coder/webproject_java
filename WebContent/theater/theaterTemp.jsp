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
<title>Insert title here</title>
<link rel="stylesheet" href="<%=cp%>/theater/css/box.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/theme.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/theme2.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/menubarP2.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/scheduleP2.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/theaterP2_menutab.css" type="text/css" />

<script src="https://code.jquery.com/jquery-1.8.3.min.js"></script>

<style type="text/css">

.youtubeV {
padding-top: 16px;
position: relative;

}

</style>

</head>
<jsp:include page="../header2.jsp" flush="false" />
<body>

<!-- 첫이미지부터 탭메뉴전까지 -->
<div class="whole_wrap">
	<div class="main_wrap">
		<div class="P2_container" style="position: static; margin-top: 0px;">
 	
<div class="sc no1"
		style="background-repeat: no-repeat; height: 580px; border: 1px solid black; 
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
<div class="sc no2">
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
				<li class="topMenuLi"><a class="menuLink">경기</a>
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
	<div>
		<img alt="" src="http://image2.megabox.co.kr/mop/home/map/world2.jpg" style="width: 1140px; height: 500px">
	</div>
	
	<div class=youtubeV align="center" style="padding-top: 100px">
		<iframe width="984" height="562" src="https://www.youtube.com/embed/O-I0k8FLJVU?rel=0&autoplay=1" frameborder="0" class="video" allowfullscreen></iframe>
	</div><p><br /></p>
	
	<div>
		<a href="http://ad.imp.joins.com/NetInsight/event/
		clk/v4tpfnqPm-iPGc4CsBFOh9jkGcGJ_ErzI1vVY3YeuIeIA
		bZueUdSaUpDQ1NVZWVUby1kVkp1N2tBAstB1t2qjVLUNQO2Tnh
		YbS1DWmNTR21LcGN5MW45YU45dwbZI21lZ2Fib3hfcC9tYWluL
		21haW5AbWFpbl90b3BfOTcweDgwB83uSAjNAWoJhaN0aWS2T1pv
		RjVOSmZUcHEtcnZGM2tIQWtwZ6RfbW5toKRfdWlk2W9GZXFfcG1
		aa1R2NjJWN3liUnpCZ2FoRHFpUWQ4MUw2ODFsSTVuSDh5Y1FpRUFN
		NW1qU2JDQWJaa01XdHBUbXBaUjFSR2VXMVlSVFU1U1ZWRVNrcDNBc
		3RCMXRmOFhpZ0VfQVBMUWRiWF9GNG9CUHekX2NpZLZwdWl6VDBsM1J
		2MndHbldkeHJFQjJ3o19ydMtB1t2qjVLUNQqBoXLD" target="_blank" style="display:block;text-align:center;width:100%;background-color:#f4ddbd">
		<img src="http://mlink-cdn.netinsight.co.kr/2018/08/14/3e69187c067a0d003472d491c898d73f.jpg" width="1140" height="80" border="0"></a>
	</div>
	

	</div><!-- whole_wrap 끝  -->
</div><!-- sc n02 끝  -->







	</div>
</div>

<jsp:include page="../footer.jsp" flush="false" />
</div>

</body>
</html>