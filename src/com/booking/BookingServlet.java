package com.booking;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.login.MemberDTO;
import com.sun.java.swing.plaf.windows.resources.windows;
import com.timetable.TimetableDAO;
import com.timetable.TimetableDTO;

import util.DBCPConn;

public class BookingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// Get占쏙옙占� 처占쏙옙
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	// 占쏙옙占쏙옙占쏙옙 占쌨소듸옙
	protected void forward(HttpServletRequest req, HttpServletResponse resp,
			String url) throws ServletException, IOException {

		// url 占쏙옙 占쌍소뤄옙 RequestDistpatcher 占쏙옙체 占쏙옙占쏙옙
		RequestDispatcher rd = req.getRequestDispatcher(url);
		// 占쏙옙占쏙옙占쏙옙 占쌜억옙
		rd.forward(req, resp);

	}

	// Post 占쏙옙占� 처占쏙옙
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		Connection conn = DBCPConn.getConnection();
		BookingDAO dao = new BookingDAO(conn);
		TimetableDAO dao2 = new TimetableDAO(conn);
		String cp = req.getContextPath();
		String uri = req.getRequestURI();

		String url;

		if (uri.indexOf("booking.do") != -1) {

			List<TheaterDTO> lists = dao.getReadData(); // 영화관 리스트 가져오기

			req.setAttribute("lists", lists);

			Calendar cal = Calendar.getInstance();

			// 오늘날짜

			int nowDay = cal.get(Calendar.DAY_OF_MONTH); // 현재 요일
			int nowHour = cal.get(Calendar.HOUR_OF_DAY); // 현재 시간
			// 클라이언트에서 넘어온 데이터
			String nowHour2 = req.getParameter("nowHour"); // 시간 이동
			String nowDay2 = req.getParameter("nowDay"); // 날짜 이동

			String selectedDate2 = Integer.toString(nowDay); // 선택된 날짜
			String selectedHour2 = Integer.toString(nowHour); // 선택된 시간

			int hour = nowHour;
			int day = nowDay;

			if (nowHour2 != null) {
				hour = Integer.parseInt(nowHour2);
			}

			if (nowDay2 != null) {
				day = Integer.parseInt(nowDay2);
			}

			String strDate = req.getParameter("selectedDate");
			String strHour = req.getParameter("selectedHour");
			
			if (strDate != null) {
				selectedDate2 = strDate;
				//System.out.println(selectedDate2);
			}else if(strDate == null){
				selectedDate2 = Integer.toString(nowDay);
			}

			if (strHour != null) {
				selectedHour2 = strHour;
			}
			String selectedMoviedId2 = "0";

			String strMovieId = req.getParameter("selectedMoviedId");

			if (strMovieId != null) {
				selectedMoviedId2 = strMovieId;
			}

			String selectedTheaterId2 = "0";

			String strTheaterId = req.getParameter("theaterId");
			if (strTheaterId != null) {
				selectedTheaterId2 = strTheaterId;
			}

			String checkPara = "0";
			String strPara = req.getParameter("checking");
			if(strPara != null){
				checkPara = strPara;
			}
			
			if(checkPara.equals("1")){ // 모두 선택되었을때
				System.out.println(selectedDate2);
				System.out.println(selectedHour2);
				System.out.println(selectedTheaterId2);
				System.out.println(selectedMoviedId2);
				List<MovieDTO> lists2 = dao.getMovieData(selectedDate2,selectedHour2,selectedTheaterId2,selectedMoviedId2);
				req.setAttribute("lists2", lists2);
			}
			
			if(checkPara.equals("2")){ // 날짜만 선택되었을때
				if(selectedDate2 == nowDay2){
					List<MovieDTO> lists2 = dao.getMovieData(selectedDate2);
					req.setAttribute("lists2", lists2);
					
				}else {
					List<MovieDTO> lists2 = dao.getMovieData3(selectedDate2);
					req.setAttribute("lists2", lists2);
				}
				
			}
			
			if(checkPara.equals("3")){ // 날짜 시간 선택되었을때
				List<MovieDTO> lists2 = dao.getMovieData(selectedDate2,selectedHour2);
				req.setAttribute("lists2", lists2);
			}
			
			if(checkPara.equals("4")){ // 날짜 시간 영화관 선택되었을때
				if(selectedDate2 == nowDay2){
					List<MovieDTO> lists2 = dao.getMovieData(selectedDate2,selectedHour2,selectedTheaterId2);
					req.setAttribute("lists2", lists2);
					
				}else{
					List<MovieDTO> lists2 = dao.getMovieData4(selectedDate2,selectedHour2,selectedTheaterId2);
					req.setAttribute("lists2", lists2);
					
				}
			}
			
			if(checkPara.equals("5")){ // 날짜 영화 선택되었을때
				List<MovieDTO> lists2 = dao.getMovieData1(selectedMoviedId2);
				req.setAttribute("lists2", lists2);
			}
			
			
			
			// 세션에 올리기


			String imagePath2 = cp + "/movie/image"; // timetable 이미지 경로
			req.setAttribute("imagePath2", imagePath2);
			
			req.setAttribute("nowDay", nowDay);
			req.setAttribute("hour", hour);
			req.setAttribute("day", day);
			req.setAttribute("selectedDate", selectedDate2);
			req.setAttribute("selectedHour", selectedHour2);
			req.setAttribute("selectedMovieId", selectedMoviedId2);
			req.setAttribute("theaterId", selectedTheaterId2);

			url = "/booking/booking.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("calendar.do") != -1) {
			url = "/booking/calendar.jsp";
			forward(req, resp, url);

			
		} else if (uri.indexOf("seatSelect.do") != -1) {
			
			String screen_id = req.getParameter("screen_id");
			//System.out.println(screen_id);
			req.setAttribute("screen_id", screen_id);
			
			MovieDTO movieDTO = dao.getScreenInfo(screen_id);
			
			String age_limit = movieDTO.getAge_limit();
			String movie_name = movieDTO.getMovie_name();
			String screen_num = movieDTO.getScreen_num();
			String start_time = movieDTO.getStart_time();
			String type = movieDTO.getType();
			String district = movieDTO.getDistrict();
			
		
			List<BookingDTO> lists_seat = dao.getSeatInfo(screen_id); // 예약된 좌석 정보 가져오기
			
			Iterator<BookingDTO> it = lists_seat.iterator();
			while(it.hasNext()){
				BookingDTO dto = it.next();
				dto.getRnum();
				dto.getStatus();
				
				System.out.print(dto.getScreen_id());
				System.out.print(dto.getRnum());
				System.out.print(dto.getRow_num());
				System.out.print(dto.getSeat_num());
				System.out.print(dto.getStatus());
				System.out.print("\n");
			}
			
			
			String value11 = req.getParameter("value1"); // 성인
			String value22 = req.getParameter("value2"); // 청소년
			String value33 = req.getParameter("value3"); // 어린이
			String value44 = req.getParameter("value4"); // 우대
			
			String value1 = "0";
			String value2 = "0";
			String value3 = "0";
			String value4 = "0";
			
			if(value11 != null){
				value1 =value11;
			}
			if(value22 != null){
				value2 =value22;
			}
			
			if(value33 != null){
				value3 =value33;
			}
			if(value44 != null){
				value4 =value44;
			}
			
			
			int price = 0;

			if (value1 != null) {
				price = (Integer.parseInt(value1) * 10000)
						+ (Integer.parseInt(value2) * 8000)
						+ (Integer.parseInt(value3) * 4000)
						+ (Integer.parseInt(value4) * 5000);
			}

			req.setAttribute("value1", value1);
			req.setAttribute("value2", value2);
			req.setAttribute("value3", value3);
			req.setAttribute("value4", value4);
			
			//------------------------------------------------------------------
			req.setAttribute("age_limit", age_limit);
			req.setAttribute("movie_name", movie_name);
			req.setAttribute("screen_num", screen_num);
			req.setAttribute("start_time", start_time);
			req.setAttribute("type",type);
			req.setAttribute("district", district);
			
			//------------------------------------------------------------------
			req.setAttribute("priceMessage", price); // 선택인원에 따른 값 반환

			
			//------------------------------------------------------------------
			String imagePath = cp + "/timetable/image"; // timetable 이미지 경로
			req.setAttribute("imagePath", imagePath);
			
			String imagePath2 = cp + "/movie/image"; // timetable 이미지 경로
			req.setAttribute("imagePath2", imagePath2);

			//------------------------------------------------------------------
			req.setAttribute("lists_seat", lists_seat);

			url = "/booking/seatSelect.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("seatSelect_ok.do") != -1) {
			
			
			HttpSession session = req.getSession();

			MemberDTO member = (MemberDTO)session.getAttribute("member");
			
			if(member==null){
				//로그인해야합니다.페이지로 넘기기
				url = "/booking/needLogin.jsp";
				forward(req, resp, url);
				return;
			}
			
			String user_id = member.getUser_id();
			System.out.println("userid: "+user_id);

			String screen_id = req.getParameter("screen_id");
			req.setAttribute("screen_id", screen_id);
			
			
			
			
			int[] type = new int[]{0,0,0,0};
			
			
			type[0] = Integer.parseInt(req.getParameter("value1"));
			
			type[1] = Integer.parseInt(req.getParameter("value2"));
			
			type[2] = Integer.parseInt(req.getParameter("value3"));
			
			type[3] = Integer.parseInt(req.getParameter("value4"));
			
			System.out.println(type[0]);
			System.out.println(type[1]);
			System.out.println(type[2]);
			System.out.println(type[3]);
				

			
			//------------------------------------------------------------------
			//좌석예매
			String[] temp = req.getParameterValues("arrSeatNum");
			
			//System.out.println(temp.length);
			
			String[] seatNum;
			
			seatNum = temp[0].split(",");
			
			
			int bookedNum = dao.getBookedNum()+1;
			
			if(seatNum!=null){
			
			
			for(int i = 0; i<seatNum.length; i++){
				
				int ticketType=0;
				for(int j = 0; j<4; j++){
					
					if(type[j]!=0){
						ticketType = j+1;
						System.out.println("type:"+ticketType);
						type[j]--;
						break;
					}
					
				}
				
				bookedSeatDTO dto = new bookedSeatDTO();
				
				String row_num = "";
				int seat_num = 0;
				
				if(Integer.parseInt(seatNum[i])/10==0){
					row_num = "A";
					seat_num = Integer.parseInt(seatNum[i])%10;
				}if(Integer.parseInt(seatNum[i])/10==1){
					row_num = "B";
					seat_num = Integer.parseInt(seatNum[i])%10;
				}if(Integer.parseInt(seatNum[i])/10==2){
					row_num = "C";
					seat_num = Integer.parseInt(seatNum[i])%10;
				}if(Integer.parseInt(seatNum[i])/10==3){
					row_num = "D";
					seat_num = Integer.parseInt(seatNum[i])%10;
				}
				
				dto.setRow_num(row_num);
				dto.setSeat_num(seat_num);
				dto.setScreen_id(screen_id);
				dto.setType(Integer.toString(ticketType));
				//dto.setType("1");
				dto.setUser_id(user_id);
				
				dao.updateSeatStatus(screen_id, row_num, seat_num);
				dao.insertBookedSeats(dto,bookedNum);
				
				
			}
			
	
			
			}
			
			//------------------------------------------------------------------
			
			
//			dao.insertBookedSeats(lists, maxNum);

			url = "/booking/bookingOK.jsp";
			forward(req, resp, url);
			return;
			
			
		}else if (uri.indexOf("theaterSelect.do") != -1) {

			// String nowHour2 = req.getParameter("nowHour");
			// String nowDay2 = req.getParameter("nowDay");
			// String strDate = req.getParameter("seletedDate");
			// int hour = 0 ;
			// int day = 0;
			// if (strDate != null) {
			// String[] strTemp = strDate.split("일");
			// String seletedDate2 = strTemp[0];
			// System.out.println(seletedDate2);
			// }
			// if (nowHour2 != null) {
			// hour = Integer.parseInt(nowHour2);
			// }
			//
			// if (nowDay2 != null) {
			// day = Integer.parseInt(nowDay2);
			// }
			//
			//
			// req.setAttribute("hour", hour);
			// req.setAttribute("day", day);

			List<TheaterDTO> lists = dao.getReadData(); // 영화관 리스트 가져오기

			req.setAttribute("lists", lists);

			url = "/booking/theaterSelect.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("movieSelect.do") != -1) {

			
			
		
			Calendar cal = Calendar.getInstance();
			
			// 오늘날짜

			int nowDay = cal.get(Calendar.DAY_OF_MONTH); // 현재 요일
			int nowHour = cal.get(Calendar.HOUR_OF_DAY); // 현재 시간

			// 클라이언트에서 넘어온 데이터
			String nowHour2 = req.getParameter("nowHour"); // 시간 이동
			String nowDay2 = req.getParameter("nowDay"); // 날짜 이동

			String selectedDate2 = "0"; // 선택된 날짜
			String selectedHour2 = "0"; // 선택된 시간

			int hour = nowHour;
			int day = nowDay;

			if (nowHour2 != null) {
				hour = Integer.parseInt(nowHour2);
			}

			if (nowDay2 != null) {
				day = Integer.parseInt(nowDay2);
			}

			String strDate = req.getParameter("selectedDate"); // 선택된 날짜
			if (strDate != null) {
				String[] strTemp = strDate.split("일");
				selectedDate2 = strTemp[0];
				//System.out.println(selectedDate2);
			}

			selectedHour2 = req.getParameter("selectedHour"); // 선택된 시간

			String selectedMoviedId2 = "0";

			String strMovieId = req.getParameter("selectedMoviedId");

			if (strMovieId != null) {
				selectedMoviedId2 = strMovieId;
			}

			String selectedTheaterId2 = "0";

			String strTheaterId = req.getParameter("theaterId");
			if (strTheaterId != null) {
				selectedTheaterId2 = strTheaterId; // 선택된 영화관
			}

			req.setAttribute("hour", hour);
			req.setAttribute("day", day);
			req.setAttribute("selectedDate", selectedDate2);
			req.setAttribute("selectedHour", selectedHour2);
			req.setAttribute("selectedMovieId", selectedMoviedId2);
			req.setAttribute("theaterId", selectedTheaterId2);

			String imagePath = cp + "/timetable/image"; // timetable 이미지 경로
			List<TimetableDTO> lists1 = dao2.getMovie();
		
			
			req.setAttribute("lists1", lists1);
			req.setAttribute("imagePath", imagePath);

			String imagePath2 = cp + "/movie/image"; // timetable 이미지 경로
			req.setAttribute("imagePath2", imagePath2);

			
			url = "/booking/movieSelect.jsp";
			forward(req, resp, url);
			
			
			
		} 

	}

}
