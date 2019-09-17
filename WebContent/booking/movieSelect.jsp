<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화 선택</title>

<script type="text/javascript">
	function sendIt(){
		var f = document.myForm;
		
		var movieRb = document.getElementsByName("movie");
		var movieId ;
		for(var i = 0 ; i < movieRb.length ; i++){
			if(movieRb[i].checked == true){
				movieId = movieRb[i].value;
			}
		}
		
		changedDate = ${day };
		changedTime = ${hour };
		date = ${selectedDate };
		hour = ${selectedHour }; 
		//
		theaterId = ${theaterId };
		
	
		if(!movieId){
			alert("영화를 선택해주세요!");		
			return;
		}
		// 영화가 선택되었으면 checking에 1을 함께 보냄
		f.action= "<%=cp %>/Booking/booking.do/?selectedMoviedId=" + movieId 
				+ "&nowHour=" + changedTime + "&nowDay=" +changedDate
				+ "&selectedDate="+date+"&selectedHour="+ hour + "&theaterId="+theaterId+"&checking=1";
		f.submit();
		
	}

</script>


</head>
<body>
	<div align="center">
	<form name="myForm" method="post" action="">
	<c:set var = "i" value = "1"></c:set>
	<table  border="0"   cellpadding="0" cellspacing="10" align="center" >
		<c:if test="${i % 4 == 1 }">
			<tr height="190">		
		</c:if>
		
			<c:forEach var="dto" items="${lists1 }">	
			
			<td width="260">
			<center>
			<img src="${imagePath}/${dto.movie_name}.PNG" width="200" height="180" border="2">
			</center>
			<br/><br/>
		
			<input type="radio" value ="${dto.movie_id }" name ="movie"/>
			<c:if test="${dto.age_limit=='all' }"><img src="${imagePath2 }/ageallbig.png" style="background-color:#555555; width: 18px; height: 18px;" ></c:if>
			<c:if test="${dto.age_limit=='12' }"><img src="${imagePath2 }/age12big.png" style="background-color:#555555; width: 18px; height: 18px; "></c:if>
			<c:if test="${dto.age_limit=='15' }"><img src="${imagePath2 }/age15big.png" style="background-color:#555555; width: 18px; height: 18px; "></c:if>
			<c:if test="${dto.age_limit=='18' }"><img src="${imagePath2 }/age18big.png" style="background-color:#555555; width: 18px; height: 18px;"></c:if>
			${dto.movie_name}
			</td>	
			
		<c:if test="${i %4 == 0 }">
			</tr>		
		</c:if>
		<c:set var = "i" value="${i+1 }"></c:set>
			</c:forEach>	
		<tr height="20">
			<td></td>
		</tr>
	</table>
	
	<center>
	<hr width="1100" >
		<input type="button" value = "취소" onclick="javascript:location.href='<%=cp %>/Booking/booking.do'" style=" font-size :13pt ; font-weight :bold;  width: 95px; height: 40px; background-color: #F9F9F9 ; color : #747474 ;border: 0"/>
				
		<input type="button" value = "다음" onclick="sendIt();" style=" font-size :13pt ; font-weight :bold;  width: 95px; height: 40px; background-color: #513396; color: #ffffff; border: 0"/>
	</center>

	</form>

	</div>


</body>
</html>