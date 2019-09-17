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
.guest_book{width:100%;padding:0px; color: #363636; margin: 0px;margin-bottom: 0px;}
.g_book-box{width:100%;}
.g_book-box dd{width:100%; height:160px; padding:10px; font-size:10pt; border-top:1px solid #ddd; background:#fff;border-bottom:1px solid #ddd;}
.g_book-box dd span{float:right; font-size:9pt; font-weight: normal; cursor: pointer;}

</style>

<script type="text/javascript">


		 function showPop(movie_id) {
			
			
			var url = "<%=cp%>/Movie/movie.do?movie_id=" + movie_id;

			var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top=90, width=968, height=650, left='+(screen.width-968)/2+'';
			
			window.open(url,"movieInfo",setting);
		
		
		} 
		
</script>

</head>
<body>
<div id="list"><br/><br/>
* 본 영화 리스트는 실제 관람한 이력으로 보여지며, 상영일 익일에 자동 노출됩니다.<br/><br/><br/>
<c:if test="${!empty seenMovieList }">
<c:forEach items="${seenMovieList }" var="dto">
<div class="guest_book">	
            <dl class="g_book-box">
                <dd>
					<img alt="포스터" src="<%=path %>/${dto.getFile_name()}" style="float: left; margin-right: 10px" height="160px" width="100px">
                	<img alt="나이" src="<%=path %>/age${dto.age_limit }big.png" height="30px" width="30px" style="float: left; margin-right: 10px">
                		
                      <font size="4" style="font-weight: bold;">${dto.getMovie_name() }</font>
                      <!-- 한줄평 삭제 -->
                      
                      <a href="<%=cp%>/Mypage/seen_delete.do?booked_id=${dto.getBooked_id() }"><span><img src="<%=cp%>/mypage/image/del.JPG"></span></a>
                     <br/><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <!-- 상영시간 -->
                     <c:out value="${fn:substring(dto.getStart_time(),0,fn:length(dto.getStart_time())-6) }"></c:out>
                     <c:out value="${fn:substring(dto.getStart_time(),fn:length(dto.getStart_time())-6,fn:length(dto.getStart_time())) }"></c:out>~${dto.getEnd_time() }
                     <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     ${dto.getDistrict() } ${dto.getScreen_num() }관
                       <br/><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <!-- 평점 불러오기 -->
                       <c:if test="${empty dto.getRating()}">등록된 평점이 없습니다.</c:if>
                       <c:if test="${!empty dto.getRating() }">
                       		<c:choose>
                       			<c:when test="${dto.getRating()==0}">
                       				<img alt="" src="<%=cp%>/movie/image/rate0.png">
                       			</c:when>
                       			<c:when test="${dto.getRating()<3 && 0<dto.getRating() }">
                       				<img alt="" src="<%=cp%>/movie/image/rate1.png">
                       			</c:when>
                       			<c:when test="${2<dto.getRating() && dto.getRating()<5 }">
                       				<img alt="" src="<%=cp%>/movie/image/rate2.png">
                       			</c:when>
                       			<c:when test="${4<dto.getRating() && dto.getRating()<7 }">
                       				<img alt="" src="<%=cp%>/movie/image/rate3.png">
                       			</c:when>
                       			<c:when test="${6<dto.getRating() && dto.getRating()<9 }">
                       				<img alt="" src="<%=cp%>/movie/image/rate4.png">
                       			</c:when>
                       			<c:when test="${8<dto.getRating() && dto.getRating()<11 }">
                       				<img alt="" src="<%=cp%>/movie/image/rate5.png">
                       			</c:when>
                       		</c:choose>
                       </c:if>

                      <span><input type="button" value="한줄평 쓰기>" class="btn3" onclick="showPop(${dto.getMovie_id()})"></span>
                </dd>  
            </dl>

</div>
</c:forEach>
</c:if>
<c:if test="${empty seenMovieList }">
	<div class="guest_book">	
		<dl class="g_book-box">
			<dd style="text-align: center;">
			<br/><br/><br/><br/>
				본 영화가 없습니다.
			</dd>
		</dl>
	</div>

</c:if>



</div>
</body>
</html>