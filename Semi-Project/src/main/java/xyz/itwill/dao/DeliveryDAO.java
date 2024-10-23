package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.DeliveryDTO;



public class DeliveryDAO extends JdbcDAO {
	private static DeliveryDAO _dao;
	
	public DeliveryDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {	
		_dao = new DeliveryDAO();
	}
	
	public static DeliveryDAO getDAO() {
		return _dao;
	}
	
	/*배송테이블의 모든 값을 조회하는 DAO*/
	public List<DeliveryDTO> selectDeliveryListAll() {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<DeliveryDTO> deliveryList = new ArrayList<DeliveryDTO>();
	    try {
	        con = getConnection();
	        
	        String sql = "SELECT delivery_num, order_num, delivery_create, delivery_update FROM delivery ORDER BY delivery_num"; // SQL 쿼리 추가
	        pstmt = con.prepareStatement(sql);
	        
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            DeliveryDTO delivery = new DeliveryDTO();
	            delivery.setDeliveryNum(rs.getInt("delivery_num")); // 대문자로 컬럼명 사용
	            delivery.setOrderNum(rs.getInt("order_num"));
	            delivery.setDeliveryCreate(rs.getDate("delivery_create")); // DATE 타입이므로 getDate 사용
	            delivery.setDeliveryUpdate(rs.getDate("delivery_update"));
	            deliveryList.add(delivery);
	        }
	    } catch (SQLException e) {
	        System.out.println("[에러]selectDeliveryListAll() 메소드의 SQL 오류 = " + e.getMessage());
	    } finally {
	        close(con, pstmt, rs);
	    }
	    
