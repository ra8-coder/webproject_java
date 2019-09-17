package com.mypage;

import java.io.Serializable;

public class MyBookingDTO implements Serializable{

	private static final long serialVersionUID = 1L;

	private String booked_id;
	private String user_id;		
	private String reservation_date;	
	private String cancel_date;
	private String movie_id;	
	private String file_name;	
	private String movie_name;	
	private String screen_type;
	private int rating;			
	private String age_limit;	
	private String district;	
	private String screen_num;
	private String row_num;
	private int seat_num;
	private String start_time;	
	private String end_time;
	private int price;


	public String getBooked_id() {
		return booked_id;
	}
	public void setBooked_id(String booked_id) {
		this.booked_id = booked_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getReservation_date() {
		return reservation_date;
	}
	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}
	public String getCancel_date() {
		return cancel_date;
	}
	public void setCancel_date(String cancel_date) {
		this.cancel_date = cancel_date;
	}
	public String getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getMovie_name() {
		return movie_name;
	}
	public String getScreen_type() {
		return screen_type;
	}
	public void setScreen_type(String screen_type) {
		this.screen_type = screen_type;
	}
	public void setMovie_name(String movie_name) {
		this.movie_name = movie_name;
	}
	public String getAge_limit() {
		return age_limit;
	}
	public void setAge_limit(String age_limit) {
		this.age_limit = age_limit;
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
	public String getRow_num() {
		return row_num;
	}
	public void setRow_num(String row_num) {
		this.row_num = row_num;
	}
	public int getSeat_num() {
		return seat_num;
	}
	public void setSeat_num(int seat_num) {
		this.seat_num = seat_num;
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
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
}



