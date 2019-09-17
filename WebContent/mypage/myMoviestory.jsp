<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String linkpage  = request.getParameter("linkpage");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=cp%>/mypage/css/mypage.css" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>나의 메가박스</title>

<script type="text/javascript"> 

function calcHeight(){


 var the_height=
 document.getElementById('iframe1').contentWindow.
 document.body.scrollHeight;

 //change the height of the iframe
 document.getElementById('iframe1').height=
 the_height;

 document.getElementById('iframe1').scrolling = "atuo";
 document.getElementById('iframe1').style.overflow = "hidden";
}

function autoResize(id){
    var newheight;
    var newwidth;

    if(document.getElementById){
        newheight=document.getElementById(id).contentWindow.document .body.scrollHeight;
        newwidth=document.getElementById(id).contentWindow.document .body.scrollWidth;
    }

    document.getElementById(id).height= (newheight) + "px";
    document.getElementById(id).width= (newwidth) + "px";
}



</script>



</head>
<body>
<jsp:include page="../header.jsp" flush="false"/>
<div id="mypage">

<div style="clear: both;background-color: #f8f8f8; line-height: 20px; border-bottom: #352669 2px solid;padding-left: 20px; padding-right: 40px;">
<span class="font"><a href="<%=cp%>/Mypage/mypageMain.do"><br/>나의 메가박스</a>
<span class="right"><input type="button" class="btn1" value="로그아웃" onclick="javascript:location.href='<%=cp%>/Login/log_out.do';"></span>
<br/>&nbsp;<br/></span>
</div>

<br/>
<div><span class="font" style="padding-left: 20px;">${member.getUser_name() }</span> 님, 오늘도 영화처럼 멋진 하루 되세요!<br/><br/>
<br/><br/>
</div>

<div>
	<ul class="nav_gnb">     	
		<li>
            <a href="<%=cp%>/Mypage/myBooking.do"><img src="<%=cp%>/mypage/image/res.JPG" alt=""/><span>예매 확인/취소</span></a>
        </li>
        <li>
           <a href="#"><img src="<%=cp%>/mypage/image/moviestory.JPG" alt=""/><span>나의 무비스토리</span></a>
        </li>
        <li>
           <a href="<%=cp%>/Mypage/myInfo.do"><img src="<%=cp%>/mypage/image/update.JPG" alt=""/><span>개인정보수정</span></a>
        </li>
    </ul>
</div>

<div style="clear: both;">
	<br/>
<div style="clear: both;">
	<span class="title2">나의 무비스토리</span> &nbsp;&nbsp;&nbsp; 
	<br/><br/>
</div>

<div style="clear: both;">
	<ul>
		<li class="tab"><a href="<%=cp %>/mypage/list/interestingList.jsp" target="iframe1">보고싶어 (${wishList.size() })</a></li>
		<li class="tab"><a href="<%=cp %>/mypage/list/seenList.jsp" target="iframe1">본 영화 (${seenMovieList.size()})</a></li>
		<li class="tab"><a href="<%=cp %>/mypage/list/myCommentList.jsp" target="iframe1">나의 한줄평 (${commentsList.size() })</a></li>
	</ul>
</div>
	<br/><br/>

<div style="clear: both;">
<iframe onload="autoResize('iframe1')" src="<%=cp %>/mypage/list/<%=linkpage %>.jsp" id="iframe1" name="iframe1" frameborder="0" style="overflow-y:hidden; width:100%; min-height:700px; height:100%;">
</iframe>
</div>


</div>


</div>
<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>




