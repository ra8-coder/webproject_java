package com.booking;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

	private Connection conn;
	
	// DI (占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙)
	public BookingDAO(Connection conn) {
		this.conn = conn;		
	}
	
	// 1. 占쏙옙화占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 (Select)
	public List<TheaterDTO> getReadData(){
		List<TheaterDTO> lists_theater = new ArrayList<TheaterDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ;
		
		try {
			sql = "select theater_id ,city, district from theater "; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
					
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				TheaterDTO dto = new TheaterDTO();
				dto.setTheater_id(rs.getString("theater_id"));
				dto.setCity(rs.getString("city"));
				dto.setDistrict(rs.getString("district"));
				
				lists_theater.add(dto);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists_theater;
		
	}
	
	
	// 2. 占쏙옙화占쏙옙 占쏙옙짜 占시곤옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 (Select) .v2
//	 public List<MovieDTO> getMovieData(String movieName,String date){
//		List<MovieDTO> lists2 = new ArrayList<MovieDTO>();
//		
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String sql ;
//		
//		try {
//			sql = "SELECT to_char(start_time,'HH24:MI'), to_char(end_time,'HH24:MI'), "
//					+ "age_limit , movie_name, type , city, district"
//					+ "FROM TIMETABLE;"; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
//					
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, );
//			
//			rs = pstmt.executeQuery();
//			
//			
//			
//			while(rs.next()){
//				MovieDTO dto = new MovieDTO();
//				
//				
//				
//				
//				
//				lists2.add(dto);
//			}
//			
//			rs.close();
//			pstmt.close();
//			
//		} catch (Exception e) {
//			System.out.println(e.toString());
//		}
//		
//		
//		return lists2;	
//		
//	}
	// 2. 占쏙옙화占쏙옙 占쏙옙짜 占시곤옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 (Select) .v1
	 public List<MovieDTO> getMovieData(String date, String hour, String theaterId, String movieId){
			List<MovieDTO> lists2 = new ArrayList<MovieDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ;
			
			try {
				sql = "SELECT screen_id ,to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time, "
						+ "age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber "
						+ "FROM TIMETABLE "
						+ "where to_char(start_time,'DD') >= ? AND to_char(start_time,'HH24') >= ? and "
						+ "theater_id = ? and movie_id = ?"; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
						
				//SELECT screen_id, to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time,
//				age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber FROM timetable
//				where movie_id =7 and theater_id = 4 and to_char(start_time,'HH24') >= 15 and to_char(start_time,'DD') = 21;
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, date);
				pstmt.setString(2, hour);
				pstmt.setString(3, theaterId);
				pstmt.setString(4, movieId);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					MovieDTO dto = new MovieDTO();
					
					dto.setStart_time(rs.getString("start_time"));
					dto.setEnd_time(rs.getString("end_time"));
					dto.setAge_limit(rs.getString("age_limit"));
					dto.setMovie_name(rs.getString("movie_name"));
					dto.setType(rs.getString("type"));
					dto.setDistrict(rs.getString("district"));
					dto.setScreen_num(rs.getString("screen_num"));
					dto.setSeatedSeat(rs.getString("seatedseat"));
					dto.setSeatNumber(rs.getString("seatnumber"));
					dto.setScreen_id(rs.getString("screen_id"));
					
					lists2.add(dto);
				}
				
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists2;

		}
	 // 날짜만 선택해서 가져오기
	 public List<MovieDTO> getMovieData(String date){
			List<MovieDTO> lists2 = new ArrayList<MovieDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ;
			
			try {
				
				sql = "SELECT screen_id ,to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time, "
						+ "age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber "
						+ "FROM TIMETABLE "
						+ "where to_char(start_time,'DD') >= ? and to_char(start_time,'HH24') >= to_char(sysdate,'HH24') "
						+ "order by start_time"; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
						
				//SELECT screen_id, to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time,
//				age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber FROM timetable
//				where movie_id =7 and theater_id = 4 and to_char(start_time,'HH24') >= 15 and to_char(start_time,'DD') = 21;
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, date);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					MovieDTO dto = new MovieDTO();
					
					dto.setStart_time(rs.getString("start_time"));
					dto.setEnd_time(rs.getString("end_time"));
					dto.setAge_limit(rs.getString("age_limit"));
					dto.setMovie_name(rs.getString("movie_name"));
					dto.setType(rs.getString("type"));
					dto.setDistrict(rs.getString("district"));
					dto.setScreen_num(rs.getString("screen_num"));
					dto.setSeatedSeat(rs.getString("seatedseat"));
					dto.setSeatNumber(rs.getString("seatnumber"));
					dto.setScreen_id(rs.getString("screen_id"));
					
					lists2.add(dto);
				}
				
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists2;

		}
	 
	 public List<MovieDTO> getMovieData3(String date){
			List<MovieDTO> lists2 = new ArrayList<MovieDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ;
			
			try {
				
				sql = "SELECT screen_id ,to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time, "
						+ "age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber "
						+ "FROM TIMETABLE "
						+ "where to_char(start_time,'DD') >= ? order by start_time"; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
						
				//SELECT screen_id, to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time,
//				age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber FROM timetable
//				where movie_id =7 and theater_id = 4 and to_char(start_time,'HH24') >= 15 and to_char(start_time,'DD') = 21;
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, date);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					MovieDTO dto = new MovieDTO();
					
					dto.setStart_time(rs.getString("start_time"));
					dto.setEnd_time(rs.getString("end_time"));
					dto.setAge_limit(rs.getString("age_limit"));
					dto.setMovie_name(rs.getString("movie_name"));
					dto.setType(rs.getString("type"));
					dto.setDistrict(rs.getString("district"));
					dto.setScreen_num(rs.getString("screen_num"));
					dto.setSeatedSeat(rs.getString("seatedseat"));
					dto.setSeatNumber(rs.getString("seatnumber"));
					dto.setScreen_id(rs.getString("screen_id"));
					
					lists2.add(dto);
				}
				
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists2;

		}
	 
	 public List<MovieDTO> getMovieData(String date, String hour){
			List<MovieDTO> lists2 = new ArrayList<MovieDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ;
			
			try {
				sql = "SELECT screen_id ,to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time, "
						+ "age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber "
						+ "FROM TIMETABLE "
						+ "where to_char(start_time,'DD') >= ? AND to_char(start_time,'HH24') >= ?"; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
						
				//SELECT screen_id, to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time,
//				age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber FROM timetable
//				where movie_id =7 and theater_id = 4 and to_char(start_time,'HH24') >= 15 and to_char(start_time,'DD') = 21;
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, date);
				pstmt.setString(2, hour);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					MovieDTO dto = new MovieDTO();
					
					dto.setStart_time(rs.getString("start_time"));
					dto.setEnd_time(rs.getString("end_time"));
					dto.setAge_limit(rs.getString("age_limit"));
					dto.setMovie_name(rs.getString("movie_name"));
					dto.setType(rs.getString("type"));
					dto.setDistrict(rs.getString("district"));
					dto.setScreen_num(rs.getString("screen_num"));
					dto.setSeatedSeat(rs.getString("seatedseat"));
					dto.setSeatNumber(rs.getString("seatnumber"));
					dto.setScreen_id(rs.getString("screen_id"));
					
					lists2.add(dto);
				}
				
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists2;

		}
	 
	 public List<MovieDTO> getMovieData(String date, String hour, String theaterId){
			List<MovieDTO> lists2 = new ArrayList<MovieDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ;
			
			try {
				sql = "SELECT screen_id ,to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time, "
						+ "age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber "
						+ "FROM TIMETABLE "
						+ "where to_char(start_time,'DD') >= ? AND to_char(start_time,'HH24') >= ? and "
						+ "theater_id = ? "; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
						
				//SELECT screen_id, to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time,
//				age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber FROM timetable
//				where movie_id =7 and theater_id = 4 and to_char(start_time,'HH24') >= 15 and to_char(start_time,'DD') = 21;
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(date));
				pstmt.setInt(2, Integer.parseInt(hour));
				pstmt.setString(3, theaterId);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					MovieDTO dto = new MovieDTO();
					
					dto.setStart_time(rs.getString("start_time"));
					dto.setEnd_time(rs.getString("end_time"));
					dto.setAge_limit(rs.getString("age_limit"));
					dto.setMovie_name(rs.getString("movie_name"));
					dto.setType(rs.getString("type"));
					dto.setDistrict(rs.getString("district"));
					dto.setScreen_num(rs.getString("screen_num"));
					dto.setSeatedSeat(rs.getString("seatedseat"));
					dto.setSeatNumber(rs.getString("seatnumber"));
					dto.setScreen_id(rs.getString("screen_id"));
					
					lists2.add(dto);
				}
				
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists2;

		}
	 public List<MovieDTO> getMovieData4(String date, String hour, String theaterId){
			List<MovieDTO> lists2 = new ArrayList<MovieDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ;
			
			try {
				sql = "SELECT screen_id ,to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time, "
						+ "age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber "
						+ "FROM TIMETABLE "
						+ "where to_char(start_time,'DD') >= ? AND theater_id = ? "; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
						
				//SELECT screen_id, to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time,
//				age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber FROM timetable
//				where movie_id =7 and theater_id = 4 and to_char(start_time,'HH24') >= 15 and to_char(start_time,'DD') = 21;
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(date));
				pstmt.setString(2, theaterId);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					MovieDTO dto = new MovieDTO();
					
					dto.setStart_time(rs.getString("start_time"));
					dto.setEnd_time(rs.getString("end_time"));
					dto.setAge_limit(rs.getString("age_limit"));
					dto.setMovie_name(rs.getString("movie_name"));
					dto.setType(rs.getString("type"));
					dto.setDistrict(rs.getString("district"));
					dto.setScreen_num(rs.getString("screen_num"));
					dto.setSeatedSeat(rs.getString("seatedseat"));
					dto.setSeatNumber(rs.getString("seatnumber"));
					dto.setScreen_id(rs.getString("screen_id"));
					
					lists2.add(dto);
				}
				
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists2;

		}
	 
	 
	 	//날짜 영화 선택
	 public List<MovieDTO> getMovieData1(String movie_id){
			List<MovieDTO> lists2 = new ArrayList<MovieDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ;
			
			try {
				sql = "SELECT screen_id ,to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time, "
						+ "age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber "
						+ "FROM TIMETABLE "
						+ "where to_char(start_time,'DD') >= TO_CHAR(sysdate,'DD') and to_char(start_time,'HH24') >= TO_CHAR(sysdate,'HH24') and movie_id = ?"; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
						
				//SELECT screen_id, to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time,
//				age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber FROM timetable
//				where movie_id =7 and theater_id = 4 and to_char(start_time,'HH24') >= 15 and to_char(start_time,'DD') = 21;
				
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, movie_id);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					MovieDTO dto = new MovieDTO();
					
					dto.setStart_time(rs.getString("start_time"));
					dto.setEnd_time(rs.getString("end_time"));
					dto.setAge_limit(rs.getString("age_limit"));
					dto.setMovie_name(rs.getString("movie_name"));
					dto.setType(rs.getString("type"));
					dto.setDistrict(rs.getString("district"));
					dto.setScreen_num(rs.getString("screen_num"));
					dto.setSeatedSeat(rs.getString("seatedseat"));
					dto.setSeatNumber(rs.getString("seatnumber"));
					dto.setScreen_id(rs.getString("screen_id"));
					
					lists2.add(dto);
				}
				
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists2;

		}
	 
		//날짜 영화 선택
	 public List<MovieDTO> getMovieData2(String date, String movie_id){
			List<MovieDTO> lists2 = new ArrayList<MovieDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ;
			
			try {
				sql = "SELECT screen_id ,to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time, "
						+ "age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber "
						+ "FROM TIMETABLE "
						+ "where to_char(start_time,'DD') >= ? and movie_id = ?"; // 占쏢영곤옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 sql占쏙옙
						
				//SELECT screen_id, to_char(start_time,'HH24:MI') as start_time, to_char(end_time,'HH24:MI') as end_time,
//				age_limit, movie_name, type, district, screen_num, seatedseat, seatnumber FROM timetable
//				where movie_id =7 and theater_id = 4 and to_char(start_time,'HH24') >= 15 and to_char(start_time,'DD') = 21;
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, date);
				pstmt.setString(2, movie_id);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					MovieDTO dto = new MovieDTO();
					
					dto.setStart_time(rs.getString("start_time"));
					dto.setEnd_time(rs.getString("end_time"));
					dto.setAge_limit(rs.getString("age_limit"));
					dto.setMovie_name(rs.getString("movie_name"));
					dto.setType(rs.getString("type"));
					dto.setDistrict(rs.getString("district"));
					dto.setScreen_num(rs.getString("screen_num"));
					dto.setSeatedSeat(rs.getString("seatedseat"));
					dto.setSeatNumber(rs.getString("seatnumber"));
					dto.setScreen_id(rs.getString("screen_id"));
					
					lists2.add(dto);
				}
				
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists2;

		}
	 
	 

	 
	 
	 
	 public List<BookingDTO> getSeatInfo(String screenId){
			List<BookingDTO> lists = new ArrayList<BookingDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql ;
			
			try {
				
				sql = "select rnum, screen_id, row_num, seat_num, status from "
						+ " (select rownum rnum, data.* "
						+ " from (select screen_id, row_num, seat_num, status from seat "
						+ " where screen_id = ? order by row_num,seat_num) data)";
						
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, screenId);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					BookingDTO dto = new BookingDTO();
					dto.setRnum(rs.getString("rnum"));
					dto.setScreen_id(rs.getString("screen_id"));
					dto.setRow_num(rs.getString("row_num"));
					dto.setSeat_num(rs.getInt("seat_num"));
					dto.setStatus(rs.getInt("status"));
					
					lists.add(dto);
				}
				
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists;

		}
	 
	 public void insertBookedSeats(bookedSeatDTO dto, int booked_id){
		 
		 PreparedStatement pstmt = null;
		 String sql;
		 
		 sql = "insert into booked_seats(screen_id, row_num, seat_num, booked_id, user_id, reservation_date, type, cancel_date) values(?,?,?,?,?,SYSDATE,?,NULL)";
		 
		 
		 try {
			 
			pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getScreen_id());
				pstmt.setString(2, dto.getRow_num());
				pstmt.setInt(3,dto.getSeat_num());
				pstmt.setString(4,Integer.toString(booked_id));
				pstmt.setString(5, dto.getUser_id());
				//pstmt.setDate(6,Date.valueOf(LocalDate.now()));
				pstmt.setString(6,dto.getType());
				//pstmt.setNull(8,Types.NULL);
				
				pstmt.executeUpdate();
				
				pstmt.close();
				
		} catch (Exception e) {
			// TODO: handle exception
		}
		 
	 }
	 
	 public void insertBookedSeatsList(List<bookedSeatDTO> lists, int booked_id){
		 
		 PreparedStatement pstmt = null;
		 String sql;
		 
		 sql = "insert into booked_seats(screen_id, row_num, seat_num, booked_id, user_id, reservation_date, type, cancel_date) values(?,?,?,?,?,SYSDATE,?,NULL)";
		 
		 
		 try {
			 
			pstmt = conn.prepareStatement(sql);
			
			for(bookedSeatDTO dto : lists){
				
				pstmt.setString(1, dto.getScreen_id());
				pstmt.setString(2, dto.getRow_num());
				pstmt.setInt(3,dto.getSeat_num());
				pstmt.setString(4,Integer.toString(booked_id));
				pstmt.setString(5, dto.getUser_id());
				//pstmt.setDate(6,Date.valueOf(LocalDate.now()));
				pstmt.setString(6,dto.getType());
				//pstmt.setNull(8,Types.NULL);
				
				
				pstmt.addBatch();
			}
			
			pstmt.executeBatch();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		 
	 }
	 
	 public void updateSeatStatus(String screen_id, String row_num, int seat_num ){
		 
		 PreparedStatement pstmt = null;
		 String sql = "";
		 
		 try {
			
			 sql = "update seat set status = 1 where screen_id=? and row_num = ? and seat_num = ?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, screen_id);
			 pstmt.setString(2,row_num);
			 pstmt.setInt(3, seat_num);
			 
			 pstmt.executeUpdate();
			 
			 pstmt.close();
			 
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.toString());
		}
		 
		 
		 
		 
	 }
	 
	 
	 public int getBookedNum(){
			
			int maxNum =0;
			
			PreparedStatement pstmt = null;
			String sql= "";
			ResultSet rs = null;
			
			try {
				sql = "select max(to_number(BOOKED_ID)) from booked_seats";
				pstmt = conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				
				if(rs.next()){
					
					maxNum = rs.getInt(1);
					
				}
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			return maxNum;
		}
	 
	 //---���엯�쓣 諛쏆븘�삩�떎.
	 
	 public MovieDTO getScreenInfo(String screen_id){
		 
		 PreparedStatement pstmt = null;
		 String sql = "";
		 ResultSet rs = null;
		 MovieDTO dto = null;
		 
		 try {
			
			 sql = "select movie_id, theater_id, screen_id, city ,district, movie_name, screen_num, to_char(start_time,'HH24:MI') as start_time, to_char(start_time,'HH24:MI') as end_time, seatedseat, seatnumber, type, age_limit "
			 		+ "from timetable where screen_id = ?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, screen_id);
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()){
			 
				 dto = new MovieDTO();
			 
				 dto.setAge_limit(rs.getString("age_limit"));
				 dto.setDistrict(rs.getString("district"));
				 dto.setMovie_name(rs.getString("movie_name"));
				 dto.setScreen_id(rs.getString("screen_id"));
				 dto.setScreen_num(rs.getString("screen_num"));
				 dto.setStart_time(rs.getString("start_time"));
				 dto.setType(rs.getString("type"));
			 }
			 pstmt.close();
			 rs.close();
			 
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.toString());
		}
		 
		return dto;
	 }
	

	
}
