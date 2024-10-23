package xyz.itwill.dto;

public class ReviewDTO {
	private int reviewNum;	//글 번호
	private int reviewClientNum; // 작성자 번호
	private String reviewSubject;	// 제목	
	private String reviewContent;	// 내용
	private String reviewImg;		// 이미지
	private String reviewRegisterTime;	// 작성날짜
	private String reviewUpdateTime;	// 변경날짜
	private int reviewReadcount;	// 조회수
	private String reviewReplay;	// 답변내용
	private int reviewProductNum;	// 제품번호
	private int reviewOrderNum;		// 주문번호
	private int reviewLevel;		// 후기별점 1~5
	private String clientId; // 클라이언트 아이디
	private int clientStatus; // 클라이언트 status 번호
	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}
	public ReviewDTO(int reviewNum, int reviewClientNum, String reviewSubject, String reviewContent, String reviewImg,
			String reviewRegisterTime, String reviewUpdateTime, int reviewReadcount, String reviewReplay,
			int reviewProductNum, int reviewOrderNum, int reviewLevel, String clientId, int clientStatus) {
		super();
		this.reviewNum = reviewNum;
		this.reviewClientNum = reviewClientNum;
		this.reviewSubject = reviewSubject;
		this.reviewContent = reviewContent;
		this.reviewImg = reviewImg;
		this.reviewRegisterTime = reviewRegisterTime;
		this.reviewUpdateTime = reviewUpdateTime;
		this.reviewReadcount = reviewReadcount;
		this.reviewReplay = reviewReplay;
		this.reviewProductNum = reviewProductNum;
		this.reviewOrderNum = reviewOrderNum;
		this.reviewLevel = reviewLevel;
		this.clientId = clientId;
		this.clientStatus = clientStatus;
	}
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}
	public int getReviewClientNum() {
		return reviewClientNum;
	}
	public void setReviewClientNum(int reviewClientNum) {
		this.reviewClientNum = reviewClientNum;
	}
	public String getReviewSubject() {
		return reviewSubject;
	}
	public void setReviewSubject(String reviewSubject) {
		this.reviewSubject = reviewSubject;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getReviewImg() {
		return reviewImg;
	}
	public void setReviewImg(String reviewImg) {
		this.reviewImg = reviewImg;
	}
	public String getReviewRegisterTime() {
		return reviewRegisterTime;
	}
	public void setReviewRegisterTime(String reviewRegisterTime) {
		this.reviewRegisterTime = reviewRegisterTime;
	}
	public String getReviewUpdateTime() {
		return reviewUpdateTime;
	}
	public void setReviewUpdateTime(String reviewUpdateTime) {
		this.reviewUpdateTime = reviewUpdateTime;
	}
	public int getReviewReadcount() {
		return reviewReadcount;
	}
	public void setReviewReadcount(int reviewReadcount) {
		this.reviewReadcount = reviewReadcount;
	}
	public String getReviewReplay() {
		return reviewReplay;
	}
	public void setReviewReplay(String reviewReplay) {
		this.reviewReplay = reviewReplay;
	}
	public int getReviewProductNum() {
		return reviewProductNum;
	}
	public void setReviewProductNum(int reviewProductNum) {
		this.reviewProductNum = reviewProductNum;
	}
	public int getReviewOrderNum() {
		return reviewOrderNum;
	}
	public void setReviewOrderNum(int reviewOrderNum) {
		this.reviewOrderNum = reviewOrderNum;
	}
	public int getReviewLevel() {
		return reviewLevel;
	}
	public void setReviewLevel(int reviewLevel) {
		this.reviewLevel = reviewLevel;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public int getClientStatus() {
		return clientStatus;
	}
	public void setClientStatus(int clientStatus) {
		this.clientStatus = clientStatus;
	}
	
	
	
}
