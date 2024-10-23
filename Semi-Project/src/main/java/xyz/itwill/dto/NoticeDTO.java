package xyz.itwill.dto;

/*
 CREATE TABLE notice (
    notice_num      NUMBER PRIMARY KEY,
    notice_title    VARCHAR2(100),
    notice_image    VARCHAR2(100),
    notice_date     DATE DEFAULT SYSDATE,
    notice_update   DATE DEFAULT SYSDATE,
    notice_count    NUMBER,
    notice_client_num   NUMBER,
    notice_status   NUMBER(1),
    CONSTRAINT fk_notice_client_num FOREIGN KEY (notice_client_num) REFERENCES client (client_num)
);
 */

/* create sequence notice_seq; */

/*
이름             널?       유형             
-------------- -------- -------------- 
NOTICE_NUM     NOT NULL NUMBER         - 글번호
NOTICE_TITLE            VARCHAR2(100)  - 글제목
NOTICE_IMAGE            VARCHAR2(100)  - 이미지파일의 경로
NOTICE_DATE             DATE           - 작성날짜
NOTICE_UPDATE           DATE           - 수정날짜
NOTICE_COUNT            NUMBER         - 조회수
NOTICE_CLIENT_NUM       NUMBER   	   - 회원번호 : 회원번호의 해당하는 회원의 상태가 9인지 확인하기 위한 컬럼
NOTICE_STATUS			NUMBER(1)	   - 공지사항 글 상태 - 상단고정글(0), 일반글(1)
*/


public class NoticeDTO {

	private int noticeNum;
	private String noticeTitle;
	private String noticeImage;
	private String noticeDate;
	private String noticeUpdate;
	private int noticeCount;
	private int noticeClientNum;
	private int noticeStatus;
	
	public NoticeDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getNoticeNum() {
		return noticeNum;
	}

	public void setNoticeNum(int noticeNum) {
		this.noticeNum = noticeNum;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeImage() {
		return noticeImage;
	}

	public void setNoticeImage(String noticeImage) {
		this.noticeImage = noticeImage;
	}

	public String getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}

	public String getNoticeUpdate() {
		return noticeUpdate;
	}

	public void setNoticeUpdate(String noticeUpdate) {
		this.noticeUpdate = noticeUpdate;
	}

	public int getNoticeCount() {
		return noticeCount;
	}

	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}

	public int getNoticeClientNum() {
		return noticeClientNum;
	}

	public void setNoticeClientNum(int noticeClientNum) {
		this.noticeClientNum = noticeClientNum;
	}


	public int getNoticeStatus() {
		return noticeStatus;
	}

	public void setNoticeStatus(int noticeStatus) {
		this.noticeStatus = noticeStatus;
	}

	
	
	
}
