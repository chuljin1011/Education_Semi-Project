package xyz.itwill.dto;

/*
이름               널?       유형            
---------------- -------- ------------- 
PRODUCT_NUM      NOT NULL NUMBER        
PRODUCT_NAME              VARCHAR2(200) 
PRODUCT_PRICE             NUMBER(10)    
PRODUCT_COM               VARCHAR2(30)  
PRODUCT_BRAND             VARCHAR2(50)  
PRODUCT_ORIGIN            VARCHAR2(50)  
PRODUCT_TYPE              NUMBER(2)     
PRODUCT_REG               TIMESTAMP(6)  
PRODUCT_STATUS            NUMBER(1)     
PRODUCT_MAIN_IMG          VARCHAR2(50)  
PRODUCT_SUB_IMG           VARCHAR2(50)  
PRODUCT_RANK              NUMBER(1)  
*/

public class ProductDTO {
	private int productNum;
	private String productName;
	private int productPrice;
	private String productCom;
	private String productBrand;
	private String productOrigin;
	private int productType;
	private String productReg;
	private int productStatus;
	private String productMainImg;
	private String productSubImg;
	private int productRank;
	
	public ProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductCom() {
		return productCom;
	}

	public void setProductCom(String productCom) {
		this.productCom = productCom;
	}

	public String getProductBrand() {
		return productBrand;
	}

	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}

	public String getProductOrigin() {
		return productOrigin;
	}

	public void setProductOrigin(String productOrigin) {
		this.productOrigin = productOrigin;
	}

	public int getProductType() {
		return productType;
	}

	public void setProductType(int productType) {
		this.productType = productType;
	}

	public String getProductReg() {
		return productReg;
	}

	public void setProductReg(String productReg) {
		this.productReg = productReg;
	}

	public int getProductStatus() {
		return productStatus;
	}

	public void setProductStatus(int productStatus) {
		this.productStatus = productStatus;
	}

	public String getProductMainImg() {
		return productMainImg;
	}

	public void setProductMainImg(String productMainImg) {
		this.productMainImg = productMainImg;
	}

	public String getProductSubImg() {
		return productSubImg;
	}

	public void setProductSubImg(String productSubImg) {
		this.productSubImg = productSubImg;
	}

	public int getProductRank() {
		return productRank;
	}

	public void setProductRank(int productRank) {
		this.productRank = productRank;
	}
	
	
	
	
}
