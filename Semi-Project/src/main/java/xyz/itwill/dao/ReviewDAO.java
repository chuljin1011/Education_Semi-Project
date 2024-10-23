package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.ReviewDTO;

public class ReviewDAO extends JdbcDAO{
	private static ReviewDAO _dao;
	
	public ReviewDAO() {
		// TODO Auto-generated constructor stub
	}
	static {
		_dao=new ReviewDAO();
	}
	public static ReviewDAO getDAO() {
		return _dao;
	}
	public int insertReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			String sql="insert into review values (review_seq.nextval,?,?,?,?,sysdate,sysdate,0,null,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, review.getReviewClientNum());
			pstmt.setString(2, review.getReviewSubject());
			pstmt.setString(3, review.getReviewContent());
			pstmt.setString(4, review.getReviewImg());
			pstmt.setInt(5, review.getReviewProductNum()); 
			pstmt.setInt(6, review.getReviewOrderNum());
			pstmt.setInt(7, review.getReviewLevel());
			
			rows=pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println("[에러]insertReview() 메소드 에러"+e.getMessage());
		}finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public List<ReviewDTO> selectReviewAll(int num){
		Connection con =null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		List<ReviewDTO> reviewList =new ArrayList<ReviewDTO>();
		
		try {
			con=getConnection();
			
			String sql="select review_num, review_client, review_subject, review_content, review_image, review_register"
					+ ",review_update, review_readcount, review_replay, review_product_num, review_order_num"
					+ ",review_level,client_id,client_status from review join client on client.client_num=review.review_client where review_product_num=?" ;
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO review =new ReviewDTO();
				review.setReviewNum(rs.getInt("review_num"));
				review.setReviewClientNum(rs.getInt("review_client"));
				review.setReviewSubject(rs.getString("review_subject"));
				review.setReviewContent(rs.getString("review_content"));
				review.setReviewImg(rs.getString("review_image"));
				review.setReviewRegisterTime(rs.getString("review_register"));
				review.setReviewUpdateTime(rs.getString("review_update"));
				review.setReviewReadcount(rs.getInt("review_readcount"));
				review.setReviewReplay(rs.getString("review_replay"));
				review.setReviewProductNum(rs.getInt("review_product_num"));
				review.setReviewOrderNum(rs.getInt("review_order_num"));
				review.setReviewLevel(rs.getInt("review_level"));
				review.setClientId(rs.getString("client_id"));
				review.setClientStatus(rs.getInt("client_status"));
				
				reviewList.add(review);
				
			}
			
		}catch (SQLException e) {
			System.out.println("[에러]selectReviewAll 메소드 에러"+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}
	//수정시작
	public int countReviewList(String search, String keyword, int clientNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			//매개변수에 저장된 값을 비교하여 DBMS 서버에 다른 SQL 명령을 전달하여 실행
			// => 동적 SQL(Dynamic SQL)
			if(keyword.equals("")) {//조회기능을 사용하지 않을 경우
				String sql="SELECT count(*) FROM REVIEW "
						+ "WHERE review_client = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, clientNum);
			} else {	//조회기능을 사용한 경우
				String sql="SELECT count(*) FROM REVIEW "
						+ "WHERE review_client = ? "
						+ "AND " + search + " LIKE '%' || ? || '%'";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, clientNum);
				pstmt.setString(1, keyword);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]countReviewList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con,pstmt,rs);
		}
		return count;
	}
	
	public List<ReviewDTO> selectReviewAllbyNumPaging(int startRow, int endRow, int clientNum, String search, String keyword){
		Connection con =null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		List<ReviewDTO> reviewList =new ArrayList<ReviewDTO>();
		
		try {
			con=getConnection();
			
			String sql;
			if(keyword.equals("")) {
			    sql = "SELECT * FROM ( select rownum rn, temp.* from ( "
			            + "SELECT review_num, review_client, review_subject, review_content, review_image, review_register, "
			            + "review_update, review_readcount, review_replay, review_product_num, review_order_num, "
			            + "review_level FROM REVIEW "
			            + "WHERE review_client = ? "
			            + "ORDER BY review_register DESC ) temp ) "
			            + "WHERE rn BETWEEN ? AND ?";
			    pstmt = con.prepareStatement(sql);
			    pstmt.setInt(1, clientNum);
			    pstmt.setInt(2, startRow);
			    pstmt.setInt(3, endRow);
			} else {
			    sql = "SELECT * FROM ( select rownum rn, temp.* from ( "
			            + "SELECT review_num, review_client, review_subject, review_content, review_image, review_register, "
			            + "review_update, review_readcount, review_replay, review_product_num, review_order_num, "
			            + "review_level FROM REVIEW "
			            + "WHERE review_client = ? "
			            + "AND " + search + " LIKE '%' || ? || '%' "
			            + "ORDER BY review_register DESC ) temp ) "
			            + "WHERE rn BETWEEN ? AND ?";
			    pstmt = con.prepareStatement(sql);
			    pstmt.setInt(1, clientNum);
			    pstmt.setString(2, keyword);
			    pstmt.setInt(3, startRow);
			    pstmt.setInt(4, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO review =new ReviewDTO();
				review.setReviewNum(rs.getInt("review_num"));
				review.setReviewClientNum(rs.getInt("review_client"));
				review.setReviewSubject(rs.getString("review_subject"));
				review.setReviewContent(rs.getString("review_content"));
				review.setReviewImg(rs.getString("review_image"));
				review.setReviewRegisterTime(rs.getString("review_register"));
				review.setReviewUpdateTime(rs.getString("review_update"));
				review.setReviewReadcount(rs.getInt("review_readcount"));
				review.setReviewReplay(rs.getString("review_replay"));
				review.setReviewProductNum(rs.getInt("review_product_num"));
				review.setReviewOrderNum(rs.getInt("review_order_num"));
				review.setReviewLevel(rs.getInt("review_level"));
				
				reviewList.add(review);
				
			}
			
		}catch (SQLException e) {
			System.out.println("[에러]selectReviewAllbyNumPaging 메소드 에러"+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}
}
