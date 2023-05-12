<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model1.P_BoardTO"%>
<%@page import="model1.P_BoardDAO"%>
<%@page import="model1.P_BoardListTO"%>
<%
//내용이 있다면 cpage 구성
int cpage = 1;
if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")){
	cpage = Integer.parseInt(request.getParameter("cpage"));
}

P_BoardListTO listTO = new P_BoardListTO();
listTO.setCpage(cpage);

P_BoardDAO dao = new P_BoardDAO();
listTO = dao.boardList(listTO);

//페이징 설정
int recordPerpage = listTO.getRecordPerPage();
int totalRecord = listTO.getTotalRecord();
int totalPage = listTO.getTotalPage();
int blockPerPage = listTO.getBlockPerPage();
int blockRecord = listTO.getBlockRecord();
int startBlock = listTO.getStartBlock();
int endBlock = listTO.getEndBlock();

/*
StringBuffer => 문자열을 추가하거나 변경할 때 주로 사용하는 자료형이다.
	- 사용 예시
		: StringBuffer sb = new StringBuffer(); - 객체 sb생성
		  sb.append("hello")
		  sb.append("world")
		  String result = sb.toString()
*/
//컴포넌트 작성
StringBuffer sbHtml = new StringBuffer();
for(P_BoardTO to : listTO.getBoardLists()){
	blockRecord++;
	sbHtml.append("<td>");
		sbHtml.append("<div>");
			sbHtml.append("<table>");
			
				sbHtml.append("<tr>");
					sbHtml.append("<td>");
					
						sbHtml.append("<div class='card' style='width:250px'>");
							//사진이 올라가있는 썸네일 -> 클릭시 board_view.jsp로 이동
							sbHtml.append("<a href='P_board_view.jsp?cpage=" + cpage + "&seq=" + to.getSeq() + "'><img src='upload/" + to.getFilename() + "' class='card-img-top'/></a>");

							//텍스트 오버플로우 선언하는 곳
							sbHtml.append("<div class='card-body'>");
								sbHtml.append("<div class='card-title'>");
									//제목 가져오기
									sbHtml.append("<span class='badge bg-danger me-2'>new</span><strong>" + to.getSubject() + "</strong>");
							
									//제목이 너무 짧을 경우에 사용
									if(to.getWgap() == 0){
										sbHtml.append(" ~~ ");
									}
								sbHtml.append("</div>"); //card-title-end

					
								sbHtml.append("<div class='card-text'>");
									//글쓴이 가져오기
									sbHtml.append("<span class='mt-3 mb-3'>작성자 : " + to.getWriter() + "</span>");
									
									sbHtml.append("<br>");
									
									//hit 가져오기
									sbHtml.append("<div class='d-flex justify-content-end fs10 mt-3 mb-3'>" + to.getWdate() + "&nbsp;|&nbsp;Hit" + to.getHit() + "</div>");
			
								sbHtml.append("</div>"); //card-text-end
								
								sbHtml.append("<div class='d-flex justify-content-end'>");
									//more클릭 시 board_view.jsp로 이동
									sbHtml.append("<a href='P_board_view.jsp?cpage=" + cpage + "&seq=" + to.getSeq() + "'>more</a>");	
								sbHtml.append("</div>");
								
							sbHtml.append("</div>"); //card-body-end
						sbHtml.append("</div>"); //card-end
					
					sbHtml.append("</td>");	
				sbHtml.append("</tr>");				
				
			sbHtml.append("</table>");
		sbHtml.append("</div>");
	sbHtml.append("</td>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>Main</title>
</head>
<body style="height:100%;">
<%@include file="include/header.jsp"%>

<div class="container-fluid p-0">
	<div id="demo" class="carousel slide" data-bs-ride="carousel">
		<%-- preview next --%>
		<div class="carousel-indicators">
   			<button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active">
   			</button>
   			<button type="button" data-bs-target="#demo" data-bs-slide-to="1">
   			</button>
   			<button type="button" data-bs-target="#demo" data-bs-slide-to="2">
   			</button>
   		</div>	
   		   
   		<%-- slide image --%>
   		<div class="carousel-inner">
   			<div class="carousel-item active">
   				<img src="img/slide/1.jpg" alt="" class="d-block">
   			</div>
   				
   			<div class="carousel-item active">
   				<img src="img/slide/2.jpg" alt="" class="d-block">
   			</div>
   				
   			<div class="carousel-item active">
   				<img src="img/slide/3.jpg" alt="" class="d-block">
   			</div>
   		</div>
   			
   		<%-- left and right controls --%>
   		<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
   			<span class="carousel-control-prev-icon"></span>
   		</button>
   			
   		<button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
   			<span class="carousel-control-next-icon"></span>
   		</button>	
	</div>
</div>

<div class="container">
	<%-- sbHtml이 들어가는 곳 --%>
    <div>
      	<h3 class="mt-3 mb-3">최신 게시물</h3>
      	<table class="table">
      		<tr>
      		<%=sbHtml%>	
      		</tr>
      	</table>
    </div>
</div>

<%@include file="include/footer.jsp"%>
</body>
</html>