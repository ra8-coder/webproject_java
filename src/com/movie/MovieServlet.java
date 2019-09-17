package com.movie;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.ha.backend.Sender;

import com.login.MemberDTO;
import com.mypage.MypageDAO;

import util.DBCPConn;
import util.MyUtil;

public class MovieServlet extends HttpServlet{

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

		Connection conn = DBCPConn.getConnection();
		MovieDAO dao = new MovieDAO(conn);
		MypageDAO daoMP = new MypageDAO(conn);
		MyUtil myUtil = new MyUtil();
		

		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;
		
		String root = getServletContext().getRealPath("/");
		String path = root + "memberImages";

		File f = new File(path);
		if(!f.exists())
			f.mkdirs();

		if(uri.indexOf("list.do")!=-1){// ��ȭ ����Ʈ

			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if(pageNum!=null)
				currentPage = Integer.parseInt(pageNum);

			//��ü ������ ����
			int numPerPage = 21;
			int dataCount = dao.getDataCount();

			int totalPage = myUtil.getPageCount(numPerPage, dataCount);

			if(currentPage>totalPage)
				currentPage=totalPage;

			//������ ���۰� ��
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;

			List<MovieDTO> lst = dao.getAllMV(start, end);

			String listUrl = cp + "/Movie/list.do";
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

			String imagePath = cp + "/mv/imageFile";

			req.setAttribute("lst", lst);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum", currentPage);
			req.setAttribute("totalPage", totalPage);
			req.setAttribute("imagePath", imagePath);


			url = "/movie/list.jsp";
			forward(req, resp, url);

		}else if(uri.indexOf("movie.do")!=-1){//��ȭ ��������
			
			HttpSession session = req.getSession();
			MemberDTO member = new MemberDTO();
			member = (MemberDTO)session.getAttribute("member");
			
			
			
			
			MovieDTO dto = new MovieDTO();
			String movie_id = req.getParameter("movie_id");

			dto = dao.getOneData(movie_id);

			List<MovieDTO> still = dao.getStillcut(movie_id);
			List<MovieDTO> comm = dao.getAllComment(movie_id);
			int stillCount = dao.getStillCount(movie_id);
			int wishCount = dao.wishCount(movie_id);

			dto.setSummary(dto.getSummary().replaceAll("/", "<br>"));
			
			/////////-------------------------------------
			
			if(member!=null){
				
				String user_id = member.getUser_id();
				
				String wish = dao.searchWishlist(user_id, movie_id);
				req.setAttribute("wish", wish);
				
				int commCheck = dao.commentCheck(movie_id, user_id);
				req.setAttribute("commCheck", commCheck);
				
			}

			////////--------------------------------------
				
			String imagePath = cp + "/mv/imageFile";
			String profileImg = cp + "/memberImages";

			req.setAttribute("imagePath", imagePath);
			req.setAttribute("dto", dto);
			req.setAttribute("still", still);
			req.setAttribute("comm", comm);
			req.setAttribute("stillCount", stillCount);
			req.setAttribute("profileImg", profileImg);
			req.setAttribute("wishCount", wishCount);

			url = "/movie/movie.jsp?movie_id= + movie_id";
			forward(req, resp, url);

			
		}else if(uri.indexOf("comments.do")!=-1){// ������ �ۼ�

			HttpSession session = req.getSession();

			MemberDTO member = (MemberDTO)session.getAttribute("member");

			String user_id = member.getUser_id();

			String movie_id = req.getParameter("movie_id");

			MovieDTO dto = new MovieDTO();

			dto.setMovie_id(movie_id);
			dto.setUser_id(user_id);
			dto.setComments(req.getParameter("comments"));
			if(req.getParameter("rating")==""){
				dto.setRating(0);
			}else{
			dto.setRating(Integer.parseInt(req.getParameter("rating")));
			}

			dao.insertComment(dto);

			url = cp + "/Movie/movie.do?movie_id=" + movie_id;			
			resp.sendRedirect(url);

			
		}else if(uri.indexOf("delete.do")!=-1){//������ ����
			
			HttpSession session = req.getSession();
			MemberDTO member = (MemberDTO)session.getAttribute("member");

			String user_id = member.getUser_id();
			String movie_id = req.getParameter("movie_id");
			
			dao.delComment(movie_id, user_id);
			
			url = cp +"/Movie/movie.do?movie_id=" + movie_id;
			resp.sendRedirect(url);
		
			
		}else if(uri.indexOf("update.do")!=-1){
			
			HttpSession session = req.getSession();
			MemberDTO member = new MemberDTO();
			member = (MemberDTO)session.getAttribute("member");
			
			MovieDTO dto = new MovieDTO();
			
			dto.setUser_id(member.getUser_id());
			dto.setMovie_id(req.getParameter("movie_id"));
			dto.setComments(req.getParameter("contentArea"));
			if(req.getParameter("rating_t")==""){
				dto.setRating(0);
			}else{
			dto.setRating(Integer.parseInt(req.getParameter("rating_t")));
			}
			
			dao.updateComment(dto);
			
			url = cp + "/Movie/movie.do?movie_id=" + dto.getMovie_id();
			resp.sendRedirect(url);
			
			
			

		}else if(uri.indexOf("list_date.do")!=-1){//�ֱٰ�����ȭ ������


			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if(pageNum!=null)
				currentPage = Integer.parseInt(pageNum);

			//��ü ������ ����
			int numPerPage = 21;
			int dataCount = dao.getDataCount();

			int totalPage = myUtil.getPageCount(numPerPage, dataCount);

			if(currentPage>totalPage)
				currentPage=totalPage;

			//������ ���۰� ��
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;

			List<MovieDTO> lst = dao.getListDate(start, end);

			String listUrl = cp + "/Movie/list.do";
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

			String imagePath = cp + "/mv/imageFile";

			req.setAttribute("lst", lst);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum", currentPage);
			req.setAttribute("totalPage", totalPage);
			req.setAttribute("imagePath", imagePath);


			url = "/movie/list_date.jsp";
			forward(req, resp, url);

		
		}else if(uri.indexOf("list_pre.do")!=-1){ //����������ȭ ������


			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if(pageNum!=null)
				currentPage = Integer.parseInt(pageNum);

			//��ü ������ ����
			int numPerPage = 21;
			int dataCount = dao.getDataCount();

			int totalPage = myUtil.getPageCount(numPerPage, dataCount);

			if(currentPage>totalPage)
				currentPage=totalPage;

			//������ ���۰� ��
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;

			List<MovieDTO> lst = dao.getListPre(start, end);
			
					
			String listUrl = cp + "/Movie/list.do";
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

			String imagePath = cp + "/mv/imageFile";

			req.setAttribute("lst", lst);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum", currentPage);
			req.setAttribute("totalPage", totalPage);
			req.setAttribute("imagePath", imagePath);


			url = "/movie/list_pre.jsp";
			forward(req, resp, url);	
			

		}else if(uri.indexOf("movieTime_ok.do")!=-1){ //�󿵽ð�ǥ

			String movie_id = req.getParameter("movie_id");


			url = "/timetable/movieTime_ok.jsp?movie_id=" + movie_id;
			forward(req, resp, url);
			
			
			
		}else if(uri.indexOf("wish.do")!=-1){//����;� ������
			
			List<MovieDTO> lst = new ArrayList<MovieDTO>();
			
			HttpSession session = req.getSession();
			MemberDTO member = new MemberDTO();
			member = (MemberDTO)session.getAttribute("member");
			
			String user_id = member.getUser_id();
			
			lst = daoMP.getWishList(user_id);
			
			
			
			String imagePath = cp + "/mv/imageFile";
			
			req.setAttribute("lst", lst);
			req.setAttribute("imagePath", imagePath);
			
			url = "/movie/wish.jsp";
			forward(req, resp, url);
			

		}else if(uri.indexOf("recommend.do")!=-1){
			
			String user_id = req.getParameter("user_id");
			String movie_id = req.getParameter("movie_id");
			
			int result = dao.recommend(user_id, movie_id);
			
			req.setAttribute("result", result);
			
			url = cp + "/Movie/movie.do?movie_id=" + movie_id;
			resp.sendRedirect(url);
			
		

		////////--------------------------------------
			
		}else if(uri.indexOf("wish_add.do")!=-1){
			
			HttpSession session = req.getSession();
			MemberDTO member = new MemberDTO();
			member = (MemberDTO)session.getAttribute("member");
			String movie_id = (String) req.getParameter("movie_id");
			String message = null;
			
			if(member!=null){
				
				String user_id = member.getUser_id();

				dao.insertWishlist(user_id, movie_id);
			}
			else{
				message =  "로그인 후 이용할 수 있습니다!";
			}
			
			req.setAttribute("message", message);
			/*
			url = cp + "/Movie/movie.do?movie_id=" + movie_id;
			resp.sendRedirect(url);
			*/
			
			url = "/Movie/movie.do?movie_id=" + movie_id;
			forward(req, resp, url);
			
		}else if(uri.indexOf("wish_remove.do")!=-1){
				
			HttpSession session = req.getSession();
			MemberDTO member = new MemberDTO();
			member = (MemberDTO)session.getAttribute("member");
			String user_id = member.getUser_id();
			
			String movie_id = (String) req.getParameter("movie_id");	
			
			dao.deleteWishlist(user_id, movie_id);
			
			url = cp +"/Movie/movie.do?movie_id=" + movie_id;
			resp.sendRedirect(url);
		}
		
			
		////////--------------------------------------
			
		
		
		
		
		
		
	}
}




