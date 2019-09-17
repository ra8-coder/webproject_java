<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%	//POST 방식에서 한글깨짐을 방지
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
.btn {
	border-style: none;
	height: 50px;
	width: 150px;
	margin-top: 0px;
	background-color: #351f66;
	color: #ffffff;
	font-weight: bold;
}

</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인이 필요합니다.</title>
</head>
<body onresize="parent.resizeTo(500,400)" onload="parent.moveTo(750,300);">




<table width="470" height="310" style="border-style: solid; border-color: #352669; border-width: 8px">
	<tr>
		<td align="center" style="font-size: 20pt; font-weight: 100">로그인이 필요합니다.</td>
	</tr>
	<tr>	
		<td align="center">
			<input type="button" class="btn" value="창닫기" onclick="window.close();">
		</td>
	</tr>
</table>

</body>
</html>