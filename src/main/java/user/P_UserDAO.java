package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class P_UserDAO {
	private Connection conn; //자바와 데이터베이스를 연결
	private PreparedStatement pstmt; //쿼리문 대기 및 설정
	private ResultSet rs; //결과값 받아오기
	
	//기본생성자
	public P_UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/PET?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "12345678!";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//로그인 메소드
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user1 where userID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID); 
			rs = pstmt.executeQuery(); 

			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)){
					return 1; //로그인 성공
				}else {
					return 0; //비밀번호가 틀림
				}		
			}
			return -1; //아이디 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	//회원가입 메소드
	public int join(P_User user) {
		String sql = "insert into user1 values(?,?,?,?,?)"; 
		try {
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword()); 
			pstmt.setString(3, user.getUserName()); 
			pstmt.setString(4, user.getUserGender()); 
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //-> primary key인 아이디의 중복오류발생
	}	
	
/*
	//DB연동
	private DataSource dataSource;

	//기본생성자
	public P_UserDAO() {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			this.dataSource = (DataSource)envCtx.lookup("jdbc/mysql");	
		}catch(NamingException e) {
			System.out.println("[error] : " + e.getMessage()); 
		}
	}

	//로그인 메소드
	public int login(P_User user) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT userPassword FROM user1 WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID()); 
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(user.getUserPassword())){
					return 1; //로그인 성공
				}else {
					return 0; //비밀번호가 틀림
				}		
			}
			return -1; //아이디 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	//회원가입 메소드
	public int join(P_User user) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "INSERT INTO user1 VALUES(?,?,?,?,?)"; 
		try {
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, user.getUserID()); 
			pstmt.setString(2, user.getUserPassword()); 
			pstmt.setString(3, user.getUserName()); 
			pstmt.setString(4, user.getUserGender()); 
			pstmt.setString(5, user.getUserEmail()); 
			return pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //-> primary key인 아이디의 중복오류발생
	}
*/
}
