<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.P_UserDAO"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.P_User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<%
//현재 세션상태를 체크한다.
String userID = null;
//세션의 userID값이 null이 아니라면 = 이미 로그인을 했다면
if(session.getAttribute("userID") != null){
	//userID를 세션의 userID값으로 설정
	userID = (String)session.getAttribute("userID");
}

//DB 테이블에 들어가는 DB 중 하나라도 누락될 경우
if(
user.getUserID() == null ||
user.getUserPassword() == null ||
user.getUserName() == null ||
user.getUserGender() == null ||
user.getUserEmail() == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력하지 않은 내용이 존재합니다. 다시 입력해주세요.')");
	script.println("history.back()");
	script.println("</script>");
}
else{
	P_UserDAO userDAO = new P_UserDAO();
	int result = userDAO.mypage(user);
	
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다. 다른 아이디를 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('내 정보 수정 성공!')");
		script.println("location.href='P_main.jsp'");
		script.println("</script>");
	}
}

%>