<%@page import="java.io.File"%>
<%@page import="util.MyUtil"%>
<%@page import="com.movie.MovieDAO"%>
<%@page import="util.DBCPConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.movie.MovieDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	//POST 방식에서 한글깨짐을 방지
	request.setCharacterEncoding("UTF-8");
	
	Connection conn = DBCPConn.getConnection();
	MovieDAO dao = new MovieDAO(conn);
	MyUtil myUtil = new MyUtil();
	
	String cp = request.getContextPath();
	String uri = request.getRequestURI();
	String url;
	
	String root = getServletContext().getRealPath("/");
	String path = root + File.separator + "mv" + File.separator + "imageFile";
	
	File f = new File(path);
	if(!f.exists())
		f.mkdirs();
	
	String pageNum = request.getParameter("pageNum");
	
	int currentPage = 1;
	
	if(pageNum!=null)
		currentPage = Integer.parseInt(pageNum);
	
	int numPerPage = 21;
	int dataCount = dao.getDataCount();
	
	int totalPage = myUtil.getPageCount(numPerPage, dataCount);
	
	if(currentPage>totalPage)
		currentPage=totalPage;
	
	int start = (currentPage-1)*numPerPage+1;
	int end = currentPage*numPerPage;
	
	String check = request.getParameter("check");
	
	List<MovieDTO> lst = null;
	if(check==null || check.equals("0")){
		lst = dao.getAllMV(start, end);	
	}
	else if(check.equals("1")){
		lst = dao.getListDate(start, end);
	}else if(check.equals("2")){
		lst = dao.getListPre(start, end);
	}
	//List<MovieDTO> lst = dao.getListDate(start, end);
	//List<MovieDTO> lst = dao.getListPre(start, end);
	
	String listUrl = cp + "/Movie/list.do";
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	String imagePath = cp + "/mv/imageFile";
	request.setAttribute("check", check);
	request.setAttribute("lst", lst);
	request.setAttribute("pageIndexList", pageIndexList);
	request.setAttribute("dataCount", dataCount);
	request.setAttribute("pageNum", currentPage);
	request.setAttribute("totalPage", totalPage);
	request.setAttribute("imagePath", imagePath);
	
%>

<%-- 
<jsp:include page="../header.jsp" flush="false"/>
<jsp:include page="../footer.jsp" flush="false"/> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>라이프시어터, 메가박스</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

<style type="text/css">

body{font-family: 'Nanum Gothic', sans-serif;}

#header-wrap {
	position: fixed;
	top: -20px;
	left: 0px;
	width: 100%;
	background-color: white;
}

#header {
	background-color: white;
	width: 1140px;
	margin: auto;
	height: 50px;
}

#header img {
	float: left;
	width: 200px;
	height: 50px;
}

#header ul li {
	list-style: none;
	float: left;
	line-height: 50px;
	vertical-align: middle;
	text-align: center;
	border-style: groove;
	border-width: 1px;
	border-color: gray;
}

#header .menuLink {
	background-color: white;
	color: black;
	text-decoration: none;
	display: block;
	width: 120px;
	font-size: 11pt;
	font-weight: bold;
}

#header .menuLink:hover {
	color: #198591;
}

#header-menu {
	margin: auto;
	margin-top: 60px;
	padding-left: 0px;
	height: 80px;
	width: 1140px;
	border-bottom-style: solid;
	border-bottom-width: 5px;
	border-bottom-color: #352669;
}

#header-menu-left {
	padding-left: 0px;
	margin-left: 0px;
	float: left;
}

#header-menu-right {
	margin-right:40px;
	float: right;
}

#header-menu-left img {
	margin-top: 5px;
	width: 80px;
	height: 40px;
}

#header-menu-right img {
	margin-top: 5px;
	width: 110px;
	height: 40px;
}

#header-menu ul li{
	list-style: none;
	float: left;
	line-height: 50px;
	vertical-align: middle;
	text-align: center;
	margin: 0px;
	pdding: 0px;
}

#header-menu-left .menu-left {
	color: black;
	text-decoration: none;
	display: block;
	width: 100px;
	font-size: 11pt;
	font-weight: bold;
	text-align: left;
}

