<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");

	String cp = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화관 산택</title>
<script type="text/javascript">
	function sendIt() {
		var f = document.myForm;
		
// 		var id = f.ff.value;
		
// 		var id2 = document.getElementById("theater").value;
		opener.document.getElementById("theater1").value = document.getElementById("ff").value;
		
// 		opener.parent.location.reload();
		window.close(); // 창 닫음
	}
</script>

</head>
<body>
<!-- 	<form name="myForm" target = "main"> -->
		<c:forEach var="dto" items="${lists }">
			<dl>
				<dd
					style="font-size: 14pt; font-family: sans-serif; font-weight: bold;">
					${dto.city } | ${dto.district } 영화관 <input type="radio" id = "ff" value="${dto.district } "  />
						
				</dd>
			</dl>
			<hr color="#CFCFCF">
		</c:forEach>
		
		<dl>
			<dd> 
			<input type="button" value = "취소" onclick="window.close();" style=" font-size :13pt ; font-weight :bold;  width: 95px; height: 40px; background-color: #F9F9F9 ; color : #747474 ;border: 0"/>
			<input type="button" value = "다음" onclick="sendIt();" style=" font-size :13pt ; font-weight :bold;  width: 95px; height: 40px; background-color: #513396; color: #ffffff; border: 0"/>
			</dd>
		</dl>
<!-- 	</form> -->
</body>
</html>