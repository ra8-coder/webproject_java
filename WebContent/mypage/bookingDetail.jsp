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
<link rel="stylesheet" href="<%=cp%>/mypage/css/mypage.css" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>예매 상세정보</title>

<script type="text/javascript">

function cancel(booked_id) {
	
	var f = document.myForm

	if(confirm("예매를 취소하시겠습니까?") == true){
		
		f.action = "<%=cp%>/Mypage/list/cancel_ok.do?booked_id=" + booked_id;
			
		f.submit();
		
		window.opener.location.reload();
		
		window.close();

	}else{
		return;
	}
}

</script>


</head>
<body>
<div id="detailPage">
<div style="clear: both;background-color: #f8f8f8; line-height: 20px; border-bottom: #666 2px solid;text-align: center; padding-bottom: 20px; padding-top: 20px;">
<font size="5pt" style="font-weight: bold;">예매 상세 정보</font></div>
</div>

<div id="detailPage">

<div style="clear: both;">
	<br/>

<div style="float:left ; padding-left: 20px;">

<table class="detail">
	<tr>
		<th colspan="2"><font size="4pt" style="font-weight: bold;">예매내역</font>
		</th>
	</tr>
	<tr>
		<td width="150px" style="background-color: #f8f8f8"><b>예매 영화</b>
		</td>
		<td>${detailDTO.movie_name } ${detailDTO.screen_type }
		</td>
	</tr>
	<tr>
		<td style="background-color: #f8f8f8"><b>예매 번호</b> 
		</td>
		<td>${detailDTO.booked_id }
		</td>
	</tr>
	<tr>
		<td style="background-color: #f8f8f8"><b>관람 일시</b>
		</td>
		<td><c:out value="${fn:substring(detailDTO.start_time,0,fn:length(detailDTO.start_time)-3) }"></c:out>
		</td>
	</tr>
	<tr>
		<td style="background-color: #f8f8f8"><b>관람 인원</b>
		</td>
		<td>${seats.size() }명
		</td>
	</tr>
	<tr>
		<td style="background-color: #f8f8f8"><b>상영 영화관</b>
		</td>
		<td>${detailDTO.district } ${detailDTO.screen_num }관
		</td>
	</tr>
	<tr>
		<td style="background-color: #f8f8f8"><b>좌석</b>
		</td>
		<td>
			<c:forEach var="seat" items="${seats }">
			${seat } | 
			</c:forEach>
		</td>
	</tr>
	<tr>
		<td style="background-color: #f8f8f8"><b>전화번호</b>
		</td>
		<td>${member.tel }
		</td>
	</tr>

</table>
</div>

<div style="float: left;padding-left: 10px;">
<br/><br/>
	<img src="<%=path %>/${detailDTO.file_name}" width="210px" height="310px" alt="포스터" />
</div>



<div style="clear: both; padding-left: 20px;">
<table class="detail">
	<tr>
		<th colspan="2"><font size="4pt" style="font-weight: bold;">결제정보</font>
		</th>
	</tr>
	<tr>
		<td width="150px" style="background-color: #f8f8f8"><b>결제일</b>
		</td>
		<td>${detailDTO.reservation_date }
		</td>
	</tr>
	<tr>
		<td style="background-color: #f8f8f8"><b>결제금액</b>
		</td>
		<td>${price }원
		</td>	
	</tr>

</table>
</div>

</div>
<form action="" name="myForm" method="post">
<div align="center">
<br/><br/><br/>
<input type="button" value="예매 취소" class="btn3" onclick="cancel(${detailDTO.booked_id });">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="확인" class="btn4" onclick="window.close();">
</div>
</form>


</div>
</body>
</html>