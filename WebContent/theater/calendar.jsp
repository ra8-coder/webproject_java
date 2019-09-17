<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.Calendar"%>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();	
%>

<%
	Calendar cal = Calendar.getInstance();

	// 오늘날짜
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH) + 1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);

	// 클라이언트에서 넘어온 데이터
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");

	//표시할 달력의 년과 월
	int year = nowYear;
	int month = nowMonth;

	if (strYear != null) {
		year = Integer.parseInt(strYear); // 클라이언트가 선택한 연도
	}

	if (strMonth != null) {
		month = Integer.parseInt(strMonth); // 클라이언트가 선택한 월
	}

	int preYear = year;
	int preMonth = month - 1;

	if (preMonth < 1) {
		preYear = year - 1;
		preMonth = 12;
	}
	int nextYear = year;
	int nextMonth = month + 1;
	if (nextMonth > 12) {
		nextYear = year + 1;
		nextMonth = 1;
	}

	//표시할 달력 세팅
	cal.set(year, month - 1, 1);
	int startDay = 1;
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

	int week = cal.get(Calendar.DAY_OF_WEEK);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>달력</title>
<script type="text/javascript">
 	function gotoToday(){
 		var f = document.myForm;
 		f.action = "calendar.do?year=nowYear&month=nowMonth";
		f.submit();

	}
</script>
<style>
body {
	font-size: 12pt;
}

td {
	font-size: 12pt;
}
</style>

</head>
<body>
	<form name="myForm">
		<table align="center" width="210" cellpadding="1" cellspacing="1">
			<tr>
				<td align="center">
					<a href="calendar.do?year=<%=preYear%>&month=<%=preMonth%>">◀</a> <b>&nbsp;<%=year%>
						년&nbsp;&nbsp;<%=month%>월
				</b> <a href="calendar.do?year=<%=nextYear%>&month=<%=nextMonth%>">▶</a>
				</td>

			</tr>
		</table>
		<br/>
		<table align="center" width="240" cellpadding="0" cellspacing="1"
			bgcolor="#cccccc">

			<tr>

				<td bgcolor="#e6e4e6" align="center"><font color="red">일</font></td>
				<td bgcolor="#e6e4e6" align="center">월</td>
				<td bgcolor="#e6e4e6" align="center">화</td>
				<td bgcolor="#e6e4e6" align="center">수</td>
				<td bgcolor="#e6e4e6" align="center">목</td>
				<td bgcolor="#e6e4e6" align="center">금</td>
				<td bgcolor="#e6e4e6" align="center"><font color="blue">토</font></td>
			</tr>
			<%
				int newLine = 0;
				out.print("<tr height = '30'>");
				for (int i = 1; i < week; i++) {
					out.print("<td bgcolor ='#ffffff'>&nbsp;</td>");
					newLine++;

				}

				for (int i = startDay; i <= endDay; i++) {
					String fontColor = (newLine == 0) ? "red"
							: (newLine == 6) ? "blue" : "black";
					String bgColor = (nowYear == year) && (nowMonth == month)
							&& (nowDay == i) ? "#e6e4e6" : "ffffff";
					out.print("<td align = 'center' bgcolor='" + bgColor
							+ "'><font color = '" + fontColor + "'>" + 
					"<a style = 'text-decoration:none; color : '"+ fontColor + "' href = javascript:location.href='/Theater/theaterP2.do?date='"+i+"'>"+i
							+"</a>"+ "</font></td>");

					newLine++;
					if (newLine == 7 && i != endDay) {
						out.print("<tr/><tr height = '30'>");
						newLine = 0;
					}

				}

				while (newLine > 0 && newLine < 7) {
					out.print("<td bgColor = '#ffffff'>&nbsp;</td>");
					newLine++;
				}
				out.print("</tr>");
			%>
			<tr>
				<td></td>
			</tr>

		</table>
	</form>

</body>
</html>