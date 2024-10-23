package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.DeliveryDTO;
import xyz.itwill.dto.OptionDTO;

public class OptionDAO extends JdbcDAO {
	private static OptionDAO _dao;
	public OptionDAO() {
		// TODO Auto-generated constructor stub
	}
	static {
		_dao=new OptionDAO();
	}
	public static OptionDAO getDAO() {
		return _dao;
	}
	
	public List<OptionDTO> selectOption(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OptionDTO> optionList=new ArrayList<OptionDTO>();
		try {
			con=getConnection();
			String sql="select product_opt from opt where product_num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				OptionDTO option=new OptionDTO();
				option.setOption(rs.getString("product_opt"));
				
				optionList.add(option);
			}
			
		}catch (SQLException e) {
			System.out.println("[에러]selectOption() 메소드 오류 ="+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		return optionList;
		
	}
	
	public void insertOption(OptionDTO option) {
		Connection con = null;
	    PreparedStatement pstmt = null;
	    try {
	    	con = getConnection();
	    	String sql = "INSERT INTO opt (product_num, product_opt) "
	    			+ "VALUES(?, ?)";
	                
	    	pstmt = con.prepareStatement(sql);
	    	pstmt.setInt(1, option.getProductNum());	
	    	pstmt.setString(2, option.getOption());	
	    	pstmt.executeUpdate();
	    } catch (SQLException e) {
	    	System.out.println("[에러]insertOption() 메소드의 SQL 오류 = " + e.getMessage());
	    } finally {
			close(con, pstmt);
		}
	}
	
}
