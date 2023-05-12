<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.P_UserDAO" %>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.P_User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<%
//현재 세션 상태를 체크한다.
String userID = null;
//세션의 userID값이 null이 아니라면 = 이미 로그인을 했다면
if(session.getAttribute("userID") != null){
	//userID를 세션의 userID값으로 설정
	userID = (String)session.getAttribute("userID");
}
//이미 로그인을 한 경우 다시 로그인을 할 수 없게 한다.
if(userID != null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인 되어있습니다.')");
	script.println("location.href='P_main.jsp'");
	script.println("</script>");
}


P_UserDAO userDAO = new P_UserDAO(); //UserDAO클래스의 인스턴스 userDAO 생성
int result = userDAO.login(user.getUserID(), user.getUserPassword());
//-> int타입 변수 result에 userDAO인스턴스 클래스의 login()메소드 실행결과를 저장

if(result == 1){
	//로그인을 성공하면 세션을 부여
	session.setAttribute("userID", user.getUserID());
	
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인 성공')");
	script.println("location.href='P_main.jsp'");
	script.println("</script>");
}
else if(result == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('비밀번호가 틀립니다.')");
	script.println("history.back()");
	script.println("</script>");
}
else if(result == -1){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('존재하지 않는 아이디입니다.')");
	script.println("history.back()");
	script.println("</script>");
}
else if(result == -2){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('데이터베이스 오류입니다.')");
	script.println("history.back()");
	script.println("</script>");
}
%>