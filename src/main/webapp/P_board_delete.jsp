<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model1.P_BoardTO"%>
<%@ page import="model1.P_BoardDAO"%>
<%
request.setCharacterEncoding("UTF-8");
 
//현재 세션상태를 체크한다.
String user_ID = null;
//세션의 userID값이 null이 아니라면 = 이미 로그인을 했다면
if(session.getAttribute("userID") != null){
	//userID를 세션의 userID값으로 설정
	user_ID = (String)session.getAttribute("userID");
}
//로그인 하지 않은 경우 로그인 하도록 유도
if(user_ID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('먼저 로그인 해주세요.')");
	script.println("location.href='P_login.jsp'");
	script.println("</script>");
}

String cpage = request.getParameter("cpage");
String seq = request.getParameter("seq");

String subject = "";
String writer = "";

P_BoardTO to = new P_BoardTO();
P_BoardDAO dao = new P_BoardDAO();

to.setSeq(seq);
to.setSubject(subject);
to.setWriter(writer);
to = dao.boardDelete(to);

subject = to.getSubject();
writer = to.getWriter();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="js/delete.js"></script>
<title>Board Delete</title>
</head>
<body>
<%@include file="include/header.jsp"%>

<div class="container">
   <div class="row">
      <div class="col-12">
      
      	<ul class="breadcrumb my-3">
	      	<li class="breadcrumb-item"><img src="img/home.svg" alt="홈아이콘"/> &gt;</li>
	      	<li class="breadcrumb-item">게시판 &gt;</li>
	      	<li class="breadcrumb-item active">Delete</li>
      	</ul>
      	
      	<form action="P_board_delete_ok.jsp" method="post" name="dfrm">
      		<input type="hidden" name="seq" value="<%=seq%>">
      		
      		<table class="table">
      			<tr>
      				<th>작성자</th>
      				<td>
      					<input type="text" name="writer" value="<%=writer%>" class="form-control">
      				</td>
      			</tr>
      			<tr>
      				<th>제목</th>
      				<td>
      					<input type="text" name="subject" value="<%=subject%>" class="form-control">
      				</td>
      			</tr>
      			<tr>
      			    <th>비밀번호</th>
      				<td>
      					<input type="password" name="password" value="" class="form-control">
      				</td>
      			</tr>
      		</table>
      		
      		<div class="btn-group">
      			<input type="button" value="목록" class="btn btn-primary" onclick="location.href='P_board_list.jsp?cpage=<%=cpage%>'"/>
      			<input type="button" value="글 확인" class="btn btn-success" onclick="location.href='P_board_view.jsp?cpage=<%=cpage%>&seq=<%=seq%>'"/>
      			<input type="submit" id="submit1" value="삭제" class="btn btn-danger"/>
      		</div>	
      	</form>
      
      </div>
   </div>
</div>

<%@include file="include/footer.jsp"%>
</body>
</html>