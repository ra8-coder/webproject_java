<%@page import="util.DBCPConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.booking.BookingDAO"%>
<%@page import="com.booking.bookedSeatDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<title>좌석 선택</title>

<link rel="stylesheet" href="<%=cp%>/booking/css/bookingstyle.css"
	type="text/css" />

<style type="text/css">



.checkbox-wrap1 .check-icon {
	display: inline-block;
	width: 29px;
	height: 29px;
	background: url(<%=cp%>/booking/image/s1.png) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap2 .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url(<%=cp%>/booking/image/s2.png) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap3 .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url(<%=cp%>/booking/image/s3.png) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap4 .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url(<%=cp%>/booking/image/s4.png) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap5 .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url(<%=cp%>/booking/image/s5.png) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap6 .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url(<%=cp%>/booking/image/s6.png) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap7 .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url(<%=cp%>/booking/image/s7.png) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap8 .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url(<%=cp%>/booking/image/s8.png) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap9 .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url(<%=cp%>/booking/image/s9.png) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

 .checkbox-wrap0 .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url(<%=cp%>/booking/image/noSeat.PNG) left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap {
	cursor: pointer;
}

.checkbox-wrap0 input[type=checkbox] {
	display: none;
}

.checkbox-wrap1 input[type=checkbox] {
	display: none;
}

.checkbox-wrap2 input[type=checkbox] {
	display: none;
}

.checkbox-wrap3 input[type=checkbox] {
	display: none;
}

.checkbox-wrap4 input[type=checkbox] {
	display: none;
}

.checkbox-wrap5 input[type=checkbox] {
	display: none;
}

.checkbox-wrap6 input[type=checkbox] {
	display: none;
}

.checkbox-wrap7 input[type=checkbox] {
	display: none;
}

.checkbox-wrap8 input[type=checkbox] {
	display: none;
}

.checkbox-wrap9 input[type=checkbox] {
	display: none;
}

.checkbox-wrap input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}

.checkbox-wrap0 input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}

.checkbox-wrap1 input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}

.checkbox-wrap2 input[type=checkbox]:checked+.check-icon {
	background-image: url('<%=cp%>/booking/image/selected.PNG');
}

.checkbox-wrap3 input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}

.checkbox-wrap4 input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}

.checkbox-wrap5 input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}

.checkbox-wrap6 input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}

.checkbox-wrap7 input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}

.checkbox-wrap8 input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}

.checkbox-wrap9 input[type=checkbox]:checked+.check-icon {
	background-image: url(<%=cp%>/booking/image/selected.PNG);
}
</style>

