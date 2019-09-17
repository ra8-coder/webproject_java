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
<title>최신 개봉작</title>
<link rel="stylesheet" href="<%=cp%>/movie/css/list.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<script type="text/javascript">


		 function showPop(movie_id) {

			var url = "movie.do?movie_id=" + movie_id;

			var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=1100, height=650, left='+(screen.width-968)/2+'';
			
			window.open(url,"movieInfo",setting);
		} 
		 
		 function goToB(movie_id) {
				
				var url = "<%=cp%>/Booking/booking.do?movie_id=" + movie_id;
				
				var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=1100, height=650, left='+(screen.width-968)/2+'';
				
				window.open(url,"booking",setting);
		}
		 function loginPlz() {
				
			 alert("로그인 후 이용 가능합니다")
			 return;	 
		}

		
</script>
</head>
<jsp:include page="../header.jsp" flush="false"/>
<body>
<form action="" method="post" id="mvForm">
<div id="title">
	<table width="1000px" height="50px" align="center" style="vertical-align: middle;" class="topMenu">
		<tr>
			<td><a href=<%=cp %>/Movie/list.do>박스오피스</a></td>
			<td><a href=<%=cp %>/Movie/list_date.do><font color="#503396">최신개봉작</font></a></td>
			<td><a href=<%=cp %>/Movie/list_pre.do>상영예정작</a></td>
			<td><span style="float: left;">
			<c:choose>
				<c:when test="${empty sessionScope.member.user_id }">
					<td><span style="float: left;">
					<a href="javascript:loginPlz();">♥ 보고싶어</a></span>
				</c:when>
				<c:otherwise>
					<td><span style="float: left;">
					<a href="<%=cp%>/Movie/wish.do">♥ 보고싶어</a></span>
				</c:otherwise>
			</c:choose>
		
			<span style="float: right;">
			<font size="2pt">
			<a href="<%=cp %>/Mypage/myMoivestory.do?linkpage=interestingList">나의 무비스토리 ></a></font></span></td>
		</tr>
	</table>
</div>

<div id="content">
	<table width="990px">
		<tr>
		<td height="50px" colspan="4"></td>

		</tr>
	<c:set var="i" value="0"/>
	<c:forEach var="dto" items="${lst }">
	<c:if test="${i==0 }">
		<tr>
	</c:if>
	<c:if test="${i!=0&&i%4==0 }">
		</tr>
		<tr>
	</c:if>
		<td width="242px" height="517px">
		<table width="230px" height="503px" style="margin: 3px;">
			<tr>
				<td class="top">
				<img src="${imagePath }/${dto.file_name}" width="230px" height="330px"/>
				</td>
			</tr>
			<tr>
				<td width="230px" height="50px" class="bottom">
				<span style="line-height: 25px;">
				<font color="grey" style="font-weight: bold; font-size: 11pt;">평점 ${dto.rating }</font></span>
				<span style="float: right;">
				<c:if test="${dto.rating==0 }"><img src="${imagePath }/rate0.png"></c:if>
				<c:if test="${dto.rating<3&&0<dto.rating}"><img src="${imagePath }/rate1.png"></c:if>
				<c:if test="${2<dto.rating&&dto.rating<5}"><img src="${imagePath }/rate2.png"></c:if>
				<c:if test="${4<dto.rating&&dto.rating<7 }"><img src="${imagePath }/rate3.png"></c:if>
				<c:if test="${6<dto.rating&&dto.rating<9 }"><img src="${imagePath }/rate4.png"></c:if>
				<c:if test="${8<dto.rating&&dto.rating<11 }"><img src="${imagePath }/rate5.png"></c:if>
				</span>
				</td>
			</tr>
			<tr>
				<td class="middle">
				<img src="${imagePath }/age${dto.age_limit }big.png">
				<font color="#353535" style="font-weight: bold; vertical-align: top;">
				<a href="javascript:showPop(${dto.movie_id});">
				<c:choose>
					<c:when test="${fn:length(dto.movie_name)>10 }">
						<c:out value="${fn:substring(dto.movie_name,0,8) }"/>…
					</c:when>
					<c:otherwise>
						<c:out value="${dto.movie_name }"></c:out>
					</c:otherwise>
				</c:choose>
				</a>
				</font>
				</td>
			</tr>
			<tr>
				<td class="bottom" align="center"> 
				<input type="hidden" id="movieid" value="${dto.movie_id }"/>
				<input type="button" value="상세정보" class="btn1"
				onclick="showPop(${dto.movie_id});"/>
				&nbsp;<input type="button" value="예매하기" class="btn1"
				onclick="goToB(${dto.movie_id});"/></td>
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
</form>	
</div>




<div style="clear: both;">
<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>