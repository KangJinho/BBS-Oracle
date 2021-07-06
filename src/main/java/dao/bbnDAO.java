package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Bbn;

public class bbnDAO {
	private Connection conn;
	private ResultSet rs;
	public PreparedStatement pstmt;

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
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("이상3");
		}
		return "";
	}

	public int getNext() {
		String SQL = "SELECT bbnId FROM bbn ORDER BY bbnId DESC";
		try {
			pstmt = conn.prepareStatement(SQL);
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
		String SQL = "INSERT INTO bbn VALUES(?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
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
		System.out.println("이상1");
		return -1;
	}

	public ArrayList<Bbn> getList(int pageNumber){
		String SQL= "SELECT * FROM bbn WHERE bbsId <? AND bbsAvailable =1 order by bbsID DESC LIMIT 10";
		ArrayList<Bbn> list=new ArrayList<Bbn>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbn bbn = new Bbn();
				bbn.setBbnId(rs.getInt(1));
				bbn.setBbnTitle(rs.getString(2));
				bbn.setUserId(rs.getString(3));
				bbn.setBbnDate(rs.getTimestamp(4));
				bbn.setBbnContent(rs.getString(5));
				bbn.setBbnAvailable(rs.getInt(6));
				
			}
		} catch (Exception e) {
			// TODO: handle exception
		e.printStackTrace();	
		}
		return list;
		
	}
}
