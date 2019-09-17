package com.mypage;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.booking.bookedSeatDTO;
import com.login.MemberDAO;
import com.login.MemberDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import util.DBCPConn;

public class MypageServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		doPost(req, resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url)
			throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");

		String cp = req.getContextPath();

		Connection conn = DBCPConn.getConnection();

		MypageDAO dao = new MypageDAO(conn);

		MemberDAO memberdao = new MemberDAO(conn);

		String url;

		String uri = req.getRequestURI();

	
		String root = getServletContext().getRealPath("/");
		String path = root + "memberImages";

		File f = new File(path);

		if(!f.exists()){
			f.mkdirs();
		}

		if(uri.indexOf("mypageMain.do")!=-1){

			HttpSession session = req.getSession();
			
			MemberDTO member = (MemberDTO)session.getAttribute("member");
			
			if(member==null){
	
				forward(req, resp, cp);
				
			}
			else{
				
				String user_id = member.getUser_id();

				List<MyBookingDTO> recentBookedList = new ArrayList<MyBookingDTO>();

				recentBookedList = dao.getRecentBookedList(user_id);

				req.setAttribute("recentBookedList", recentBookedList);



				int wishMovieCount = dao.getWishMovieCount(member.getUser_id());
				int seenMovieCount = dao.getSeenMovieCount(member.getUser_id());
				int commentCount = dao.getCommentCount(member.getUser_id());

				req.setAttribute("wishMovieCount", wishMovieCount);
				req.setAttribute("seenMovieCount", seenMovieCount);
				req.setAttribute("commentCount", commentCount);



				String preferredTheater = dao.getPreferredTheater(member.getUser_id());

				session.setAttribute("preferredTheater", preferredTheater);

				url = "/mypage/mypageMain.jsp";
				forward(req, resp, url);
				
			}

		}else if(uri.indexOf("myBooking.do")!=-1){


			HttpSession session = req.getSession();

			MemberDTO member = (MemberDTO)session.getAttribute("member");

			String user_id = member.getUser_id();


			List<MyBookingDTO> bookingList = new ArrayList<MyBookingDTO>();

			bookingList = dao.getBookingList(user_id);

			session.setAttribute("bookingList", bookingList);

			List<MyBookingDTO> seenMovieList = new ArrayList<MyBookingDTO>();
			seenMovieList = dao.getSeenMoiveList(user_id);

			session.setAttribute("seenMovieList", seenMovieList);



			List<MyBookingDTO> canceledList = new ArrayList<MyBookingDTO>();

			canceledList = dao.getCanceledBooking(user_id);

			session.setAttribute("canceledList", canceledList);



			url = "/mypage/myBooking.jsp";
			forward(req, resp, url);


		}else if(uri.indexOf("cancel_ok.do")!=-1){

			//update cancel_date
			
			HttpSession session = req.getSession();

			MemberDTO member = (MemberDTO)session.getAttribute("member");

			String user_id = member.getUser_id();

			String booked_id = req.getParameter("booked_id");
			
			List<bookedSeatDTO> cancelSeatsList = new ArrayList<bookedSeatDTO>();
			
			cancelSeatsList = dao.getCancelseat(booked_id);

			dao.cancelReservation(booked_id);		
			dao.cancelSeats(cancelSeatsList);
			
			List<MyBookingDTO> bookingList = new ArrayList<MyBookingDTO>();

			bookingList = dao.getBookingList(user_id);

			session.setAttribute("bookingList", bookingList);
			
			List<MyBookingDTO> canceledList = new ArrayList<MyBookingDTO>();

			canceledList = dao.getCanceledBooking(user_id);

			session.setAttribute("canceledList", canceledList);

			url = cp+ "/mypage/list/cancelList.jsp";

			resp.sendRedirect(url);

		}else if(uri.indexOf("myMoivestory.do")!=-1){

			HttpSession session = req.getSession();

			MemberDTO member = (MemberDTO)session.getAttribute("member");
			
			if(member==null){
				
				url = "/Login/login.do";
				forward(req, resp, url);
				
			}

			String user_id = member.getUser_id();

			List<MyBookingDTO> seenMovieList = new ArrayList<MyBookingDTO>();
			seenMovieList = dao.getSeenMoiveList(user_id);

			session.setAttribute("seenMovieList", seenMovieList);

			List<CommentDTO> commentsList = new ArrayList<CommentDTO>();

			commentsList = dao.getCommentList(user_id);

			session.setAttribute("commentsList", commentsList);
			
			List<com.movie.MovieDTO> wishList = new ArrayList<com.movie.MovieDTO>();
			
			wishList = dao.getWishList(user_id);
			
			session.setAttribute("wishList", wishList);

			url = "/mypage/myMoviestory.jsp";
			forward(req, resp, url);

		}else if(uri.indexOf("myInfo.do")!=-1){

			url = "/mypage/myInfo.jsp";
			forward(req, resp, url);

		}else if(uri.indexOf("myInfo_ok.do")!=-1){

			HttpSession session = req.getSession();

			MemberDTO member = new MemberDTO();

			member = (MemberDTO)session.getAttribute("member");

			String user_id = member.getUser_id();

			String encType = "UTF-8";
			int maxSize = 10*1024*1024;
			String file_name;
			String preferred_theater;

			MultipartRequest mr = new MultipartRequest(req, path, maxSize, encType, new DefaultFileRenamePolicy());

			file_name = mr.getFilesystemName("file_name");


			//member image file check
			if(file_name!=null){

				String getFileName = dao.getMemberImage(user_id);

				if(getFileName==null){				
					dao.insertMemberImage(user_id, file_name);				
				}
				else{				
					dao.updateMemberImage(user_id, file_name);		
				}
			}

			MemberDTO updateMember = new MemberDTO();

			updateMember.setBirth(mr.getParameter("birth"));
			updateMember.setTel(mr.getParameter("tel"));
			updateMember.setEmail(mr.getParameter("email"));
			updateMember.setAddr(mr.getParameter("addr"));
			String city = mr.getParameter("city");
			String district = mr.getParameter("district");

			//preferred_theater check
			if(city!=null && district!=null){

				preferred_theater = dao.getPreferredTheater(user_id);

				String theater_id = dao.getTheaterId(city, district);

				if(preferred_theater==null){

					dao.insertPreferredTheater(user_id, theater_id);

				}
				else{

					dao.updatePreferredTheater(user_id, theater_id);
				}

			}

			//member update
			dao.updateMember(user_id, updateMember);

			MemberDTO dto = new MemberDTO();

			dto = memberdao.getReadMemberData(user_id);

			session.setAttribute("member", dto);

			String preferredTheater = dao.getPreferredTheater(member.getUser_id());

			session.setAttribute("preferredTheater", preferredTheater);

			url = cp + "/Mypage/mypageMain.do";

			resp.sendRedirect(url);

		}else if(uri.indexOf("seen_delete.do")!=-1){

			//seenList delete

			String booked_id = req.getParameter("booked_id");

			HttpSession session = req.getSession();

			MemberDTO member = new MemberDTO();

			member = (MemberDTO)session.getAttribute("member");

			String user_id = member.getUser_id();

			dao.deleteSeenMovie(booked_id);

			List<MyBookingDTO> seenMovieList = new ArrayList<MyBookingDTO>();

			seenMovieList = dao.getSeenMoiveList(user_id);

			session.setAttribute("seenMovieList", seenMovieList);

			url = cp + "/mypage/list/seenList.jsp";

			resp.sendRedirect(url);

		}else if(uri.indexOf("comm_delete.do")!=-1){

			String movie_id = req.getParameter("movie_id");

			HttpSession session = req.getSession();

			MemberDTO member = new MemberDTO();

			member = (MemberDTO)session.getAttribute("member");

			String user_id = member.getUser_id();

			dao.deleteComment(user_id, movie_id);
			
			dao.deleteRating(user_id, movie_id);

			List<CommentDTO> commentsList = new ArrayList<CommentDTO>();

			commentsList = dao.getCommentList(user_id);

			session.setAttribute("commentsList", commentsList);

			url = cp + "/mypage/list/myCommentList.jsp";

			resp.sendRedirect(url);

		}else if(uri.indexOf("comm_update.do")!=-1){
			
			String movie_id = req.getParameter("movie_id");
			String var = "comments" + movie_id;
			String comments = req.getParameter(var);
			

			HttpSession session = req.getSession();
			MemberDTO member = new MemberDTO();
			member = (MemberDTO)session.getAttribute("member");
			String user_id = member.getUser_id();
			
			dao.updateComment(comments, user_id, movie_id);
			
			List<CommentDTO> commentsList = new ArrayList<CommentDTO>();
			commentsList = dao.getCommentList(user_id);

			session.setAttribute("commentsList", commentsList);

			url = cp + "/mypage/list/myCommentList.jsp";
			
			resp.sendRedirect(url);
			
		}else if(uri.indexOf("delImage_ok")!=-1){
			
			HttpSession session = req.getSession();
			MemberDTO member = new MemberDTO();
			member = (MemberDTO)session.getAttribute("member");
			String user_id = member.getUser_id();
			
			dao.deleteMemberImage(user_id);
			
			MemberDTO dto = new MemberDTO();

			dto = memberdao.getReadMemberData(user_id);

			session.setAttribute("member", dto);
			
			url = cp + "/mypage/mypageMain.jsp";
			
			resp.sendRedirect(url);
			
		}else if(uri.indexOf("updatePwd.do")!=-1){
			
			url = "/mypage/updatePwd.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("updatePwd_ok.do")!=-1){
			
			HttpSession session = req.getSession();
			MemberDTO member = new MemberDTO();
			member = (MemberDTO)session.getAttribute("member");
			String user_id = member.getUser_id();
			
			String user_pwd = req.getParameter("new_pwd1");
			
			dao.updateUserPwd(user_pwd, user_id);
			
			session.removeAttribute("member"); 
			session.invalidate();	
			
			resp.sendRedirect(cp);
			
		}else if(uri.indexOf("cancelMember.do")!=-1){
			
			url = "/mypage/cancelMember.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("cancelMember_ok.do")!=-1){
			
			HttpSession session = req.getSession();
			MemberDTO member = new MemberDTO();
			member = (MemberDTO)session.getAttribute("member");
			String user_id = member.getUser_id();
			
			dao.deleteMember(user_id);
			
			resp.sendRedirect(cp);

		}else if(uri.indexOf("bookingDetail.do")!=-1){
			
			String booked_id = req.getParameter("booked_id");
			
			MyBookingDTO detailDTO = new MyBookingDTO();
			
			detailDTO = dao.getDetailBooking(booked_id);
			
			List<String> seats = new ArrayList<String>();
			
			seats = dao.getDetailSeats(booked_id);
			
			String price = dao.getDetailPrice(booked_id);
			
			req.setAttribute("detailDTO", detailDTO);
			req.setAttribute("seats", seats);
			req.setAttribute("price", price);
			
			url = "/mypage/bookingDetail.jsp";
			forward(req, resp, url);
			
		}		

	}

	

}
