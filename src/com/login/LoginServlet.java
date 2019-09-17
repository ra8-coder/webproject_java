package com.login;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.DBCPConn;

public class LoginServlet extends HttpServlet{

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
		
		MemberDAO dao = new MemberDAO(conn);
		
		String url;
		
		String uri = req.getRequestURI();
		
		
		if(uri.indexOf("login.do")!=-1){
			
			url = "/loginPage/login.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("login_ok.do")!=-1){
			
			String user_id = req.getParameter("user_id");
			String user_pwd = req.getParameter("user_pwd");
			
			MemberDTO dto = dao.getReadMemberData(user_id);
			
			if(dto==null || !(dto.getUser_id().equals(user_id))){
				
				req.setAttribute("message", "아이디를 다시 확인하세요!");

				url = "/loginPage/login.jsp";
				forward(req, resp, url);
				
				return;
				
			}else if(!(dto.getUser_pwd().equals(user_pwd))){
				
				req.setAttribute("message", "비밀번호를 다시 확인하세요!");
				
				url = "/loginPage/login.jsp";
				forward(req, resp, url);
				
				return;
			}
			
			HttpSession session = req.getSession();
			session.setAttribute("member", dto);

			url = cp + "/Mypage/mypageMain.do";
			
			resp.sendRedirect(url);

			
		}else if(uri.indexOf("register.do")!=-1){
			
			url = "/login/register.jsp";
			forward(req,resp,url);
			
		}else if(uri.indexOf("register_ok.do")!=-1){
			System.out.println(req.getParameter("id"));
			System.out.println(req.getParameter("pwd"));
			System.out.println(req.getParameter("name"));
			System.out.println(req.getParameter("birth"));
			System.out.println(req.getParameter("tel"));
			System.out.println(req.getParameter("email"));
			System.out.println(req.getParameter("addr"));
			
			MemberDTO dto = new MemberDTO();
			
			dto.setUser_id(req.getParameter("id"));
			dto.setUser_pwd(req.getParameter("pwd"));
			dto.setUser_name(req.getParameter("name"));
			dto.setBirth(req.getParameter("birth"));
			dto.setTel(req.getParameter("tel"));
			dto.setEmail(req.getParameter("email"));
			dto.setAddr(req.getParameter("addr"));
			
			int result = dao.insertData(dto);
			
			System.out.print(result);
			url = cp+"/Login/login.do";
			resp.sendRedirect(url);
			
		}else if(uri.indexOf("log_out.do")!=-1){
			
			HttpSession session = req.getSession();
			
			session.removeAttribute("member"); 
			session.invalidate();

			resp.sendRedirect(cp);
			
		}else if(uri.indexOf("findUser.do")!=-1){
			
			url = "/loginPage/findUser.jsp";
			forward(req,resp,url);
			
		}else if(uri.indexOf("findUser_id.do")!=-1){
			
			String user_name = req.getParameter("user_name");
			String birth = req.getParameter("birth");
			String tel = req.getParameter("tel");
			String findId = null;
			String message = null;
			
			findId = dao.searchId(user_name, birth, tel);
			
			if(findId==null){
				message = "해당하는 회원 정보가 없습니다.";
			}
			else{
				message = user_name + "님의 메가박스 아이디는 " + findId + "입니다!";
			}
			
			req.setAttribute("message", message);
			
			url = "/loginPage/findUser.jsp";
			forward(req, resp, url);

			
		}else if(uri.indexOf("findUser_pw.do")!=-1){
			
			String user_id = req.getParameter("user_id");
			String user_name = req.getParameter("user_name");
			String tel = req.getParameter("tel");
			String findPw = null;
			String message = null;
			
			findPw = dao.searchPw(user_id, user_name, tel);
			
			if(findPw==null){
				message = "해당하는 회원 정보가 없습니다.";
			}
			else{
				message = user_name + "님의 메가박스 비밀번호는 [" + findPw + "]입니다!";
			}
			
			req.setAttribute("message", message);
			
			url = "/loginPage/findUser.jsp";
			forward(req, resp, url);

		}
		
		
		
		
	}

}
