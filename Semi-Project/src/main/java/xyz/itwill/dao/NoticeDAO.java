package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.NoticeDTO;

public class NoticeDAO extends JdbcDAO{
	private static NoticeDAO _dao;
	
	public NoticeDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new NoticeDAO();
	}
	
	public static NoticeDAO getDAO() {
		return _dao;
	}
	
	//조회정보(조회대상과 조회단어)를 전달받아 NOTICE 테이블에 저장된 행에서 조회정보가 포함된 
	//행의 갯수를 검색하여 반환하는 메소드
	// => 조회기능을 사용하지 않을 경우 REVIEW 테이블에 저장된 모든 행의 갯수를 검색하여 반환	
	//페이징 처리할 때 필요한 기능
	public int selectTotalNotice(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			//매개변수에 저장된 값을 비교하여 DBMS 서버에 다른 SQL 명령을 전달하여 실행
			// => 동적 SQL(Dynamic SQL)
			if(keyword.equals("")) {//조회기능을 사용하지 않을 경우
				String sql="select count(*) from notice";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from notice join client on notice_client_num=client_num"
						+ " where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalNotice() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	// 삭제 행 제외
	public int selectTotalNoticeND(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();

			if(keyword.equals("")) {//조회기능을 사용하지 않을 경우
				String sql="select count(*) from notice where notice_status != 0";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from notice join client on notice_client_num=client_num"
						+ " where "+search+" like '%'||?||'%' and notice_status != 0";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalNotice() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//페이징 관련 정보(시작행번호, 종료행번호)와 게시글 조회기능 관련 정보(조회대상과 조회단어)를
	//전달받아 NOTICE 테이블에 저장된 행에서 조회정보가 포함된 행을 페이징 처리로 검색하여
	//검색된 게시글 목록(List 객체)을 반환하는 메소드
	public List<NoticeDTO> selectNoticeList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<NoticeDTO> noticeList=new ArrayList<NoticeDTO>();
		try {
			con=getConnection();
			
			if(keyword.equals("")) {
				String sql="select * from (select rownum rn, temp.* from (select notice_num,notice_title"
						+ ",notice_image,notice_date,notice_update,notice_count,notice_client_num,notice_status"
						+ " from notice join client on notice_client_num=client_num order by notice_num desc)"
						+ "temp) where rn between ? and ? order by notice_status desc, notice_num desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn, temp.* from (select notice_num,notice_title"
					+ ",notice_image,notice_date,notice_update,notice_count,notice_client_num,notice_status"
					+ " from notice join client on notice_client_num=client_num where "+search+" like '%'||?||'%'"
					+ " order by notice_num desc) temp) where rn between ? and ? order by notice_status desc, notice_num desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO notice=new NoticeDTO();
				notice.setNoticeNum(rs.getInt("notice_num"));
				notice.setNoticeTitle(rs.getString("notice_title"));
				notice.setNoticeImage(rs.getString("notice_image"));
				notice.setNoticeDate(rs.getString("notice_date"));
				notice.setNoticeUpdate(rs.getString("notice_update"));
				notice.setNoticeCount(rs.getInt("notice_count"));
				notice.setNoticeClientNum(rs.getInt("notice_client_num"));
				notice.setNoticeStatus(rs.getInt("notice_status"));
								
				noticeList.add(notice);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return noticeList;
	}
	
	//삭제 글 제외
	public List<NoticeDTO> selectNoticeListND(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<NoticeDTO> noticeList=new ArrayList<NoticeDTO>();
		try {
			con=getConnection();
			
			if(keyword.equals("")) {
				String sql="select * from (select rownum rn, temp.* from (select notice_num,notice_title"
						+ ",notice_image,notice_date,notice_update,notice_count,notice_client_num,notice_status"
						+ " from notice join client on notice_client_num=client_num where notice_status != 0 order by notice_num desc)"
						+ "temp) where rn between ? and ? order by notice_status desc, notice_num desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn, temp.* from (select notice_num,notice_title"
					+ ",notice_image,notice_date,notice_update,notice_count,notice_client_num,notice_status"
					+ " from notice join client on notice_client_num=client_num where "+search+" like '%'||?||'%' and notice_status != 0"
					+ " order by notice_num desc) temp) where rn between ? and ? order by notice_status desc, notice_num desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO notice=new NoticeDTO();
				notice.setNoticeNum(rs.getInt("notice_num"));
				notice.setNoticeTitle(rs.getString("notice_title"));
				notice.setNoticeImage(rs.getString("notice_image"));
				notice.setNoticeDate(rs.getString("notice_date"));
				notice.setNoticeUpdate(rs.getString("notice_update"));
				notice.setNoticeCount(rs.getInt("notice_count"));
				notice.setNoticeClientNum(rs.getInt("notice_client_num"));
				notice.setNoticeStatus(rs.getInt("notice_status"));
								
				noticeList.add(notice);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return noticeList;
	}
	
	//공지글(NoticeDTO 객체)을 전달받아 NOTICE 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into notice values(?,?,?,sysdate,null,0,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, notice.getNoticeNum());
			pstmt.setString(2, notice.getNoticeTitle());
			pstmt.setString(3, notice.getNoticeImage());
			pstmt.setInt(4, notice.getNoticeClientNum());
			pstmt.setInt(5, notice.getNoticeStatus());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertNotice() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int selectNoticeNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select notice_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	public NoticeDTO selectNoticeByNum(int noticeNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		NoticeDTO notice=null;
		try {
			con=getConnection();
			
			String sql="select notice_num,notice_title,notice_image,notice_date,notice_count"
					+ ",notice_status from notice where notice_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, noticeNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				notice=new NoticeDTO();
				notice.setNoticeNum(rs.getInt("notice_num"));
				notice.setNoticeTitle(rs.getString("notice_title"));
				notice.setNoticeImage(rs.getString("notice_image"));
				notice.setNoticeDate(rs.getString("notice_date"));
				notice.setNoticeCount(rs.getInt("notice_count"));
				notice.setNoticeStatus(rs.getInt("notice_status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		} 
		return notice;
	}
	
	public int updateNoticeCount(int noticeNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update notice set notice_count=notice_count+1 where notice_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, noticeNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateNoticeCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int updateNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update notice set notice_title=?, notice_image=?, notice_status=?,"
					+"notice_update=sysdate where notice_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getNoticeImage());
			pstmt.setInt(3, notice.getNoticeStatus());
			pstmt.setInt(4, notice.getNoticeNum());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateNotice() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public List<NoticeDTO> selectNoticeTopList(int noticeStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<NoticeDTO> noticeList=new ArrayList<NoticeDTO>();
		try {
			con=getConnection();
			
			String sql="select * from notice where notice_status=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, noticeStatus);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO notice=new NoticeDTO();
				notice.setNoticeNum(rs.getInt("notice_num"));
				notice.setNoticeTitle(rs.getString("notice_title"));
				notice.setNoticeImage(rs.getString("notice_image"));
				notice.setNoticeDate(rs.getString("notice_date"));
				notice.setNoticeUpdate(rs.getString("notice_update"));
				notice.setNoticeCount(rs.getInt("notice_count"));
				notice.setNoticeClientNum(rs.getInt("notice_client_num"));
				notice.setNoticeStatus(rs.getInt("notice_status"));
								
				noticeList.add(notice);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeTopList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return noticeList;
	}
}






























