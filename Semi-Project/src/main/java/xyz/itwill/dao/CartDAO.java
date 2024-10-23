package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import xyz.itwill.dto.CartDTO;

public class CartDAO extends JdbcDAO {
    private static CartDAO _dao;

    static {
        _dao = new CartDAO();
    }

    public static CartDAO getCartDAO() {
        return _dao;
    }

    public List<CartDTO> selectCartClient(int ClientNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null; 
        List<CartDTO> cartList = new ArrayList<CartDTO>();

        try {
            con = getConnection();
            String sql = "SELECT cart_num, cart_client_num, cart_product_num, cart_count,cart_opt FROM cart where cart_client_num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, ClientNum);
            
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CartDTO cart = new CartDTO();
                cart.setCartNum(rs.getInt("cart_num"));
                cart.setCartClientNum(rs.getInt("cart_client_num"));
                cart.setCartProductNum(rs.getInt("cart_product_num"));
                cart.setCartCount(rs.getInt("cart_count"));
                cart.setCartOpt(rs.getString("cart_opt"));
                cartList.add(cart); 
            }
        } catch (SQLException e) {
            System.out.println("[에러] selectCartClient() 메서드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        } 
        return cartList;
    }
 
    public int insertCart(CartDTO cart) {
      Connection con=null;
      PreparedStatement pstmt=null;
      int rows=0;
      try {
         con=getConnection();
         
         String sql="insert into cart values(cart_seq.nextval,?,?,?,?)";
         pstmt=con.prepareStatement(sql);
         pstmt.setInt(1, cart.getCartClientNum());
         pstmt.setInt(2, cart.getCartProductNum());
         pstmt.setInt(3, cart.getCartCount());
         pstmt.setString(4, cart.getCartOpt());
         
         rows=pstmt.executeUpdate();
      }catch (SQLException e) {
         System.out.println("[에러]insertCart()메소드 에러"+e.getMessage());
      }finally {
         close(con, pstmt);
      }
      return rows;
   }
    
    //test
    public int insertCartSeq(CartDTO cart) {
      Connection con=null;
      PreparedStatement pstmt=null;
      int rows=0;
      try {
         con=getConnection();
         
         String sql="insert into cart values(?,?,?,?,?)";
         pstmt=con.prepareStatement(sql);
         pstmt.setInt(1, cart.getCartNum());
         pstmt.setInt(2, cart.getCartClientNum());
         pstmt.setInt(3, cart.getCartProductNum());
         pstmt.setInt(4, cart.getCartCount());
         pstmt.setString(5, cart.getCartOpt());
         
         rows=pstmt.executeUpdate();
      }catch (SQLException e) {
         System.out.println("[에러]insertCart()메소드 에러"+e.getMessage());
      }finally {
         close(con, pstmt);
      }
      return rows;
   }
    
    public CartDTO selectCart(int cartNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CartDTO cart = null;

        try {
            con = getConnection();
            String sql = "SELECT * FROM cart WHERE cart_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, cartNum);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                cart = new CartDTO();
                cart.setCartNum(rs.getInt("cart_num"));
                cart.setCartClientNum(rs.getInt("cart_client_num"));
                cart.setCartProductNum(rs.getInt("cart_product_num"));
                cart.setCartCount(rs.getInt("cart_count"));
                cart.setCartOpt(rs.getString("cart_opt"));
            }
        } catch (SQLException e) {
            System.out.println("[에러] selectCart() 메서드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
        return cart;
    }

    //새로운 수량 받아와서 업데이트
   public void updateCartQuantity(int cartNum, int newQuantity) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = getConnection();
            String sql = "UPDATE cart SET cart_count = ? WHERE cart_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, newQuantity); // 수량을 설정합니다
            pstmt.setInt(2, cartNum); // 장바구니 항목 번호를 설정합니다
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("[에러] updateCartQuantity() 메서드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt);
        }
       
   }
   
   public int deleteCart(int cartNum) {
       Connection con = null;
       PreparedStatement pstmt = null;
       int rows = 0;
       try {
           con = getConnection();
           String sql = "DELETE FROM cart WHERE cart_num = ?";
           pstmt = con.prepareStatement(sql);
           pstmt.setInt(1, cartNum);
           rows = pstmt.executeUpdate();
       } catch (SQLException e) {
           System.out.println("[에러] deleteCart() 메서드의 SQL 오류 = " + e.getMessage());
       } finally {
           close(con, pstmt);
       }
       return rows;
   }
   public void clearCartClient(int clientNum) {
       Connection con = null;
       PreparedStatement pstmt = null;

       try {
           con = getConnection();
           String sql = "DELETE FROM cart WHERE cart_client_num = ?";
           pstmt = con.prepareStatement(sql);
           pstmt.setInt(1, clientNum);
           pstmt.executeUpdate();
       } catch (SQLException e) {
           System.out.println("[에러] clearCartClient() 메서드의 SQL 오류 = " + e.getMessage());
       } finally {
           close(con, pstmt);
       }
   }
   
   public int selectCartNextNum() {
      Connection con=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      int nextNum=0;
      try {
         con=getConnection();
         
         String sql="select cart_seq.nextval from dual";
         pstmt=con.prepareStatement(sql);
         
         rs=pstmt.executeQuery();
         
         if(rs.next()) {
            nextNum=rs.getInt(1);
         }
      } catch (SQLException e) {
         System.out.println("[에러]selectCartNextNum() 메소드의 SQL 오류 = "+e.getMessage());
      } finally {
         close(con, pstmt, rs);
      }
      return nextNum;
   }
   
   
   
}
    