#header-menu-right .menu-right {
	color: black;
	text-decoration: none;
	display: block;
	width: 110px;
	font-size: 11pt;
	font-weight: bold;
	text-align: left;
}

#footer-wrap {
	margin: 0 auto;
	width: 1000px;
}

#footer {
	overflow: hidden;
	background-color: #333333;
}

#footer h4 {
	color: white;
}

#footer dl {
	float: left;
	margin-top: 0px;
}

#footer dt {
	float: left;
	color: white;
	font-size: 11pt;
	font-weight: bold;
}

#footer dd {
	float: left;
	color: gray;
	font-size: 9pt;
	margin: 5px;
}

#footer a:link {
	color: gray;
	text-decoration: none;
}

#footer a:visited {
	color: gray;
	text-decoration: none;
}

#footer1 {
	background-color: #221F1F;
	overflow: hidden;
}

#footer1-wrap .logo {
	padding-top: 15px;
}

#footer1-wrap {
	margin: 0 auto;
	width: 1000px;
	font-size: 9pt;
}

#footer1-wrap .text1 {
	float: left;
	width: 500px;
	margin-top: 10px;
}

#footer1-wrap .text2 {
	float: right;
	width: 400px;
	margin-bottom: 15px;
}

#footer1-wrap .text2 img {
	width: 200px;
	height: 60px;
}

#topbanner-wrap {
	width: 1140px;  
	margin: 0 auto;
	overflow: hidden;
	
}

#topbanner-wrap img {
	width: 1140px;
}

#middle-box {
	background-color: #E6E6E6;
	overflow: hidden;
}

#middle-box-wrap {
	display: table;
	margin-left: auto;
	margin-right: auto;
	height: 500px;
}

#middle-list li {
	
	list-style: none;
	float: left;
	line-height: 50px;
	vertical-align: middle;
	text-align: center;
}

#middle-list a {
	background-color: white;
	color: #666666;
	text-decoration: none;
	display: block;
	width: 140px;
	font-size: 11pt;
	font-weight: bold;
	border: 1px solid #666666;
	
}

#middle-list a:HOVER {
	color: white;
	background-color: #666666;
}

/* movie list */

#content{
	font-family: 'Nanum Gothic', sans-serif;
	margin-left: 70px;
	margin-right: 70px;
	margin-bottom: 100px;
	align: center;
}

#content .top{
	border-top: 1px solid #CCCCCC;
	border-bottom: 1px solid #CCCCCC;
	border-left: 1px solid #CCCCCC;
	border-right: 1px solid #CCCCCC;
}
#content .middle{
	font-size: 14pt;
	padding: 10px;
	padding-bottom: 0px;
	height: 50px;
	border-left: 1px solid #CCCCCC;
	border-right: 1px solid #CCCCCC;
	background-color: white;
}
#content .bottom{
	font-size: 10pt;
	padding: 10px;
	height: 30px;
	border-bottom: 1px solid #CCCCCC;
	border-left: 1px solid #CCCCCC;
	border-right: 1px solid #CCCCCC;
	background-color: white;
}
#content .btn1{
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 11pt;
	font-weight: bold;
	color: #4C4C4C;
	background-color: #F2F2F2;
	width: 100px;
	height: 50px;
	border-style: none;
	cursor: pointer;
}
#content .btn1:hover{
	background-color: white; 
	color: #1294AB;
	border: 1px solid #1294AB;
}

