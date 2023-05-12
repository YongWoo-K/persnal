<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model1.P_BoardTO"%>
<%@ page import="model1.P_BoardDAO"%>
<%
request.setCharacterEncoding("UTF-8");
 
String cpage = request.getParameter("cpage");
String seq = request.getParameter("seq");
String password = request.getParameter("password");

P_BoardTO to = new P_BoardTO();
P_BoardDAO dao = new P_BoardDAO();

to.setSeq(seq);
to.setPassword(password);

int flag = dao.boardDeleteOK(to);

out.println("<script>");
if(flag == 0){
	out.println("alert('글 삭제에 성공했습니다.');");
	out.println("location.href='P_board_list.jsp'");
}
else if(flag == 1){
	out.println("alert('비밀번호가 틀립니다. 다시 입력해주세요.');");
	out.println("history.back();");
}
else{
	out.println("alert('글 삭제에 실패했습니다.');");
	out.println("history.back();");
}
out.println("</script>");

%>