	    return deliveryList;
	}
	
	/* 관리자 배송 리스트를 보기 위한 전체 or 검색어 포함 리스트 불러오기  */
	public List<DeliveryDTO> selectDeliveryList(int startRow, int endRow, String search, String keyword, String solt) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<DeliveryDTO> deliveryList=new ArrayList<DeliveryDTO>();
		
		if (search.equals("delivery_create")) {
			keyword = keyword.replace("-", "/");
		}
		
		try {
			con=getConnection();
			
			if(keyword.equals("")) {
				String sql="select * from (select rownum rn, temp.* from (select "
					+ "delivery_num,order_num,delivery_create,delivery_update,ord_status from delivery"
					+ " join ord on order_num=ord_num"	
					+ " order by delivery_num "+solt+") temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn, temp.* from (select "
					+ "delivery_num,order_num,delivery_create,delivery_update,ord_status from delivery"
					+ " join ord on order_num=ord_num where "	
					+search+" like '%'||?||'%' order by delivery_num "+solt+") temp) where rn"
					+ " between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DeliveryDTO delivery = new DeliveryDTO();
	            delivery.setDeliveryNum(rs.getInt("delivery_num"));
	            delivery.setOrderNum(rs.getInt("order_num"));
	            delivery.setDeliveryCreate(rs.getDate("delivery_create"));
	            delivery.setDeliveryUpdate(rs.getDate("delivery_update"));
	            delivery.setOrdStatus(rs.getInt("ord_status"));
				
				deliveryList.add(delivery);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectDeliveryList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return deliveryList;
	}
	
	/* 관리자 List 페이징 처리를 위한 전체 data 개수 반환 */
		public int selectTotalDelivery(String search, String keyword) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				con=getConnection();
				
				if (search.equals("delivery_create")) {
					keyword = keyword.replace("-", "/");
				}				
				
				//매개변수에 저장된 값을 비교하여 DBMS 서버에 다른 SQL 명령을 전달하여 실행
				// => 동적 SQL(Dynamic SQL)
				if(keyword.equals("")) {//조회기능을 사용하지 않을 경우
					String sql="select count(*) from delivery";
					pstmt=con.prepareStatement(sql);
				} else {
					String sql="select count(*) from delivery where "+search+" like '%'||?||'%'";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				}
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					count=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectTotalDelivery() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return count;
		}
	
	/*clinetNum 의 값을 가지고 30일 이내의 배송테이블을 조회하는 DAO */
	public List<DeliveryDTO> getRecentlyDateByNum(int clientNum) {
		Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<DeliveryDTO> deliveryList = new ArrayList<DeliveryDTO>();
	    
	    try {
	    	
	    	con = getConnection();
	    	
	    	String sql = "SELECT o.ORD_NUM, d.DELIVERY_CREATE, o.ORD_STATUS, o.ORD_COUNT, o.PAY_SUM, o.ORD_CLIENT_NUM, p.PRODUCT_NAME "
	                + "FROM DELIVERY d "
	                + "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
	                + "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
	                + "WHERE d.DELIVERY_CREATE >= SYSDATE - 30 AND o.ORD_CLIENT_NUM = ? "
	                + "ORDER BY DELIVERY_NUM DESC";
	                
	    	
	    	pstmt = con.prepareStatement(sql);
	    	pstmt.setInt(1, clientNum);
	    	rs = pstmt.executeQuery();
	    	
	    	while (rs.next()) {
	    	    DeliveryDTO delivery = new DeliveryDTO();
	    	    delivery.setOrderNum(rs.getInt("ORD_NUM"));
	    	    delivery.setDeliveryCreate(rs.getDate("DELIVERY_CREATE"));
	    	    delivery.setOrdStatus(rs.getInt("ORD_STATUS"));
	    	    delivery.setOrdCount(rs.getString("ORD_COUNT"));
	    	    delivery.setPaySum(rs.getInt("PAY_SUM"));
	    	    delivery.setProductName(rs.getString("PRODUCT_NAME"));
	    	    deliveryList.add(delivery); 
	    	}
	    	
	    } catch (SQLException e) {
	    	System.out.println("[에러]getRecentlyDate() 메소드의 SQL 오류 = " + e.getMessage());
	    } finally {
			close(con, pstmt, rs);
		}
	    
	    return deliveryList; 
			
	}
	
	/*배송테이블에 값을 삽입하는 DAO */
	public void insertDeliveryList(DeliveryDTO delivery) {
		Connection con = null;
	    PreparedStatement pstmt = null;
	    try {
	    	con = getConnection();
	    	String sql = "INSERT INTO DELIVERY (DELIVERY_NUM, ORDER_NUM, DELIVERY_CREATE, DELIVERY_UPDATE) "
	    			+ "VALUES(DELIVERY_SEQ.NEXTVAL, ?, SYSDATE, SYSDATE)";
	                
	    	pstmt = con.prepareStatement(sql);
	    	pstmt.setInt(1, delivery.getOrderNum());	// 최신값 + 1 삽입
	    	pstmt.executeUpdate();
	    } catch (SQLException e) {
	    	System.out.println("[에러]insertDeliveryList() 메소드의 SQL 오류 = " + e.getMessage());
	    } finally {
			close(con, pstmt);
		}
	}
	
	/*clinetNum 의 값을 가지고 배송테이블을 조회하는 DAO */
	public List<DeliveryDTO> selectDeliveryListByNum(int clientNum) {
		Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<DeliveryDTO> deliveryList = new ArrayList<DeliveryDTO>();
	    
	    try {
	    	
	    	con = getConnection();
	    	
	    	String sql = "SELECT o.ORD_NUM, d.DELIVERY_CREATE, o.ORD_STATUS, o.ORD_COUNT, o.PAY_SUM, o.ORD_CLIENT_NUM, p.PRODUCT_NAME "
	                + "FROM DELIVERY d "
	                + "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
	                + "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
	                + "WHERE o.ORD_CLIENT_NUM = ?"
	                + "ORDER BY d.DELIVERY_NUM DESC";
	                
	    	
	    	pstmt = con.prepareStatement(sql);
	    	pstmt.setInt(1, clientNum);
	    	rs = pstmt.executeQuery();
	    	
	    	while (rs.next()) {
	    	    DeliveryDTO delivery = new DeliveryDTO();
	    	    delivery.setOrderNum(rs.getInt("ORD_NUM"));
	    	    delivery.setDeliveryCreate(rs.getDate("DELIVERY_CREATE"));
	    	    delivery.setOrdStatus(rs.getInt("ORD_STATUS"));
	    	    delivery.setOrdCount(rs.getString("ORD_COUNT"));
	    	    delivery.setPaySum(rs.getInt("PAY_SUM"));
	    	    delivery.setProductName(rs.getString("PRODUCT_NAME"));
	    	    deliveryList.add(delivery); 
	    	}
	    	
	    } catch (SQLException e) {
	    	System.out.println("[에러]getRecentlyDate() 메소드의 SQL 오류 = " + e.getMessage());
	    } finally {
			close(con, pstmt, rs);
		}
	    
	    return deliveryList; 
			
	}
	
	/*datepicker 로 설정한 기간의 배송내역을 조회하는 DAO*/
	public List<DeliveryDTO> getDeliveriesByDateRange(String startDate, String endDate, int clientNum) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<DeliveryDTO> deliveryList = new ArrayList<DeliveryDTO>();
	    
	    try {
	        con = getConnection();
	        
	        String sql = "SELECT o.ORD_NUM, d.DELIVERY_CREATE, o.ORD_STATUS, o.ORD_COUNT, o.PAY_SUM, o.ORD_CLIENT_NUM, p.PRODUCT_NAME "
	                + "FROM DELIVERY d "
	                + "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
	                + "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
	                + "WHERE o.ORD_CLIENT_NUM = ? "
	                + "AND d.DELIVERY_CREATE >= ? AND d.DELIVERY_CREATE <= ? "  
	                + "ORDER BY d.DELIVERY_CREATE DESC";
	        
	        pstmt = con.prepareStatement(sql);
	        
	        // 사용자가 입력한 시작 날짜에서 하루 전 날짜로 설정
	        LocalDate startLocalDate = LocalDate.parse(startDate);
	        LocalDate adjustedStartDate = startLocalDate.minusDays(1); // 실제 조회 시 하루 전
	        
	        // 사용자가 입력한 종료 날짜에서 하루 후 날짜로 설정
	        LocalDate endLocalDate = LocalDate.parse(endDate);
	        LocalDate nextDay = endLocalDate.plusDays(1); // 실제 조회 시 하루 후
	        
	        pstmt.setInt(1, clientNum); // 첫 번째 매개변수에 clientNum 설정
	        pstmt.setString(2, adjustedStartDate.toString()); // 두 번째 매개변수에 하루 전 날짜 설정
	        pstmt.setString(3, nextDay.toString()); // 세 번째 매개변수에 하루 후 날짜 설정
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            DeliveryDTO delivery = new DeliveryDTO();
	    	    delivery.setOrderNum(rs.getInt("ORD_NUM"));
	    	    delivery.setDeliveryCreate(rs.getDate("DELIVERY_CREATE"));
	    	    delivery.setOrdStatus(rs.getInt("ORD_STATUS"));
	    	    delivery.setOrdCount(rs.getString("ORD_COUNT"));
	    	    delivery.setPaySum(rs.getInt("PAY_SUM"));
	    	    delivery.setProductName(rs.getString("PRODUCT_NAME"));
	    	    deliveryList.add(delivery); 
	        }
	        
	    } catch (SQLException e) {
	        System.out.println("[에러] getDeliveriesByDateRange() 메소드의 SQL 오류 " + e.getMessage());
	    } finally {
	        close(con, pstmt, rs);
	    }
	    
	    return deliveryList;
	}
	//조회정보(조회대상과 조회단어)를 전달받아 DELIVERY 테이블에 저장된 행에서 조회정보가 포함된 
	//행의 갯수를 검색하여 반환하는 메소드
	// => 조회기능을 사용하지 않을 경우 REVIEW 테이블에 저장된 모든 행의 갯수를 검색하여 반환
	public int countDeliveryListRecentPaging(String startDate, String endDate, String search, String keyword, int clientNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			//매개변수에 저장된 값을 비교하여 DBMS 서버에 다른 SQL 명령을 전달하여 실행
			// => 동적 SQL(Dynamic SQL)
			if(keyword.equals("")) {//조회기능을 사용하지 않을 경우
				String sql="SELECT count(*) FROM DELIVERY d "
						+ "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
						+ "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
						+ "WHERE o.ORD_CLIENT_NUM = ? "
						+ "AND d.DELIVERY_CREATE >= ? "
						+ "AND d.DELIVERY_CREATE <= ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, clientNum);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);
				
			} else {	//조회기능을 사용한 경우
				String sql="SELECT count(*) FROM DELIVERY d "
						+ "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
						+ "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
						+ "WHERE o.ORD_CLIENT_NUM = ? "
						+ "AND " + search + " LIKE '%' || ? || '%' "
						+ "AND d.DELIVERY_CREATE >= ? "
						+ "AND d.DELIVERY_CREATE <= ?";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, clientNum);
				pstmt.setString(1, keyword);
				pstmt.setString(3, startDate);
				pstmt.setString(4, endDate);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]countDeliveryListRecentPaging() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	/*datepicker 로 설정한 기간의 배송내역을 조회하는 DAO*/
	public List<DeliveryDTO> getDeliveriesByDateRangePaging(String startDate, String endDate, int clientNum, int startRow, int endRow, String search, String keyword) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<DeliveryDTO> deliveryList = new ArrayList<DeliveryDTO>();
	    
	    try {
	        con = getConnection();
	        
	        String sql = "SELECT * FROM ( select rownum rn, temp. * from ("
	        		+ "SELECT o.ORD_NUM, d.DELIVERY_CREATE, o.ORD_STATUS, o.ORD_COUNT, o.PAY_SUM, o.ORD_CLIENT_NUM, p.PRODUCT_NAME "
	                + "FROM DELIVERY d "
	                + "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
	                + "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
	                + "WHERE o.ORD_CLIENT_NUM = ? "
	                + "AND d.DELIVERY_CREATE >= ? AND d.DELIVERY_CREATE <= ? "  
	                + "ORDER BY d.DELIVERY_CREATE DESC ) temp ) "
	                + "WHERE rn BETWEEN ? AND ?";
	        
	        pstmt = con.prepareStatement(sql);
	        
	        // 사용자가 입력한 시작 날짜에서 하루 전 날짜로 설정
	        LocalDate startLocalDate = LocalDate.parse(startDate);
	        LocalDate adjustedStartDate = startLocalDate.minusDays(1); // 실제 조회 시 하루 전
	        
	        // 사용자가 입력한 종료 날짜에서 하루 후 날짜로 설정
	        LocalDate endLocalDate = LocalDate.parse(endDate);
	        LocalDate nextDay = endLocalDate.plusDays(1); // 실제 조회 시 하루 후
	        
	        pstmt.setInt(1, clientNum); // 첫 번째 매개변수에 clientNum 설정
	        pstmt.setString(2, adjustedStartDate.toString()); // 두 번째 매개변수에 하루 전 날짜 설정
	        pstmt.setString(3, nextDay.toString()); // 세 번째 매개변수에 하루 후 날짜 설정
	        pstmt.setInt(4, startRow);
	        pstmt.setInt(5, endRow);
	        
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            DeliveryDTO delivery = new DeliveryDTO();
	    	    delivery.setOrderNum(rs.getInt("ORD_NUM"));
	    	    delivery.setDeliveryCreate(rs.getDate("DELIVERY_CREATE"));
	    	    delivery.setOrdStatus(rs.getInt("ORD_STATUS"));
	    	    delivery.setOrdCount(rs.getString("ORD_COUNT"));
	    	    delivery.setPaySum(rs.getInt("PAY_SUM"));
	    	    delivery.setProductName(rs.getString("PRODUCT_NAME"));
	    	    deliveryList.add(delivery); 
	        }
	        
	    } catch (SQLException e) {
	        System.out.println("[에러] getDeliveriesByDateRange() 메소드의 SQL 오류 " + e.getMessage());
	    } finally {
	        close(con, pstmt, rs);
	    }
	    
	    return deliveryList;
	}
	
	//조회정보(조회대상과 조회단어)를 전달받아 DELIVERY 테이블에 저장된 행에서 조회정보가 포함된 
	//행의 갯수를 검색하여 반환하는 메소드
	// => 조회기능을 사용하지 않을 경우 REVIEW 테이블에 저장된 모든 행의 갯수를 검색하여 반환
	public int countDeliveryList(String search, String keyword, int clientNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			//매개변수에 저장된 값을 비교하여 DBMS 서버에 다른 SQL 명령을 전달하여 실행
			// => 동적 SQL(Dynamic SQL)
			if(keyword.equals("")) {//조회기능을 사용하지 않을 경우
				String sql="SELECT count(*) FROM DELIVERY d "
						+ "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
						+ "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
						+ "WHERE o.ORD_CLIENT_NUM = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, clientNum);
			} else {	//조회기능을 사용한 경우
				String sql="SELECT count(*) FROM DELIVERY d "
						+ "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
						+ "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
						+ "WHERE o.ORD_CLIENT_NUM = ? "
						+ "AND " + search + " LIKE '%' || ? || '%'";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, clientNum);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]countDeliveryListByKeyword() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	public List<DeliveryDTO> getDeliveryListPaging(int startRow, int endRow, int clientNum, String search, String keyword) {
	       Connection con = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       List<DeliveryDTO> deliveryList = new ArrayList<>();

	       try {
	           con = getConnection();

	           String sql;
	           if (keyword.equals("")) {
	               sql = "SELECT * FROM ( select rownum rn, temp.* from ( "
	                       + "SELECT d.DELIVERY_NUM, d.ORDER_NUM, d.DELIVERY_CREATE, o.ORD_STATUS, "
	                       + "o.ORD_COUNT, o.PAY_SUM, o.ORD_CLIENT_NUM, p.PRODUCT_NAME "
	                       + "FROM DELIVERY d "
	                       + "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
	                       + "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
	                       + "WHERE o.ORD_CLIENT_NUM = ? "
	                       + "ORDER BY d.ORDER_NUM DESC ) temp ) "
	                       + "WHERE rn BETWEEN ? AND ?";
	               pstmt = con.prepareStatement(sql);
	               pstmt.setInt(1, clientNum);
	               pstmt.setInt(2, startRow);
	               pstmt.setInt(3, endRow);
	           } else {
	               sql = "SELECT * FROM ( select rownum rn, temp.* from ( "
	                       + "SELECT d.DELIVERY_NUM, d.ORDER_NUM, d.DELIVERY_CREATE, o.ORD_STATUS, "
	                       + "o.ORD_COUNT, o.PAY_SUM, o.ORD_CLIENT_NUM, p.PRODUCT_NAME "
	                       + "FROM DELIVERY d "
	                       + "JOIN ORD o ON d.ORDER_NUM = o.ORD_NUM "
	                       + "JOIN PRODUCT p ON o.ORD_PRODUCT_NUM = p.PRODUCT_NUM "
	                       + "WHERE o.ORD_CLIENT_NUM = ? "
	                       + "AND " + search + " LIKE '%' || ? || '%' "
	                       + "ORDER BY d.ORDER_NUM DESC ) temp ) "
	                       + "WHERE rn BETWEEN ? AND ?";
	               pstmt = con.prepareStatement(sql);
	               pstmt.setInt(1, clientNum);
	               pstmt.setString(2, keyword);
	               pstmt.setInt(3, startRow);
	               pstmt.setInt(4, endRow);
	           }

	           rs = pstmt.executeQuery();

	           while (rs.next()) {
	               DeliveryDTO delivery = new DeliveryDTO();
	               delivery.setOrderNum(rs.getInt("ORDER_NUM")); // 수정: ORDER_NUM으로 변경
	               delivery.setDeliveryCreate(rs.getDate("DELIVERY_CREATE"));
	               delivery.setOrdStatus(rs.getInt("ORD_STATUS"));
	               delivery.setOrdCount(rs.getString("ORD_COUNT"));
	               delivery.setPaySum(rs.getInt("PAY_SUM"));
	               delivery.setProductName(rs.getString("PRODUCT_NAME"));
	               deliveryList.add(delivery);
	           }
	       } catch (SQLException e) {
	           System.out.println("[에러] getDeliveryListPaging() 메소드의 SQL 오류 = " + e.getMessage());
	           e.printStackTrace(); // 오류 스택 트레이스 출력
	       } finally {
	           close(con, pstmt, rs);
	       }
	      return deliveryList;
	   }
	
	
	public int updateDate(int order_num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "update delivery set delivery_update=sysdate where order_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order_num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateDate() 메서드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

}






















