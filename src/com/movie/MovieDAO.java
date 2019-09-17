package com.movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBCPConn;

public class MovieDAO {
	
	private Connection conn;
	
	public MovieDAO(Connection conn){
		this.conn = conn;
	}
	
	
	//전체 데이터 갯수
	public int getDataCount(){
		
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select nvl(count(*),0) from movie";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				dataCount = rs.getInt(1);
			
			rs.close();
			pstmt.close();
		
			
		} catch (Exception e) { 
			System.out.println(e.toString());
		}
		return dataCount;
		
	}
	
	public List<MovieDTO> getAllMV(int start, int end){//list.do 에 뿌릴 데이터를 가져옴
		
		List<MovieDTO> lst = new ArrayList<MovieDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select rnum, movie_id,movie_name,age_limit,rating,file_name from ";
			sql+= "(select rownum rnum, a.* , release_date from (movie_list) a , ";
			sql+= "movie b where a.movie_id=b.movie_id) where rnum>=? and rnum<=? and release_date<sysdate";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				MovieDTO dto = new MovieDTO();
				
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setRating(rs.getInt("rating"));
				dto.setFile_name(rs.getString("file_name"));
				
				lst.add(dto);	
			}
			
			
			rs.close();
			pstmt.close();	
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lst;
		
	}
	
	
	public MovieDTO getOneData(String movie_id){ //movie.do 에 뿌릴 해당 영화 데이터를 가져옴
		
		MovieDTO dto = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select * from (select (b.movie_id) movie_id,movie_name,movie_eng_name,rating,release_date,type,director,actors,genre,showtimes,summary,";
			sql+= "age_limit,file_name,countRate from movie a,(select a.*, nvl(countRate,0) countRate, nvl(rating,0) rating from ";
			sql+= "(select * from image_files where file_name like ('%Post%') and movie_id=?) a left join ";
			sql+= "(select count(rating) countRate,round(avg(rating)) rating,movie_id from rating group by movie_id having movie_id=?) b ";
			sql+= "on a.movie_id=b.movie_id) b where a.movie_id=b.movie_id) a,";
			sql+= "(select count(comments) commCount from comments where movie_id=?) b";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, movie_id);
			pstmt.setString(2, movie_id);
			pstmt.setString(3, movie_id);
			
			rs = pstmt.executeQuery();
			
			
			if(rs.next()){
				
				dto = new MovieDTO();
				
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setMovie_eng_name(rs.getString("movie_eng_name"));
				dto.setRating(rs.getInt("rating"));
				dto.setRelease_date(rs.getString("release_date"));
				dto.setType(rs.getString("type"));
				dto.setDirector(rs.getString("director"));
				dto.setActors(rs.getString("actors"));
				dto.setGenre(rs.getString("genre"));
				dto.setShowtimes(rs.getString("showtimes"));
				dto.setSummary(rs.getString("summary"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setCountRate(rs.getString("countRate"));
				dto.setCommCount(rs.getInt("commCount"));
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
		
	}
	
	public List<MovieDTO> getStillcut(String movie_id){//movie.do에 뿌릴 영화 스틸컷을 가져옴
		
		List<MovieDTO> lst = new ArrayList<MovieDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select file_name from image_files where movie_id=? and file_name like '%Still%'";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, movie_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				MovieDTO dto = new MovieDTO();
				
				dto.setFile_name(rs.getString("file_name"));
				
				lst.add(dto);	
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lst;
		
	}
	
	public int getStillCount(String movie_id){
		
		int count = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select count(file_name) count from image_files where file_name like ('%Still%') and movie_id=?";
			
			pstmt = conn.prepareCall(sql);
			
			pstmt.setString(1, movie_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				count = rs.getInt("count");
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return count;
	}
	
	
	public List<MovieDTO> getAllComment(String movie_id){//moive.do에 뿌릴 영화 코멘트를 가져옴
		
		List<MovieDTO> lst = new ArrayList<MovieDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		
		try {
			
			/*sql = "select * from (select rownum rnum, data.* from (select a.*, rating from";
			sql+= "(select movie_id,a.user_id,comment_date,comments,recommend_num,file_name from comments a,";
			sql+= "member_image b where a.user_id=b.user_id and movie_id=?) a , rating b where ";
			sql+= "a.movie_id=b.movie_id and a.user_id=b.user_id) data) where rnum>=? and rnum<=?;";*/
			
			sql = "select a.*, rating from (select movie_id,a.user_id,to_char(comment_date,'YYYY.MM.DD') ";
			sql+= "comment_date,comments,recommend_num,file_name from (select * from comments order by comment_date desc) a ";
			sql+= "left join member_image b on a.user_id=b.user_id where movie_id=?) a , rating b where ";
			sql+= "a.movie_id=b.movie_id and a.user_id=b.user_id";
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, movie_id);
			/*pstmt.setInt(2, start);
			pstmt.setInt(3, end);*/
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				MovieDTO dto = new MovieDTO();
				
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setComment_date(rs.getString("comment_date"));
				dto.setComments(rs.getString("comments"));
				dto.setRecommend_num(rs.getInt("recommend_num"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setRating(rs.getInt("rating"));
				
				lst.add(dto);	
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lst;
		
	}
	
	public int insertComment(MovieDTO dto){ //한줄평 작성
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into comments (user_id,movie_id,comments,comment_date,recommend_num) ";
			sql+= "values(?,?,?,sysdate,0)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getMovie_id());
			pstmt.setString(3, dto.getComments());
			
			result = pstmt.executeUpdate();
			
			sql = "insert into rating (movie_id,user_id,rating) ";
			sql+= "values(?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getMovie_id());
			pstmt.setString(2, dto.getUser_id());
			pstmt.setInt(3, dto.getRating());
			
			result = pstmt.executeUpdate();
		
			
			pstmt.close();
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	////////--------------------------------------
	//wish된 영화인지 판별하기
	public String searchWishlist(String user_id, String movie_id){
	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String wish = null;
		
		try {
			
			sql = "select movie_id from wish_list where user_id=? and movie_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			pstmt.setString(2, movie_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				wish = rs.getString("movie_id");
				
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return wish;
	}
	
	public int wishCount(String movie_id){
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select count(movie_id) wishCount from wish_list where movie_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, movie_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
				result = Integer.parseInt(rs.getString("wishCount"));
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;

	}
	
	public int insertWishlist(String user_id, String movie_id){
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into wish_list values(?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			pstmt.setString(2, movie_id);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	public int deleteWishlist(String user_id, String movie_id){
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete wish_list where user_id=? and movie_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			pstmt.setString(2, movie_id);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	////////--------------------------------------
	
	
	public List<MovieDTO> getListDate(int start, int end){//list.do 에 뿌릴 데이터를 가져옴
		
		List<MovieDTO> lst = new ArrayList<MovieDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select * from (select rownum rnum, data.* from (select a.*, release_date from movie_list a, ";
			sql+= "movie b where a.movie_id=b.movie_id order by release_date desc) data) ";
			sql+= "where rnum>=? and rnum<=? and release_date<sysdate";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				MovieDTO dto = new MovieDTO();
				
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setRating(rs.getInt("rating"));
				dto.setFile_name(rs.getString("file_name"));
				
				lst.add(dto);	
			}
			
			
			rs.close();
			pstmt.close();	
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lst;
		
	}
	
	
	public List<MovieDTO> getListPre(int start, int end){//list_pre.do 에 뿌릴 데이터를 가져옴
		
		List<MovieDTO> lst = new ArrayList<MovieDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select * from (select rownum rnum, data.* from (select a.*, release_date from movie_list a, ";
			sql+= "movie b where a.movie_id=b.movie_id order by release_date desc) data) ";
			sql+= "where rnum>=? and rnum<=? and release_date>sysdate";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				MovieDTO dto = new MovieDTO();
				
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setRating(rs.getInt("rating"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setRelease_date(rs.getString("release_date"));
				
				lst.add(dto);	
			}
			
			
			rs.close();
			pstmt.close();	
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lst;
		
	}
	
	public int recommend(String user_id, String movie_id){//추천수 증가
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update comments set recommend_num=(recommend_num+1) where user_id=? and movie_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			pstmt.setString(2, movie_id);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public int commentCheck(String movie_id, String user_id){//한줄평 여부 확인
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "select * from comments where movie_id=? and user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, movie_id);
			pstmt.setString(2, user_id);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();	
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public int delComment(String movie_id, String user_id){//한줄평 삭제
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete from comments where movie_id=? and user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, movie_id);
			pstmt.setString(2, user_id);
			
			result = pstmt.executeUpdate();
			
			sql = "delete from rating where movie_id=? and user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, movie_id);
			pstmt.setString(2, user_id);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public int updateComment(MovieDTO dto){//한줄평 수정
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "update comments set comments=? where movie_id=? and user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getComments());
			pstmt.setString(2, dto.getMovie_id());
			pstmt.setString(3, dto.getUser_id());
			
			result = pstmt.executeUpdate();
			
			sql = "update rating set rating=? where movie_id=? and user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getRating());
			pstmt.setString(2, dto.getMovie_id());
			pstmt.setString(3, dto.getUser_id());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
		
	}

	
	
	
	
	
	

}