<script type="text/javascript">

	function checkNum(){
		var maxCheck = 0; // 최대 인원수 
		var cntCheck = 0; // 사용자가 체크한 체크박스 개수
		var f = document.seatSelectForm;

		var value1 = ${value1};
		var value2 = ${value2};
		var value3 = ${value3};
		var value4 = ${value4};
		
		maxCheck = value1 + value2 + value3 + value4; // 총인원수 
		
		var arr_Check = document.getElementsByName("seatCheckBox");

		for (var i = 0; i < arr_Check.length; i++) {
			if (arr_Check[i].checked == true) {
				cntCheck++; // 체크 되어있다면 1증가
// 				alert(cntCheck);
			}
		}

		if (cntCheck >= maxCheck) {
			alert("좌석 선택이 완료되었습니다 !");
			for (var i = 0; i < arr_Check.length; i++) {
				
				f['seatCheckBox'][i].disabled = true;
				
			}
			for (var i = 0; i < arr_Check.length; i++) {
				
				if (arr_Check[i].checked == true) {
					f['seatCheckBox'][i].disabled = false;
				}
				
			}
			
			return;
			
		}else{
			for (var i = 0; i < arr_Check.length; i++) {
				
				f['seatCheckBox'][i].disabled = false;
				
			}
		}
	}
	
	
	function selectNum(){
		var f = document.seatSelectForm;
		
		var cvalue1 = f.type1.selectedIndex;
		value1 = f.type1.options[cvalue1].value;
		var cvalue2 = f.type2.selectedIndex;
		
		value2 = f.type2.options[cvalue2].value;
		
		cvalue3 = f.type3.selectedIndex;
		
		value3 = f.type3.options[cvalue3].value;
		
		var cvalue4 = f.type4.selectedIndex;
		
		value4 = f.type4.options[cvalue4].value;
		
		var moviename = encodeURI("${movie_name}");
		var starttime = encodeURI("${start_time}");
		var type = encodeURI("${type}");
		var district = encodeURI("${district}");
		var age_limit = encodeURI("${age_limit}");
		
		
		f.action = "<%=cp%>/Booking/seatSelect.do?value1=" + value1
				+ "&value2=" + value2 + "&value3=" + value3 + "&value4="+ value4 + 
				"&movie_name=" + moviename+"&age_limit=" +age_limit+
				"&screen_num=" + ${screen_num}+"&start_time=" +starttime+
				"&type=" + type+"&district=" + district+"&screen_id="+${screen_id};
		f.submit();
	}

	function cntCheck() {
		var maxCheck = 0; // 최대 인원수 
		var cntCheck = 0; // 사용자가 체크한 체크박스 개수
		var f = document.seatSelectForm;

		var value1 = ${value1};
		var value2 = ${value2};
		var value3 = ${value3};
		var value4 = ${value4};
		

		var arrSeatNum = new Array; // 선택된 좌석 번호 저장할 배열

		maxCheck = value1 + value2 + value3 + value4; // 총인원수 
// 		alert("최대 선택 가능한 좌석 수 :" + maxCheck);

		var arr_Check = document.getElementsByName("seatCheckBox");

		for (var i = 0; i < arr_Check.length; i++) {
			if (arr_Check[i].checked == true) {
				cntCheck++; // 체크 되어있다면 1증가
				arrSeatNum.push(arr_Check[i].value); // 체크박스의 값을 배열에 추가
			}
		}
// 		alert("선택한 좌석수 : " + cntCheck);
	

		if (cntCheck > maxCheck) {
			alert("선택하신 좌석 개수 확인해주세요 ! ");
			return;
		}

		
		
		f.action = "<%=cp%>/Booking/seatSelect_ok.do?arrSeatNum=" + arrSeatNum
				+ "&screen_id=" + ${screen_id }+"&value1=" + value1 + "&value2=" + value2 + "&value3=" + value3
				+ "&value4=" + value4;
		f.submit();

	}
