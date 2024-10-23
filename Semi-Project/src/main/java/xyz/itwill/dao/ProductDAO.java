
package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.ProductDTO;

public class ProductDAO extends JdbcDAO {
	private static ProductDAO _dao;

	public ProductDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new ProductDAO();
	}

	public static ProductDAO getDAO() {
		return _dao;
	}

	// 제품번호 전달받아 PRODUCT 테이블의 모든 행 검색
	public List<ProductDTO> selectProductAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "select product_num, product_name, product_price, product_com, product_brand"
					+ ",product_origin, product_type, product_reg, product_status, product_main_img"
					+ ",product_sub_img, product_rank from product order by product_num";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductCom(rs.getString("product_com"));
				product.setProductBrand(rs.getString("product_brand"));
				product.setProductOrigin(rs.getString("product_origin"));
				product.setProductType(rs.getInt("product_type"));
				product.setProductReg(rs.getString("product_reg"));
				product.setProductStatus(rs.getInt("product_status"));
				product.setProductMainImg(rs.getString("product_main_img"));
				product.setProductSubImg(rs.getString("product_sub_img"));
				product.setProductRank(rs.getInt("product_rank"));

				// List 객체에 요소를 추가하여 요소값(ProductDTO)을 추가하여 저장
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductAll() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;

	}

	// rank 번호를 전달받아 PRODUCT 테이블의 해당 행들을 List 객체로 저장
	public List<ProductDTO> selectProductRank(int rank) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "select product_num, product_name, product_price, product_main_img from product where product_rank=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rank);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductMainImg(rs.getString("product_main_img"));

				// List 객체에 요소를 추가하여 요소값(ProductDTO)을 추가하여 저장
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductAll() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;

	}
	
	// rank 번호를 전달받아 PRODUCT 테이블의 해당 행들을 List 객체로 저장
		public List<ProductDTO> selectProductRankSortDate(int rank) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> productList = new ArrayList<ProductDTO>();

			try {
				con = getConnection();

				String sql = "select product_num, product_name, product_price, product_main_img from product where product_rank=? order by product_reg";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rank);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					ProductDTO product = new ProductDTO();
					product.setProductNum(rs.getInt("product_num"));
					product.setProductName(rs.getString("product_name"));
					product.setProductPrice(rs.getInt("product_price"));
					product.setProductMainImg(rs.getString("product_main_img"));

					// List 객체에 요소를 추가하여 요소값(ProductDTO)을 추가하여 저장
					productList.add(product);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectProductAll() 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return productList;

		}
		
		// rank 번호를 전달받아 PRODUCT 테이블의 해당 행들을 List 객체로 저장
		public List<ProductDTO> selectProductRankSortPD(int rank) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> productList = new ArrayList<ProductDTO>();
	
			try {
				con = getConnection();
	
				String sql = "select product_num, product_name, product_price, product_main_img from product where product_rank=? order by product_price desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rank);
	
				rs = pstmt.executeQuery();
	
				while (rs.next()) {
					ProductDTO product = new ProductDTO();
					product.setProductNum(rs.getInt("product_num"));
					product.setProductName(rs.getString("product_name"));
					product.setProductPrice(rs.getInt("product_price"));
					product.setProductMainImg(rs.getString("product_main_img"));
	
					// List 객체에 요소를 추가하여 요소값(ProductDTO)을 추가하여 저장
					productList.add(product);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectProductAll() 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return productList;
	
		}
		
		
		// rank 번호를 전달받아 PRODUCT 테이블의 해당 행들을 List 객체로 저장
				public List<ProductDTO> selectProductRankSortPA(int rank) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					List<ProductDTO> productList = new ArrayList<ProductDTO>();
			
					try {
						con = getConnection();
			
						String sql = "select product_num, product_name, product_price, product_main_img from product where product_rank=? order by product_price";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, rank);
			
						rs = pstmt.executeQuery();
			
						while (rs.next()) {
							ProductDTO product = new ProductDTO();
							product.setProductNum(rs.getInt("product_num"));
							product.setProductName(rs.getString("product_name"));
							product.setProductPrice(rs.getInt("product_price"));
							product.setProductMainImg(rs.getString("product_main_img"));
			
							// List 객체에 요소를 추가하여 요소값(ProductDTO)을 추가하여 저장
							productList.add(product);
						}
					} catch (SQLException e) {
						System.out.println("[에러]selectProductAll() 메소드의 SQL 오류 = " + e.getMessage());
					} finally {
						close(con, pstmt, rs);
					}
					return productList;
			
				}
		

	// type 번호를 전달받아 PRODUCT 테이블의 해당 행들을 List 객체로 저장
	public List<ProductDTO> selectProductType(int type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "select product_num, product_name, product_price, product_main_img from product where product_type=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, type);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductMainImg(rs.getString("product_main_img"));

				// List 객체에 요소를 추가하여 요소값(ProductDTO)을 추가하여 저장
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductAll() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;

	}
	
	// type 번호를 전달받아 PRODUCT 테이블의 해당 행들을 List 객체로 저장
	public List<ProductDTO> selectProductTypeSortDate(int type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "select product_num, product_name, product_price, product_main_img from product where product_type=? order by product_reg desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, type);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductMainImg(rs.getString("product_main_img"));

				// List 객체에 요소를 추가하여 요소값(ProductDTO)을 추가하여 저장
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductTypeSortPriceDesc() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;

	}
	
	public List<ProductDTO> selectProductTypeSortPD(int type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "select product_num, product_name, product_price, product_main_img from product where product_type=? order by product_price desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, type);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductMainImg(rs.getString("product_main_img"));

				// List 객체에 요소를 추가하여 요소값(ProductDTO)을 추가하여 저장
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductTypeSortPriceDesc() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;

	}
	
	public List<ProductDTO> selectProductTypeSortPA(int type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "select product_num, product_name, product_price, product_main_img from product where product_type=? order by product_price";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, type);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductMainImg(rs.getString("product_main_img"));

				// List 객체에 요소를 추가하여 요소값(ProductDTO)을 추가하여 저장
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductTypeSortPriceDesc() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;

	}
	

	// 제품번호를 전달받아 PRODUCT 테이블의 해당 행검색
	public ProductDTO selectProduct(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;

		try {
			con = getConnection();

			String sql = "select product_num ,product_name, product_price, product_com, product_brand, product_origin, product_type"
					+ ", product_reg, product_status, product_main_img, product_sub_img, product_rank from product where product_num=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductCom(rs.getString("product_com"));
				product.setProductBrand(rs.getString("product_brand"));
				product.setProductOrigin(rs.getString("product_origin"));
				product.setProductType(rs.getInt("product_type"));
				product.setProductReg(rs.getString("product_reg"));
				product.setProductStatus(rs.getInt("product_status"));
				product.setProductMainImg(rs.getString("product_main_img"));
				product.setProductSubImg(rs.getString("product_sub_img"));
				product.setProductRank(rs.getInt("product_rank"));
			}

		} catch (SQLException e) {
			System.out.println("[에러]selectProduct()메소드" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}

	// 상품정보(ProductDTO 객체)를 전달받아 PRODUCT 테이블의 행을 삽입하고 삽입 갯수를 반환하는 메소드
	/*
	 * public int insertProduct(ProductDTO product) { Connection con=null;
	 * PreparedStatement pstmt=null; int rows=0;
	 * 
	 * try { con=getConnection();
	 * 
	 * String
	 * sql="insert into product values(product_seq.nextval,?,?,?,?,?,?,sysdate,?,?,?,?)"
	 * ; pstmt=con.prepareStatement(sql); pstmt.setString(1,
	 * product.getProductName()); pstmt.setInt(2, product.getProductPrice());
	 * pstmt.setString(3, product.getProductCom()); pstmt.setString(4,
	 * product.getProductBrand()); pstmt.setString(5, product.getProductOrigin());
	 * pstmt.setInt(6, product.getProductType()); pstmt.setInt(7,
	 * product.getProductStatus()); pstmt.setString(8, product.getProductMainImg());
	 * pstmt.setString(9, product.getProductSubImg()); pstmt.setInt(10,
	 * product.getProductRank());
	 * 
	 * 
	 * rows=pstmt.executeUpdate(); } catch (SQLException e) {
	 * System.out.println("[에러]insertProduct() 메서드의 SQL 오류 = "+e.getMessage()); }
	 * finally { close(con, pstmt); } return rows;
	 * 
	 * }
	 */
	public int insertProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			// SQL 쿼리에서 열 이름을 명시적으로 지정
			String sql = "INSERT INTO product (PRODUCT_NUM, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_COM, "
					+ "PRODUCT_BRAND, PRODUCT_ORIGIN, PRODUCT_TYPE, PRODUCT_REG, "
					+ "PRODUCT_STATUS, PRODUCT_MAIN_IMG, PRODUCT_SUB_IMG, PRODUCT_RANK) "
					+ "VALUES (product_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getProductName());
			pstmt.setInt(2, product.getProductPrice());
			pstmt.setString(3, product.getProductCom());
			pstmt.setString(4, product.getProductBrand());
			pstmt.setString(5, product.getProductOrigin());
			pstmt.setInt(6, product.getProductType());
			pstmt.setInt(7, product.getProductStatus());
			pstmt.setString(8, product.getProductMainImg());
			pstmt.setString(9, product.getProductSubImg());
			pstmt.setInt(10, product.getProductRank());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("[에러] insertProduct() 메서드의 SQL 오류 = " + e.getMessage(), e);
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 제품번호(int)를 전달받아 PRODUCT 테이블에 저장된 행을 삭제하고 삭제행의 갯수(int)를
	// 반환하는 메소드
	public int deleteProduct(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "delete from product where product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteProduct() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 여기부터 수정
	public int countProductList(String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql;

		try {
			con = getConnection();

			if (keyword.equals("")) { // 조회기능을 사용하지 않을 경우
				sql = "SELECT COUNT(*) FROM product";
				pstmt = con.prepareStatement(sql);
			} else { // 조회기능을 사용한 경우
				sql = "SELECT COUNT(*) FROM product WHERE PRODUCT_NAME" + " LIKE '%' || ? || '%'";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%"); // LIKE 구문 수정
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (SQLException e) {
			System.out.println("[에러] countProductList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs); // 리소스 정리
		}
		return count;
	}

	/*
	 * public List<ProductDTO> getProductListPaging(int startRow, int endRow, String
	 * search, String keyword) { Connection con = null; PreparedStatement pstmt =
	 * null; ResultSet rs = null; List<ProductDTO> productList = new
	 * ArrayList<ProductDTO>();
	 * 
	 * String sql; try { con = getConnection(); if (keyword.equals("")) { sql =
	 * "SELECT * FROM ( " +
	 * "SELECT product_num, product_name, product_price, product_main_img, ROWNUM rn "
	 * + "FROM product " + "ORDER BY product_num) " + "WHERE rn BETWEEN ? AND ?";
	 * pstmt = con.prepareStatement(sql); pstmt.setInt(1, startRow); pstmt.setInt(2,
	 * endRow); } else { sql = "SELECT * FROM ( " +
	 * "SELECT product_num, product_name, product_price, product_main_img, ROWNUM rn "
	 * + "FROM product " + "WHERE " + search + " LIKE '%' || ? || '%' " +
	 * "WHERE PRODUCT_NAME LIKE '%' || ? || '%' " + "ORDER BY product_num) " +
	 * "WHERE rn BETWEEN ? AND ?"; pstmt = con.prepareStatement(sql);
	 * pstmt.setString(1, keyword); pstmt.setInt(2, startRow); pstmt.setInt(3,
	 * endRow); } rs = pstmt.executeQuery();
	 * 
	 * while (rs.next()) { ProductDTO product = new ProductDTO();
	 * product.setProductNum(rs.getInt("product_num")); // 수정
	 * product.setProductName(rs.getString("product_name"));
	 * product.setProductPrice(rs.getInt("product_price"));
	 * product.setProductMainImg(rs.getString("product_main_img"));
	 * productList.add(product); } } catch (SQLException e) {
	 * System.out.println("[에러]getProductListPaging()메소드: " + e.getMessage()); }
	 * finally { close(con, pstmt, rs); } return productList; }
	 */
	
	public List<ProductDTO> getProductListPaging(int startRow, int endRow, String search, String keyword, String orderby) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<ProductDTO> productList = new ArrayList<ProductDTO>();
	    
	    String sql;
	    try {
	        con = getConnection();
	        if (keyword.equals("")) {
	            sql = "SELECT * FROM ( "
	                    + "SELECT product_num, product_name, product_price, product_main_img, ROWNUM rn "
	                    + "FROM product "
	                    + "ORDER BY "+ orderby + ") "
	                    + "WHERE rn BETWEEN ? AND ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setInt(1, startRow);
	            pstmt.setInt(2, endRow);
	        } else {
	            sql = "SELECT * FROM ( "
	                    + "SELECT product_num, product_name, product_price, product_main_img, ROWNUM rn "
	                    + "FROM product "
	                    + "WHERE PRODUCT_NAME LIKE '%' || ? || '%' "
	                    + "ORDER BY "+ orderby + ") "
	                    + "WHERE rn BETWEEN ? AND ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, keyword);
	            pstmt.setInt(2, startRow);
	            pstmt.setInt(3, endRow);
	        }
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            ProductDTO product = new ProductDTO();
	            product.setProductNum(rs.getInt("product_num")); 
	            product.setProductName(rs.getString("product_name"));
	            product.setProductPrice(rs.getInt("product_price"));
	            product.setProductMainImg(rs.getString("product_main_img"));
	            productList.add(product);
	        }
	    } catch (SQLException e) {
	        System.out.println("[에러]getProductListPaging()메소드: " + e.getMessage());
	    } finally {
	        close(con, pstmt, rs);
	    }
	    return productList;
	}
	
	//상품수정
	public int updateProduct(ProductDTO product) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    int rows = 0;

	    try {
	        con = getConnection();

	        String sql = "UPDATE product SET product_name = ?, product_price = ?, product_com = ?, "
	                   + "product_brand = ?, product_origin = ?, product_type = ?, product_status = ?, "
	                   + "product_main_img = ?, product_sub_img = ?, product_rank = ? "
	                   + "WHERE product_num = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, product.getProductName());
	        pstmt.setInt(2, product.getProductPrice());
	        pstmt.setString(3, product.getProductCom());
	        pstmt.setString(4, product.getProductBrand());
	        pstmt.setString(5, product.getProductOrigin());
	        pstmt.setInt(6, product.getProductType());
	        pstmt.setInt(7, product.getProductStatus());
	        pstmt.setString(8, product.getProductMainImg());
	        pstmt.setString(9, product.getProductSubImg());
	        pstmt.setInt(10, product.getProductRank());
	        pstmt.setInt(11, product.getProductNum());

	        rows = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        throw new RuntimeException("[에러] updateProduct() 메서드의 SQL 오류 = " + e.getMessage(), e);
	    } finally {
	        close(con, pstmt);
	    }
	    return rows;
	}



	
	
}
