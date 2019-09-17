package com.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.booking.bookedSeatDTO;
import com.login.MemberDTO;
import com.movie.MovieDTO;

public class MypageDAO {

	private Connection conn;

	public MypageDAO(Connection conn){

		this.conn = conn;
	}

	
	//mypageMain에서 출력되는 최근 예매 내역 리스트 불러오기
	
	public List<MyBookingDTO> getRecentBookedList(String user_id){

		List<MyBookingDTO> lists = new ArrayList<MyBookingDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select * from booked_list where user_id=? and cancel_date is null and start_time>(select sysdate -30 from dual) order by start_time desc";


			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()){

				MyBookingDTO dto = new MyBookingDTO();

				dto.setBooked_id(rs.getString("booked_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setReservation_date(rs.getString("reservation_date"));
				dto.setCancel_date(rs.getString("cancel_date"));
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setDistrict(rs.getString("district"));
				dto.setScreen_num(rs.getString("screen_num"));
				dto.setStart_time(rs.getString("start_time"));
				dto.setEnd_time(rs.getString("end_time"));
				dto.setRating(rs.getInt("rating"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();



		}catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;

	}

	//현재 예약중인 리스트
	
	public List<MyBookingDTO> getBookingList(String user_id){

		List<MyBookingDTO> lists = new ArrayList<MyBookingDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql;


		try {
			sql = "select booked_id, user_id, reservation_date, to_char(cancel_date,'YYYY-MM-DD HH24:MI') cancel_date,movie_id, file_name, movie_name, age_limit,"
					+ "district, screen_num, to_char(start_time,'YYYY-MM-DD HH24:MI') start_time ,to_char(end_time,'HH24:MI') end_time "
					+ " from booked_list where user_id=? and cancel_date is null and start_time>sysdate order by start_time desc";


			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()){

				MyBookingDTO dto = new MyBookingDTO();

				dto.setBooked_id(rs.getString("booked_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setReservation_date(rs.getString("reservation_date"));
				dto.setCancel_date(rs.getString("cancel_date"));
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setDistrict(rs.getString("district"));
				dto.setScreen_num(rs.getString("screen_num"));
				dto.setStart_time(rs.getString("start_time"));
				dto.setEnd_time(rs.getString("end_time"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();



		}catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;

	}

	//getSeenMovieList
	public List<MyBookingDTO> getSeenMoiveList(String user_id){

		List<MyBookingDTO> lists = new ArrayList<MyBookingDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;



		try {

			sql = "select booked_id, user_id, reservation_date, to_char(cancel_date,'YYYY-MM-DD HH24:MI') cancel_date,movie_id, file_name, movie_name, age_limit, rating, " 
			+ "district, screen_num, to_char(start_time,'YYYY-MM-DD HH24:MI') start_time ,to_char(end_time,'HH24:MI') end_time " + 
					"from booked_list where user_id=? and cancel_date is null and start_time<sysdate order by start_time desc";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()){

				MyBookingDTO dto = new MyBookingDTO();

				dto.setBooked_id(rs.getString("booked_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setReservation_date(rs.getString("reservation_date"));
				dto.setCancel_date(rs.getString("cancel_date"));
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setRating(rs.getInt("rating"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setDistrict(rs.getString("district"));
				dto.setScreen_num(rs.getString("screen_num"));
				dto.setStart_time(rs.getString("start_time"));
				dto.setEnd_time(rs.getString("end_time"));
				
				
				lists.add(dto);
				
			}

			rs.close();
			pstmt.close();



		}catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;

	}

	//canceled Movie List
	public List<MyBookingDTO> getCanceledBooking(String user_id){

		List<MyBookingDTO> lists = new ArrayList<MyBookingDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;



		try {

			sql = "select booked_id, user_id, reservation_date, to_char(cancel_date,'YYYY-MM-DD HH24:MI') cancel_date,movie_id, file_name, movie_name, age_limit,"
					+ "district, screen_num, to_char(start_time,'YYYY-MM-DD HH24:MI') start_time ,to_char(end_time,'HH24:MI') end_time "
					+ " from booked_list where user_id=? and cancel_date is not null order by cancel_date desc";


			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()){

				MyBookingDTO dto = new MyBookingDTO();

				dto.setBooked_id(rs.getString("booked_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setReservation_date(rs.getString("reservation_date"));
				dto.setCancel_date(rs.getString("cancel_date"));
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setDistrict(rs.getString("district"));
				dto.setScreen_num(rs.getString("screen_num"));
				dto.setStart_time(rs.getString("start_time"));
				dto.setEnd_time(rs.getString("end_time"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();



		}catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;

	}


	//������� ��ȭ count
	public int getWishMovieCount(String user_id){

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int count = 0;

		try {

			sql = "select count(*) from wish_list where user_id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()){

				count = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return count;
	}

	//�� ��ȭ count
	public int getSeenMovieCount(String user_id){

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int count = 0;

		try {

			sql = "select count(*) from booked_list where user_id=? and cancel_date is null and start_time<sysdate";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()){

				count = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return count;
	}

	//������ count
	public int getCommentCount(String user_id){

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int count = 0;

		try {

			sql = "select count(*) from comments where user_id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()){

				count = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return count;
	}

	//��ȣ�ϴ� ��ȭ�� �ҷ�����(city, district�� �ҷ���)
	public String getPreferredTheater(String user_id){

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String preferredTheater = null;

		try {

			sql = "select city, district from(select user_id, a.theater_id, city, district from preferred_theater a inner join theater b on a.theater_id = b.theater_id) where user_id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()){

				String city = rs.getString("city");
				String district = rs.getString("district");
				preferredTheater = city + " " + district;
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return preferredTheater;

	}


	//booked_seats Table update for cancel of reservation

	public int cancelReservation(String booked_id) {	
		PreparedStatement pstmt = null;
		int result = 0;
		String sql;

		try {

			sql = "update booked_seats set cancel_date = sysdate where booked_id = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, booked_id);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}



	//회원정보 수정
	//update member
	public int updateMember(String user_id, MemberDTO dto){

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "update member set birth=?, tel=?, email=?, addr=? where user_id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getBirth());
			pstmt.setString(2, dto.getTel());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getAddr());
			pstmt.setString(5, user_id);

			result = pstmt.executeUpdate();

			pstmt.close();


		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	//회원 프로필 사진 테이블 검색
	public String getMemberImage(String user_id){

		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		String file_name = null;

		try {

			sql = "select file_name from member_image where user_id = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()){

				file_name = rs.getString("file_name");
			}

			rs.close();
			pstmt.close();


		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return file_name;

	}


	//회원 프로필 사진 수정-프로필 사진이 없는 경우
	//insert member_image
	public int insertMemberImage(String user_id, String file_name){

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "insert into member_image values(?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);
			pstmt.setString(2, file_name);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}


	//회원 프로필 사진 수정-이미 프로필 사진이 있는 경우
	//update member_image
	public int updateMemberImage(String user_id, String file_name){

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "update member_image set file_name=? where user_id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, file_name);
			pstmt.setString(2, user_id);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}
	
	public int deleteMemberImage(String user_id){

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "delete member_image where user_id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	//theater_id 찾기
	public String getTheaterId(String city, String district){

		PreparedStatement pstmt = null;
		ResultSet rs;
		String sql;
		String theater_id = null;

		try {

			sql = "select theater_id from theater where city=? and district=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, city);
			pstmt.setString(2, district);

			rs = pstmt.executeQuery();

			while(rs.next()){

				theater_id = rs.getString("theater_id");

			}

			rs.close();
			pstmt.close();


		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return theater_id;
	}



	//회원 선호 영화관 insert
	public int insertPreferredTheater(String user_id, String theater_id){

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "insert into preferred_theater values(?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);
			pstmt.setString(2, theater_id);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	//회원 선호 영화관 update
	public int updatePreferredTheater(String user_id, String theater_id){

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "update preferred_theater set theater_id=? where user_id=? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, theater_id);
			pstmt.setString(2, user_id);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	//본 영화 삭제 seenList delete
	public int deleteSeenMovie(String booked_id) {

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "delete booked_seats where booked_id = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, booked_id);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	//나의 한줄평 myCommentList 가져오기
	public List<CommentDTO> getCommentList(String user_id){

		List<CommentDTO> lists = new ArrayList<CommentDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select e.user_id, e.movie_id, comments, to_char(comment_date,'YYYY-MM-DD HH24:MI')comment_date, recommend_num, movie_name, age_limit, file_name, rating "
					+ "from (select c.user_id, c.movie_id, comments, comment_date, recommend_num, movie_name, age_limit, file_name "
					+ "from (select user_id, movie_id, comments, comment_date, recommend_num from comments  where user_id=?) c " + 
					"left join (select a.movie_id, movie_name, age_limit, file_name "
					+ "from movie a left join IMAGE_FILES b on a.movie_id = b.movie_id where file_name like '%Post%') d on c.movie_id = d.movie_id) e "
					+ "left join rating f on e.user_id=f.user_id and e.movie_id=f.movie_id";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while(rs.next()) {

				CommentDTO dto = new CommentDTO();

				dto.setUser_id(rs.getString("user_id"));
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setRating(rs.getInt("rating"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setComments(rs.getString("comments").replace("\n", "<br/>"));
				dto.setComment_date(rs.getString("comment_date"));
				dto.setRecommend_num(rs.getInt("recommend_num"));

				lists.add(dto);
				

			}

			rs.close();
			pstmt.close();


		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;

	}
	
	//comment 삭제하기
	public int deleteComment(String user_id, String movie_id) {
		
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete comments where user_id=? and movie_id=?";
			
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
	
	//comment 삭제시 rating도 삭제
	public int deleteRating(String user_id, String movie_id){
		
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete rating where user_id=? and movie_id=?";
			
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
	
	//comment 업데이트
	public int updateComment(String comments, String user_id, String movie_id) {
		
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update comments set comments=? where user_id=? and movie_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, comments);
			pstmt.setString(2, user_id);
			pstmt.setString(3, movie_id);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	//보고싶어 리스트 불러오기
	public List<MovieDTO> getWishList(String user_id){
		
		List<MovieDTO> lst = new ArrayList<MovieDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select user_id, a.movie_id, movie_name, age_limit, file_name, rating from WISH_LIST a inner join MOvie_list b on a.movie_id = b.movie_id where user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				MovieDTO dto = new MovieDTO();
				
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setAge_limit(rs.getString("age_limit"));
				dto.setRating(rs.getInt("rating"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setUser_id(rs.getString("user_id"));
				
				lst.add(dto);	
			}
			
			
			rs.close();
			pstmt.close();	
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lst;
		
	}
	
	//비밀번호 수정
	public int updateUserPwd(String user_pwd, String user_id) {
		
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update member set user_pwd=? where user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_pwd);
			pstmt.setString(2, user_id);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	//예약 상세정보 가져오기 - 단일정보
	public MyBookingDTO getDetailBooking(String booked_id){
		
		MyBookingDTO dto = new MyBookingDTO();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select distinct booked_id, user_id, reservation_date, movie_id, screen_type, file_name, movie_name, district, screen_num, start_time "
					+ "from detail_booked_list where booked_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, booked_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {

				dto.setBooked_id(rs.getString("booked_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setReservation_date(rs.getString("reservation_date"));
				dto.setMovie_id(rs.getString("movie_id"));
				dto.setFile_name(rs.getString("file_name"));
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setScreen_type(rs.getString("screen_type"));
				dto.setDistrict(rs.getString("district"));
				dto.setScreen_num(rs.getString("screen_num"));
				dto.setStart_time(rs.getString("start_time"));
			
			}
			
			rs.close();
			pstmt.close();
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
	
	//예약 상세정보 가져오기 - 좌석 번호(값이 몇개나 될지 모르므로 리스트로 받음)
	public List<String> getDetailSeats(String booked_id){
		
		List<String> detailSeats = new ArrayList<String>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String row;
		String num;
		String seats;
		
		try {
			
			sql = "select row_num, seat_num from detail_booked_list where booked_id=? order by seat_num";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, booked_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				row = rs.getString("row_num");
				num = rs.getString("seat_num");
				seats = row + "열 " + num + "번 ";
				
				detailSeats.add(seats);
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return detailSeats;
		
	}
	
	//예약 상세정보 가져오기 - 가격
	public String getDetailPrice(String booked_id) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int sum = 0;
		DecimalFormat df = new DecimalFormat("#,##0");
		
		try {
			
			sql = "select sum(price) sumPrice from detail_booked_list where booked_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, booked_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				sum = rs.getInt("sumPrice");

			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return df.format(sum);
	}
	
	
	//회원탈퇴 cancelMember_ok.do 시작
	public int deleteMember(String user_id){
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete member where user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	
		return result;
	}
	
	public List<bookedSeatDTO> getCancelseat(String booked_id){
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		List<bookedSeatDTO> seatsList = new ArrayList<bookedSeatDTO>();
		
		try {
			
			sql = "select row_num, seat_num, screen_id from detail_booked_list where booked_id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, booked_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				bookedSeatDTO dto = new bookedSeatDTO();
				
				dto.setScreen_id(rs.getString("screen_id"));
				dto.setRow_num(rs.getString("row_num"));
				dto.setSeat_num(rs.getInt("seat_num"));
				
				seatsList.add(dto);
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return seatsList;
		
	}
	
	public int cancelSeats(List<bookedSeatDTO> list){
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		String row_num;
		String screen_id;
		int seat_num;
		
		
		try {

			Iterator<bookedSeatDTO> it = list.iterator();
			
			while(it.hasNext()){
				
				pstmt = null;
				result = 0;
				
				bookedSeatDTO dto = new bookedSeatDTO();			
				dto = it.next();
				
				row_num = dto.getRow_num();
				seat_num = dto.getSeat_num();
				screen_id = dto.getScreen_id();
				
				
				sql = "update seat set status=0 where row_num=? and seat_num=? and screen_id=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, row_num);
				pstmt.setInt(2, seat_num);
				pstmt.setString(3, screen_id);
				
				result = pstmt.executeUpdate();
				
			}
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	

}