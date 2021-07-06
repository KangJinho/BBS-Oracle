<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Bbn"%>
<%@ page import="dao.bbnDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
<title>게시판 만들기</title>
</head>
<body>
	<%
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}
	int bbnId = 0;
	if (request.getParameter("bbnId") != null) {
		bbnId = Integer.parseInt(request.getParameter("bbnId"));
	}
	if (bbnId == 0) {
		PrintWriter pr = response.getWriter();
		pr.println("<script>");
		pr.println("alert('삭제된 글입니다.')");
		pr.println("location.href='bbn.jsp'");
		pr.println("</script>");
	}
	Bbn bbn = new bbnDAO().getBbn(bbnId);
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">게시판 만들기</a>
		</div>
		<div class="navbar navbar-collapse" id="bs.exmpale-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li>
					<a href="main.jsp">메인</a>
				</li>
				<li>
					<a href="bbn.jsp">게시판</a>
				</li>
			</ul>
			<%
			if (userId == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> 접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="login.jsp"> 로그인 </a>
						</li>
						<li>
							<a href="join.jsp"> 회원가입 </a>
						</li>
					</ul>
				</li>
			</ul>
			<%
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원 관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="logoutAction.jsp"> 로그아웃 </a>
						</li>

					</ul>
				</li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table talbe-striped" style="text-align: center; border: 1px sodid #ddddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="">글제목</td>
						<td colspan="2"><%=bbn.getBbnTitle()%></td>
					</tr>
					<tr>
						<td style="">작성자</td>
						<td colspan="2"><%=bbn.getUserId()%></td>
					</tr>
					<tr>
						<td style="">작성일자</td>
						<td colspan="2"><%=bbn.getBbnDate()%></td>
					</tr>
					<tr>
						<td style="">내용</td>
						<td colspan="2" style="text-align: left; min-height: 200px;"><%=bbn.getBbnContent()%></td>
					</tr>
				</tbody>
			</table>
			<a href="bbn.jsp" class="btn btn-primary">목록</a>
			<% 
			if(userId !=null && userId.equals(bbn.getUserId())){
			 %>
			<a href="update.jsp?bbnId=<%=bbnId%>" class="btn btn-primary">수정</a>
			<a onclick="alert('삭제 ㄱㄱ?')" href="deleteAction.jsp?bbnId=<%=bbnId%>" class="btn btn-primary">삭제</a>
			<% 
			}
			 %>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>