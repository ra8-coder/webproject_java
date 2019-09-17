package com.movie;

public class MovieDTO {
	
	private String movie_id; //��ȭ ����or�����ѹ�
	private String movie_name; //��ȭ ����
	private String movie_eng_name; //��ȭ ���� ����
	private int rating; //��ȭ ����
	private String release_date; //��ȭ ������
	private String type; //��Ÿ�� ex)������,3D,������(�ڸ�)..
	private String director; //��ȭ ����
	private String actors; //��ȭ �⿬��� 
	private String genre; //��ȭ �帣	ex)������
	private String showtimes; // ��ȭ �ѻ󿵽ð� ex)111��
	private String summary; //��ȭ �ٰŸ�
	private String age_limit;// ��ȭ ������������
	private String countRate; //���� �� �ο�
	
	private String user_id; //����� ID (������ ���)
	private String comment_date; //������ �ۼ� ��¥
	private String comments; //������ ����
	private int recommend_num; //������ ��õ��
	private int commCount; // �ش翵ȭ �� �ڸ�Ʈ ����
	
	
	private String file_name; // ���ϼ��̺��


	public String getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}
	public String getMovie_name() {
		return movie_name;
	}
	public void setMovie_name(String movie_name) {
		this.movie_name = movie_name;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getRelease_date() {
		return release_date;
	}
	public void setRelease_date(String release_date) {
		this.release_date = release_date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActors() {
		return actors;
	}
	public void setActors(String actors) {
		this.actors = actors;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getShowtimes() {
		return showtimes;
	}
	public void setShowtimes(String showtimes) {
		this.showtimes = showtimes;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getComment_date() {
		return comment_date;
	}
	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public int getRecommend_num() {
		return recommend_num;
	}
	public void setRecommend_num(int recommend_num) {
		this.recommend_num = recommend_num;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getAge_limit() {
		return age_limit;
	}
	public void setAge_limit(String age_limit) {
		this.age_limit = age_limit;
	}
	public String getCountRate() {
		return countRate;
	}
	public void setCountRate(String countRate) {
		this.countRate = countRate;
	}
	public int getCommCount() {
		return commCount;
	}
	public void setCommCount(int commCount) {
		this.commCount = commCount;
	}
	public String getMovie_eng_name() {
		return movie_eng_name;
	}
	public void setMovie_eng_name(String movie_eng_name) {
		this.movie_eng_name = movie_eng_name;
	}
	

	
	
	
}
