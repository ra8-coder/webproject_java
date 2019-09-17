package com.theater;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DBCPConn;

public class TheaterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		
		doPost(req, resp);
		
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp,
			String url) throws ServletException, IOException {
			
		RequestDispatcher rd = req.getRequestDispatcher(url);
		
		rd.forward(req, resp);
	
	}
	

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		
		Connection conn = DBCPConn.getConnection();
		TheaterDAO dao = new TheaterDAO(conn);
		
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;
		 
		if(uri.indexOf("theater.do") != -1){
			String imagePath = cp +"/timetable/image";		
			req.setAttribute("imagePath", imagePath);

			url = "/theater/theater.jsp";
			forward(req, resp, url);
		
		}else if(uri.indexOf("theaterP2.do") != -1){
			String imagePath = cp +"/timetable/image";		
			req.setAttribute("imagePath", imagePath);
			
			Calendar cal = Calendar.getInstance();
			int y = cal.get(Calendar.YEAR);
			int m = cal.get(Calendar.MONTH) + 1;
			int d = cal.get(Calendar.DAY_OF_MONTH);
			String date;			
			date = y+"/";
			date = date.substring(2,4);	
			date = date+"/0"+m+"/"+d+"%";

			//다음페이지 데이터 받기
			String theater_id = req.getParameter("theater_id");
			String start_time = req.getParameter("start_time");
			
			req.setAttribute("theater_id", theater_id);
			req.setAttribute("start_time", start_time);
	
			url = "/theater/theaterP2.jsp";
			forward(req, resp, url);
			
		}else if (uri.indexOf("theaterP2_ok.do") != -1) {
			String imagePath = cp +"/timetable/image";		
			req.setAttribute("imagePath", imagePath);
			
			String theater_id = req.getParameter("theater_id");
			req.setAttribute("theater_id", theater_id);
			
			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String day = req.getParameter("day");
			String date;
			if (year != null) {

				date = year + "/";
				date = date.substring(2, 4);
				date = date + "/0" + month + "/" + day + "%";
			} else {

				Calendar cal = Calendar.getInstance();

				int y = cal.get(Calendar.YEAR);
				int m = cal.get(Calendar.MONTH) + 1;
				int d = cal.get(Calendar.DAY_OF_MONTH);
				date = y + "/";
				date = date.substring(2, 4);
				date = date + "/0" + m + "/" + d + "%";

			}

			List<TheaterDTO> lists = dao.getlist(theater_id,date);			
			req.setAttribute("lists", lists);
			
			url = "/theater/theaterP2.jsp?theater_id="+theater_id;
			forward(req, resp, url);
			
		}else if(uri.indexOf("calendar.do") != -1){
			
			url = "/theater/calendar.jsp";
			forward(req, resp, url);
		
		}
			
			
			
			
			
		
	}
	
	
}
