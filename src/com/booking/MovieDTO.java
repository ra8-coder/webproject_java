package com.booking;

public class MovieDTO {

	private String start_time; // 상영 시작 시간
	private String end_time; // 상영 종료 시간
	private String age_limit; // 연령대
	private String movie_name; // 영화제목
	private String type; // 영화 종류
	private String district; // 영화관 이름
	private String screen_num; // 상영관 번호 6관
	private String seatedSeat; // 선택된 좌석
	private String seatNumber; // 전체 좌석수
	private String screen_id; // 상영관 아이디 
	
	
	
	public String getScreen_id() {
		return screen_id;
	}

	public void setScreen_id(String screen_id) {
		this.screen_id = screen_id;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getAge_limit() {
		return age_limit;
	}

	public void setAge_limit(String age_limit) {
		this.age_limit = age_limit;
	}

	public String getMovie_name() {
		return movie_name;
	}

	public void setMovie_name(String movie_name) {
		this.movie_name = movie_name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getScreen_num() {
		return screen_num;
	}

	public void setScreen_num(String screen_num) {
		this.screen_num = screen_num;
	}

	public String getSeatedSeat() {
		return seatedSeat;
	}

	public void setSeatedSeat(String seatedSeat) {
		this.seatedSeat = seatedSeat;
	}

	public String getSeatNumber() {
		return seatNumber;
	}

	public void setSeatNumber(String seatNumber) {
		this.seatNumber = seatNumber;
	}

}
