<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%	//POST 방식에서 한글깨짐을 방지
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>header</title>


<style type="text/css">

body{font-family: 'Nanum Gothic', sans-serif;}

#header-wrap {
	position: fixed;
	top: -3px;
	width: 100%;
	background-color: white;
	z-index: 15;
}

#header {
	background-color: white;
	width: 1140px;
	margin: 0 auto;
	padding-left: 35px;
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
	margin-top: 75px;
	padding-left: 40px;
	height: 80px;
	width: 1140px;;
	padding-bottom: -30px;
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
</style>


</head>
<body>
	
		<!-- HEADER 시작 -->
	<div id="header-wrap">
		<div id="header">
			<ul>
				<li style="list-style: none; border: none; padding-top: 2px;"><a href="<%=cp%>"><img alt=""
						src="<%=cp%>/login/image/magabox.jpg"></a></li>
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
						src="<%=cp%>/login/image/timetable.jpg"></a></li>
				<li class="menu-right" style="margin-left: 5px">
				<img alt="" src="<%=cp%>/login/image/booking.jpg" onclick="<%=str%>"></li>
			</ul>
		</div>
	</div>
	<!-- HEADER 끝 -->


</body>
</html>