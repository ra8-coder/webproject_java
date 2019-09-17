package com.theater;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TheaterDAO {
	
	private Connection conn;
	
	//의존성 주입
	public TheaterDAO(Connection conn){
		this.conn = conn;
	}
	 
	//모든데이터 가져오기

	public List<TheaterDTO> getlist(String theater_id,String date){


		
		List<TheaterDTO> lists = new ArrayList<TheaterDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			

			
			sql ="select movie_id, city, district, movie_name, screen_num, to_char(start_time,'hh24:mi') start_time, to_char(end_time,'hh24:mi') end_time, ";
			sql+="seatedSeat, seatNumber, type, age_limit, screen_id from timetable where theater_id=? and start_time like ? order by screen_num,start_time";

			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, theater_id);	
			pstmt.setString(2, date);		

			rs = pstmt.executeQuery();
			
			while(rs.next()){

				TheaterDTO dto = new TheaterDTO();
				
				dto.setMovie_id(rs.getString("movie_id"));

				dto.setCity(rs.getString("city"));				
				dto.setDistrict(rs.getString("district"));				
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setScreen_num(rs.getString("screen_num"));
				dto.setStart_time(rs.getString("start_time"));
				dto.setEnd_time(rs.getString("end_time"));
				dto.setSeatedseat(rs.getInt("seatedseat"));
				dto.setSeatnumber(rs.getInt("seatnumber"));
				dto.setType(rs.getString("type"));
				dto.setAge_limit(rs.getString("age_limit"));	
				dto.setScreen_id(rs.getString("screen_id"));
				
				lists.add(dto);
			}
			
			pstmt.close();
			rs.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists;

	}
	
	
	
}