</script>
</head>
<body>
	<div align="center">
		<form name="seatSelectForm" method="post">
			<table border="1" cellpadding="0" cellspacing="0" width="1000"
				class="tb2" style="border-color: #CFCFCF; border-width: 1px;">
				<tr height="50">
					<td colspan="2"><span class="text"
						style="margin-left: 20px; margin-top: 10px;">인원/좌석선택</span></td>
				</tr>

				<tr>
					<%-- 일반		<c:when test=""></c:when>	 --%>
					<td>일반 <select class="selection" name="type1"
						onchange="selectNum();">

							<option value=0>0</option>
							<option value=1>1</option>
							<option value=2>2</option>
							<option value=3>3</option>
							<option value=4>4</option>
							<option value=5>5</option>
							<option value=6>6</option>
							<option value=7>7</option>
							<option value=8>8</option>

							<option value=${value1 } selected="selected">${value1 }</option>
					</select> 청소년 <select class="selection" name="type2" onchange="selectNum();">
							<option value=0>0</option>
							<option value=1>1</option>
							<option value=2>2</option>
							<option value=3>3</option>
							<option value=4>4</option>
							<option value=5>5</option>
							<option value=6>6</option>
							<option value=7>7</option>
							<option value=8>8</option>
							<option value=${value2 } selected="selected">${value2 }</option>
					</select> 어린이 <select class="selection" name="type3" onchange="selectNum();">
							<option value=0>0</option>
							<option value=1>1</option>
							<option value=2>2</option>
							<option value=3>3</option>
							<option value=4>4</option>
							<option value=5>5</option>
							<option value=6>6</option>
							<option value=7>7</option>
							<option value=8>8</option>
							<option value=${value3 } selected="selected">${value3 }</option>
					</select> 우대 <select class="selection" name="type4" onchange="selectNum();">
							<option value=0>0</option>
							<option value=1>1</option>
							<option value=2>2</option>
							<option value=3>3</option>
							<option value=4>4</option>
							<option value=5>5</option>
							<option value=6>6</option>
							<option value=7>7</option>
							<option value=8>8</option>
							<option value=${value4 } selected="selected">${value4 }</option>
					</select> 

						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span
						style="text-align: right; font-size: 9pt">인원 선택은 최대 8명까지
							가능합니다.</span>
					</td>

					<td rowspan="2" style="background-color: #555555" width="220">

						<table border="0" width="220" cellpadding="0" cellspacing="0">
							<tr height="250">
								<td style="background-color: #555555"><img alt="IMG"
									src="${imagePath}/${movie_name}.PNG" width="220" height="235">
									<!-- 영화정보 이미지 불러오기 --></td>
							</tr>
							<tr height="50">
								<td style="background-color: #555555">
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td rowspan="2" style="background-color: #555555"><c:if
													test="${age_limit=='all' }">
													<img src="${imagePath2 }/ageallbig.png"
														style="background-color: #555555">
												</c:if> <c:if test="${age_limit=='12' }">
													<img src="${imagePath2 }/age12big.png"
														style="background-color: #555555">
												</c:if> <c:if test="${age_limit=='15' }">
													<img src="${imagePath2 }/age15big.png"
														style="background-color: #555555">
												</c:if> <c:if test="${age_limit=='18' }">
													<img src="${imagePath2 }/age18big.png"
														style="background-color: #555555;">
												</c:if></td>
											<td style="background-color: #555555"><span
												style="color: white; background-color: #555555">
													&nbsp;&nbsp;${movie_name } </span></td>
										</tr>
										<tr>
											<td style="background-color: #555555"><span
												style="font-size: 8pt; color: white; background-color: #555555">
													&nbsp;&nbsp;&nbsp;&nbsp;${type }</span></td>
										</tr>
									</table>
								</td>
							</tr>

							<tr>
								<td style="background-color: #555555">
									<ul style="background-color: #555555; color: #5CD1E5;">
										<li
											style="background-color: #555555; list-style-type: square;">
											<span style="color: white; background-color: #555555">
												${district }<br /> ${screen_num }관
										</span>
										</li>
										<li
											style="background-color: #555555; list-style-type: square;">
											<span style="color: white; background-color: #555555">
												${start_time } </span>
										</li>


									</ul>
								</td>
								<!-- 영화 상세정보 -->
							</tr>
							<tr height="60">
								<td style="background-color: #555555"></td>
							</tr>
							<tr height="50">
								<td style="background-color: #555555; text-align: right;">
									<c:if test="${!empty priceMessage }">
										<span
											style="color: white; background-color: #555555; font-size: 14pt;">
											${priceMessage } 원</span>
									</c:if>
								</td>
								<!-- 결제금액 정보 -->
							</tr>


						</table>

					</td>
				</tr>

				<tr>
					<td>
						<table border="1"
							style="margin-top: 10px; margin-left: 10px; margin-right: 10px; margin-bottom: 10px;">
							<tr height="50">
								<td width="600"><img alt=""
									src="<%=cp%>/booking/image/screen.PNG"></td>

								<td rowspan="3"><img alt=""
									src="<%=cp%>/booking/image/infoSeatPic.PNG" width="" height="">
									<!-- 좌석안내 이미지 --></td>
							</tr>
							
							<tr height="150">
								<td><c:set var="k" value="1"></c:set>
									<div align="center">
										<table border="0" cellpadding="0" cellspacing="0">

											<c:forEach var="dto3" items="${lists_seat }">
												<c:if test="${dto3.rnum % 9 == 1 }">
													<tr height="70">
												</c:if>
												<td align="center" width="77" style="font-size: 13pt;">

													<c:if test="${k==1 }">
														<span style="font-weight: bold;">A&nbsp;</span>
													</c:if> <c:if test="${k==10 }">
														<span style="font-weight: bold;">B&nbsp;</span>
													</c:if> <c:if test="${k==19 }">
														<span style="font-weight: bold;">C&nbsp;</span>
													</c:if> <c:if test="${k==28}">
														<span style="font-weight: bold;">D&nbsp;</span>
													</c:if> <c:if test="${dto3.rnum>=1 && dto3.rnum <10}">

														<c:choose>
															<c:when test="${dto3.rnum eq 1 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap1"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 2 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled" /><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap2"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 3 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled" /><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap3"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 4 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap4"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 5 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap5"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 6 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap6"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 7 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap7"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 8 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">

																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">

																		<label class="checkbox-wrap8"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 9 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap9"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>
														</c:choose>


													</c:if> <c:if test="${dto3.rnum>=10 && dto3.rnum < 19}">
														<c:choose>
															<c:when test="${dto3.rnum eq 10 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap1"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();" /><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 11 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap2"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 12 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap3"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 13 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap4"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 14 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap5"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 15 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap6"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 16 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap7"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 17 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">

																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">

																		<label class="checkbox-wrap8"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 18 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap9"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>
														</c:choose>

													</c:if> <c:if test="${dto3.rnum>=19 && dto3.rnum <28}">

														<c:choose>
															<c:when test="${dto3.rnum eq 19 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled" /><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap1"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 20 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled" /><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap2"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 21 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap3"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 22 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap4"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 23 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap5"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 24 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap6"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 25 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap7"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 26 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">

																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">

																		<label class="checkbox-wrap8"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 27 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap9"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>
														</c:choose>

													</c:if> <c:if test="${dto3.rnum>=28 && dto3.rnum <=36}">

														<c:choose>
															<c:when test="${dto3.rnum eq 28 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap1"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();" /><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 29 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap2"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 30 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled" /><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap3"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 31 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap4"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 32 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap5"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();" /><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>

															</c:when>

															<c:when test="${dto3.rnum eq 33 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap6"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 34 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap7"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 35 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">

																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">

																		<label class="checkbox-wrap8"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>

															<c:when test="${dto3.rnum eq 36 }">
																<c:choose>
																	<c:when test="${dto3.status eq 1 }">
																		<label class="checkbox-wrap0"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox[]" disabled="disabled"/><i class="check-icon"></i>
																		</label>
																	</c:when>

																	<c:when test="${dto3.status ne 1 }">
																		<label class="checkbox-wrap9"> <input
																			type="checkbox" value=${dto3.rnum }
																			name="seatCheckBox" onclick="checkNum();"/><i class="check-icon"></i>
																		</label>
																	</c:when>
																</c:choose>
															</c:when>
														</c:choose>
													</c:if>

												</td>
												<c:if test="${dto3.rnum % 9 == 0 }">
													</tr>
												</c:if>

												<c:set var="k" value="${k+1 }"></c:set>
											</c:forEach>
										</table>
									</div></td>
							</tr>
						</table>
					</td>

				</tr>

				<tr height="40">
					<td>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr align="center">
								<td width="460"></td>
								<td width="100"><img
									src="<%=cp%>/booking/image/reChoice.PNG" width="100"
									height="35"
									onclick="javascript:location.href='<%=cp%>/Booking/booking.do'" />
								</td>
								<td width="200"><span style="font-weight: bold;"> 좌석 선택 인원  ${value1 + value2+ value3+ value4 }</span></td>
							</tr>

						</table>
					</td>
					<td style="background-color: #555555">
						<table border="0" align="center" style="background-color: #555555"
							cellpadding="0" cellspacing="0">
							<tr height="40">
								<td><input type="button" value="이전"
									onclick="javascript:location.href='<%=cp%>/Booking/booking.do'"
									style="font-size: 13pt; font-weight: bold; width: 95px; height: 40px; background-color: #F9F9F9; color: #747474; border: 0" />
								</td>
								<td style="background-color: #555555; width: 20px;"></td>
								<td><input type="button" value="다음" onclick="cntCheck();"
									style="font-size: 13pt; font-weight: bold; width: 95px; height: 40px; background-color: #513396; color: #ffffff; border: 0" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>