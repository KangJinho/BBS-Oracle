package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import vo.Bbn;

public class bbnDAO {
	private Connection conn;
	private ResultSet rs;

	public bbnDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbId = "hr";
			String dbPassword = "1234";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbId, dbPassword);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public String getDate() {
		String SQL = "SELECT SYSDATE FROM bbn";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return " ";
	}

	public int getNext() {
		String SQL = "SELECT bbnId FROM bbn ORDER BY bbnId DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("이상2");
		}
		return -1;
	}

	public int write(String bbnTitle, String userId, String bbnContent) {
		String SQL = "INSERT INTO BBN VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbnTitle);
			pstmt.setString(3, userId);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbnContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Bbn> getList(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT *FROM BBN WHERE BBNID <? AND BBNAVAILABLE=1 ORDER BY BBNID DESC)WHERE ROWNUM <= 10";
		ArrayList<Bbn> list = new ArrayList<Bbn>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbn bbn = new Bbn();
				bbn.setBbnId(rs.getInt(1));
				bbn.setBbnTitle(rs.getString(2));
				bbn.setUserId(rs.getString(3));
				bbn.setBbnDate(rs.getTimestamp(4));
				bbn.setBbnContent(rs.getString(5));
				bbn.setBbnAvailable(rs.getInt(6));
				list.add(bbn);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;

	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT *FROM BBN WHERE BBNID <? AND BBNAVAILABLE=1 ORDER BY BBNID DESC)WHERE ROWNUM <= 10";
		ArrayList<Bbn> list = new ArrayList<Bbn>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;

	}
	
	public Bbn getBbn(int bbsId) {
		String SQL = "SELECT * FROM BBN WHERE BBNID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbn bbn = new Bbn();
				bbn.setBbnId(rs.getInt(1));
				bbn.setBbnTitle(rs.getString(2));
				bbn.setUserId(rs.getString(3));
				bbn.setBbnDate(rs.getTimestamp(4));
				bbn.setBbnContent(rs.getString(5));
				bbn.setBbnAvailable(rs.getInt(6));
				return bbn;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbnId, String bbnTitle, String bbnContent) {
		String SQL = "UPDATE BBN SET bbnTitle=?, bbnContent=? WHERE bbnId=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbnTitle);
			pstmt.setString(2, bbnContent);
			pstmt.setInt(3, bbnId);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbnId) {
		String SQL = "UPDATE BBN SET bbnAvailable = 0 WHERE bbnId=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,bbnId);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
}
