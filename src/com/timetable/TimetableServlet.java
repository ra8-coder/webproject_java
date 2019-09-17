package com.timetable;

import java.io.IOException;
import java.sql.Connection;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import util.DBCPConn;


public class TimetableServlet extends HttpServlet {

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
		TimetableDAO dao = new TimetableDAO(conn);		

		String cp = req.getContextPath();
		String url;
		String uri = req.getRequestURI();
		
		if (uri.indexOf("movieTime.do") != -1) {
			String imagePath = cp +"/timetable/image";		
			req.setAttribute("imagePath", imagePath);
			
			//city, district, movie_name, screen_num, start_time, end_time, seatedseat, seatnumber, type, age_limt, movie_id

			// ������ ��������(list)

			Calendar cal = Calendar.getInstance();
			//���ó�¥
			
			int y = cal.get(Calendar.YEAR);
			int m = cal.get(Calendar.MONTH) + 1;
			int d = cal.get(Calendar.DAY_OF_MONTH);
			String date;			
			date = y+"/";
			date = date.substring(2,4);	
			date = date+"/0"+m+"/"+d+"%";
			System.out.println(date);
			
			String movie_id=null;
			req.setAttribute("movie_id", movie_id);


			List<TimetableDTO> lists1 = dao.getMovie();
			req.setAttribute("lists1", lists1);		
			
			url="/timetable/movieTime.jsp";
			forward(req, resp, url);	
			
		}else if (uri.indexOf("movieTime_ok.do") != -1) {
			String imagePath = cp +"/timetable/image";
			String movie_id = req.getParameter("movie_id");
			req.setAttribute("movie_id", movie_id);
			
			
			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String day = req.getParameter("day");
			String date;
			if(year!=null){			
			
			date = year+"/";
			date = date.substring(2,4);	
			date = date+"/0"+month+"/"+day+"%";
			System.out.println(date);
			}else{
			
			Calendar cal = Calendar.getInstance();
			//���ó�¥
			
			int y = cal.get(Calendar.YEAR);
			int m = cal.get(Calendar.MONTH) + 1;
			int d = cal.get(Calendar.DAY_OF_MONTH);
			date = y+"/";
			date = date.substring(2,4);	
			date = date+"/0"+m+"/"+d+"%";
			System.out.println(date);
			
			
			}
			req.setAttribute("imagePath", imagePath);
			
			//List<TimetableDTO> lists = dao1.getList(movie_id,date);
			List<TimetableDTO> lists = dao.getList(movie_id,date);
			req.setAttribute("lists", lists);	
			
			List<TimetableDTO> lists1 = dao.getMovie();
			req.setAttribute("lists1", lists1);	
			
			url="/timetable/movieTime.jsp?movie_id="+movie_id;
			forward(req, resp, url);

		}else if (uri.indexOf("movieGuide.do") != -1) {
			
			String imagePath = cp +"/timetable/image";
			req.setAttribute("imagePath", imagePath);
			url="/timetable/movieGuide.jsp";
			forward(req, resp, url);
		}

	}

}
