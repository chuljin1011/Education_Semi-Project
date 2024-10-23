package xyz.itwill.dto;

/*
 이름              널?       유형            
--------------- -------- ------------- 
ORD_NUM         NOT NULL NUMBER        
ORD_CLIENT_NUM  NOT NULL NUMBER        
ORD_TIME        NOT NULL VARCHAR2(100) 
ORD_DATE        NOT NULL DATE          
ORD_PRODUCT_NUM NOT NULL NUMBER        
ORD_STATUS      NOT NULL NUMBER(1)     
ORD_RECEIVER    NOT NULL VARCHAR2(20)  
ORD_ZIPCODE     NOT NULL VARCHAR2(10)  
ORD_ADDRESS1    NOT NULL VARCHAR2(200) 
ORD_ADDRESS2             VARCHAR2(100) 
ORD_MOBILE      NOT NULL VARCHAR2(20)  
ORD_COUNT       NOT NULL VARCHAR2(5)   
ORD_EMAIL       NOT NULL VARCHAR2(50)  
CART_METHOD     NOT NULL NUMBER(5)     
PAY_SUM         NOT NULL NUMBER     
 
 */

public class OrdDTO {
	private int ordNum;
	private int ordclientNum;
	private String ordTime;
	private String ordDate;
	private int ordproductNum;
	private int ordStatus;
	private String ordReceiver;
	private String ordZipcode;
	private String ordAddress1;
	private String ordAddress2;
	private String ordMobile;
	private String ordCount;
	private String ordEmail;
	private int ordCartMethod;
	private int ordPaySum;
	
	
	public OrdDTO() {
		// TODO Auto-generated constructor stub
	}


	public OrdDTO(int ordNum, int ordclientNum, String ordTime, String ordDate, int ordproductNum, int ordStatus,
			String ordReceiver, String ordZipcode, String ordAddress1, String ordAddress2, String ordMobile,
			String ordCount, String ordEmail, int ordCartMethod, int ordPaySum) {
		super();
		this.ordNum = ordNum;
		this.ordclientNum = ordclientNum;
		this.ordTime = ordTime;
		this.ordDate = ordDate;
		this.ordproductNum = ordproductNum;
		this.ordStatus = ordStatus;
		this.ordReceiver = ordReceiver;
		this.ordZipcode = ordZipcode;
		this.ordAddress1 = ordAddress1;
		this.ordAddress2 = ordAddress2;
		this.ordMobile = ordMobile;
		this.ordCount = ordCount;
		this.ordEmail = ordEmail;
		this.ordCartMethod = ordCartMethod;
		this.ordPaySum = ordPaySum;
	}


	public int getOrdNum() {
		return ordNum;
	}


	public void setOrdNum(int ordNum) {
		this.ordNum = ordNum;
	}


	public int getOrdclientNum() {
		return ordclientNum;
	}


	public void setOrdclientNum(int ordclientNum) {
		this.ordclientNum = ordclientNum;
	}


	public String getOrdTime() {
		return ordTime;
	}


	public void setOrdTime(String ordTime) {
		this.ordTime = ordTime;
	}


	public String getOrdDate() {
		return ordDate;
	}


	public void setOrdDate(String ordDate) {
		this.ordDate = ordDate;
	}


	public int getOrdproductNum() {
		return ordproductNum;
	}


	public void setOrdproductNum(int ordproductNum) {
		this.ordproductNum = ordproductNum;
	}


	public int getOrdStatus() {
		return ordStatus;
	}


	public void setOrdStatus(int ordStatus) {
		this.ordStatus = ordStatus;
	}


	public String getOrdReceiver() {
		return ordReceiver;
	}


	public void setOrdReceiver(String ordReceiver) {
		this.ordReceiver = ordReceiver;
	}


	public String getOrdZipcode() {
		return ordZipcode;
	}


	public void setOrdZipcode(String ordZipcode) {
		this.ordZipcode = ordZipcode;
	}


	public String getOrdAddress1() {
		return ordAddress1;
	}


	public void setOrdAddress1(String ordAddress1) {
		this.ordAddress1 = ordAddress1;
	}


	public String getOrdAddress2() {
		return ordAddress2;
	}


	public void setOrdAddress2(String ordAddress2) {
		this.ordAddress2 = ordAddress2;
	}


	public String getOrdMobile() {
		return ordMobile;
	}


	public void setOrdMobile(String ordMobile) {
		this.ordMobile = ordMobile;
	}


	public String getOrdCount() {
		return ordCount;
	}


	public void setOrdCount(String ordCount) {
		this.ordCount = ordCount;
	}


	public String getOrdEmail() {
		return ordEmail;
	}


	public void setOrdEmail(String ordEmail) {
		this.ordEmail = ordEmail;
	}


	public int getOrdCartMethod() {
		return ordCartMethod;
	}


	public void setOrdCartMethod(int ordCartMethod) {
		this.ordCartMethod = ordCartMethod;
	}


	public int getOrdPaySum() {
		return ordPaySum;
	}


	public void setOrdPaySum(int ordPaySum) {
		this.ordPaySum = ordPaySum;
	}
	

	
	

	
	
	
	
	
}
