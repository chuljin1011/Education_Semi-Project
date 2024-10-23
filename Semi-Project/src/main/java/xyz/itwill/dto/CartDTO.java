package xyz.itwill.dto;

public class CartDTO {
	private int cartNum; //장바구니 번호
	private int cartClientNum; //회원번호
	private int cartProductNum; //제품번호
	private int cartCount; // 수량
	private String cartOpt; // 옵션
	
	public CartDTO() {
		// TODO Auto-generated constructor stub
	}

	
		
	
		
	public CartDTO(int cartNum, int cartClientNum, int cartProductNum, int cartCount, String cartOpt) {
		super();
		this.cartNum = cartNum;
		this.cartClientNum = cartClientNum;
		this.cartProductNum = cartProductNum;
		this.cartCount = cartCount;
		this.cartOpt = cartOpt;
	}





	public String getCartOpt() {
		return cartOpt;
	}

	public void setCartOpt(String cartOpt) {
		this.cartOpt = cartOpt;
	}

	public int getCartNum() {
		return cartNum;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}

	public int getCartClientNum() {
		return cartClientNum;
	}

	public void setCartClientNum(int cartClientNum) {
		this.cartClientNum = cartClientNum;
	}

	public int getCartProductNum() {
		return cartProductNum;
	}

	public void setCartProductNum(int cartProductNum) {
		this.cartProductNum = cartProductNum;
	}

	public int getCartCount() {
		return cartCount;
	}

	public void setCartCount(int cartCount) {
		this.cartCount = cartCount;
	}
	
	
	
}
