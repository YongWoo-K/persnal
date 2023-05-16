<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//현재 세션 상태를 체크
String userID = null;
//세션의 userID값이 null이 아니라면 = 이미 로그인을 했다면
if(session.getAttribute("userID") != null){
	//userID를 세션의 userID값으로 설정
	userID = (String)session.getAttribute("userID");
}

//pageNumber의 기본값을 1으로 설정
int pageNumber = 1;
/*
만약 파라미터로 넘어온 오브젝트타입'pageNumber'가 존재한다면 int타입으로 캐스팅해주고
그 값을 pageNumber변수에 저장한다.
*/
if(request.getParameter("pageNumber") != null){
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-success bg-opacity-50">

	<div class="container-fluid">
	
		<a class="navbar-brand active text-white" href="P_main.jsp">Pet</a>
		
		<%-- 토글버튼 --%>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
		
			 <ul class="navbar-nav me-auto">
			 	<li class="nav-item">
			 		<a class="nav-link text-white" href="P_main.jsp">Main</a>
			 	</li>
			 	
			 	<li class="nav-item">
			 		<a class="nav-link text-white" href="P_board_list.jsp">나의 애완동물</a>
			 	</li>
			 </ul>
			 <%
			 //로그인 하지않았을 경우 보여지는 화면
			 if(userID == null){
			 %>
			 <ul class="navbar-nav mr-auto">
			 
			 	<li class="nav-item dropdown">
			 	
			 		<a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">회원관리</a>
			 		<ul class="dropdown-menu">
			 			<li>
			 				<a class="dropdown-item" href="P_login.jsp">
			 				로그인
			 				</a>
			 			</li>
			 			
			 			<li>
			 				<a class="dropdown-item" href="P_join.jsp">
			 				회원가입
			 				</a>
			 			</li>
			 		</ul>
			 		
			 	</li>
			 	
			 </ul>
			 <%
			 //로그인이 되어있는 상태에서 보여지는 화면
			 } else{%>
			 <ul class="navbar-nav mr-auto">
			 	<p class="nav-item text-white mt-2" type="text"><%=userID%>님 환영합니다.</p>
			 	<li class="nav-item dropdown">
			 		<a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">회원관리</a>
			 		<ul class="dropdown-menu">
			 			<li>
			 				<a class="dropdown-item" href="P_myPage.jsp">
			 				내 정보 수정
			 				</a>
			 			</li>
			 			
			 			<li>
			 				<a class="dropdown-item" href="P_logoutAction.jsp">
			 				로그아웃
			 				</a>
			 			</li>
			 		</ul>
			 		
			 	</li>
			 	
			 </ul>
			 <%} %>
		</div>
		
	</div>
	
</nav>

</body>
</html>