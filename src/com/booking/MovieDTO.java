package com.booking;

public class MovieDTO {

	private String start_time; // �� ���� �ð�
	private String end_time; // �� ���� �ð�
	private String age_limit; // ���ɴ�
	private String movie_name; // ��ȭ����
	private String type; // ��ȭ ����
	private String district; // ��ȭ�� �̸�
	private String screen_num; // �󿵰� ��ȣ 6��
	private String seatedSeat; // ���õ� �¼�
	private String seatNumber; // ��ü �¼���
	private String screen_id; // �󿵰� ���̵� 
	
	
	
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
