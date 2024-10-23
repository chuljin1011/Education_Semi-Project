package xyz.itwill.dto;

/*
create table client(client_num number primary key, client_id varchar2(30) unique, client_passwd varchar2(200)
    , client_name varchar2(30), client_email varchar2(50), client_mobile varchar2(20), client_zipcode varchar2(10)
    , client_address1 varchar2(200), client_address2 varchar2(100), client_register_date date
    , client_update_date date, client_last_login date, client_status number(1));
    
create sequence client_seq;
*/

/*
이름                   널?       유형            
-------------------- -------- ------------- 
CLIENT_NUM           NOT NULL NUMBER        - 회원번호(PK)
CLIENT_ID                     VARCHAR2(30)  - 아이디(UNIQUE)
CLIENT_PASSWD                 VARCHAR2(200) - 비밀번호(암호화 처리)
CLIENT_NAME                   VARCHAR2(30)  - 이름
CLIENT_EMAIL                  VARCHAR2(50)  - 이메일 
CLIENT_MOBILE                 VARCHAR2(20)  - 전화번호 
CLIENT_ZIPCODE                VARCHAR2(10)  - 우편번호
CLIENT_ADDRESS1               VARCHAR2(200) - 기본주소
CLIENT_ADDRESS2               VARCHAR2(100) - 상세주소
CLIENT_REGISTER_DATE          DATE          - 회원가입날짜
CLIENT_UPDATE_DATE            DATE          - 회원변경날짜
CLIENT_LAST_LOGIN             DATE          - 마지막 로그인 날짜
CLIENT_STATUS                 NUMBER(1)     - 회원권한 : 0(탈퇴회원), 1(일반회원), 9(관리자)
*/

public class ClientDTO {
	private int clientNum;
	private String clientId;
	private String clientPasswd;
	private String clientName;
	private String clientEmail;
	private String clientMobile;
	private String clientZipcode;
	private String clientAddress1;
	private String clientAddress2;
	private String clientRegisterDate;
	private String clientUpdateDate;
	private String clientLastLogin;
	private int clientStatus;

	public ClientDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getClientNum() {
		return clientNum;
	}

	public void setClientNum(int clientNum) {
		this.clientNum = clientNum;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientPasswd() {
		return clientPasswd;
	}

	public void setClientPasswd(String clientPasswd) {
		this.clientPasswd = clientPasswd;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getClientEmail() {
		return clientEmail;
	}

	public void setClientEmail(String clientEmail) {
		this.clientEmail = clientEmail;
	}

	public String getClientMobile() {
		return clientMobile;
	}

	public void setClientMobile(String clientMobile) {
		this.clientMobile = clientMobile;
	}

	public String getClientZipcode() {
		return clientZipcode;
	}

	public void setClientZipcode(String clientZipcode) {
		this.clientZipcode = clientZipcode;
	}

	public String getClientAddress1() {
		return clientAddress1;
	}

	public void setClientAddress1(String clientAddress1) {
		this.clientAddress1 = clientAddress1;
	}

	public String getClientAddress2() {
		return clientAddress2;
	}

	public void setClientAddress2(String clientAddress2) {
		this.clientAddress2 = clientAddress2;
	}

	public String getClientRegisterDate() {
		return clientRegisterDate;
	}

	public void setClientRegisterDate(String clientRegisterDate) {
		this.clientRegisterDate = clientRegisterDate;
	}

	public String getClientUpdateDate() {
		return clientUpdateDate;
	}

	public void setClientUpdateDate(String clientUpdateDate) {
		this.clientUpdateDate = clientUpdateDate;
	}

	public String getClientLastLogin() {
		return clientLastLogin;
	}

	public void setClientLastLogin(String clientLastLogin) {
		this.clientLastLogin = clientLastLogin;
	}

	public int getClientStatus() {
		return clientStatus;
	}

	public void setClientStatus(int clientStatus) {
		this.clientStatus = clientStatus;
	}
}