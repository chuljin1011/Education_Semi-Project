package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.OrdDTO;

public class OrdDAO extends JdbcDAO {
    private static OrdDAO _dao;

    static {
        _dao = new OrdDAO();
    }

    public static OrdDAO getOrdDAO() {
        return _dao;
    }

    public void insertOrder(OrdDTO cartOrd) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = getConnection();
            String sql = "INSERT INTO ORD (ord_num, ord_client_num, ord_time, ord_date, ord_product_num, ord_status, ord_receiver, ord_zipcode, ord_address1, ord_address2, ord_mobile, ord_count, ord_email, cart_method, pay_sum) VALUES (ord_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, cartOrd.getOrdclientNum());
            pstmt.setString(2, cartOrd.getOrdTime());
            pstmt.setString(3, cartOrd.getOrdDate());
            pstmt.setInt(4, cartOrd.getOrdproductNum());
            pstmt.setInt(5, cartOrd.getOrdStatus());
            pstmt.setString(6, cartOrd.getOrdReceiver());
            pstmt.setString(7, cartOrd.getOrdZipcode());
            pstmt.setString(8, cartOrd.getOrdAddress1());
            pstmt.setString(9, cartOrd.getOrdAddress2());
            pstmt.setString(10, cartOrd.getOrdMobile());
            pstmt.setString(11, cartOrd.getOrdCount());
            pstmt.setString(12, cartOrd.getOrdEmail()); // 이 부분 추가
            pstmt.setInt(13, cartOrd.getOrdCartMethod());
            pstmt.setInt(14, cartOrd.getOrdPaySum());

            // 로그 추가
            System.out.println("Executing SQL: " + sql);

            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("[에러] insertOrder() 메서드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt);
        }
    }
    
    public int selectLatestOrdNum() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int latestOrdNum = -1; // 기본값으로 -1을 설정

        try {
            con = getConnection();
            String sql = "SELECT MAX(ORD_NUM) AS LATEST_ORD_NUM FROM ord";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                latestOrdNum = rs.getInt("LATEST_ORD_NUM");
            }

        } catch (SQLException e) {
            System.out.println("[에러] selectLatestOrdNumByClientNum() 메서드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }

        return latestOrdNum+1; // 최신 주문 번호 반환 +!
    }

    
    public List<OrdDTO> selectOrdListByClientNum(int clientNum) {
    	
    	Connection con = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	List<OrdDTO> ordList = new ArrayList<OrdDTO>();
    	
    	
    	try {
    		con = getConnection();
    		String sql = "SELECT * FROM ord WHERE ORD_CLIENT_NUM = ?";
    		pstmt = con.prepareStatement(sql);
    		pstmt.setInt(1, clientNum);
    		rs = pstmt.executeQuery();
    		
    		while(rs.next()) {
    			OrdDTO ord = new OrdDTO();
    			ord.setOrdNum(rs.getInt("ORD_NUM"));
    			ord.setOrdclientNum(rs.getInt("ORD_CLIENT_NUM"));
    			ord.setOrdTime(rs.getString("ORD_TIME"));
    			ord.setOrdDate(rs.getString("ORD_DATE"));
    			ord.setOrdproductNum(rs.getInt("ORD_PRODUCT_NUM"));
    			ord.setOrdStatus(rs.getInt("ORD_STATUS"));
    			ord.setOrdReceiver(rs.getString("ORD_RECEIVER"));
    			ord.setOrdZipcode(rs.getString("ORD_ZIPCODE"));
    			ord.setOrdAddress1(rs.getString("ORD_ADDRESS1"));
    			ord.setOrdAddress2(rs.getString("ORD_ADDRESS2"));
    			ord.setOrdMobile(rs.getString("ORD_MOBILE"));
    			ord.setOrdCount(rs.getString("ORD_COUNT"));
    			ord.setOrdEmail(rs.getString("ORD_EMAIL"));
    			ord.setOrdCartMethod(rs.getInt("CART_METHOD"));
    			ord.setOrdPaySum(rs.getInt("PAY_SUM"));
    			
    			ordList.add(ord);
    		}
    		
    		
    	} catch (SQLException e) {
    		System.out.println("[에러] selectOrdListByClientNum() 메서드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
    	
    	return ordList;
    	
    }
    
    public int updateStatus(int order_num, int delivery_status) {
    	
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "update ord set ord_status=? where ord_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, delivery_status);
			pstmt.setInt(2, order_num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus() 메서드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
    
}






























