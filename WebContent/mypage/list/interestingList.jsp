<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String path = cp + "/mv/imageFile";
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>interestingList</title>
<link rel="stylesheet" href="<%=cp%>/mypage/css/list.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/mypage/css/wishlist.css" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">

function showPop(movie_id) {
	
	var url = "<%=cp%>/Movie/movie.do?movie_id=" + movie_id;

	var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=968, height=650, left='+(screen.width-968)/2+'';
	
	window.open(url,"예약상세내역",setting);


} 

$(window).on('load', function () {
    load('#js-load', '4');
    $("#js-btn-wrap .button").on("click", function () {
        load('#js-load', '4', '#js-btn-wrap');
    })
});
 
function load(id, cnt, btn) {
    var girls_list = id + " .js-load:not(.active)";
    var girls_length = $(girls_list).length;
    var girls_total_cnt;
    if (cnt < girls_length) {
        girls_total_cnt = cnt;
    } else {
        girls_total_cnt = girls_length;
        $('.button').hide()
    }
    $(girls_list + ":lt(" + girls_total_cnt + ")").addClass("active");
}

function goToB(movie_id) {
	
	 var url = "<%=cp%>/Booking/booking.do?selectedMoviedId="+movie_id+"&checking=5";
		
		var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=968, height=650, left='+(screen.width-968)/2+'';
		
		window.open(url,"booking",setting);

}

</script>

</head>
<body>
<div id="list">
<br/><br/>
* 보고싶은 영화 해제는 영화 상세정보 페이지에서 가능합니다.
<div>

<c:if test="${empty wishList }">
<div id="content">
	<table style="float: left;" class="wish_movie" width="235px" height="515px">
		<tr>
			<td style="border-bottom: none;"><img alt="" src="<%=cp%>/mypage/image/wishmovie.JPG">
			</td>
		</tr>
	</table>
</div>
</c:if>


<div id="content">
<div id="js-load" class="main" style="width: 1000px">
<ul class="lists">
<c:forEach var="dto" items="${wishList }">
<li class="lists__item js-load" style="float: left; width: 230px">
	
		<table width="235px" height="503px" style="margin: 3px;">
			<tr>
				<td class="top">
				<img src="<%=path %>/${dto.file_name}" width="230px" height="330px" alt="포스터"/>
				</td>
			</tr>
			<tr>
				<td width="230px" height="50px" class="bottom">
				<span style="line-height: 25px;">
				<font color="grey" style="font-weight: bold; font-size: 11pt;">평점 ${dto.rating }</font></span>
				<span style="float: right;">
				<c:if test="${dto.rating==0 }"><img src="<%=cp %>/movie/image/rate0.png"></c:if>
				<c:if test="${dto.rating<3&&0<dto.rating}"><img src="<%=cp %>/movie/image/rate1.png"></c:if>
				<c:if test="${2<dto.rating&&dto.rating<5}"><img src="<%=cp %>/movie/image/rate2.png"></c:if>
				<c:if test="${4<dto.rating&&dto.rating<7 }"><img src="<%=cp %>/movie/image/rate3.png"></c:if>
				<c:if test="${6<dto.rating&&dto.rating<9 }"><img src="<%=cp %>/movie/image/rate4.png"></c:if>
				<c:if test="${8<dto.rating&&dto.rating<11 }"><img src="<%=cp %>/movie/image/rate5.png"></c:if>
				</span>
				</td>
			</tr>
			<tr>
				<td class="middle">
				<img src="<%=path %>/age${dto.age_limit }big.png" alt="나이">
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
			</tr>
	</table>
	</li>
		</c:forEach>	
</ul>
	
</div>
<div id="js-btn-wrap" class="btn-wrap" style="clear: both;"> <a href="javascript:;" class="button">더보기 + </a> </div>

</div>

</div>

</div>

</body>
</html>