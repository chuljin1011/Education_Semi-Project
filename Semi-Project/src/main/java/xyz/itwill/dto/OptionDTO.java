package xyz.itwill.dto;

public class OptionDTO {
	private int productNum;
	private String option;
	public OptionDTO() {
		// TODO Auto-generated constructor stub
	}
	public OptionDTO(int productNum, String option) {
		super();
		this.productNum = productNum;
		this.option = option;
	}
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	
}
