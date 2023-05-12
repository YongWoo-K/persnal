<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String cpage = request.getParameter("cpage");

//현재 세션상태를 체크한다.
String userID1 = null;
//세션의 userID값이 null이 아니라면 = 이미 로그인을 했다면
if(session.getAttribute("userID") != null){
	//userID를 세션의 userID값으로 설정
	userID1 = (String)session.getAttribute("userID");
}
//로그인 하지 않은 경우 로그인 하도록 유도
if(userID1 == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('먼저 로그인 해주세요.')");
	script.println("location.href='P_login.jsp'");
	script.println("</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="js/list.js"></script>
<title>Board Write</title>
</head>
<body>
<%@include file="include/header.jsp"%>

<div class="container">
   <div class="row">
      <div class="col-12">
      
      <ul class="breadcrumb my-3">
      	<li class="breadcrumb-item">HOME &gt;</li>
      	<li class="breadcrumb-item">게시판 &gt;</li>
      	<li class="breadcrumb-item active">쓰기 &gt;</li>
      </ul>
      
      <form action="P_board_write_ok.jsp" method="post" name="wfrm" enctype="multipart/form-data">
      	<input type="hidden" name="cpage" value="<%=cpage%>"/>
      	
      	<table class="table">
      		<tr>
      			<th>작성자</th>
      			<td><input type="text" name="writer" class="form-control" maxlength="5" placeholder="이름을 입력해주세요."></td>
      		</tr>
      		<tr>
      			<th>제목</th>
      			<td><input type="text" name="subject" class="form-control" maxlength="100" placeholder="제목을 입력해주세요."></td>
      		</tr>
      		<tr>
      			<th>비밀번호</th>
      			<td><input type="password" name="password" class="form-control" maxlength="16" placeholder="비밀번호를 입력해주세요."></td>
      		</tr>
      		<tr>
      			<th>내용</th>
      			<td><textarea name="content" class="form-control" maxlength="2048" placeholder="내용을 입력해주세요." rows="6"></textarea></td>
      		</tr>
      		<tr>
      			<th>이메일</th>
      			<td>
      				<div class="input-group">
      					<input type="text" name="mail1" class="form-control" maxlength="16"/>
      					&nbsp;@&nbsp;
      					<input type="text" name="mail2" class="form-control"/>
      				</div>
      			</td>
      		</tr>
      		<tr>
      			<th>첨부파일</th>
      			<td>
      				<input type="file" name="upload" class="form-control" maxlength="16" value="파일첨부">
      			</td>
      		</tr>
      	</table>
      	
      	<table class="table">
      		<tr>
      			<h3>개인정보 수집 및 이용에 관한 안내</h3>
<pre class="py-3">
1. 개인정보 수집 항목 : 
2. 개인정보 수집 및 이용목적 : 
3. 개인정보의 이용기간 : 
4. 그 밖의 사항은 개인정보 취급방침을 준수합니다.		
</pre>
<div class="py-3">
	<input type="checkbox" name="info" value="1">&nbsp;개인정보 수집 및 이용에 대해 동의합니다.
</div>
      		</tr>
      	</table>
      	
      	<div class="d-flex justify-content-end">
      		<div class="btn-group">
      			<input 
      			type="button" 
      			class="btn btn-primary" 
      			value="목록" 
      			onclick="location.href='P_board_list.jsp?cpage=<%=cpage%>'"/>
      			
      			<input 
      			type="submit" 
      			class="btn btn-success" 
      			value="쓰기" 
      			id="submit1"/>
      		</div>
      	</div>
      	
      </form>
      
      </div>
   </div>
</div>

<%@include file="include/footer.jsp"%>
</body>
</html>