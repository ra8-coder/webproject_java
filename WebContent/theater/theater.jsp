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
<title>영화관선택</title>
<link rel="stylesheet" href="<%=cp%>/theater/css/box.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/theme.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/theme2.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/menubarP2.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/theater/css/schedule.css" type="text/css" />
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
<head>


<!-- 첫이미지부터 탭메뉴전까지 -->
<div class="whole_wrap">
	<div class="main_wrap">
		<div class="P2_container" style="position: relative; margin-top: 0px;">
 	
<div class="sc no1"
		style="background-repeat: no-repeat; height: 580px; border: 1px solid black; 
		background-image: url(http://image2.megabox.co.kr/mop/cinema/2014/A5/DF9DFB-4533-4B70-8A8E-22C8672D6C1A.jpg)">
		<%-- 		<c:if test="${theater_id eq '1' }">
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
		</c:if> --%>

<div class="whole_wrap narrow">
	<p class="P2_ti_box">
		<font style="color: #fff; font-size: 37px; font-weight: bolder;">
			MEGABOX
		</font>
		<br/>
		<font style="color: #fff; font-size: 17px; font-weight: bolder;">
			LIFE THEATER
		</font>
	</p>
	
<!-- 	<p class="P2_btn_box">
		<button class="top_btn2" type="button" onclick="">선호영화관</button>
	</p> -->
	
	<p class="P2_tx_box">
		
		창의적인 콘텐트로 다양한 라이프 스타일을 <br/> 
		만족시키는 당신의 인생 극장
		
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
	<div>
		<img alt="" src="http://image2.megabox.co.kr/mop/home/map/world2.jpg" style="width: 1140px; height: 500px">
	</div>

	</div><!-- whole_wrap 끝  -->
</div><!-- sc n02 끝  -->





<!-- 유투브 및 광고 삽입 -->

<div class="sc no3" style="margin: 0 auto; width: 970px; margin-bottom: 10px;">
		<div class="whole_wrap">
			
			<h3 class="h3" style="margin-bottom: 10px; margin-left: 10px;">새로운 이벤트</h3>
			<div id="mainEventNew">


<div class="eve_box1">

	<div class="eve_autoOff">

    </div>

	<dl>
		<dd class="eve1_dd">
			<iframe width="630px" height="315px" src="https://www.youtube.com/embed/O-I0k8FLJVU?rel=0&autoplay=1" frameborder="0" class="video" allowfullscreen></iframe>
		</dd>

	</dl>
</div>
<div class="eve_box2">
	<div class="eve2_left">

	
	<!-- eve2_left 랜덤 반복-->
	<div style="display:none;">

	
				<a href="javascript:EventDetail.showPage('5883', 0);" title="">
	
				<img src="http://image2.megabox.co.kr/mop/home/main/315X315/180503_private_315_315.jpg" alt="더 부티크 프라이빗">
	
			</a>
	
	</div>
	<!-- eve2_left 랜덤 반복-->
	
	<!-- eve2_left 랜덤 반복-->
	<div style="display:none;">

	
				<a href="javascript:EventDetail.showPage('6317', 0);" title="">
	
				<img src="http://image2.megabox.co.kr//mop/frontbanner/2018/33/066F5B-0806-477F-AACB-6616734A4A59.jpg" alt="<카메라를 멈추면 안 돼!> 굿즈 패키지 상영회">
	
			</a>
	
	</div>
	<!-- eve2_left 랜덤 반복-->
	
	<!-- eve2_left 랜덤 반복-->
	<div style="">

	
				<a href="javascript:EventDetail.showPage('6312', 0);" title="">
	
				<img src="http://image2.megabox.co.kr//mop/frontbanner/2018/4B/E6BDEE-BF12-40F9-8B09-65FEC12FF174.jpg" alt="<톰 오브 핀란드> 굿즈 패키지 상영회 ">
	
			</a>
	
	</div>
	<!-- eve2_left 랜덤 반복-->
	
	</div>
	<div class="eve2_right">

	
	<!-- eve2_right 랜덤 반복-->
	<div style="">

	
				<a href="javascript:adHasClick('http://www.megabox.co.kr/?menuId=store', 0);" title="">
	
				<img src="http://image2.megabox.co.kr/mop/home/main/315X315/160321_store_315x315.jpg" alt="메가박스 스토어 더 즐거운 영화관람을 위해 다양한 스토어 상품과 함께하세요">
	
			</a>
	
	</div>
	<!-- eve2_right 랜덤 반복 -->
	
	</div>
</div>


<div class="eve_box3" style="background:url(http://image2.megabox.co.kr//mop/frontbanner/2018/33/145474-82C9-4616-82AC-6530B7CEDE6F.jpg) no-repeat; width:500px; margin-top: 0px;">
       
			<a href="javascript:adHasClick('http://www.megabox.co.kr/?menuId=event&amp;p=detail&amp;p2=6251', 0, 'pop');" title="VIP 급행 열차에 탑승하라! 나도 이제 VIP ">
				<img src="http://image2.megabox.co.kr//mop/frontbanner/2018/33/145474-82C9-4616-82AC-6530B7CEDE6F.jpg" alt="VIP 급행 열차에 탑승하라! 나도 이제 VIP ">
			</a>
		
</div>


</div>
</div>
</div>


<!-- 광고삽입 끝  -->

	</div> <!-- p2_container  -->
</div> <!-- main_wrap  -->



<div id="mainBannerParallax">


<script type="text/javascript" src="/js/common/common.js"></script>


<!-- if(display.equals("HTM")) 인경우 추가. -->

<!-- if(!display.equals("HTM")) 인경우 추가. -->
 

<div class="parallax_txt">
	<img src="http://image2.megabox.co.kr//mop/frontbanner/2018/46/471CF5-03F1-4349-9D97-F1629F8325F2.png" 
	alt="대구이시아 군자 김포한강신도시" style="margin-top: -400px; margin-left: -432.5px;">
	</div>
	<div class="content_middle_banner parallax_img" data-stellar-background-ratio="0.3" style="background: url(&quot;http://image2.megabox.co.kr/mop/home/ad/1600x1000/160926_bg_1600x1000.jpg&quot;) 0px -280.7px / cover no-repeat; overflow: visible;">
	<a href="javascript:void(0);" onclick="megaboxLog.init('event','MAIN','New_theater');" title="" style="display:block; margin:1px 0 0 1px; background:none; height:499px;"><span class="blind">BalconyM</span></a>
</div>



<jsp:include page="../footer.jsp" flush="false" />
</div>

</body>
</html>