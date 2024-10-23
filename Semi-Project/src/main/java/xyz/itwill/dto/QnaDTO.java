package xyz.itwill.dto;

/*
CREATE TABLE QnA (
    qna_num NUMBER PRIMARY KEY, 
    qna_client_num NUMBER,
    qna_subject VARCHAR2(10),
    qna_title VARCHAR2(100),
    qna_content VARCHAR2(4000),
    qna_image VARCHAR2(100),
    qna_date DATE DEFAULT SYSDATE,
    qna_update DATE DEFAULT SYSDATE,
    qna_ip VARCHAR2(20),
    qna_count NUMBER,
    qna_reply VARCHAR2(4000),
    qna_product_num NUMBER,
    qna_status NUMBER(1),
    CONSTRAINT fk_client_num FOREIGN KEY (qna_client_num) REFERENCES Client(client_num),
    CONSTRAINT fk_product_num FOREIGN KEY (qna_product_num) REFERENCES Product(product_num)
);

  */

/*CREATE SEQUENCE qna_seq;*/

/*
이름              널?       유형             
--------------- -------- -------------- 
QNA_NUM         NOT NULL NUMBER         - 글번호
QNA_CLIENT_NUM           NUMBER           - 회원번호
QNA_SUBJECT              VARCHAR2(10)    - 글말머리
QNA_TITLE                VARCHAR2(100)      - 글제목
QNA_CONTENT              VARCHAR2(4000) - 글내용
QNA_IMAGE                VARCHAR2(100)    - 이미지경로
QNA_DATE                 DATE                         - 작성일자
QNA_UPDATE               DATE                      - 수정일자
QNA_IP                   VARCHAR2(20)            - 회원 ip 주소
QNA_REPLY                VARCHAR2(4000)   - 답변 
QNA_PRODUCT_NUM          NUMBER        - 상품번호
QNA_STATUS               NUMBER(1)            - 글상태(0:삭제글, 1:비밀글 - 모든 글은 비공개)
QNA_WRITER					VARCHAR2(50)	  - 작성자이름
*/

public class QnaDTO {
	private int qnaNum;
	private int qnaClientNum;
	private String qnaSubject;
	private String qnaTitle;
	private String qnaContent;
	private String qnaImage;
	private String qnaDate;
	private String qnaUpdate;
	private String qnaIp;
	private String qnaReply;
	private int qnaProductNum;
	private int qnaStatus;
	private String ClientName;
	private String ProductName;
	private String qnaWriter;
	private String clientId;
	private int clientStatus;
	
	public QnaDTO() {
		// TODO Auto-generated constructor stub
	}

	public QnaDTO(int qnaNum, int qnaClientNum, String qnaSubject, String qnaTitle, String qnaContent, String qnaImage,
			String qnaDate, String qnaUpdate, String qnaIp, String qnaReply, int qnaProductNum, int qnaStatus,
			String clientName, String productName, String qnaWriter, String clientId, int clientStatus) {
		super();
		this.qnaNum = qnaNum;
		this.qnaClientNum = qnaClientNum;
		this.qnaSubject = qnaSubject;
		this.qnaTitle = qnaTitle;
		this.qnaContent = qnaContent;
		this.qnaImage = qnaImage;
		this.qnaDate = qnaDate;
		this.qnaUpdate = qnaUpdate;
		this.qnaIp = qnaIp;
		this.qnaReply = qnaReply;
		this.qnaProductNum = qnaProductNum;
		this.qnaStatus = qnaStatus;
		ClientName = clientName;
		ProductName = productName;
		this.qnaWriter = qnaWriter;
		this.clientId = clientId;
		this.clientStatus = clientStatus;
	}

	public int getQnaNum() {
		return qnaNum;
	}

	public void setQnaNum(int qnaNum) {
		this.qnaNum = qnaNum;
	}

	public int getQnaClientNum() {
		return qnaClientNum;
	}

	public void setQnaClientNum(int qnaClientNum) {
		this.qnaClientNum = qnaClientNum;
	}

	public String getQnaSubject() {
		return qnaSubject;
	}

	public void setQnaSubject(String qnaSubject) {
		this.qnaSubject = qnaSubject;
	}

	public String getQnaTitle() {
		return qnaTitle;
	}

	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}

	public String getQnaContent() {
		return qnaContent;
	}

	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}

	public String getQnaImage() {
		return qnaImage;
	}

	public void setQnaImage(String qnaImage) {
		this.qnaImage = qnaImage;
	}

	public String getQnaDate() {
		return qnaDate;
	}

	public void setQnaDate(String qnaDate) {
		this.qnaDate = qnaDate;
	}

	public String getQnaUpdate() {
		return qnaUpdate;
	}

	public void setQnaUpdate(String qnaUpdate) {
		this.qnaUpdate = qnaUpdate;
	}

	public String getQnaIp() {
		return qnaIp;
	}

	public void setQnaIp(String qnaIp) {
		this.qnaIp = qnaIp;
	}

	public String getQnaReply() {
		return qnaReply;
	}

	public void setQnaReply(String qnaReply) {
		this.qnaReply = qnaReply;
	}

	public int getQnaProductNum() {
		return qnaProductNum;
	}

	public void setQnaProductNum(int qnaProductNum) {
		this.qnaProductNum = qnaProductNum;
	}

	public int getQnaStatus() {
		return qnaStatus;
	}

	public void setQnaStatus(int qnaStatus) {
		this.qnaStatus = qnaStatus;
	}

	public String getClientName() {
		return ClientName;
	}

	public void setClientName(String clientName) {
		ClientName = clientName;
	}

	public String getProductName() {
		return ProductName;
	}

	public void setProductName(String productName) {
		ProductName = productName;
	}

	public String getQnaWriter() {
		return qnaWriter;
	}

	public void setQnaWriter(String qnaWriter) {
		this.qnaWriter = qnaWriter;
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
