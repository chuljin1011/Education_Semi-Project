package xyz.itwill.dto;

import java.sql.Date;

/*
 create table delivery (delivery_num number primary key, order_num number,delivery_status number
, delivery_create date, delivery_update date); 

create SEQUENCE delivery_seq;
  */
/* 
이름              널?       유형     
--------------- -------- ------ 
DELIVERY_NUM    NOT NULL NUMBER 
ORDER_NUM                NUMBER 
DELIVERY_CREATE          DATE   
DELIVERY_UPDATE          DATE
 */
public class DeliveryDTO {
	private int deliveryNum;
	private int orderNum;
	private Date deliveryCreate;
	private Date deliveryUpdate;
	//JOIN 값 추가 설정
	private int ordStatus;
    private String ordCount;
    private int paySum;
    private String productName;
	
	public DeliveryDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getDeliveryNum() {
		return deliveryNum;
	}

	public void setDeliveryNum(int deliveryNum) {
		this.deliveryNum = deliveryNum;
	}

	public int getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}

	public Date getDeliveryCreate() {
		return deliveryCreate;
	}

	public void setDeliveryCreate(Date date) {
		this.deliveryCreate = date;
	}

	public Date getDeliveryUpdate() {
		return deliveryUpdate;
	}

	public void setDeliveryUpdate(Date date) {
		this.deliveryUpdate = date;
	}

	public int getOrdStatus() {
		return ordStatus;
	}

	public void setOrdStatus(int ordStatus) {
		this.ordStatus = ordStatus;
	}

	public String getOrdCount() {
		return ordCount;
	}

	public void setOrdCount(String ordCount) {
		this.ordCount = ordCount;
	}

	public int getPaySum() {
		return paySum;
	}

	public void setPaySum(int paySum) {
		this.paySum = paySum;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	
	
	
	
	
}