a:visited{text-decoration: none; color: #4C4C4C;}
a:link {text-decoration: none; color: #4C4C4C;}

/* movie list */



</style>

</head>
<body >

	<!-- HEADER 시작 -->
	<div id="header-wrap">
		<div id="header">
			<ul>
				<li style="list-style: none; border: none; padding-top: 2px;"><a href="<%=cp%>"><img alt=""
						src="./login/image/magabox.jpg"></a></li>
				<li><a class="menuLink" href="<%=cp%>/Movie/list.do">영화</a></li>
				<li><a class="menuLink" href="#">큐레이션</a></li>
				<li><a class="menuLink" href="<%=cp%>/Theater/theater.do">영화관</a></li>
				<li><a class="menuLink" href="#">특별관</a></li>
				<li><a class="menuLink" href="#">스토어</a></li>
				<li><a class="menuLink" href="#">이벤트</a></li>
				<li>
					<c:if test="${empty member.getUser_id() }">
						<a class="menuLink" href="<%=cp%>/Login/login.do">로그인</a>
					</c:if>
					<c:if test="${!empty member.getUser_id() }">
						<a class="menuLink" href="<%=cp%>/Mypage/mypageMain.do"><font color="#351f66">마이페이지</font></a>
					</c:if>
				</li>
				
			</ul>
		</div>
	</div>
	<div id="header-menu">
		<div id="header-menu-left">
			<ul>
				<li class="menu-left"><img alt=""
					src="<%=cp%>/login/image/menu.jpg"></li>
				<li class="menu-left" style="width: 120px">필름소사이어티</li>
				<li class="menu-left" style="width: 130px">클래식 소사이어티</li>
			</ul>
		</div>

		<%
			String str;
			String strUrl;

			strUrl = cp + "/Booking/booking.do";
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

		<div id="header-menu-right">
			<ul>
				<li class="menu-right" style="width: 170px">고객센터 | 멤버십 | VIP</li>
				<li class="menu-right"><a
					href="<%=cp%>/Timetable/movieTime.do"><img alt=""
						src="./login/image/timetable.jpg"></a></li>
				<li class="menu-right" style="margin-left: 5px">
				<img alt="" src="./login/image/booking.jpg" onclick="<%=str%>"></li>
			</ul>
		</div>
	</div>
	<!-- HEADER 끝 -->


	<div id="topbanner">
		<div id="topbanner-wrap">
			<img id="banner-image"  alt=""  src="./image/banner1.jpg">
		</div>
	</div>

	<div id="middle-box">
		<div id="middle-box-wrap" style="width: 1000px; margin: 0 auto;">
			<form action="" method="post" name="hidden">
				 <input type="hidden" name="check" value=""> 
			
			<div id="middle-list" style=" width: 1000px; margin: 0 auto;">
				<ul style="overflow: hidden; margin: 170px; margin-top: 60px; margin-bottom: 0px;">
					<li><a href="<%=cp %>/index.jsp?check=0">박스오피스</a></li>
					<li><a href="<%=cp %>/index.jsp?check=1">최신개봉작</a></li>
					<li><a href="<%=cp %>/index.jsp?check=2">상영예정작</a></li>
					<li><a href="">큐레이션</a></li>
				</ul>
			</div>
			
			</form>
			
			<!-- 메인 영화정보 -->

			<div id="content" style="margin: 0 auto; margin-bottom: 70px;">
				<table width="1000px" >
					<tr>
						<td height="50px" colspan="7"></td>

					</tr>
					<c:set var="i" value="0" />
					<c:forEach var="dto" items="${lst }" begin="0" end="3">
						<c:if test="${i==0 }">
							<tr>
						</c:if>
						<c:if test="${i!=0&&i%4==0 }">
							</tr>
							<tr>
						</c:if>
						<td width="242px" height="517px">
							<table width="230px" height="503px" style="margin: 0px; background-color: #E6E6E6;">
								<tr>
									<td class="top"><img src="${imagePath }/${dto.file_name}"
										width="230px" height="330px" />
									</td>
								</tr>
								<tr>
									<td width="230px" height="50px" class="bottom"><span
										style="line-height: 25px;"> <font color="grey"
											style="font-weight: bold; font-size: 11pt;">평점
												${dto.rating }</font></span> <span style="float: right;"> <c:if
												test="${dto.rating==0 }">
												<img src="${imagePath }/rate0.png">
											</c:if> <c:if test="${dto.rating<3&&0<dto.rating}">
												<img src="${imagePath }/rate1.png">
											</c:if> <c:if test="${2<dto.rating&&dto.rating<5}">
												<img src="${imagePath }/rate2.png">
											</c:if> <c:if test="${4<dto.rating&&dto.rating<7 }">
												<img src="${imagePath }/rate3.png">
											</c:if> <c:if test="${6<dto.rating&&dto.rating<9 }">
												<img src="${imagePath }/rate4.png">
											</c:if> <c:if test="${8<dto.rating&&dto.rating<11 }">
												<img src="${imagePath }/rate5.png">
											</c:if>
									</span></td>
								</tr>
								<tr>
									<td class="middle"><c:if test="${dto.age_limit=='all' }">
											<img src="${imagePath }/ageallbig.png">
										</c:if> <c:if test="${dto.age_limit=='12' }">
											<img src="${imagePath }/age12big.png">
										</c:if> <c:if test="${dto.age_limit=='15' }">
											<img src="${imagePath }/age15big.png">
										</c:if> <c:if test="${dto.age_limit=='18' }">
											<img src="${imagePath }/age18big.png">
										</c:if> <font color="#353535"
										style="font-weight: bold; vertical-align: top;"> <a
											href="javascript:showPop();"> <c:choose>
													<c:when test="${fn:length(dto.movie_name)>10 }">
														<c:out value="${fn:substring(dto.movie_name,0,9) }" />…
													</c:when>
													<c:otherwise>
														<c:out value="${dto.movie_name }"></c:out>
													</c:otherwise>
												</c:choose>
										</a>
									</font></td>
								</tr>
								<tr>
									<td class="bottom" align="center"><input type="hidden"
										name="movie_id1" value="${dto.movie_id }" /> <input
										type="button" value="상세정보" class="btn1" onclick="showPop(${dto.movie_id});" />
										&nbsp;<input type="button" value="예매하기" class="btn1"
										onclick="goToB(${dto.movie_id});" /></td>
									<c:set var="i" value="${i+1 }" />
								</tr>
							</table>
						</td>
					</c:forEach>
					<c:if test="${i>0&&i%4!=0 }">
					<c:forEach var="j" begin="${i%4+1 }" end="4" step="1"><td width="230px" height="503px">
						&nbsp;
					</td></c:forEach>
					</c:if>
					<c:if test="${i!=0 }"></tr></c:if>
				</table>
			</div>
			<!-- 메인 영화정보 끝 -->


		</div>
	</div>


	<!-- FOOTER 시작 -->
	<div id="footer">
		<div id="footer-wrap">
			<h4>메가박스 영화관 찾기</h4>
			<dl class="clearfix">
				<dt>서울</dt>
				<dd>
					<a href="">강남</a>
				</dd>
				<dd>
					<a href="">강남대로(씨티)</a>
				</dd>
				<dd>
					<a href="">강동</a>
				</dd>
				<dd>
					<a href="">동대문</a>
				</dd>
				<dd>
					<a href="">마곡</a>
				</dd>
				<dd>
					<a href="">목동</a>
				</dd>
				<dd>
					<a href="">상봉</a>
				</dd>

				<dd>
					<a href="">상암월드컵경기장</a>
				</dd>
				<dd>
					<a href="">센트럴</a>
				</dd>
				<dd>
					<a href="">송파파크하비오</a>
				</dd>
				<dd>
					<a href="">신촌</a>
				</dd>
				<dd>
					<a href="">은평</a>
				</dd>
				<dd>
					<a href="">이수</a>
				</dd>
				<dd>
					<a href="">창동</a>
				</dd>
				<dd>
					<a href="">코엑스</a>
				</dd>
				<dd>
					<a href="">화곡</a>
				</dd>
				<dd>
					<a href="">ARTNINE</a>
				</dd>
				<dd>
					<a href="">EOE4</a>
				</dd>
			</dl>
			<dl class="clearfix">
				<dt>경기</dt>
				<dd>
					<a href="">고양스타필드</a>
				</dd>
				<dd>
					<a href="">김포</a>
				</dd>
				<dd>
					<a href="">남양주</a>
				</dd>
				<dd>
					<a href="">동탄</a>
				</dd>

				<dd>
					<a href="">미사강변</a>
				</dd>

				<dd>
					<a href="">백석</a>
				</dd>

				<dd>
					<a href="">별내</a>
				</dd>
				<dd>
					<a href="">분당</a>
				</dd>
				<dd>
					<a href="">수원</a>
				</dd>
				<dd>
					<a href="">수원남문</a>
				</dd>
				<dd>
					<a href="">시흥배곧</a>
				</dd>
				<dd>
					<a href="">안산중앙</a>
				</dd>
				<dd>
					<a href="">양주</a>
				</dd>
				<dd>
					<a href="">영통</a>
				</dd>
				<dd>
					<a href="">오산</a>
				</dd>
				<dd>
					<a href="">의정부 민락</a>
				</dd>
				<dd>
					<a href="">일산</a>
				</dd>

				<dd>
					<a href="">일산벨라시타</a>
				</dd>
				<dd>
					<a href="">킨텍스</a>
				</dd>
				<dd>
					<a href="">파주금촌</a>
				</dd>
				<dd>
					<a href="">파주운정</a>
				</dd>
				<dd>
					<a href="">파주출판도시</a>
				</dd>
				<dd>
					<a href="">평택</a>
				</dd>
				<dd>
					<a href="">하남스타필드</a>
				</dd>
			</dl>
			<dl class="clearfix">
				<dt>인천</dt>
				<dd>
					<a href="">검단</a>
				</dd>
				<dd>
					<a href="">송도</a>
				</dd>
				<dd>
					<a href="">인천논현</a>
				</dd>
				<dd>
					<a href="">청라</a>
				</dd>


				<dd>
					<a href="">청라지젤</a>
				</dd>
			</dl>
			<dl class="clearfix dt_st1">
				<dt>대전 | 세종 | 충청</dt>
				<dd>
					<a href="">공주</a>
				</dd>
				<dd>
					<a href="">대전</a>
				</dd>
				<dd>
					<a href="">세종</a>
				</dd>

				<dd>
					<a href="">오창</a>
				</dd>

				<dd>
					<a href="">제천</a>
				</dd>

				<dd>
					<a href="">진천</a>
				</dd>
				<dd>
					<a href="">천안</a>
				</dd>
				<dd>
					<a href="">충주</a>
				</dd>

				<dd>
					<a href="">홍성내포</a>
				</dd>

			</dl>
			<dl class="clearfix dt_st2">
				<dt>부산 | 경상</dt>
				<dd>
					<a href="">거창</a>
				</dd>
				<dd>
					<a href="">경남대</a>
				</dd>

				<dd>
					<a href="">경산하양</a>
				</dd>
				<dd>
					<a href="">경주</a>
				</dd>
				<dd>
					<a href="">구미강동</a>
				</dd>
				<dd>
					<a href="">김천</a>
				</dd>

				<dd>
					<a href="">남포항</a>
				</dd>
				<dd>
					<a href="">대구(칠성로)</a>
				</dd>
				<dd>
					<a href="">대구신세계</a>
				</dd>
				<dd>
					<a href="">대구 이시아</a>
				</dd>
				<dd>
					<a href="">덕천</a>
				</dd>

				<dd>
					<a href="">마산</a>
				</dd>
				<dd>
					<a href="">문경</a>
				</dd>
				<dd>
					<a href="">부산극장</a>
				</dd>
				<dd>
					<a href="">부산대</a>
				</dd>
				<dd>
					<a href="">북대구(칠곡)</a>
				</dd>
				<dd>
					<a href="">사천</a>
				</dd>
				<dd>
					<a href="">삼천포</a>
				</dd>
				<dd>
					<a href="">서면</a>
				</dd>
				<dd>
					<a href="">안동</a>
				</dd>
				<dd>
					<a href="">양산</a>
				</dd>
				<dd>
					<a href="">울산</a>
				</dd>
				<dd>
					<a href="">정관</a>
				</dd>
				<dd>
					<a href="">창원</a>
				</dd>

				<dd>
					<a href="">해운대(장산)</a>
				</dd>
			</dl>
			<dl class="clearfix dt_st2">
				<dt>광주 | 전라</dt>
				<dd>
					<a href="">광주(충장로)</a>
				</dd>
				<dd>
					<a href="">광주상무</a>
				</dd>
				<dd>
					<a href="">광주하남</a>
				</dd>
				<dd>
					<a href="">남원</a>
				</dd>
				<dd>
					<a href="">목포</a>
				</dd>
				<dd>
					<a href="">목포하당(포르모)</a>
				</dd>
				<dd>
					<a href="">송천</a>
				</dd>
				<dd>
					<a href="">순천</a>
				</dd>
				<dd>
					<a href="">여수</a>
				</dd>

				<dd>
					<a href="">여수웅천</a>
				</dd>
				<dd>
					<a href="">전대(광주)</a>
				</dd>
				<dd>
					<a href="">전주(객사)</a>
				</dd>
				<dd>
					<a href="">첨단(광주)</a>
				</dd>
			</dl>
			<dl class="clearfix">
				<dt>강원</dt>
				<dd>
					<a href="">남춘천</a>
				</dd>
				<dd>
					<a href="">속초</a>
				</dd>
				<dd>
					<a href="">원주</a>
				</dd>
				<dd>
					<a href="">원주센트럴</a>
				</dd>
			</dl>
			<dl class="clearfix">
				<dt>제주</dt>
				<dd>
					<a href="">제주</a>
				</dd>
				<dd>
					<a href="">제주아라</a>
				</dd>
			</dl>
		</div>
	</div>

	<div id="footer1">
		<div id="footer1-wrap">
			<div class="logo">
				<a href="/webproject/" title="MEGABOX 메인으로 가기"><img
					src="http://image2.megabox.co.kr/mop/home/logo_footer_new.png"
					alt="MEGABOX"></a>
			</div>
			<div class="text1">
				회사소개 | 채용정보 | 제휴/광고/부대사업 문의 | 이용약관 | 개인정보 처리방침 | 고객센터<br /> 서울특별시
				강남구 도산대로 156, 2층 메가박스중앙(주) (논현동, 중앙엠앤비사옥)<br /> 대표자명 김진선 | 개인정보보호
				책임자 경영지원실 실장 박영진<br /> 사업자등록번호 211-86-59478 | 통신판매업신고번호 제 833호
			</div>
			<div class="text2">
				<img alt="" src="./login/image/footerimage.jpg"><br />
				Copyright 2014 by MegaboxJoongAng, Inc. All rights reserved
			</div>

		</div>
	</div>
	<!-- FOOTER 끝 -->

</body>

<script type="text/javascript">
	var itv = 2000;
	var mainImage = document.getElementById("banner-image");
	var imageIndex = 0;
	
	var ImageArray = new Array();
	ImageArray[0] = "./image/banner1.jpg";
	ImageArray[1] = "./image/banner2.jpg";
	ImageArray[2] = "./image/banner3.jpg";
	ImageArray[3] = "./image/banner4.jpg";
	ImageArray[4] = "./image/banner5.jpg";
	ImageArray[5] = "./image/banner6.jpg";

	function ImageRotate() {
		mainImage.setAttribute("src", ImageArray[imageIndex]);
		imageIndex++;
		if(imageIndex>=ImageArray.length){
			imageIndex=0;
		}
	}
	
	setInterval(ImageRotate,itv);
	
	
	function showPop(movie_id) {

		var url = "<%=cp%>/Movie/movie.do?movie_id=" + movie_id;

		var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=1100, height=650, left='+(screen.width-968)/2+'';
		
		window.open(url,"movieInfo",setting);
	
	
	} 
		 
		 function goToB(movie_id) {
				
			 var url = "<%=cp%>/Booking/booking.do?selectedMoviedId="+movie_id+"&checking=5";
				
				var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=1100, height=650, left='+(screen.width-968)/2+'';
				
				window.open(url,"booking",setting);
	
		}
		 
	function goPost(check){
		
		/* var f = document.hidden.check
		f.value = check;  */
		document.hidden.action = "<%=cp%>/index.jsp?check="+check;
		document.hidden.submit();
		
	}
	
	
	
	
	
</script>
</html>